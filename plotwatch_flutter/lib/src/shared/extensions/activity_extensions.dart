import 'package:flutter/material.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// Where tapping a feed event or a notification goes (doc/04e M5-7).
typedef SourceRoute = ({String name, Map<String, String> pathParameters});

/// The sentence, icon and source of a feed event (FEED-01, doc/04e M5-7).
/// The server sends names and numbers only; the app writes the sentence
/// (`_standards/14` §2).
extension ActivityEntryX on ActivityEntry {
  String sentence(AppLocalizations l10n) {
    final actor = actorName ?? l10n.someone;
    final payload = event.payload ?? const <String, String>{};
    final name = payload['name'] ?? '';
    String role(String key) => _role(payload[key], l10n);

    return switch (event.type) {
      ActivityType.projectCreated => l10n.activityProjectCreated(actor, name),
      ActivityType.projectUpdated => l10n.activityProjectUpdated(actor),
      ActivityType.projectStatusChanged => l10n.activityProjectStatusChanged(
        actor,
        ProjectStatus.values.asNameMap()[payload['status']]?.label(l10n) ??
            payload['status'] ??
            '',
      ),
      ActivityType.siteProposed => l10n.activitySiteProposed(actor),
      ActivityType.siteProposalRejected => l10n.activitySiteProposalRejected(
        actor,
      ),
      ActivityType.siteChanged => l10n.activitySiteChanged(actor),
      ActivityType.memberJoined => l10n.activityMemberJoined(
        actor,
        role('role'),
      ),
      // Earlier events don't carry the name (doc/04e C-2c).
      ActivityType.memberRemoved => l10n.activityMemberRemoved(
        actor,
        payload['memberName'] ?? l10n.aMember,
        role('role'),
      ),
      ActivityType.memberRoleChanged => l10n.activityMemberRoleChanged(
        actor,
        payload['memberName'] ?? l10n.aMember,
        role('from'),
        role('to'),
      ),
      // One stage changed (with its name), a plan created (with its stage
      // count), or the plan reordered (neither).
      ActivityType.stagePlanChanged => switch ((
        payload['name'],
        int.tryParse(payload['stageCount'] ?? ''),
      )) {
        (final String stage, _) => l10n.activityStageChanged(actor, stage),
        (_, final int count) => l10n.activityPlanCreated(actor, count),
        _ => l10n.activityPlanChanged(actor),
      },
      ActivityType.stageStarted => l10n.activityStageStarted(actor, name),
      ActivityType.evidenceCaptured => l10n.activityEvidenceCaptured(
        actor,
        VerificationLevel.values
                .asNameMap()[payload['verificationLevel']]
                ?.label(l10n) ??
            '',
      ),
      ActivityType.evidenceRetracted => l10n.activityEvidenceRetracted(actor),
      ActivityType.stageSubmitted => l10n.activityStageSubmitted(actor, name),
      ActivityType.stageApproved => l10n.activityStageApproved(actor, name),
      ActivityType.stageChangesRequested => l10n.activityChangesRequested(
        actor,
        name,
      ),
      ActivityType.progressUpdatePosted => l10n.activityUpdatePosted(
        actor,
        payload['excerpt'] ?? '',
      ),
    };
  }

  IconData get icon => switch (event.type) {
    ActivityType.projectCreated ||
    ActivityType.projectUpdated ||
    ActivityType.projectStatusChanged => Icons.home_work_outlined,
    ActivityType.siteProposed ||
    ActivityType.siteProposalRejected ||
    ActivityType.siteChanged => Icons.place_outlined,
    ActivityType.memberJoined ||
    ActivityType.memberRemoved ||
    ActivityType.memberRoleChanged => Icons.group_outlined,
    ActivityType.stagePlanChanged ||
    ActivityType.stageStarted => Icons.view_list_outlined,
    ActivityType.evidenceCaptured ||
    ActivityType.evidenceRetracted => Icons.photo_camera_outlined,
    ActivityType.stageSubmitted => Icons.outbox_outlined,
    ActivityType.stageApproved => Icons.check_circle_outline_rounded,
    ActivityType.stageChangesRequested => Icons.replay_rounded,
    ActivityType.progressUpdatePosted => Icons.campaign_outlined,
  };

