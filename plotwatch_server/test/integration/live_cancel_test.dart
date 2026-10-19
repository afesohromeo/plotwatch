import 'dart:async';

import 'package:plotwatch_server/src/services/live_service.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

// Plan: doc/04g-m8-hardening.md, step 11 (Cloud slowness of 2026-10-19).
void main() {
  setUpAll(() => LiveService.tick = const Duration(milliseconds: 50));
  tearDownAll(() => LiveService.tick = LiveService.defaultTick);

  withServerpod('Given a live stream on a quiet channel', (sessionBuilder, _) {
    test('when the client cancels it then it stops reading', () async {
      var reads = 0;
      final rows = LiveService.watch<int>(
        sessionBuilder.build(),
        channel: 'quiet',
        afterId: 0,
        currentMaxId: () async => 0,
        fetch: (floorId, lastId, since) async => const [],
        idOf: (row) => row,
        check: () async => reads++,
      );

      final subscription = rows.listen((_) {});
      await Future<void>.delayed(const Duration(milliseconds: 200));
      expect(reads, greaterThan(1), reason: 'it reads on every tick');

      final cancelled = subscription.cancel();
      final atCancel = reads;
      await Future<void>.delayed(const Duration(milliseconds: 300));

      // At most one read already under way when it was cancelled.
      expect(reads, lessThanOrEqualTo(atCancel + 1));
      await cancelled.timeout(const Duration(seconds: 1));
    });
  });
}
