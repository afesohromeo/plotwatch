import 'dart:async';

import 'package:flutter/foundation.dart';

/// Lets GoRouter re-run its redirect whenever [stream] emits, e.g. the
/// `AuthenticationBloc` state stream (`_standards/07`).
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
