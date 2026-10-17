// When the person comes back to this browser tab (doc/04g step 10e): the web
// Google sign-in opens Google in another tab, and closing it leaves no other
// trace. Nothing on Android and iOS, where Google's own sheet reports a
// cancel.
export 'tab_returns_stub.dart'
    if (dart.library.js_interop) 'tab_returns_web.dart';
