import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// Invitations and members (`client.membership`, MEMB-01–05).
class MembershipApiProvider {
  Client get _client => ApiProvider().client;

  Future<Invitation> createInvitation(
    int projectId,
    ProjectRole role, {
    bool? canApprove,
  }) async {
    try {
      return await _client.membership.createInvitation(
        projectId,
        role,
        canApprove: canApprove,
      );
    } catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }

  Future<List<Invitation>> listInvitations(int projectId) async {
    try {
      return await _client.membership.listInvitations(projectId);
    } catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }

  Future<void> cancelInvitation(int projectId, int invitationId) async {
    try {
      await _client.membership.cancelInvitation(projectId, invitationId);
    } catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }

  Future<InvitationPreview> previewInvitation(String code) async {
    try {
      return await _client.membership.previewInvitation(code);
    } catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }

  Future<ProjectMember> acceptInvitation(String code) async {
    try {
      return await _client.membership.acceptInvitation(code);
    } catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }

  Future<List<MemberView>> listMembers(int projectId) async {
    try {
      return await _client.membership.listMembers(projectId);
    } catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }

  /// doc/04e C-2b.
  Future<List<MemberView>> listFormerMembers(int projectId) async {
    try {
      return await _client.membership.listFormerMembers(projectId);
    } catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }

  /// doc/04b H-4.
  Future<ProjectMember> changeRole(
    int projectId,
    int memberId,
    ProjectRole role,
  ) async {
    try {
      return await _client.membership.changeRole(projectId, memberId, role);
    } catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }

  Future<void> removeMember(int projectId, int memberId) async {
    try {
      await _client.membership.removeMember(projectId, memberId);
    } catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }
}
