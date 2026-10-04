import 'dart:async';

import 'package:plotwatch_client/plotwatch_client.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

/// Holds the app's single generated Serverpod [Client] (`_standards/14` §2.4).
/// API providers use `ApiProvider().client`.
class ApiProvider {
  factory ApiProvider() => _instance;
  ApiProvider._();

  static final ApiProvider _instance = ApiProvider._();

  Client? _client;

  Client get client {
    final client = _client;
    if (client == null) {
      throw StateError('ApiProvider.initialize() has not been called.');
    }
    return client;
  }

  /// Creates the client and restores the saved session. Called once from
  /// `AppInitializer.preAppRun`.
  ///
  /// Server URL: `--dart-define=SERVER_URL=...`, else `assets/config.json`
  /// (served by the Serverpod web server for the web app), else localhost
  /// (`getServerUrl` from serverpod_flutter).
  Future<void> initialize() async {
    if (_client != null) return;

    final client = Client(await getServerUrl())
      ..connectivityMonitor = FlutterConnectivityMonitor()
      ..authSessionManager = FlutterAuthSessionManager();
    _client = client;

    // Restores the session from secure storage, then validates it with the
    // server (2 s timeout, never throws), as in the Serverpod template.
    unawaited(client.auth.initialize());
  }
}
