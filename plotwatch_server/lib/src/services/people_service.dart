import 'dart:developer';

import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import '../generated/protocol.dart';

/// Names of users (from their auth profile) and the members who must act
/// on a project, for history, feed and notifications (doc/04e M5-3, M5-4).
class PeopleService {
  const PeopleService();

  /// The full name of each user, or null when it isn't known.
  Future<Map<UuidValue, String?>> names(
    Session session,
    Set<UuidValue> userIds,
  ) async => {
    for (final id in userIds) id: await name(session, id),
  };

  Future<String?> name(Session session, UuidValue userId) async {
    try {
      final profile = await AuthServices.instance.userProfiles
          .maybeFindUserProfileByUserId(session, userId);
      return profile?.fullName;
    } catch (e) {
      // A name is a nicety: a missing profile never breaks a feed or a
      // notification.
      log('PeopleService.name error: $e');
      return null;
    }
  }

  /// The owner and the co-funders allowed to approve (`reviewStage`).
  Future<List<UuidValue>> approvers(
    Session session,
    int projectId, {
    Transaction? transaction,
  }) async => [
    for (final member in await _active(session, projectId, transaction))
      if (member.role == ProjectRole.owner ||
          (member.role == ProjectRole.coFunder && member.canApprove))
        member.authUserId,
  ];

  Future<List<UuidValue>> siteManagers(
    Session session,
    int projectId, {
    Transaction? transaction,
  }) async => [
    for (final member in await _active(session, projectId, transaction))
      if (member.role == ProjectRole.siteManager) member.authUserId,
  ];

  Future<UuidValue?> owner(
    Session session,
    int projectId, {
    Transaction? transaction,
  }) async {
    for (final member in await _active(session, projectId, transaction)) {
      if (member.role == ProjectRole.owner) return member.authUserId;
    }
    return null;
  }

  Future<List<ProjectMember>> _active(
    Session session,
    int projectId,
    Transaction? transaction,
  ) => ProjectMember.db.find(
    session,
    where: (t) =>
        t.projectId.equals(projectId) & t.status.equals(MemberStatus.active),
    transaction: transaction,
  );
}
