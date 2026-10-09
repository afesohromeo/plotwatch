import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

import '../../../helpers/helpers.dart';

// Plan: doc/04e-m5-review-realtime.md, group E (M5-5 to M5-7,
// _standards/14 §3.3): pages keyed by the last ID; live events on top,
// each once even if a page brings it too.
void main() {
  late MockActivityRepository repository;
  late StreamController<LiveUpdate<ActivityEntry>> live;

  final newest = testActivity(id: 12);
  final older = testActivity(id: 11);
  final page = PaginatedList(
    content: [newest, older],
    pagination: const Pagination(size: 20),
  );

  setUpAll(setUpTestLocalization);

  setUp(() {
    repository = MockActivityRepository();
    live = StreamController<LiveUpdate<ActivityEntry>>();
    when(
      () => repository.fetchActivity(1, beforeId: null, size: 20),
    ).thenAnswer((_) async => page);
    when(
      () => repository.watchActivity(1, afterId: 12),
    ).thenAnswer((_) => live.stream);
  });

  // Not awaited: close() only completes once someone has listened.
  tearDown(() {
    live.close();
  });

  FeedBloc build() => FeedBloc(activityRepository: repository);

  blocTest<FeedBloc, FeedState>(
    'Given the first page then it shows it and goes live from its newest '
    'event',
    build: build,
    act: (bloc) => bloc.add(const FeedEvent.fetchActivity(projectId: 1)),
    expect: () => [
      const FeedState(projectId: 1, activityListStatus: GenericStatus.loading),
      FeedState(
        projectId: 1,
        activityListStatus: GenericStatus.success,
        activity: [newest, older],
        paginatedActivity: [newest, older],
        maxActivity: true,
        activityPageKey: 11,
      ),
    ],
    verify: (_) =>
        verify(() => repository.watchActivity(1, afterId: 12)).called(1),
  );

  blocTest<FeedBloc, FeedState>(
    'Given a next page then it asks for events before the last ID',
    build: build,
    setUp: () => when(() => repository.fetchActivity(1, beforeId: 11, size: 20))
        .thenAnswer(
          (_) async => const PaginatedList(
            content: [],
            pagination: Pagination(size: 20),
          ),
        ),
    seed: () => FeedState(
      projectId: 1,
      activity: [newest, older],
      activityPageKey: 11,
      activityListStatus: GenericStatus.success,
    ),
    act: (bloc) =>
        bloc.add(const FeedEvent.fetchActivity(projectId: 1, pageKey: 11)),
    skip: 1,
    expect: () => [
      FeedState(
        projectId: 1,
        activityListStatus: GenericStatus.success,
        activity: [newest, older],
        maxActivity: true,
        activityPageKey: 11,
      ),
    ],
    // Only the first page starts the live stream.
    verify: (_) => verifyNever(
      () => repository.watchActivity(any(), afterId: any(named: 'afterId')),
    ),
  );

  blocTest<FeedBloc, FeedState>(
    'Given a live event then it goes on top, once even if it comes again',
    build: build,
    act: (bloc) async {
      bloc.add(const FeedEvent.fetchActivity(projectId: 1));
      await pumpEventQueue();
      final fresh = testActivity(id: 13);
      live
        ..add(LiveItem(fresh))
        ..add(LiveItem(fresh))
        // Already shown by the page.
        ..add(LiveItem(newest));
      await pumpEventQueue();
    },
    skip: 2,
    expect: () => [
      isA<FeedState>()
          .having((s) => s.activity.map((e) => e.event.id), 'ids', [13, 12, 11])
          .having((s) => s.liveCount, 'liveCount', 1),
    ],
  );

  blocTest<FeedBloc, FeedState>(
    'Given a page that also holds a live event then the event is not '
    'repeated',
    build: build,
    setUp: () => when(() => repository.fetchActivity(1, beforeId: 13, size: 20))
        .thenAnswer(
          (_) async => PaginatedList(
            content: [testActivity(id: 12), older],
            pagination: const Pagination(size: 20),
          ),
        ),
    seed: () => FeedState(
      projectId: 1,
      activity: [testActivity(id: 13), newest],
      activityPageKey: 13,
      activityListStatus: GenericStatus.success,
    ),
    act: (bloc) =>
        bloc.add(const FeedEvent.fetchActivity(projectId: 1, pageKey: 13)),
    skip: 1,
    expect: () => [
      isA<FeedState>()
          .having((s) => s.activity.map((e) => e.event.id), 'ids', [13, 12, 11])
          .having(
            (s) => s.paginatedActivity.map((e) => e.event.id),
            'new on this page',
            [11],
          ),
    ],
  );

  blocTest<FeedBloc, FeedState>(
    'Given the connection drops and comes back then "Reconnecting…" shows '
    'and goes (M5-6)',
    build: build,
    act: (bloc) async {
      bloc.add(const FeedEvent.fetchActivity(projectId: 1));
      await pumpEventQueue();
      live.add(const LiveReconnecting(Duration(seconds: 2)));
      await pumpEventQueue();
      live.add(const LiveConnected());
      await pumpEventQueue();
    },
    skip: 2,
    expect: () => [
      isA<FeedState>().having((s) => s.reconnecting, 'reconnecting', isTrue),
      isA<FeedState>().having((s) => s.reconnecting, 'reconnecting', isFalse),
    ],
  );

  blocTest<FeedBloc, FeedState>(
    'Given the feed fails to load then the error is shown',
    build: build,
    setUp: () => when(
      () => repository.fetchActivity(1, beforeId: null, size: 20),
    ).thenThrow(const NetworkException()),
    act: (bloc) => bloc.add(const FeedEvent.fetchActivity(projectId: 1)),
    skip: 1,
    expect: () => [
      isA<FeedState>()
          .having((s) => s.activityListStatus, 'status', GenericStatus.failure)
          .having(
            (s) => s.activityListError,
            'error',
            setUpTestLocalization().networkError,
          ),
    ],
  );
}
