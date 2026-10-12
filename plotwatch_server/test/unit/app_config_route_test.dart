import 'package:plotwatch_server/src/web/routes/app_config_route.dart';
import 'package:test/test.dart';

// doc/04b group G (M2-11): the web app reads the Maps key from config.json,
// so the key lives in Serverpod's passwords, not in the repository.
void main() {
  test('Given a Maps key then config.json carries it next to the API URL', () {
    final widget = AppConfigWidget(
      apiUrl: 'https://plotwatch.api.serverpod.space/',
      mapsApiKey: 'maps-key',
    );

    expect(widget.object, {
      'apiUrl': 'https://plotwatch.api.serverpod.space/',
      'mapsApiKey': 'maps-key',
    });
  });

  test('Given no Maps key then config.json carries only the API URL', () {
    final widget = AppConfigWidget(apiUrl: 'http://localhost:8080/');

    expect(widget.object, {'apiUrl': 'http://localhost:8080/'});
  });

  // doc/04g step 4: the web app needs the Google web client ID, which is not
  // a secret; it is read from the googleClientSecret password.
  test('Given a Google client ID then config.json carries it', () {
    final widget = AppConfigWidget(
      apiUrl: 'http://localhost:8080/',
      googleClientId: 'id.apps.googleusercontent.com',
    );

    expect(widget.object, {
      'apiUrl': 'http://localhost:8080/',
      'googleClientId': 'id.apps.googleusercontent.com',
    });
  });

  group('Given the googleClientSecret password', () {
    test('when it is the JSON from Google then the web client ID is read', () {
      expect(
        AppConfigRoute.googleClientIdFrom(
          '{"web": {"client_id": "id.apps.googleusercontent.com", '
          '"client_secret": "secret"}}',
        ),
        'id.apps.googleusercontent.com',
      );
    });

    test('when it is missing or not that JSON then there is no ID', () {
      expect(AppConfigRoute.googleClientIdFrom(null), isNull);
      expect(AppConfigRoute.googleClientIdFrom('not json'), isNull);
      expect(AppConfigRoute.googleClientIdFrom('{"installed": {}}'), isNull);
    });
  });
}
