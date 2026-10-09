import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

import '../../helpers/helpers.dart';

// Plan: doc/04e-m5-review-realtime.md, group E.
void main() {
  late MockActivityApiProvider apiProvider;
  late ActivityRepository repository;

  setUp(() {
    apiProvider = MockActivityApiProvider();
    repository = ActivityRepository(
      apiProvider: apiProvider,
      backoff: (_) => Duration.zero,
    );
  });

  test('Given a page request then it asks for events before that ID and '
      'returns them as a page', () async {
    final items = [testActivity(id: 9), testActivity(id: 8)];
    when(
      () => apiProvider.list(1, beforeId: 10, pageSize: 20),
    ).thenAnswer((_) async => ActivityPage(items: items));

    final page = await repository.fetchActivity(1, beforeId: 10, size: 20);

    expect(page.content, items);
    expect(page.pagination.size, 20);
  });

  test('Given a drop then the feed subscribes again after the last event '
      'received (M5-6)', () async {
    final first = testActivity(id: 12);
    final second = testActivity(id: 13);
    when(
      () => apiProvider.watch(1, afterId: 11),
    ).thenAnswer((_) => Stream.value(first));
    when(
      () => apiProvider.watch(1, afterId: 12),
    ).thenAnswer((_) => Stream.value(second));
    when(
      () => apiProvider.watch(1, afterId: 13),
    ).thenAnswer((_) => const Stream.empty());

    final updates = await repository
        .watchActivity(1, afterId: 11)
        .take(4)
        .toList();

    expect(updates, [
      LiveItem(first),
      const LiveReconnecting<ActivityEntry>(Duration.zero),
      const LiveConnected<ActivityEntry>(),
      LiveItem(second),
    ]);
  });
}
