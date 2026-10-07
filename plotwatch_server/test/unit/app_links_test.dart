import 'dart:convert';
import 'dart:io';

import 'package:test/test.dart';

// Plan: doc/04b-m2-projects-site-members.md, F2-2. Android only opens the
// app for https://plotwatch.serverpod.space/join/... when this file, served
// at /.well-known/assetlinks.json, names the app and its signing key.
void main() {
  final file = File('web/app_links/assetlinks.json');

  test('Given the Digital Asset Links file then it exists', () {
    expect(file.existsSync(), isTrue);
  });

  test('Given the Digital Asset Links file then it lets the Plotwatch app '
      'handle the site\'s links, signed with real SHA-256 fingerprints', () {
    final statements = jsonDecode(file.readAsStringSync()) as List<dynamic>;
    final statement = statements.single as Map<String, dynamic>;
    final target = statement['target'] as Map<String, dynamic>;
    final fingerprints = (target['sha256_cert_fingerprints'] as List<dynamic>)
        .cast<String>();

    expect(statement['relation'], [
      'delegate_permission/common.handle_all_urls',
    ]);
    expect(target['namespace'], 'android_app');
    expect(target['package_name'], 'com.afesohromeo.plotwatch');
    expect(fingerprints, isNotEmpty);
    for (final fingerprint in fingerprints) {
      expect(fingerprint, matches(RegExp(r'^([0-9A-F]{2}:){31}[0-9A-F]{2}$')));
    }
  });
}
