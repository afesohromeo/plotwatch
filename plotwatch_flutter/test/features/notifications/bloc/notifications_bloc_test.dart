import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

import '../../../helpers/helpers.dart';

// Plan: doc/04e-m5-review-realtime.md, group E (M5-4, M5-6): the unread
// badge follows live notifications and marking read.
void main() {
  late MockNotificationRepository repository;
  late StreamController<LiveUpdate<AppNotification>> live;

  final latest = testNotification(id: 7);

  setUpAll(setUpTestLocalization);

  setUp(() {
    repository = MockNotificationRepository();
    live = StreamController<LiveUpdate<AppNotification>>();
    when(repository.fetchUnreadCount).thenAnswer((_) async => 2);
    when(() => repository.fetchNotifications(size: 1)).thenAnswer(
      (_) async => PaginatedList(
        content: [latest],
        pagination: const Pagination(size: 1),
      ),
    );
    when(
      () => repository.watchNotifications(afterId: 7),
    ).thenAnswer((_) => live.stream);
  });

  // Not awaited: close() only completes once someone has listened.
  tearDown(() {
    live.close();
  });

  NotificationsBloc build() =>
      NotificationsBloc(notificationRepository: repository);

  blocTest<NotificationsBloc, NotificationsState>(
    'Given sign-in then the badge shows the unread count and the stream '
    'starts after the newest notification',
    build: build,
    act: (bloc) => bloc.add(const NotificationsEvent.started()),
    expect: () => [
      const NotificationsState(watching: true),
      const NotificationsState(watching: true, unreadCount: 2),
    ],
    verify: (_) =>
        verify(() => repository.watchNotifications(afterId: 7)).called(1),
  );

  blocTest<NotificationsBloc, NotificationsState>(
    'Given a live notification then it goes on top and the badge goes up, '
    'once',
    build: build,
    act: (bloc) async {
      bloc.add(const NotificationsEvent.started());
      await pumpEventQueue();
      final fresh = testNotification(id: 8);
      live
        ..add(LiveItem(fresh))
        ..add(LiveItem(fresh));
      await pumpEventQueue();
    },
    skip: 2,
    expect: () => [
      isA<NotificationsState>()
          .having((s) => s.unreadCount, 'unread', 3)
          .having((s) => s.notifications.map((n) => n.id), 'ids', [8]),
    ],
  );

  blocTest<NotificationsBloc, NotificationsState>(
    'Given an unread notification when it is marked read then the badge '
    'goes down',
    build: build,
    setUp: () => when(() => repository.markRead(7)).thenAnswer((_) async {}),
    seed: () => NotificationsState(unreadCount: 2, notifications: [latest]),
    act: (bloc) => bloc.add(const NotificationsEvent.markRead(7)),
    expect: () => [
      isA<NotificationsState>()
          .having((s) => s.unreadCount, 'unread', 1)
          .having((s) => s.notifications.single.isUnread, 'unread', isFalse),
    ],
  );

  blocTest<NotificationsBloc, NotificationsState>(
    'Given notifications when all are marked read then the badge clears',
    build: build,
    setUp: () => when(repository.markAllRead).thenAnswer((_) async {}),
    seed: () => NotificationsState(
      unreadCount: 2,
      notifications: [latest, testNotification(id: 6)],
    ),
    act: (bloc) => bloc.add(const NotificationsEvent.markAllRead()),
    expect: () => [
      isA<NotificationsState>()
          .having((s) => s.unreadCount, 'unread', 0)
          .having(
            (s) => s.notifications.where((n) => n.isUnread),
            'unread ones',
            isEmpty,
          ),
    ],
  );

  blocTest<NotificationsBloc, NotificationsState>(
    'Given marking read fails then nothing changes',
    build: build,
    setUp: () =>
        when(() => repository.markRead(7)).thenThrow(const NetworkException()),
    seed: () => NotificationsState(unreadCount: 2, notifications: [latest]),
    act: (bloc) => bloc.add(const NotificationsEvent.markRead(7)),
    expect: () => <NotificationsState>[],
  );

  blocTest<NotificationsBloc, NotificationsState>(
    'Given sign-out then everything is forgotten',
    build: build,
    seed: () => NotificationsState(
      watching: true,
      unreadCount: 2,
      notifications: [latest],
    ),
    act: (bloc) => bloc.add(const NotificationsEvent.stopped()),
    expect: () => [const NotificationsState()],
  );

  blocTest<NotificationsBloc, NotificationsState>(
    'Given a page request then older notifications load below',
    build: build,
    setUp: () =>
        when(
          () => repository.fetchNotifications(beforeId: 7, size: 20),
        ).thenAnswer(
          (_) async => PaginatedList(
            content: [testNotification(id: 6)],
            pagination: const Pagination(size: 20),
          ),
        ),
    seed: () => NotificationsState(
      notifications: [latest],
      notificationsPageKey: 7,
      notificationsListStatus: GenericStatus.success,
    ),
    act: (bloc) =>
        bloc.add(const NotificationsEvent.fetchNotifications(pageKey: 7)),
    skip: 1,
    expect: () => [
      isA<NotificationsState>()
          .having((s) => s.notifications.map((n) => n.id), 'ids', [7, 6])
          .having((s) => s.notificationsPageKey, 'next key', 6)
          .having((s) => s.maxNotifications, 'last page', isTrue),
    ],
  );

  // doc/05 §9.5: only the unread ones, on the server.
  blocTest<NotificationsBloc, NotificationsState>(
    'Given Unread is chosen then only the unread ones are asked for',
    build: build,
    setUp: () =>
        when(
          () => repository.fetchNotifications(size: 20, unreadOnly: true),
        ).thenAnswer(
          (_) async => PaginatedList(
            content: [testNotification(id: 9)],
            pagination: const Pagination(size: 20),
          ),
        ),
    act: (bloc) =>
        bloc.add(const NotificationsEvent.fetchNotifications(unreadOnly: true)),
    skip: 1,
    expect: () => [
      isA<NotificationsState>().having(
        (s) => s.notifications.map((n) => n.id),
        'ids',
        [9],
      ),
    ],
  );
}
