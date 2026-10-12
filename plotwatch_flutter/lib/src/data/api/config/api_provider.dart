import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// Holds the app's single generated Serverpod [Client] (`_standards/14` §2.4).
/// API providers use `ApiProvider().client`.
class ApiProvider {
  factory ApiProvider() => _instance;
  ApiProvider._();

  static final ApiProvider _instance = ApiProvider._();

  Client? _client;

  /// Whether Google sign-in is configured here (doc/04g step 4): a client ID
  /// in `config.json` and a successful set-up.
  bool get isGoogleSignInAvailable => _googleReady;
  bool _googleReady = false;

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

    // Decision M1-5: read the saved session before the first frame, so the
    // router knows whether the user is signed in; then validate it with the
    // server in the background (2 s timeout, never throws).
    await client.auth.restore();
    unawaited(client.auth.initialize());
    await _initializeGoogleSignIn(client);
  }

  /// Web: the OAuth2 PKCE flow returns to the app's own `auth.html`
  /// (`web/auth.html`), on the origin that serves the app. Phones: the web client ID is the
  /// server client ID. Without an ID, the Google button stays hidden.
  Future<void> _initializeGoogleSignIn(Client client) async {
    final clientId = await _googleClientId();
    if (clientId == null) return;
    try {
      if (kIsWeb) {
        await client.auth.initializeGoogleSignIn(
          clientId: clientId,
          redirectUri: '${Uri.base.origin}/auth.html',
        );
      } else {
        await client.auth.initializeGoogleSignIn(serverClientId: clientId);
      }
      _googleReady = true;
    } catch (e) {
      log('Google sign-in not available: $e');
    }
  }

  /// `--dart-define=GOOGLE_CLIENT_ID=...`, else `assets/config.json` (served
  /// by the server for the web app, bundled for phones).
  static Future<String?> _googleClientId() async {
    const fromEnvironment = String.fromEnvironment('GOOGLE_CLIENT_ID');
    if (fromEnvironment.isNotEmpty) return fromEnvironment;
    try {
      final config = jsonDecode(
        await rootBundle.loadString('assets/config.json'),
      ) as Map<String, dynamic>;
      final id = config['googleClientId'] as String?;
      return (id == null || id.isEmpty) ? null : id;
    } catch (_) {
      return null;
    }
  }
}
