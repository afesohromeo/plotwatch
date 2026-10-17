import 'dart:async';

/// [result], or null when the person came back to the app ([returns]) and
/// no result followed within [grace]: they closed Google's tab (doc/04g step
/// 10e). Without it the web sign-in waited for its own 5-minute timeout,
/// with the button spinning. A result or error after that is ignored.
Future<T?> untilAbandoned<T>(
  Future<T> result,
  Stream<void> returns, {
  Duration grace = const Duration(seconds: 2),
}) {
  final completer = Completer<T?>();
  Timer? timer;
  StreamSubscription<void>? subscription;
  void done() {
    timer?.cancel();
    unawaited(subscription?.cancel());
  }

  result.then(
    (value) {
      if (completer.isCompleted) return;
      done();
      completer.complete(value);
    },
    onError: (Object error, StackTrace stackTrace) {
      if (completer.isCompleted) return;
      done();
      completer.completeError(error, stackTrace);
    },
  );
  subscription = returns.listen((_) {
    timer?.cancel();
    timer = Timer(grace, () {
      if (completer.isCompleted) return;
      done();
      completer.complete(null);
    });
  });
  return completer.future;
}
