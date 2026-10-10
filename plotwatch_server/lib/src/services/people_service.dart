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

  /// [userId]'s name, and whether they are no longer an active member of
  /// [projectId] (doc/04e C-2d).
  Future<({String? name, bool former})> person(
    Session session,
    int projectId,
    UuidValue userId,
  ) async {
    final active = await ProjectMember.db.findFirstRow(
      session,
      where: (t) =>
          t.projectId.equals(projectId) &
          t.authUserId.equals(userId) &
          t.status.equals(MemberStatus.active),
    );
    return (name: await name(session, userId), former: active == null);
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

  /// The owner and every co-funder, with or without approval rights: the
  /// people paying, told of news from the site (doc/04e M5-F1).
  Future<List<UuidValue>> funders(
    Session session,
    int projectId, {
    Transaction? transaction,
  }) async => [
    for (final member in await _active(session, projectId, transaction))
      if (member.role == ProjectRole.owner ||
          member.role == ProjectRole.coFunder)
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
