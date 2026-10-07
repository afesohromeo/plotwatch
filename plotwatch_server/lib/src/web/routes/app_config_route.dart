import 'package:serverpod/serverpod.dart';

/// The web app's `config.json`: the API URL and, when configured, the web
/// Maps key (Serverpod password `googleMapsWebKey`; doc/04b, M2-11).
class AppConfigWidget extends JsonWidget {
  final String apiUrl;
  final String? mapsApiKey;

  AppConfigWidget({
    required this.apiUrl,
    this.mapsApiKey,
  }) : super(
         object: {
           'apiUrl': apiUrl,
           'mapsApiKey': ?mapsApiKey,
         },
       );
}

class AppConfigRoute extends WidgetRoute {
  AppConfigWidget widget;

  AppConfigRoute({
    required final ServerConfig apiConfig,
    String? mapsApiKey,
  }) : widget = AppConfigWidget(
         apiUrl: apiConfig.apiUrl.toString(),
         mapsApiKey: mapsApiKey,
       );

  @override
  Future<WebWidget> build(Session session, Request request) async {
    return widget;
  }
}

extension on ServerConfig {
  Uri get apiUrl => Uri(
    scheme: publicScheme,
    host: publicHost,
    port: publicPort,
  );
}
