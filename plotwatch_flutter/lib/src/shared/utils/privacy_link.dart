import 'dart:developer';

import 'package:url_launcher/url_launcher.dart';

import 'invitation_link.dart';

/// The privacy policy (doc/04g step 6): a page of the web app, so it opens
/// on :8083, :8082 and Cloud alike; the French part starts at `#fr`.
Uri privacyPolicyUri(String languageCode, {String? webAppUrl}) {
  final base = (webAppUrl ?? defaultWebAppUrl).replaceFirst(RegExp(r'/+$'), '');
  return Uri.parse(
    '$base/privacy.html${languageCode == 'fr' ? '#fr' : ''}',
  );
}

/// Opens the privacy policy in the browser.
Future<void> openPrivacyPolicy(String languageCode) async {
  final uri = privacyPolicyUri(languageCode);
  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    log('Could not open $uri');
  }
}
