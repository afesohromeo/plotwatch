import 'dart:async';

import 'package:web/web.dart' as web;

/// Each time this tab gets the focus back or becomes visible again.
Stream<void> tabReturns() {
  final controller = StreamController<void>.broadcast();
  final focus = web.EventStreamProviders.focusEvent
      .forTarget(web.window)
      .listen((_) => controller.add(null));
  final visibility = const web.EventStreamProvider<web.Event>(
    'visibilitychange',
  ).forTarget(web.document)
      .listen((_) {
        if (web.document.visibilityState == 'visible') controller.add(null);
      });
  controller.onCancel = () {
    focus.cancel();
    visibility.cancel();
  };
  return controller.stream;
}
