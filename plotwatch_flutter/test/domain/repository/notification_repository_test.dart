import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

import '../../helpers/helpers.dart';

// Plan: doc/04e-m5-review-realtime.md, group E.
void main() {
  late MockNotificationApiProvider apiProvider;
  late NotificationRepository repository;

  setUp(() {
    apiProvider = MockNotificationApiProvider();
    repository = NotificationRepository(
      apiProvider: apiProvider,
      backoff: (_) => Duration.zero,
    );
  });

  test(
    'Given a page request then it asks for notifications before that ID',
    () async {
      final items = [testNotification(id: 5)];
      when(
        () => apiProvider.list(beforeId: 6, pageSize: 20),
      ).thenAnswer((_) async => NotificationPage(items: items, unreadCount: 1));

      final page = await repository.fetchNotifications(beforeId: 6, size: 20);

      expect(page.content, items);
    },
  );

  test('Given the unread count, mark read and mark all read then the calls '
      'go through', () async {
    when(apiProvider.unreadCount).thenAnswer((_) async => 3);
    when(() => apiProvider.markRead(5)).thenAnswer((_) async {});
    when(apiProvider.markAllRead).thenAnswer((_) async {});

    expect(await repository.fetchUnreadCount(), 3);
    await repository.markRead(5);
    await repository.markAllRead();

    verify(() => apiProvider.markRead(5)).called(1);
    verify(apiProvider.markAllRead).called(1);
  });

  test('Given the live stream then it starts after the given ID', () async {
    final notification = testNotification(id: 8);
    when(
      () => apiProvider.watch(afterId: 7),
    ).thenAnswer((_) => Stream.value(notification));

    final first = await repository.watchNotifications(afterId: 7).first;

    expect(first, LiveItem(notification));
  });
}
