import 'package:flutter_test/flutter_test.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

import '../../helpers/helpers.dart';

// Plan: doc/05-design-system.md §9 DP-1: what waits for the user.
void main() {
  final stages = testBriefs([
    StageStatus.approved,
    StageStatus.submitted,
    StageStatus.changesRequested,
    StageStatus.submitted,
  ]);

  test('Given an approver then the submitted stages wait for their review', () {
    for (final (role, canApprove) in [
      (ProjectRole.owner, false),
      (ProjectRole.coFunder, true),
    ]) {
      final waiting = attentionFor(
        stages: stages,
        role: role,
        canApprove: canApprove,
      )!;

      expect(waiting.review, isTrue);
      expect(waiting.count, 2);
      expect(waiting.first.id, 2);
    }
  });

  test('Given the site manager then the stages sent back wait for them', () {
    final waiting = attentionFor(
      stages: stages,
      role: ProjectRole.siteManager,
      canApprove: false,
    )!;

    expect(waiting.review, isFalse);
    expect(waiting.count, 1);
    expect(waiting.first.id, 3);
  });

  test(
    'Given a viewer or a co-funder who cannot approve then nothing waits',
    () {
      expect(
        attentionFor(
          stages: stages,
          role: ProjectRole.viewer,
          canApprove: false,
        ),
        isNull,
      );
      expect(
        attentionFor(
          stages: stages,
          role: ProjectRole.coFunder,
          canApprove: false,
        ),
        isNull,
      );
    },
  );

  test('Given nothing submitted then nothing waits', () {
    expect(
      attentionFor(
        stages: testBriefs([StageStatus.approved, StageStatus.notStarted]),
        role: ProjectRole.owner,
        canApprove: false,
      ),
      isNull,
    );
  });
}
