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
}
