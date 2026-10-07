import 'dart:math';

import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import '../generated/protocol.dart';
import 'activity_service.dart';
import 'audit_service.dart';

/// Invitations and members (MEMB-01–05, 08). Callers check permissions first
/// with `PermissionService`; previewing and accepting need only sign-in,
/// because the code itself is the authorization.
class MembershipService {
  const MembershipService();

  static const _audit = AuditService();
  static const _activity = ActivityService();

  /// No look-alikes (0/O, 1/I/L), decision M2-6.
  static const codeAlphabet = '23456789ABCDEFGHJKMNPQRSTUVWXYZ';
  static const codeLength = 8;
  static const invitationLifetime = Duration(days: 7);
  static const _maxCodeAttempts = 5;
  static final _random = Random.secure();

  /// Throws [AppException] for a role that can't be invited.
  static void validateInvitationRole(ProjectRole role) {
    if (role == ProjectRole.owner) {
      throw AppException(code: AppErrorCode.invalidInvitationRole);
    }
  }

  /// Upper case, without spaces or hyphens: `abcd-efgh` → `ABCDEFGH`.
  static String normalizeCode(String input) =>
      input.toUpperCase().replaceAll(RegExp(r'[\s-]'), '');

  Future<Invitation> createInvitation(
    Session session,
    ProjectMember owner,
    ProjectRole role, {
    required bool canApprove,
  }) {
    return session.db.transaction((transaction) async {
      final now = DateTime.now().toUtc();
      final invitation = await Invitation.db.insertRow(
        session,
        Invitation(
          projectId: owner.projectId,
          role: role,
          // Approval rights only exist for co-funders (doc/02 §3.2).
          canApprove: role == ProjectRole.coFunder && canApprove,
          code: await _unusedCode(session, transaction),
          status: InvitationStatus.pending,
          expiresAt: now.add(invitationLifetime),
          createdBy: owner.authUserId,
          createdAt: now,
        ),
        transaction: transaction,
      );
      await _audit.record(
        session,
        actorId: owner.authUserId,
        projectId: owner.projectId,
        action: 'invitation.create',
        entityType: 'invitation',
        entityId: invitation.id,
        after: _invitationFields(invitation),
        transaction: transaction,
      );
      return invitation;
    });
  }

  /// Pending invitations that haven't expired, newest first.
  Future<List<Invitation>> listInvitations(Session session, int projectId) {
    return Invitation.db.find(
      session,
      where: (t) =>
          t.projectId.equals(projectId) &
          t.status.equals(InvitationStatus.pending) &
          (t.expiresAt > DateTime.now().toUtc()),
      orderBy: (t) => t.id.desc(),
    );
  }

  Future<void> cancelInvitation(
    Session session,
    ProjectMember owner,
    int invitationId,
  ) {
    return session.db.transaction((transaction) async {
      final invitation = await Invitation.db.findFirstRow(
        session,
        where: (t) =>
            t.id.equals(invitationId) & t.projectId.equals(owner.projectId),
        transaction: transaction,
      );
      if (invitation == null) {
        throw AppException(code: AppErrorCode.invitationNotFound);
      }
      if (invitation.status != InvitationStatus.pending) {
        throw AppException(code: AppErrorCode.invitationUsed);
      }
      final cancelled = await Invitation.db.updateRow(
        session,
        invitation.copyWith(status: InvitationStatus.cancelled),
        transaction: transaction,
      );
      await _audit.record(
        session,
        actorId: owner.authUserId,
        projectId: owner.projectId,
        action: 'invitation.cancel',
        entityType: 'invitation',
        entityId: invitation.id,
        before: _invitationFields(invitation),
        after: _invitationFields(cancelled),
        transaction: transaction,
      );
    });
  }

  Future<InvitationPreview> previewInvitation(
    Session session,
    String code,
  ) async {
    final invitation = _usable(
      await Invitation.db.findFirstRow(
        session,
        where: (t) => t.code.equals(normalizeCode(code)),
      ),
    );
    final project = await Project.db.findById(session, invitation.projectId);
    return InvitationPreview(
      projectName: project!.name,
      role: invitation.role,
      canApprove: invitation.canApprove,
      inviterName: (await _profile(session, invitation.createdBy))?.fullName,
      expiresAt: invitation.expiresAt,
    );
  }

