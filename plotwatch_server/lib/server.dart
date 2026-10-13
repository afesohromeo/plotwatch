import 'dart:io';

import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_auth_idp_server/providers/email.dart';
import 'package:serverpod_auth_idp_server/providers/google.dart';
import 'package:serverpod_cloud_storage/serverpod_cloud_storage.dart';

import 'src/cache_busting.dart';
import 'src/generated/serverpod.dart';
import 'src/future_calls/demo_seed_future_call.dart';
import 'src/web/routes/app_config_route.dart';

/// The starting point of the Serverpod server.
void run(List<String> args) async {
  // Initialize Serverpod. The generated Serverpod class is already connected
  // with your project's generated code.
  final pod = Serverpod(args);

  // Google sign-in (AUTH-04, doc/04g step 4) is on where its secret is set,
  // so a server without it (tests, a fresh deploy) still starts.
  final googleClientSecret = pod.getPassword('googleClientSecret');

  // Initialize authentication services for the server.
  // Token managers will be used to validate and issue authentication keys,
  // and the identity providers will be the authentication options available for users.
  pod.initializeAuthServices(
    tokenManagerBuilders: [
      // Use JWT for authentication keys towards the server.
      JwtConfigFromPasswords(),
    ],
    identityProviderBuilders: [
      // Configure the email identity provider for email/password authentication.
      // The default setup works with Serverpod Cloud without configuration. In
      // development the verification codes are logged to the console, and in
      // staging and production they are sent through the Serverpod Cloud email
      // service. If you want to use a custom provider for sending emails, use
      // `EmailIdpConfigFromPasswords`.
      ServerpodCloudEmailIdpConfig(
        appDisplayName: 'Plotwatch',
      ),
      if (googleClientSecret != null) GoogleIdpConfigFromPasswords(),
    ],
  );

  // Serve all files in the web/static relative directory under /web.
  // These are used by the default web page.
  pod.webServer.addRoute(
    StaticRoute.withCacheBusting(cacheBustingConfig),
    cacheBustingConfig.mountPrefix,
  );

  // Setup the app config route.
  // We build this configuration based on the servers api url and serve it to
  // the flutter app.
  pod.webServer.addRoute(
    AppConfigRoute(
      apiConfig: pod.config.apiServer,
      mapsApiKey: pod.getPassword('googleMapsWebKey'),
      googleClientSecret: googleClientSecret,
    ),
    '/assets/assets/config.json',
  );

  // Android App Links (doc/04b F2-2): lets the installed app open
  // https://plotwatch.serverpod.space/join/... links. Kept outside a dot
  // folder because Serverpod Cloud doesn't upload hidden folders.
  pod.webServer.addRoute(
    StaticRoute.file(
      File(Uri(path: 'web/app_links/assetlinks.json').toFilePath()),
    ),
    '/.well-known/assetlinks.json',
  );

  // Checks if the flutter web app has been built and serves it if it has.
  final appDir = Directory(Uri(path: 'web/app').toFilePath());
  if (appDir.existsSync()) {
    // The privacy policy at a short address for the stores and the
    // submission (doc/04g step 6). The page is part of the web app, so an
    // older build may not have it yet.
    final privacy = File(Uri(path: 'web/app/privacy.html').toFilePath());
    if (privacy.existsSync()) {
      pod.webServer.addRoute(StaticRoute.file(privacy), '/privacy');
    }
    // Serve the flutter web app under /.
    pod.webServer.addRoute(
      FlutterRoute(
        appDir,
        // If building the Flutter app with WASM, set the below parameter to
        // true and add the --wasm flag to the flutter build command.
        enableWasmHeaders: false,
      ),
      '/',
    );
  } else {
    // If the flutter web app has not been built, serve the build app page.
    final defaultRoute = StaticRoute.file(
      File(
        Uri(path: 'web/pages/build_flutter_app.html').toFilePath(),
      ),
    );

    pod.webServer.addMiddleware(
      FallbackMiddleware(
        fallback: defaultRoute,
        on: (response) => response.statusCode == 404,
      ).call,
      '/',
    );

    pod.webServer.addRoute(
      defaultRoute,
      '/**',
    );
  }

  // Configure cloud storage.
  // This setup works with Serverpod Cloud without extra configuration.
  // If you want to use a custom provider for cloud storage, replace these
  // with your preferred provider.
  pod.addCloudStorage(
    await ServerpodCloudProvider.private(
      fallback: () => DatabaseCloudStorage('private'),
    ),
  );
  pod.addCloudStorage(
    await ServerpodCloudProvider.public(
      fallback: () => DatabaseCloudStorage('public'),
    ),
  );

  // Start the server.
  await pod.start();

  // The judges' demo project (doc/04g step 7), when the developer sets the
  // demoSeed password to true. Scheduled, not run here: during a Cloud
  // rollout the first server is stopped seconds after it starts. Two minutes
  // later the rollout is over; one server claims the call.
  if (pod.getPassword('demoSeed') == 'true') {
    await pod.futureCalls.cancel(DemoSeedFutureCall.identifier);
    await pod.futureCalls
        .callWithDelay(
          const Duration(minutes: 2),
          identifier: DemoSeedFutureCall.identifier,
        )
        .demoSeed
        .seed();
  }
}
