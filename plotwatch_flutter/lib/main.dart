import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

void main() {
  // Web addresses without "#", so invitation links read
  // https://plotwatch.serverpod.space/join/ABCD2345 (decision M2-8). The
  // server falls back to index.html for any path (FlutterRoute).
  usePathUrlStrategy();
  final AppInitializer appInitializer = AppInitializer();

  runZonedGuarded(
    () async {
      WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
      FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

      await appInitializer.preAppRun();

      runApp(
        AppRestart(
          child: const Application(),
        ),
      );
      appInitializer.postAppRun();
    },
    (error, stack) {
      // Add your error tracking here (Firebase, Sentry, custom logging, etc.)
      debugPrintStack(stackTrace: stack);
    },
  );
}
