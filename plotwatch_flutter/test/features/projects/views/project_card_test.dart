import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

import '../../../helpers/helpers.dart';

// Plan: doc/05-design-system.md §9 DP-9: the project list's card.
void main() {
  late AppLocalizations l10n;
  setUpAll(() => l10n = setUpTestLocalization());

  Future<void> pumpCard(WidgetTester tester, ProjectSummary summary) =>
      tester.pumpApp(
        Scaffold(
          body: SingleChildScrollView(
            child: ProjectCard(summary: summary, onTap: () {}),
          ),
        ),
      );

  testWidgets('Given stages with a budget then the card shows a segment per '
      'stage, the budget share and the count', (tester) async {
    await pumpCard(
      tester,
      testSummary(
        stages: testBriefs([StageStatus.approved, StageStatus.notStarted]),
        progressPercent: 62,
        budgetTotalMinor: 1000,
      ),
    );

    expect(find.byKey(const ValueKey('stageBar.1')), findsOneWidget);
    expect(find.textContaining('62%'), findsOneWidget);
    expect(find.text(l10n.progressStagesOnly(1, 2)), findsOneWidget);
  });

  testWidgets('Given a stage waiting for the owner then the card says so', (
    tester,
  ) async {
    await pumpCard(
      tester,
      testSummary(stages: testBriefs([StageStatus.submitted])),
    );

    expect(find.byKey(ProjectCard.attentionKey(1)), findsOneWidget);
    expect(find.text(l10n.attentionReview(1, 'Stage 1')), findsOneWidget);
  });

  testWidgets('Given a viewer then nothing waits on the card', (tester) async {
    await pumpCard(
      tester,
      testSummary(
        role: ProjectRole.viewer,
        stages: testBriefs([StageStatus.submitted]),
      ),
    );

    expect(find.byKey(ProjectCard.attentionKey(1)), findsNothing);
  });

  testWidgets('Given no photo yet then there is no cover', (tester) async {
    await pumpCard(tester, testSummary());

    expect(find.text(l10n.latestPhoto), findsNothing);
  });
}
