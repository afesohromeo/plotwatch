import 'dart:async';
import 'dart:developer';

import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// The wait before reconnection attempt [attempt] (1, 2, …): 2 s, 4 s, 8 s,
/// 16 s, then 30 s (doc/04e M5-6, NFR-REL-02).
Duration liveBackoff(int attempt) {
  final seconds = 1 << attempt.clamp(1, 5);
  return Duration(seconds: seconds > 30 ? 30 : seconds);
}

/// Keeps a live stream open (doc/04e M5-6). [subscribe] opens the server
/// stream after an ID. When it ends or fails with a [NetworkException] (or
/// an unknown error), this reports [LiveReconnecting], waits [backoff] and
/// subscribes again after the last ID received, then reports
/// [LiveConnected]. Any other error (a removed member's `projectNotFound`,
/// a lost session) is passed on and ends the stream.
Stream<LiveUpdate<T>> reconnectingStream<T>({
  required Stream<T> Function(int? afterId) subscribe,
  required int Function(T item) idOf,
  int? afterId,
  Duration Function(int attempt) backoff = liveBackoff,
}) {
  late final StreamController<LiveUpdate<T>> controller;
  StreamSubscription<T>? subscription;
  Timer? retry;
  var lastId = afterId;
  var attempt = 0;
  late final void Function() connect;

  void scheduleRetry() {
    subscription = null;
    if (controller.isClosed) return;
    attempt++;
    final wait = backoff(attempt);
    controller.add(LiveReconnecting<T>(wait));
    retry = Timer(wait, () {
      if (controller.isClosed) return;
      controller.add(LiveConnected<T>());
      connect();
    });
  }

  connect = () {
    subscription = subscribe(lastId).listen(
      (item) {
        attempt = 0;
        final id = idOf(item);
        if (lastId == null || id > lastId!) lastId = id;
        controller.add(LiveItem<T>(item));
      },
      onError: (Object error) {
        if (error is HttpException400 || error is HttpException401) {
          controller.addError(error);
          controller.close();
        } else {
          log('Live stream dropped: $error');
          scheduleRetry();
        }
      },
      onDone: scheduleRetry,
      cancelOnError: true,
    );
  };

  controller = StreamController<LiveUpdate<T>>(
    onListen: connect,
    onCancel: () {
      retry?.cancel();
      final open = subscription;
      subscription = null;
      return open?.cancel();
    },
  );
  return controller.stream;
}
