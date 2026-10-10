import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// What waits for the user in a project (doc/05 §9 DP-1): stages to review
/// for an approver, stages sent back for the site manager. [first] is the
/// earliest such stage in plan order, opened when there is only one.
typedef Attention = ({bool review, int count, StageBrief first});

Attention? attentionFor({
  required List<StageBrief> stages,
  required ProjectRole role,
  required bool canApprove,
}) {
  final approver =
      role == ProjectRole.owner || (role == ProjectRole.coFunder && canApprove);
  final waiting = switch (role) {
    _ when approver => StageStatus.submitted,
    ProjectRole.siteManager => StageStatus.changesRequested,
    _ => null,
  };
  if (waiting == null) return null;
  final mine = [
    for (final stage in stages)
      if (stage.status == waiting) stage,
  ];
  if (mine.isEmpty) return null;
  return (review: approver, count: mine.length, first: mine.first);
}

/// Whether one stage waits for this user (the Stages tab's highlight).
bool waitsFor(
  StageStatus status, {
  required ProjectRole role,
  required bool canApprove,
}) =>
    attentionFor(
      stages: [StageBrief(id: 0, name: '', status: status)],
      role: role,
      canApprove: canApprove,
    ) !=
    null;
