// Loads the Google Maps JavaScript API on web before a map opens (doc/04b
// G-2); nothing to do on Android and iOS, where the key is in the manifest.
export 'maps_loader_stub.dart'
    if (dart.library.js_interop) 'maps_loader_web.dart';
