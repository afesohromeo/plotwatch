import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import '../generated/protocol.dart';
import '../services/membership_service.dart';
import '../services/permission_service.dart';

/// Invitations and members (MEMB-01–05, 08). Thin: sign-in → permission →
/// validate → one service call (`_standards/14` §4.2).
class MembershipEndpoint extends Endpoint {
  static const _service = MembershipService();
  static const _permissions = PermissionService();

  @override
  bool get requireLogin => true;

  Future<Invitation> createInvitation(
    Session session,
    int projectId,
    ProjectRole role, {
    // Nullable instead of a default: see ProjectEndpoint.list.
    bool? canApprove,
  }) async {
    final owner = await _permissions.requireOpen(
      session,
      projectId,
      ProjectAction.manageMembers,
    );
    MembershipService.validateInvitationRole(role);
    return _service.createInvitation(
      session,
      owner,
      role,
      canApprove: canApprove ?? false,
    );
  }

  Future<List<Invitation>> listInvitations(
    Session session,
    int projectId,
  ) async {
    await _permissions.require(
      session,
      projectId,
      ProjectAction.manageMembers,
    );
    return _service.listInvitations(session, projectId);
  }

  Future<void> cancelInvitation(
    Session session,
    int projectId,
    int invitationId,
  ) async {
    final owner = await _permissions.require(
      session,
      projectId,
      ProjectAction.manageMembers,
    );
    return _service.cancelInvitation(session, owner, invitationId);
  }

  /// Signed-in only: the code is the authorization (MEMB-03).
  Future<InvitationPreview> previewInvitation(Session session, String code) =>
      _service.previewInvitation(session, code);

  /// Signed-in only: the code is the authorization (MEMB-03).
  Future<ProjectMember> acceptInvitation(Session session, String code) =>
      _service.acceptInvitation(
        session,
        session.authenticated!.authUserId,
        code,
      );

  Future<List<MemberView>> listMembers(Session session, int projectId) async {
    await _permissions.require(
      session,
      projectId,
      ProjectAction.viewProject,
    );
    return _service.listMembers(session, projectId);
  }

  /// Removed members, most recent first, with who removed them: their
  /// actions stay in the project's history (doc/04e C-2b).
  Future<List<MemberView>> listFormerMembers(
    Session session,
    int projectId,
  ) async {
    await _permissions.require(
      session,
      projectId,
      ProjectAction.viewProject,
    );
    return _service.listFormerMembers(session, projectId);
  }

  /// The owner gives a member another role (doc/04b H-4, MEMB-07).
  Future<ProjectMember> changeRole(
    Session session,
    int projectId,
    int memberId,
    ProjectRole role,
  ) async {
    final owner = await _permissions.requireOpen(
      session,
      projectId,
      ProjectAction.manageMembers,
    );
    MembershipService.validateMemberRole(role);
    return _service.changeRole(session, owner, memberId, role);
  }

  Future<void> removeMember(
    Session session,
    int projectId,
    int memberId,
  ) async {
    final owner = await _permissions.require(
      session,
      projectId,
      ProjectAction.manageMembers,
    );
    return _service.removeMember(session, owner, memberId);
  }
}
