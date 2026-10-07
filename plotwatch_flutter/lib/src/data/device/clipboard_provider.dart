import 'package:flutter/services.dart';

/// The system clipboard. Behind a class so BLoC tests don't need the
/// platform channel (doc/04b F3-2).
class ClipboardProvider {
  const ClipboardProvider();

  Future<void> copyText(String text) =>
      Clipboard.setData(ClipboardData(text: text));
}