  /// Joins the project with the invitation's role. The invitation row is
  /// locked, so two people using the same code at once can't both join.
  Future<ProjectMember> acceptInvitation(
    Session session,
    UuidValue userId,
    String code,
  ) {
    return session.db.transaction((transaction) async {
      final invitation = _usable(
        await Invitation.db.findFirstRow(
          session,
          where: (t) => t.code.equals(normalizeCode(code)),
          lockMode: LockMode.forUpdate,
          transaction: transaction,
        ),
      );
      final existing = await ProjectMember.db.findFirstRow(
        session,
        where: (t) =>
            t.projectId.equals(invitation.projectId) &
            t.authUserId.equals(userId),
        transaction: transaction,
      );
      if (existing?.status == MemberStatus.active) {
        throw AppException(code: AppErrorCode.alreadyMember);
      }

      final now = DateTime.now().toUtc();
      final joined = ProjectMember(
        projectId: invitation.projectId,
        authUserId: userId,
        role: invitation.role,
        canApprove: invitation.canApprove,
        status: MemberStatus.active,
        joinedAt: now,
      );
      // Someone removed earlier keeps their row (unique per project and user).
      final member = existing == null
          ? await ProjectMember.db.insertRow(
              session,
              joined,
              transaction: transaction,
            )
          : await ProjectMember.db.updateRow(
              session,
              joined.copyWith(id: existing.id, removedAt: null),
              transaction: transaction,
            );
      await Invitation.db.updateRow(
        session,
        invitation.copyWith(
          status: InvitationStatus.accepted,
          acceptedBy: userId,
        ),
        transaction: transaction,
      );
      await _audit.record(
        session,
        actorId: userId,
        projectId: member.projectId,
        action: 'member.join',
        entityType: 'project_member',
        entityId: member.id,
        after: {
          ..._memberFields(member),
          'invitationId': '${invitation.id}',
        },
        transaction: transaction,
      );
      await _activity.record(
        session,
        projectId: member.projectId,
        actorId: userId,
        type: ActivityType.memberJoined,
        targetType: 'project_member',
        targetId: member.id,
        payload: {'role': member.role.name},
        transaction: transaction,
      );
      return member;
    });
  }

  /// Active members with the name and email from their auth profile.
  Future<List<MemberView>> listMembers(Session session, int projectId) async {
    final members = await ProjectMember.db.find(
      session,
      where: (t) =>
          t.projectId.equals(projectId) & t.status.equals(MemberStatus.active),
      orderBy: (t) => t.joinedAt,
    );
    return [
      for (final member in members) await _view(session, member),
    ];
  }

  Future<void> removeMember(
    Session session,
    ProjectMember owner,
    int memberId,
  ) {
    return session.db.transaction((transaction) async {
      final member = await ProjectMember.db.findFirstRow(
        session,
        where: (t) =>
            t.id.equals(memberId) &
            t.projectId.equals(owner.projectId) &
            t.status.equals(MemberStatus.active),
        transaction: transaction,
      );
      if (member == null) {
        throw AppException(code: AppErrorCode.memberNotFound);
      }
      if (member.role == ProjectRole.owner) {
        throw AppException(code: AppErrorCode.cannotRemoveOwner);
      }
      final removed = await ProjectMember.db.updateRow(
        session,
        member.copyWith(
          status: MemberStatus.removed,
          removedAt: DateTime.now().toUtc(),
        ),
        transaction: transaction,
      );
      await _audit.record(
        session,
        actorId: owner.authUserId,
        projectId: owner.projectId,
        action: 'member.remove',
        entityType: 'project_member',
        entityId: member.id,
        before: _memberFields(member),
        after: _memberFields(removed),
        transaction: transaction,
      );
      await _activity.record(
        session,
        projectId: owner.projectId,
        actorId: owner.authUserId,
        type: ActivityType.memberRemoved,
        targetType: 'project_member',
        targetId: member.id,
        payload: {'role': member.role.name},
        transaction: transaction,
      );
    });
  }

  /// The invitation if it can still be used, or the reason it can't.
  static Invitation _usable(Invitation? invitation) {
    if (invitation == null) {
      throw AppException(code: AppErrorCode.invitationNotFound);
    }
    if (invitation.status == InvitationStatus.expired ||
        (invitation.status == InvitationStatus.pending &&
            !invitation.expiresAt.isAfter(DateTime.now().toUtc()))) {
      throw AppException(code: AppErrorCode.invitationExpired);
    }
    if (invitation.status != InvitationStatus.pending) {
      throw AppException(code: AppErrorCode.invitationUsed);
    }
    return invitation;
  }

  Future<String> _unusedCode(Session session, Transaction transaction) async {
    for (var attempt = 0; attempt < _maxCodeAttempts; attempt++) {
      final code = List.generate(
        codeLength,
        (_) => codeAlphabet[_random.nextInt(codeAlphabet.length)],
      ).join();
      final taken = await Invitation.db.count(
        session,
        where: (t) => t.code.equals(code),
        transaction: transaction,
      );
      if (taken == 0) return code;
    }
    // About 8.5 × 10^11 codes: five collisions in a row means something is
    // wrong, not bad luck.
    throw StateError('No unused invitation code after $_maxCodeAttempts tries');
  }

  Future<MemberView> _view(Session session, ProjectMember member) async {
    final profile = await _profile(session, member.authUserId);
    return MemberView(
      member: member,
      fullName: profile?.fullName,
      email: profile?.email,
    );
  }

  Future<UserProfileModel?> _profile(Session session, UuidValue userId) =>
      AuthServices.instance.userProfiles.maybeFindUserProfileByUserId(
        session,
        userId,
      );

  static Map<String, String> _invitationFields(Invitation invitation) => {
    'role': invitation.role.name,
    'canApprove': '${invitation.canApprove}',
    'status': invitation.status.name,
    'expiresAt': invitation.expiresAt.toIso8601String(),
  };

  static Map<String, String> _memberFields(ProjectMember member) => {
    'authUserId': member.authUserId.uuid,
    'role': member.role.name,
    'canApprove': '${member.canApprove}',
    'status': member.status.name,
  };
}
