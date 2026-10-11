import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

import '../../../helpers/helpers.dart';

// Plan: doc/04e-m5-review-realtime.md, group E (M5-7): the project page's
// latest 5 with "See all", the full feed, live events on top, tap opens
// the source.
class MockProjectOverviewBloc
    extends MockBloc<ProjectOverviewEvent, ProjectOverviewState>
    implements ProjectOverviewBloc {}

void main() {
  late AppLocalizations l10n;
  late MockFeedBloc bloc;

  final events = [
    for (var id = 7; id >= 1; id--)
      testActivity(id: id, payload: {'name': 'Stage $id'}),
  ];

  setUpAll(() {
    l10n = setUpTestLocalization();
    registerFallbackValue(const FeedEvent.refreshActivity());
  });
  setUp(() => bloc = MockFeedBloc());

  GoRouter router(Widget page) => GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) =>
            BlocProvider<FeedBloc>.value(value: bloc, child: page),
        routes: [
          GoRoute(
            name: feedRouteName,
            path: 'projects/:projectId/feed',
            builder: (context, state) => const Text('the feed'),
          ),
          GoRoute(
            name: stageRouteName,
            path: 'projects/:projectId/stages/:stageId',
            builder: (context, state) =>
                Text('stage ${state.pathParameters['stageId']}'),
          ),
        ],
      ),
    ],
  );

  FeedState loaded(List<ActivityEntry> activity) => FeedState(
    projectId: 1,
    activity: activity,
    paginatedActivity: activity,
    maxActivity: true,
    activityListStatus: GenericStatus.success,
  );

  group('Given the latest activity on the project page', () {
    Future<void> pumpLatest(WidgetTester tester, FeedState state) async {
      when(() => bloc.state).thenReturn(state);
      await tester.pumpRouterApp(
        router(
          const Scaffold(
            body: SingleChildScrollView(child: LatestActivity(projectId: 1)),
          ),
        ),
      );
    }

    testWidgets('then it loads the 5 newest events', (tester) async {
      await pumpLatest(tester, const FeedState());

      verify(
        () => bloc.add(const FeedEvent.fetchActivity(projectId: 1, size: 5)),
      ).called(1);
    });

    testWidgets('then it shows at most 5, newest first, with "See all"', (
      tester,
    ) async {
      await pumpLatest(tester, loaded(events));

      expect(find.byType(ActivityTile), findsNWidgets(5));
      expect(find.text(events.first.sentence(l10n)), findsOneWidget);
      expect(find.text(events.last.sentence(l10n)), findsNothing);

      await tester.tap(find.byKey(LatestActivity.seeAllButtonKey));
      await tester.pumpAndSettle();
      expect(find.text('the feed'), findsOneWidget);
    });

    testWidgets('when there is nothing yet then it says so', (tester) async {
      await pumpLatest(tester, loaded(const []));

      expect(find.text(l10n.activityEmpty), findsOneWidget);
    });

    testWidgets('when it failed then it can be tried again', (tester) async {
      await pumpLatest(
        tester,
        const FeedState(
          projectId: 1,
          activityListStatus: GenericStatus.failure,
          activityListError: 'No connection',
        ),
      );
      clearInteractions(bloc);

      await tester.tap(find.byKey(LatestActivity.retryButtonKey));

      verify(
        () => bloc.add(const FeedEvent.fetchActivity(projectId: 1, size: 5)),
      ).called(1);
    });

    testWidgets('when the stream is down then "Reconnecting…" shows', (
      tester,
    ) async {
      await pumpLatest(tester, loaded(events).copyWith(reconnecting: true));

      expect(find.text(l10n.reconnecting), findsOneWidget);
    });

    testWidgets('when an event is tapped then its source opens', (
      tester,
    ) async {
      await pumpLatest(tester, loaded(events));

      await tester.tap(find.byKey(ActivityTile.keyFor(7)));
      await tester.pumpAndSettle();

      expect(find.text('stage 2'), findsOneWidget);
    });
  });

  group('Given the full feed', () {
    testWidgets('when a live event arrives then it appears on top', (
      tester,
    ) async {
      final first = loaded(events.sublist(1));
      final fresh = events.first;
      whenListen(
        bloc,
        Stream.fromIterable([
          first,
          first.copyWith(activity: [fresh, ...first.activity], liveCount: 1),
        ]),
        initialState: const FeedState(),
      );

      await tester.pumpRouterApp(router(const FeedPage(projectId: 1)));
      await tester.pumpAndSettle();

      final tiles = tester.widgetList<ActivityTile>(find.byType(ActivityTile));
      expect(tiles.first.entry.event.id, 7);
      expect(find.text(fresh.sentence(l10n)), findsOneWidget);
    });
  });

  // doc/05 §9 DP-9: the Activity tab is grouped by day.
  testWidgets('Given events on two days then each day has its heading', (
    tester,
  ) async {
    final today = testActivity(id: 2);
    final before = testActivity(id: 1);
    final earlier = ActivityEntry(
      event: before.event.copyWith(createdAt: DateTime.utc(2026, 10, 1, 10)),
      actorName: before.actorName,
    );
    when(() => bloc.state).thenReturn(loaded([today, earlier]));
    whenListen(
      bloc,
      Stream.value(loaded([today, earlier])),
      initialState: const FeedState(),
    );

    await tester.pumpRouterApp(router(const FeedPage(projectId: 1)));
    await tester.pumpAndSettle();

    expect(find.text(dayHeading(today.event.createdAt, l10n)), findsOneWidget);
    expect(
      find.text(dayHeading(earlier.event.createdAt, l10n)),
      findsOneWidget,
    );
  });

  // doc/05 §9.5: kind chips and a stage picker, sent with every page.
  group('Given the feed filters', () {
    late StreamController<FeedState> states;
    late MockProjectOverviewBloc overviewBloc;

    setUp(() {
      states = StreamController<FeedState>();
      overviewBloc = MockProjectOverviewBloc();
      when(() => overviewBloc.state).thenReturn(
        ProjectOverviewState(
          overview: testOverview(
            stages: [
              StageBrief(
                id: 21,
                name: 'Foundation',
                status: StageStatus.approved,
              ),
              StageBrief(id: 22, name: 'Walls', status: StageStatus.inProgress),
            ],
          ),
        ),
      );
    });
    tearDown(() {
      states.close();
    });

    Future<void> pumpFeed(WidgetTester tester) async {
      whenListen(bloc, states.stream, initialState: const FeedState());
      await tester.pumpRouterApp(
        router(
          BlocProvider<ProjectOverviewBloc>.value(
            value: overviewBloc,
            child: const FeedPage(projectId: 1),
          ),
        ),
      );
      await tester.pump();
      // The first page loaded, as before anyone taps a chip.
      states.add(loaded(events));
      await tester.pump();
      await tester.pump();
    }

    Future<void> refreshed(WidgetTester tester) async {
      states.add(const FeedState(activityRefreshController: true));
      await tester.pump();
      // The list asks for its first page a frame later.
      await tester.pump();
    }

    testWidgets('when a kind is chosen then the feed reloads with its types', (
      tester,
    ) async {
      await pumpFeed(tester);

      await tester.tap(
        find.byKey(FilterChips.chipKey(FeedPage.kindChipsPrefix, 1)),
      );
      await tester.pump();
      verify(() => bloc.add(const FeedEvent.refreshActivity())).called(1);
      await refreshed(tester);

      verify(
        () => bloc.add(
          FeedEvent.fetchActivity(
            projectId: 1,
            types: ActivityKind.photos.types.toList(),
          ),
        ),
      ).called(1);
    });

    testWidgets('when a stage is picked then the feed reloads with it', (
      tester,
    ) async {
      await pumpFeed(tester);

      // The chips row scrolls sideways: the picker is at its end.
      await tester.ensureVisible(find.byKey(const Key(FeedPage.stagePickerPrefix)));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key(FeedPage.stagePickerPrefix)));
      await tester.pumpAndSettle();
      expect(find.text('Walls'), findsOneWidget);
      await tester.tap(
        find.byKey(PickerPill.optionKey(FeedPage.stagePickerPrefix, 2)),
      );
      await tester.pumpAndSettle();
      await refreshed(tester);

      verify(
        () =>
            bloc.add(const FeedEvent.fetchActivity(projectId: 1, stageId: 22)),
      ).called(1);
    });

    testWidgets('when nothing matches then it offers to clear the filters', (
      tester,
    ) async {
      await pumpFeed(tester);
      await tester.tap(
        find.byKey(FilterChips.chipKey(FeedPage.kindChipsPrefix, 3)),
      );
      await tester.pump();
      await refreshed(tester);
      states.add(loaded(const []));
      await tester.pump();
      await tester.pump();

      expect(find.text(l10n.noMatches), findsOneWidget);
      expect(find.text(l10n.activityEmpty), findsNothing);
    });
  });
}
