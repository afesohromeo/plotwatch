import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'activity_service.dart';
import 'audit_service.dart';
import 'notification_service.dart';
import 'people_service.dart';

/// The site manager's progress updates, without photos for now (UPD-01,
/// UPD-02; doc/04e M5-9 b). They show live in the feed.
class UpdateService {
  const UpdateService();

  static const _audit = AuditService();
  static const _activity = ActivityService();
  static const _notifications = NotificationService();
  static const _people = PeopleService();

  static const maxTextLength = 2000;
  static const maxIssuesLength = 1000;
  static const maxWorkers = 999;
  static const excerptLength = 140;

  /// Returns [draft] cleaned up, or throws `invalidProgressUpdate`.
  static ProgressUpdateDraft validateDraft(ProgressUpdateDraft draft) {
    final text = draft.text.trim();
    final issues = draft.issues?.trim();
    final workers = draft.workersCount;
    if (text.isEmpty ||
        text.length > maxTextLength ||
        (issues != null && issues.length > maxIssuesLength) ||
        (workers != null && (workers < 0 || workers > maxWorkers))) {
      throw AppException(code: AppErrorCode.invalidProgressUpdate);
    }
    return draft.copyWith(
      text: text,
      issues: (issues?.isEmpty ?? true) ? null : issues,
    );
  }

  Future<ProgressUpdate> create(
    Session session,
    ProjectMember siteManager,
    ProgressUpdateDraft draft,
  ) {
    return session.db.transaction((transaction) async {
      final stageId = draft.stageId;
      if (stageId != null) {
        final stage = await Stage.db.findFirstRow(
          session,
          where: (t) =>
              t.id.equals(stageId) & t.projectId.equals(siteManager.projectId),
          transaction: transaction,
        );
        if (stage == null) {
          throw AppException(code: AppErrorCode.stageNotFound);
        }
      }
      final update = await ProgressUpdate.db.insertRow(
        session,
        ProgressUpdate(
          projectId: siteManager.projectId,
          stageId: stageId,
          authorId: siteManager.authUserId,
          text: draft.text,
          workersCount: draft.workersCount,
          weather: draft.weather,
          issues: draft.issues,
          createdAt: DateTime.now().toUtc(),
        ),
        transaction: transaction,
      );
      await _audit.record(
        session,
        actorId: siteManager.authUserId,
        projectId: siteManager.projectId,
        action: 'update.create',
        entityType: 'progress_update',
        entityId: update.id,
        after: {'text': update.text},
        transaction: transaction,
      );
      final excerpt = update.text.length > excerptLength
          ? '${update.text.substring(0, excerptLength)}…'
          : update.text;
      await _activity.record(
        session,
        projectId: siteManager.projectId,
        actorId: siteManager.authUserId,
        type: ActivityType.progressUpdatePosted,
        targetType: 'progress_update',
        targetId: update.id,
        payload: {
          'excerpt': excerpt,
          'stageId': ?update.stageId?.toString(),
        },
        transaction: transaction,
      );
      // The funders are far from the site (doc/04e M5-F1).
      final project = await Project.db.findById(
        session,
        siteManager.projectId,
        transaction: transaction,
      );
      await _notifications.notify(
        session,
        userIds: await _people.funders(
          session,
          siteManager.projectId,
          transaction: transaction,
        ),
        actorId: siteManager.authUserId,
        projectId: siteManager.projectId,
        type: NotificationType.progressUpdatePosted,
        payload: {
          'updateId': '${update.id}',
          'projectName': ?project?.name,
          'actorName': ?await _people.name(session, siteManager.authUserId),
          'excerpt': excerpt,
        },
        transaction: transaction,
      );
      return update;
    });
  }

  Future<ProgressUpdate> get(
    Session session,
    int projectId,
    int updateId,
  ) async {
    final update = await ProgressUpdate.db.findFirstRow(
      session,
      where: (t) => t.id.equals(updateId) & t.projectId.equals(projectId),
    );
    if (update == null) throw AppException(code: AppErrorCode.updateNotFound);
    // With who posted it (doc/04e C-2d).
    final author = await _people.person(session, projectId, update.authorId);
    return update.copyWith(
      authorName: author.name,
      authorFormer: author.former,
    );
  }
}
