import 'package:flutter_test/flutter_test.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

// Plan: doc/04g-m8-hardening.md, step 6.
void main() {
  test('Given the web app address then the policy is its privacy page, in '
      'French at #fr', () {
    const site = 'https://plotwatch.serverpod.space/';

    expect(
      privacyPolicyUri('en', webAppUrl: site).toString(),
      'https://plotwatch.serverpod.space/privacy.html',
    );
    expect(
      privacyPolicyUri('fr', webAppUrl: site).toString(),
      'https://plotwatch.serverpod.space/privacy.html#fr',
    );
  });
}
