import 'package:share_plus/share_plus.dart';

/// The platform share sheet (share_plus 13; 10.x as in PlusLocate needs
/// win32 5, which conflicts with Serverpod's win32 6). Behind a class so BLoC
/// tests don't need the platform plugin.
class ShareProvider {
  const ShareProvider();

  Future<void> shareText(String text) async {
    await SharePlus.instance.share(ShareParams(text: text));
  }
}
