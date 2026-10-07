import 'dart:async';
import 'dart:convert';
import 'dart:js_interop';

import 'package:flutter/services.dart';
import 'package:web/web.dart' as web;

Future<void>? _loading;

/// Adds the Google Maps script once, with the web key from
/// `--dart-define=MAPS_API_KEY` (local debug) or the server's `config.json`
/// (`mapsApiKey`, from the `googleMapsWebKey` password).
Future<void> ensureMapsLoaded() => _loading ??= _load();

Future<void> _load() async {
  final key = await _webMapsKey();
  final done = Completer<void>();
  final script = web.HTMLScriptElement()
    ..src =
        'https://maps.googleapis.com/maps/api/js'
        '?key=${Uri.encodeQueryComponent(key)}'
    ..async = true;
  script.addEventListener('load', ((web.Event _) => done.complete()).toJS);
  script.addEventListener(
    'error',
    ((web.Event _) {
      _loading = null; // Allow a retry.
      done.completeError(StateError('Google Maps failed to load'));
    }).toJS,
  );
  web.document.head!.append(script);
  return done.future;
}

Future<String> _webMapsKey() async {
  const fromEnvironment = String.fromEnvironment('MAPS_API_KEY');
  if (fromEnvironment.isNotEmpty) return fromEnvironment;
  try {
    final config =
        jsonDecode(await rootBundle.loadString('assets/config.json'))
            as Map<String, dynamic>;
    return config['mapsApiKey'] as String? ?? '';
  } catch (_) {
    return '';
  }
}
