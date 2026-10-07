import 'package:flutter_test/flutter_test.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

// Decision M2-6/M2-8: codes are shown as ABCD-EFGH; the link opens the web
// app's /join/:code route.
void main() {
  test('Given an 8-character code then it is shown as two groups of four', () {
    expect(formatInvitationCode('ABCD2345'), 'ABCD-2345');
  });

  test('Given a code of another length then it is shown unchanged', () {
    expect(formatInvitationCode('ABC'), 'ABC');
  });

  test('Given a code then the link points at the join page of the web app',
      () {
    expect(
      invitationLink('ABCD2345', webAppUrl: 'https://plotwatch.serverpod.space'),
      'https://plotwatch.serverpod.space/join/ABCD2345',
    );
  });

  test('Given a web app URL with a trailing slash then the link has one slash',
      () {
    expect(
      invitationLink('ABCD2345', webAppUrl: 'http://localhost:8082/'),
      'http://localhost:8082/join/ABCD2345',
    );
  });
}
