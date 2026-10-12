import 'dart:convert';

import 'package:serverpod/serverpod.dart';

/// The web app's `config.json`: the API URL and, when configured, the web
/// Maps key (Serverpod password `googleMapsWebKey`; doc/04b, M2-11) and the
/// Google web client ID (doc/04g step 4).
class AppConfigWidget extends JsonWidget {
  final String apiUrl;
  final String? mapsApiKey;
  final String? googleClientId;

  AppConfigWidget({
    required this.apiUrl,
    this.mapsApiKey,
    this.googleClientId,
  }) : super(
         object: {
           'apiUrl': apiUrl,
           'mapsApiKey': ?mapsApiKey,
           'googleClientId': ?googleClientId,
         },
       );
}

class AppConfigRoute extends WidgetRoute {
  AppConfigWidget widget;

  AppConfigRoute({
    required final ServerConfig apiConfig,
    String? mapsApiKey,
    String? googleClientSecret,
  }) : widget = AppConfigWidget(
         apiUrl: apiConfig.apiUrl.toString(),
         mapsApiKey: mapsApiKey,
         googleClientId: googleClientIdFrom(googleClientSecret),
       );

  /// The web client ID in the `googleClientSecret` password (the JSON file
  /// from Google Cloud), or null when it is missing or not that JSON. The ID
  /// is public; the secret next to it never leaves the server.
  static String? googleClientIdFrom(String? googleClientSecret) {
    if (googleClientSecret == null) return null;
    try {
      final json = jsonDecode(googleClientSecret);
      if (json is! Map || json['web'] is! Map) return null;
      final id = (json['web'] as Map)['client_id'];
      return id is String ? id : null;
    } on FormatException {
      return null;
    }
  }

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
