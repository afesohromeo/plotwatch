import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

// Plan: doc/04e-m5-review-realtime.md, decision M5-6 (NFR-REL-02): after a
// drop the app waits 2 s, 4 s, 8 s … (at most 30 s) and subscribes again
// with the last ID it received.
void main() {
  test('Given repeated drops then the waits are 2, 4, 8, 16, 30, 30 s', () {
    expect(
      [for (var i = 1; i <= 6; i++) liveBackoff(i).inSeconds],
      [2, 4, 8, 16, 30, 30],
    );
  });

  group('Given a reconnecting stream', () {
    late List<int?> subscribedAfter;
    late List<StreamController<int>> servers;

    Stream<LiveUpdate<int>> open({int? afterId}) {
      subscribedAfter = [];
      servers = [];
      return reconnectingStream<int>(
        subscribe: (lastId) {
          subscribedAfter.add(lastId);
          final server = StreamController<int>();
          servers.add(server);
          return server.stream;
        },
        idOf: (id) => id,
        afterId: afterId,
        backoff: (_) => Duration.zero,
      );
    }

    test('when the server sends items then they arrive in order', () async {
      final updates = <LiveUpdate<int>>[];
      final sub = open(afterId: 3).listen(updates.add);
      await pumpEventQueue();

      servers.single
        ..add(4)
        ..add(5);
      await pumpEventQueue();

      expect(subscribedAfter, [3]);
      expect(updates, [const LiveItem(4), const LiveItem(5)]);
      await sub.cancel();
    });

    test('when the connection drops then it says so and subscribes again '
        'after the last ID received', () async {
      final updates = <LiveUpdate<int>>[];
      final sub = open(afterId: 3).listen(updates.add);
      await pumpEventQueue();

      servers.first.add(7);
      await pumpEventQueue();
      servers.first.addError(const NetworkException());
      await pumpEventQueue();

      expect(subscribedAfter, [3, 7]);
      expect(updates, [
        const LiveItem(7),
        const LiveReconnecting<int>(Duration.zero),
        const LiveConnected<int>(),
      ]);

      // The server closing the stream counts as a drop too.
      await servers.last.close();
      await pumpEventQueue();
      expect(subscribedAfter, [3, 7, 7]);
      await sub.cancel();
    });

    test('when the server refuses (e.g. a removed member) then the error '
        'ends the stream without reconnecting', () async {
      final errors = <Object>[];
      final done = Completer<void>();
      open(
        afterId: 3,
      ).listen((_) {}, onError: errors.add, onDone: done.complete);
      await pumpEventQueue();

      servers.single.addError(
        const HttpException400(code: AppErrorCode.projectNotFound),
      );
      await done.future;

      expect(errors.single, isA<HttpException400>());
      expect(subscribedAfter, [3]);
    });

    test('when the listener cancels then the server stream is closed and no '
        'retry happens', () async {
      final sub = open().listen((_) {});
      await pumpEventQueue();

      await sub.cancel();
      await pumpEventQueue();

      expect(servers.single.hasListener, isFalse);
      expect(subscribedAfter, [null]);
    });
  });
}
