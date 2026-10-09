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
  static Stream<T> watch<T>(
    Session session, {
    required String channel,
    required int? afterId,
    required Future<int> Function() currentMaxId,
    required Future<List<T>> Function(int floorId, int lastId, DateTime since)
    fetch,
    required int Function(T row) idOf,
    required Future<void> Function() check,
  }) async* {
    await check();
    final floorId = afterId ?? await currentMaxId();
    var lastId = floorId;
    final sent = <int>{};

    final wake = StreamController<void>();
    final signals = session.messages
        .createStream<LiveSignal>(channel)
        .listen((_) => wake.add(null));
    final timer = Timer.periodic(tick, (_) => wake.add(null));
    try {
      // The catch-up, then one read per wake-up.
      wake.add(null);
      await for (final _ in wake.stream) {
        await check();
        final since = DateTime.now().toUtc().subtract(window);
        for (final row in await fetch(floorId, lastId, since)) {
          final id = idOf(row);
          if (!sent.add(id)) continue;
          if (id > lastId) lastId = id;
          yield row;
        }
      }
    } finally {
      timer.cancel();
      await signals.cancel();
      await wake.close();
    }
  }
}
