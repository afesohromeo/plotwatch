import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import '../generated/protocol.dart';

/// Account deletion (doc/04g step 6, Google Play's account deletion policy):
/// the person is deleted, not the shared history.
class AccountService {
  const AccountService();

  static const _storageId = 'private';
  static const _closed = {ProjectStatus.completed, ProjectStatus.archived};

  /// Projects that [userId] owns, still open, with other active members:
  /// deleting would leave them without an owner. They must be completed or
  /// archived first (there is no ownership transfer).
  Future<List<Project>> blockers(Session session, UuidValue userId) async {
    final owned = await ProjectMember.db.find(
      session,
      where: (t) =>
          t.authUserId.equals(userId) &
          t.role.equals(ProjectRole.owner) &
          t.status.equals(MemberStatus.active),
    );
    final projects = <Project>[];
    for (final membership in owned) {
      final project = await Project.db.findById(session, membership.projectId);
      if (project == null || _closed.contains(project.status)) continue;
      if (await _othersActive(session, membership.projectId, userId) > 0) {
        projects.add(project);
      }
    }
    return projects;
  }

  /// Deletes [userId]'s account:
  /// - the projects where they are the only active member, with their files;
  /// - their membership elsewhere is marked removed, so their photos, entries
  ///   and updates stay for the others (shown as a former member);
  /// - their settings and notifications;
  /// - the auth user, whose sign-ins, profile and sessions follow by cascade.
  Future<void> deleteAccount(Session session, UuidValue userId) async {
    if ((await blockers(session, userId)).isNotEmpty) {
      throw AppException(code: AppErrorCode.accountOwnsSharedProjects);
    }
    final files = <String>[];
    await session.db.transaction((transaction) async {
      final memberships = await ProjectMember.db.find(
        session,
        where: (t) =>
            t.authUserId.equals(userId) & t.status.equals(MemberStatus.active),
        transaction: transaction,
      );
      final now = DateTime.now().toUtc();
      for (final membership in memberships) {
        final projectId = membership.projectId;
        if (await _othersActive(
              session,
              projectId,
              userId,
              transaction: transaction,
            ) ==
            0) {
          files.addAll(
            await _deleteProject(session, projectId, transaction),
          );
        } else {
          await ProjectMember.db.updateRow(
            session,
            membership.copyWith(status: MemberStatus.removed, removedAt: now),
            transaction: transaction,
          );
        }
      }
      await UserSettings.db.deleteWhere(
        session,
        where: (t) => t.authUserId.equals(userId),
        transaction: transaction,
      );
      await AppNotification.db.deleteWhere(
        session,
        where: (t) => t.userId.equals(userId),
        transaction: transaction,
      );
      await AuthServices.instance.authUsers.delete(
        session,
        authUserId: userId,
        transaction: transaction,
      );
    });

    await _deleteFiles(session, files);
    // Open streams of this user close.
    await session.messages.authenticationRevoked(
      userId.uuid,
      RevokedAuthenticationUser(),
    );
  }

  /// Deletes a whole project with its stored files; also used by the demo
  /// seed to remove a half-made demo project (doc/04g step 7).
  Future<void> deleteProject(Session session, int projectId) async {
    final files = await session.db.transaction(
      (transaction) => _deleteProject(session, projectId, transaction),
    );
    await _deleteFiles(session, files);
  }

  /// After the commit: a file left behind is only storage, never a dangling
  /// record.
  Future<void> _deleteFiles(Session session, List<String> files) async {
    for (final path in files) {
      try {
        await session.storage.deleteFile(storageId: _storageId, path: path);
      } catch (e) {
        session.log('Could not delete $path: $e', level: LogLevel.warning);
      }
    }
  }

  /// Deletes a project and returns its stored files (photos, thumbnails,
  /// receipts). Evidence goes first: it restricts deleting its stage.
  Future<List<String>> _deleteProject(
    Session session,
    int projectId,
    Transaction transaction,
  ) async {
    final evidence = await Evidence.db.find(
      session,
      where: (t) => t.projectId.equals(projectId),
      transaction: transaction,
    );
    final receipts = await LedgerEntry.db.find(
      session,
      where: (t) => t.projectId.equals(projectId) & t.receiptPath.notEquals(null),
      transaction: transaction,
    );
    await Evidence.db.deleteWhere(
      session,
      where: (t) => t.projectId.equals(projectId),
      transaction: transaction,
    );
    await Project.db.deleteWhere(
      session,
      where: (t) => t.id.equals(projectId),
      transaction: transaction,
    );
    return [
      for (final capture in evidence) ...[
        capture.photoPath,
        ?capture.thumbPath,
      ],
      for (final entry in receipts) ?entry.receiptPath,
    ];
  }

  Future<int> _othersActive(
    Session session,
    int projectId,
    UuidValue userId, {
    Transaction? transaction,
  }) => ProjectMember.db.count(
    session,
    where: (t) =>
        t.projectId.equals(projectId) &
        t.authUserId.notEquals(userId) &
        t.status.equals(MemberStatus.active),
    transaction: transaction,
  );
}