  /// The page the event is about; null when there is nothing to open
  /// (e.g. a photo whose stage isn't known).
  SourceRoute? get source {
    final project = '${event.projectId}';
    final target = event.targetId;
    final stageId = event.payload?['stageId'];
    SourceRoute route(String name, [Map<String, String> more = const {}]) =>
        (name: name, pathParameters: {'projectId': project, ...more});

    return switch (event.type) {
      ActivityType.projectCreated ||
      ActivityType.projectUpdated ||
      ActivityType.projectStatusChanged ||
      ActivityType.siteProposed ||
      ActivityType.siteProposalRejected ||
      ActivityType.siteChanged => route(projectRouteName),
      ActivityType.memberJoined ||
      ActivityType.memberRemoved ||
      ActivityType.memberRoleChanged => route(membersRouteName),
      // The stage may have been deleted since: the plan is always there.
      ActivityType.stagePlanChanged => route(stagesRouteName),
      ActivityType.stageStarted ||
      ActivityType.stageSubmitted ||
      ActivityType.stageApproved ||
      ActivityType.stageChangesRequested =>
        target == null
            ? route(stagesRouteName)
            : route(stageRouteName, {'stageId': '$target'}),
      ActivityType.evidenceCaptured || ActivityType.evidenceRetracted =>
        target == null || stageId == null
            ? null
            : route(evidenceRouteName, {
                'stageId': stageId,
                'evidenceId': '$target',
              }),
      ActivityType.progressUpdatePosted =>
        target == null ? null : route(updateRouteName, {'updateId': '$target'}),
    };
  }
}

/// The sentence and source of a notification (NOT-01, doc/04e M5-4).
extension AppNotificationX on AppNotification {
  String sentence(AppLocalizations l10n) {
    final payload = this.payload ?? const <String, String>{};
    final stage = payload['stageName'] ?? '';
    final project = payload['projectName'] ?? '';

    return switch (type) {
      NotificationType.stageSubmitted => l10n.notificationStageSubmitted(
        payload['actorName'] ?? l10n.someone,
        stage,
        project,
      ),
      NotificationType.stageApproved => l10n.notificationStageApproved(
        payload['reviewerName'] ?? l10n.someone,
        stage,
        project,
      ),
      NotificationType.stageChangesRequested =>
        l10n.notificationChangesRequested(
          payload['reviewerName'] ?? l10n.someone,
          stage,
          payload['comment'] ?? '',
        ),
      NotificationType.memberJoined => l10n.notificationMemberJoined(
        payload['memberName'] ?? l10n.someone,
        project,
        _role(payload['role'], l10n),
      ),
      NotificationType.progressUpdatePosted => l10n.notificationUpdatePosted(
        payload['actorName'] ?? l10n.someone,
        project,
        payload['excerpt'] ?? '',
      ),
    };
  }

  bool get isUnread => readAt == null;

  SourceRoute? get source {
    final project = projectId;
    if (project == null) return null;
    final stageId = payload?['stageId'];
    return switch (type) {
      NotificationType.stageSubmitted ||
      NotificationType.stageApproved ||
      NotificationType.stageChangesRequested =>
        stageId == null
            ? (name: stagesRouteName, pathParameters: {'projectId': '$project'})
            : (
                name: stageRouteName,
                pathParameters: {'projectId': '$project', 'stageId': stageId},
              ),
      NotificationType.memberJoined => (
        name: membersRouteName,
        pathParameters: {'projectId': '$project'},
      ),
      NotificationType.progressUpdatePosted => switch (payload?['updateId']) {
        final String updateId => (
          name: updateRouteName,
          pathParameters: {'projectId': '$project', 'updateId': updateId},
        ),
        _ => (name: feedRouteName, pathParameters: {'projectId': '$project'}),
      },
    };
  }
}

String _role(String? name, AppLocalizations l10n) =>
    ProjectRole.values.asNameMap()[name]?.label(l10n) ?? name ?? '';

/// The Activity page's kind chips (doc/05 §9.5). Project and plan events,
/// and a stage starting, belong to none: they show under "All" only.
enum ActivityKind {
  photos({ActivityType.evidenceCaptured, ActivityType.evidenceRetracted}),
  reviews({
    ActivityType.stageSubmitted,
    ActivityType.stageApproved,
    ActivityType.stageChangesRequested,
  }),
  updates({ActivityType.progressUpdatePosted}),
  members({
    ActivityType.memberJoined,
    ActivityType.memberRemoved,
    ActivityType.memberRoleChanged,
  }),
  site({
    ActivityType.siteProposed,
    ActivityType.siteProposalRejected,
    ActivityType.siteChanged,
  });

  const ActivityKind(this.types);

  final Set<ActivityType> types;

  String label(AppLocalizations l10n) => switch (this) {
    ActivityKind.photos => l10n.kindPhotos,
    ActivityKind.reviews => l10n.kindReviews,
    ActivityKind.updates => l10n.kindUpdates,
    ActivityKind.members => l10n.kindMembers,
    ActivityKind.site => l10n.kindSite,
  };
}
