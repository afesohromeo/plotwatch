import 'package:flutter/foundation.dart';

/// Shows an 8-character invitation code as `ABCD-EFGH` (decision M2-6).
String formatInvitationCode(String code) =>
    code.length == 8 ? '${code.substring(0, 4)}-${code.substring(4)}' : code;

/// The link that opens the web app's join page (decision M2-8).
String invitationLink(String code, {String? webAppUrl}) {
  final base = (webAppUrl ?? defaultWebAppUrl).replaceFirst(RegExp(r'/+$'), '');
  return '$base/join/$code';
}

/// `--dart-define=WEB_APP_URL=...`, else the site the web app runs on, else
/// the Serverpod Cloud web app (the Android app has no site of its own).
String get defaultWebAppUrl {
  const fromEnvironment = String.fromEnvironment('WEB_APP_URL');
  if (fromEnvironment.isNotEmpty) return fromEnvironment;
  if (kIsWeb) return Uri.base.origin;
  return 'https://plotwatch.serverpod.space';
}
