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
    final owner = await _permissions.require(
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
