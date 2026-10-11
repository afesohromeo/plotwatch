import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

import '../../../helpers/helpers.dart';

class MockProjectOverviewBloc
    extends MockBloc<ProjectOverviewEvent, ProjectOverviewState>
    implements ProjectOverviewBloc {}

// Plan: doc/04b-m2-projects-site-members.md, group E.
void main() {
  late AppLocalizations l10n;
  late MockProjectOverviewBloc bloc;
  late MockFeedBloc feedBloc;
  late MockMoneyBloc moneyBloc;

  setUpAll(() {
    l10n = setUpTestLocalization();
    registerFallbackValue(const ProjectOverviewEvent.resetFlowStep());
  });
  setUp(() {
    bloc = MockProjectOverviewBloc();
    feedBloc = MockFeedBloc();
    when(() => feedBloc.state).thenReturn(const FeedState());
    // The Money card (doc/04f M6-11).
    moneyBloc = MockMoneyBloc();
    when(() => moneyBloc.state).thenReturn(const MoneyState());
  });

  Future<void> pumpWith(WidgetTester tester, ProjectOverviewState state) {
    when(() => bloc.state).thenReturn(state);
    return tester.pumpApp(
      MultiBlocProvider(
        providers: [
          BlocProvider<ProjectOverviewBloc>.value(value: bloc),
          BlocProvider<FeedBloc>.value(value: feedBloc),
          BlocProvider<MoneyBloc>.value(value: moneyBloc),
        ],
        child: const ProjectOverviewPage(projectId: 1),
      ),
    );
  }

  ProjectOverviewState loaded(ProjectOverview overview) => ProjectOverviewState(
    overviewStatus: GenericStatus.success,
    overview: overview,
  );

  testWidgets('Given the page opens then it loads that project', (
    tester,
  ) async {
    await pumpWith(tester, const ProjectOverviewState());

    verify(
      () => bloc.add(const ProjectOverviewEvent.fetchProject(projectId: 1)),
    ).called(1);
  });

  testWidgets('Given a loaded project when refresh is tapped then it reloads', (
    tester,
  ) async {
    await pumpWith(tester, loaded(testOverview(role: ProjectRole.viewer)));

    await tester.tap(find.byKey(ProjectOverviewPage.refreshButtonKey));
    await tester.pump();

    verify(
      () => bloc.add(const ProjectOverviewEvent.fetchProject(projectId: 1)),
    ).called(2);
  });

  testWidgets('Given a loaded project when it is pulled down then it reloads', (
    tester,
  ) async {
    await pumpWith(tester, loaded(testOverview(role: ProjectRole.viewer)));

    await tester.fling(
      find.text(l10n.projectRoleViewer),
      const Offset(0, 400),
      1000,
    );
    await tester.pumpAndSettle();

    verify(
      () => bloc.add(const ProjectOverviewEvent.fetchProject(projectId: 1)),
    ).called(2);
  });

  testWidgets('Given the project is loading then it shows progress', (
    tester,
  ) async {
    await pumpWith(
      tester,
      const ProjectOverviewState(overviewStatus: GenericStatus.loading),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets(
    'Given the owner then the details, edit and status actions are shown',
    (tester) async {
      await pumpWith(
        tester,
        loaded(
          testOverview(project: testProject(status: ProjectStatus.active)),
        ),
      );

      expect(find.text('House in Bafoussam'), findsWidgets);
      expect(find.text(l10n.projectStatusActive), findsOneWidget);
      expect(find.text(l10n.projectRoleOwner), findsOneWidget);
      expect(find.byKey(ProjectOverviewPage.editButtonKey), findsOneWidget);
      expect(find.byKey(ProjectOverviewPage.statusButtonKey), findsOneWidget);
    },
  );

  testWidgets('Given a site manager then the owner actions are hidden', (
    tester,
  ) async {
    await pumpWith(tester, loaded(testOverview(role: ProjectRole.siteManager)));

    expect(find.byKey(ProjectOverviewPage.editButtonKey), findsNothing);
    expect(find.byKey(ProjectOverviewPage.statusButtonKey), findsNothing);
  });

  testWidgets(
    'Given a draft project then the owner can\'t change its status yet',
    (tester) async {
      await pumpWith(tester, loaded(testOverview()));

      expect(find.byKey(ProjectOverviewPage.statusButtonKey), findsNothing);
    },
  );

  final waiting = {
    ProjectRole.owner: () => l10n.siteWaitingOwner,
    ProjectRole.siteManager: () => l10n.siteWaitingManager,
    ProjectRole.viewer: () => l10n.siteWaiting,
  };
  for (final MapEntry(key: role, value: message) in waiting.entries) {
    testWidgets(
      'Given no site yet then the ${role.name} is told what happens next',
      (tester) async {
        await pumpWith(tester, loaded(testOverview(role: role)));

        expect(find.text(message()), findsOneWidget);
      },
    );
  }

  // doc/04c M3-11: the plan in short, opening the stage plan.
  testWidgets('Given a stage plan then the card shows the stage count, the '
      'total budget and the progress', (tester) async {
    await pumpWith(
      tester,
      loaded(
        testOverview(
          role: ProjectRole.viewer,
          stageCount: 10,
          budgetTotalMinor: 1500000,
          progressPercent: 40,
          approvedStageCount: 3,
        ),
      ),
    );

    expect(find.byKey(ProjectOverviewPage.stagesCardKey), findsOneWidget);
    expect(find.text(l10n.stageCount(10)), findsOneWidget);
    expect(
      find.text(formatMoney(1500000, 'XAF', locale: 'en')),
      findsOneWidget,
    );
    // doc/04e M5-F2: the stage count beside the budget share.
    expect(find.text(l10n.progressBudgetAndStages(40, 3, 10)), findsOneWidget);
  });

  // G-7, G-12 and H-2/H-3: which site buttons each role sees in each state.
  const localize = ProjectOverviewPage.localizeButtonKey;
  const review = ProjectOverviewPage.reviewSiteButtonKey;
  const editSite = ProjectOverviewPage.editSiteButtonKey;
  final buttons = <String, (ProjectOverview, Set<Key>)>{
    'the owner, no site': (testOverview(), {localize}),
    'the site manager, no site': (
      testOverview(role: ProjectRole.siteManager),
      {localize},
    ),
    'the owner, a proposal pending': (
      testOverview(pendingSiteProposal: testProposal()),
      {review},
    ),
    'the site manager, a proposal pending': (
      testOverview(
        role: ProjectRole.siteManager,
        pendingSiteProposal: testProposal(),
      ),
      {localize},
    ),
    'the site manager, a validated site': (
      testOverview(role: ProjectRole.siteManager, site: testSite()),
      {localize},
    ),
    'the owner, a validated site': (
      testOverview(site: testSite()),
      {localize, editSite},
    ),
    'the owner, a validated site and a new proposal pending': (
      testOverview(site: testSite(), pendingSiteProposal: testProposal()),
      {review, editSite},
    ),
    'a viewer, a validated site': (
      testOverview(role: ProjectRole.viewer, site: testSite()),
      {},
    ),
    'a viewer, a proposal pending': (
      testOverview(
        role: ProjectRole.viewer,
        pendingSiteProposal: testProposal(),
      ),
      {},
    ),
  };
  for (final MapEntry(key: who, value: (overview, expected))
      in buttons.entries) {
    testWidgets('Given $who then the site section offers '
        '${expected.isEmpty ? 'no site button' : expected.join(', ')}', (
      tester,
    ) async {
      await pumpWith(tester, loaded(overview));

      for (final key in [localize, review, editSite]) {
        expect(
          find.byKey(key),
          expected.contains(key) ? findsOneWidget : findsNothing,
          reason: '$key',
        );
      }
    });
  }

  testWidgets(
    'Given a validated site then the owner can move it with a new reading',
    (tester) async {
      await pumpWith(tester, loaded(testOverview(site: testSite())));

      expect(find.text(l10n.proposeNewLocationAction), findsOneWidget);
      expect(find.text(l10n.editSiteAction), findsOneWidget);
    },
  );

  testWidgets(
    'Given a proposal pending then the site manager is told it waits for '
    'the owner',
    (tester) async {
      await pumpWith(
        tester,
        loaded(
          testOverview(
            role: ProjectRole.siteManager,
            pendingSiteProposal: testProposal(),
          ),
        ),
      );

      expect(find.text(l10n.siteProposalPendingManager), findsOneWidget);
    },
  );

  testWidgets(
    'Given a validated site then its Plus Code and radius are shown',
    (tester) async {
      await pumpWith(tester, loaded(testOverview(site: testSite())));

      expect(find.text('6FW6FCHF+4V'), findsOneWidget);
      expect(find.text(l10n.radiusMeters(50)), findsOneWidget);
    },
  );

  testWidgets('Given a status change when it is chosen then it is sent', (
    tester,
  ) async {
    await pumpWith(
      tester,
      loaded(testOverview(project: testProject(status: ProjectStatus.active))),
    );

    await tester.tap(find.byKey(ProjectOverviewPage.statusButtonKey));
    await tester.pumpAndSettle();
    await tester.tap(find.text(l10n.projectStatusPaused).last);
    await tester.pump();

    verify(
      () => bloc.add(
        const ProjectOverviewEvent.changeStatus(status: ProjectStatus.paused),
      ),
    ).called(1);
  });

  // doc/04e M5-9 b and M5-7.
  group('Given the progress updates and the latest activity', () {
    final active = testProject(status: ProjectStatus.active);

    testWidgets('then the site manager of an active project can post an '
        'update', (tester) async {
      await pumpWith(
        tester,
        loaded(testOverview(project: active, role: ProjectRole.siteManager)),
      );

      expect(
        find.byKey(ProjectOverviewPage.postUpdateButtonKey),
        findsOneWidget,
      );
    });

    testWidgets('then the owner and a draft project have no update button', (
      tester,
    ) async {
      await pumpWith(tester, loaded(testOverview(project: active)));
      expect(find.byKey(ProjectOverviewPage.postUpdateButtonKey), findsNothing);

      await pumpWith(
        tester,
        loaded(testOverview(role: ProjectRole.siteManager)),
      );
      expect(find.byKey(ProjectOverviewPage.postUpdateButtonKey), findsNothing);
    });

    testWidgets('then the latest activity is shown', (tester) async {
      await pumpWith(tester, loaded(testOverview(role: ProjectRole.viewer)));

      expect(find.byType(LatestActivity), findsOneWidget);
    });
  });

  // doc/04e C-3.
  group('Given a closed project', () {
    for (final status in [ProjectStatus.completed, ProjectStatus.archived]) {
      testWidgets('when it is ${status.name} then a banner says it is '
          'read-only and the owner has no edit or site buttons', (
        tester,
      ) async {
        await pumpWith(
          tester,
          loaded(
            testOverview(
              project: testProject(status: status),
              site: testSite(),
            ),
          ),
        );

        expect(find.byKey(ProjectOverviewPage.closedBannerKey), findsOneWidget);
        expect(
          find.text(
            status == ProjectStatus.archived
                ? l10n.projectArchivedBanner
                : l10n.projectCompletedBanner,
          ),
          findsOneWidget,
        );
        expect(find.byKey(ProjectOverviewPage.editButtonKey), findsNothing);
        expect(find.byKey(ProjectOverviewPage.localizeButtonKey), findsNothing);
        expect(find.byKey(ProjectOverviewPage.editSiteButtonKey), findsNothing);
      });
    }

    testWidgets('when it is completed then the owner can still change its '
        'status (reopen or archive)', (tester) async {
      await pumpWith(
        tester,
        loaded(
          testOverview(project: testProject(status: ProjectStatus.completed)),
        ),
      );

      expect(find.byKey(ProjectOverviewPage.statusButtonKey), findsOneWidget);
    });
  });

  // doc/04e D-2, D-3.
  group('Given the owner changes the status', () {
    Future<void> choose(WidgetTester tester, ProjectStatus status) async {
      await tester.tap(find.byKey(ProjectOverviewPage.statusButtonKey));
      await tester.pumpAndSettle();
      await tester.tap(find.text(status.label(l10n)).last);
      await tester.pumpAndSettle();
    }

    final active = testProject(status: ProjectStatus.active);

    testWidgets('when completing with unfinished stages then it warns first '
        'and completes only once confirmed', (tester) async {
      await pumpWith(
        tester,
        loaded(
          testOverview(project: active, stageCount: 4, approvedStageCount: 2),
        ),
      );

      await choose(tester, ProjectStatus.completed);

      expect(
        find.textContaining(l10n.completeProjectUnfinished(2, 4)),
        findsOneWidget,
      );
      verifyNever(
        () => bloc.add(
          const ProjectOverviewEvent.changeStatus(
            status: ProjectStatus.completed,
          ),
        ),
      );

      await tester.tap(find.text(l10n.completeProjectAction));
      await tester.pumpAndSettle();
      verify(
        () => bloc.add(
          const ProjectOverviewEvent.changeStatus(
            status: ProjectStatus.completed,
          ),
        ),
      ).called(1);
    });

    testWidgets('when every stage is approved then there is no warning', (
      tester,
    ) async {
      await pumpWith(
        tester,
        loaded(
          testOverview(project: active, stageCount: 2, approvedStageCount: 2),
        ),
      );

      await choose(tester, ProjectStatus.completed);

      expect(find.textContaining(l10n.completeProjectReopen), findsOneWidget);
      expect(
        find.textContaining(l10n.completeProjectUnfinished(0, 2)),
        findsNothing,
      );
    });

    testWidgets('when pausing then it happens at once', (tester) async {
      await pumpWith(tester, loaded(testOverview(project: active)));

      await choose(tester, ProjectStatus.paused);

      verify(
        () => bloc.add(
          const ProjectOverviewEvent.changeStatus(status: ProjectStatus.paused),
        ),
      ).called(1);
    });

    testWidgets('when archiving then the name must be typed first', (
      tester,
    ) async {
      await pumpWith(
        tester,
        loaded(
          testOverview(project: testProject(status: ProjectStatus.completed)),
        ),
      );
      final name = testProject().name;

      await choose(tester, ProjectStatus.archived);
      FilledButton archive() => tester.widget<FilledButton>(
        find.byKey(ProjectOverviewPage.archiveConfirmKey),
      );
      expect(archive().onPressed, isNull);

      await tester.enterText(
        find.byKey(ProjectOverviewPage.archiveNameFieldKey),
        'something else',
      );
      await tester.pump();
      expect(archive().onPressed, isNull);

      await tester.enterText(
        find.byKey(ProjectOverviewPage.archiveNameFieldKey),
        '  ${name.toUpperCase()} ',
      );
      await tester.pump();
      await tester.tap(find.byKey(ProjectOverviewPage.archiveConfirmKey));
      await tester.pumpAndSettle();

      verify(
        () => bloc.add(
          const ProjectOverviewEvent.changeStatus(
            status: ProjectStatus.archived,
          ),
        ),
      ).called(1);
    });
  });

  // doc/05 §9 DP-1, DP-4.
  group('Given the redrawn Overview tab', () {
    testWidgets('when a stage waits for the owner then the review card shows '
        'it', (tester) async {
      await pumpWith(
        tester,
        loaded(
          testOverview(
            project: testProject(status: ProjectStatus.active),
            stages: testBriefs([StageStatus.approved, StageStatus.submitted]),
          ),
        ),
      );

      expect(find.byKey(ProjectOverviewPage.attentionCardKey), findsOneWidget);
      expect(find.text(l10n.attentionReview(1, 'Stage 2')), findsOneWidget);
    });

    testWidgets('when the members are loaded then the card counts them', (
      tester,
    ) async {
      await pumpWith(
        tester,
        loaded(testOverview()).copyWith(
          members: [
            testMember(),
            testMember(
              id: 2,
              fullName: 'Bob Mbarga',
              role: ProjectRole.siteManager,
            ),
          ],
        ),
      );

      expect(find.byKey(ProjectOverviewPage.membersButtonKey), findsOneWidget);
      expect(find.text(l10n.membersCount(2)), findsOneWidget);
      expect(find.text('AL'), findsOneWidget);
    });
  });
}
