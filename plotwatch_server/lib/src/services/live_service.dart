import 'dart:async';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Live streams with catch-up (FEED-02, FEED-03, AC-6; doc/04e M5-5).
///
/// Serverpod's messages reach only the streams of the same server instance
/// unless Redis is enabled (it isn't), and a transaction that commits late
/// can make IDs appear out of order. So a stream doesn't trust messages
/// alone: it wakes up on a message **and** every [tick], and each time it
/// re-reads the rows of the last [window] or above the last ID it sent,
/// sending those it hasn't sent yet. No gaps, no duplicates.
abstract final class LiveService {
  static const defaultTick = Duration(seconds: 3);

  /// How often an open stream looks for new rows without a message.
  /// Shortened in tests.
  static Duration tick = defaultTick;

  /// How far back a stream looks for rows committed late.
  static const window = Duration(seconds: 60);

  static String projectChannel(int projectId) => 'project:$projectId';
  static String userChannel(UuidValue userId) => 'user:${userId.uuid}';

  /// Wakes up the streams listening on [channel]. Called when a row is
  /// written, even inside a transaction: if the row isn't visible yet, the
  /// next tick finds it.
  static Future<void> signal(Session session, String channel) =>
      session.messages.postMessage(channel, LiveSignal(channel: channel));

  /// Sends the rows above [afterId] (or, without it, only rows written from
  /// now on), oldest first, then the new ones as they come.
  ///
  /// [fetch] returns the rows with an ID above `floorId` that are either
  /// above `lastId` or created since `since`, oldest first. [check] runs
  /// before each read and throws to end the stream (e.g. a removed member).
  ///
  /// An `async*` function only notices a cancel when it yields, and a quiet
  /// stream never yields: it kept polling after the client left, until the
  /// open loops filled the database pool (doc/04g step 10f). So the cancel
  /// closes the wake-up stream, which ends the reading loop.
  static Stream<T> watch<T>(
    Session session, {
    required String channel,
    required int? afterId,
    required Future<int> Function() currentMaxId,
    required Future<List<T>> Function(int floorId, int lastId, DateTime since)
    fetch,
    required int Function(T row) idOf,
    required Future<void> Function() check,
  }) {
    final wake = StreamController<void>();
    StreamSubscription<LiveSignal>? signals;
    Timer? timer;

    void poke() {
      if (!wake.isClosed) wake.add(null);
    }

    void stop() {
      timer?.cancel();
      unawaited(signals?.cancel());
      if (!wake.isClosed) unawaited(wake.close());
    }

    Stream<T> read() async* {
      await check();
      final floorId = afterId ?? await currentMaxId();
      if (wake.isClosed) return;
      var lastId = floorId;
      final sent = <int>{};

      signals = session.messages
          .createStream<LiveSignal>(channel)
          .listen((_) => poke());
      timer = Timer.periodic(tick, (_) => poke());
      // The catch-up, then one read per wake-up.
      poke();
      await for (final _ in wake.stream) {
        if (wake.isClosed) break;
        await check();
        final since = DateTime.now().toUtc().subtract(window);
        for (final row in await fetch(floorId, lastId, since)) {
          final id = idOf(row);
          if (!sent.add(id)) continue;
          if (id > lastId) lastId = id;
          yield row;
        }
      }
    }

    late final StreamController<T> rows;
    StreamSubscription<T>? reads;
    rows = StreamController<T>(
      onListen: () => reads = read().listen(
        rows.add,
        onError: rows.addError,
        onDone: () {
          stop();
          unawaited(rows.close());
        },
      ),
      onCancel: () {
        stop();
        return reads?.cancel();
      },
    );
    return rows.stream;
  }
}
