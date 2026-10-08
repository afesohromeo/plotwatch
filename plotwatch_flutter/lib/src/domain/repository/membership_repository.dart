import 'dart:developer';

import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// Invitations and members. Errors are logged and rethrown (RULE-012).
/// Members and pending invitations are plain lists: a project has only a few
/// of each (doc/04b, group C).
class MembershipRepository {
  MembershipRepository({MembershipApiProvider? apiProvider})
    : _apiProvider = apiProvider ?? MembershipApiProvider();

  final MembershipApiProvider _apiProvider;

  Future<List<MemberView>> fetchMembers(int projectId) =>
      _logged('fetching members', () => _apiProvider.listMembers(projectId));

  Future<List<Invitation>> fetchInvitations(int projectId) => _logged(
    'fetching invitations',
    () => _apiProvider.listInvitations(projectId),
  );

  Future<Invitation> createInvitation(
    int projectId,
    ProjectRole role, {
    required bool canApprove,
  }) => _logged(
    'creating an invitation',
    () =>
        _apiProvider.createInvitation(projectId, role, canApprove: canApprove),
  );

  Future<void> cancelInvitation(int projectId, int invitationId) => _logged(
    'cancelling an invitation',
    () => _apiProvider.cancelInvitation(projectId, invitationId),
  );

  Future<InvitationPreview> previewInvitation(String code) => _logged(
    'previewing an invitation',
    () => _apiProvider.previewInvitation(code),
  );

  Future<ProjectMember> acceptInvitation(String code) => _logged(
    'accepting an invitation',
    () => _apiProvider.acceptInvitation(code),
  );

  /// Gives a member another role (doc/04b H-4).
  Future<ProjectMember> changeRole(
    int projectId,
    int memberId,
    ProjectRole role,
  ) => _logged(
    "changing a member's role",
    () => _apiProvider.changeRole(projectId, memberId, role),
  );

  Future<void> removeMember(int projectId, int memberId) => _logged(
    'removing a member',
    () => _apiProvider.removeMember(projectId, memberId),
  );

  Future<T> _logged<T>(String what, Future<T> Function() call) async {
    try {
      return await call();
    } catch (e) {
      log('Error $what: $e');
      rethrow;
    }
  }
}
