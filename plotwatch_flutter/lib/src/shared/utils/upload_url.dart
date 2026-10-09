import 'dart:convert';

/// Hosts a phone on the Android emulator can't reach: they are the
/// emulator itself, not the PC (doc/04d M4-F1).
const _localHosts = {'localhost', '127.0.0.1'};

/// [description] with an upload URL the app can reach. In development the
/// database storage builds the URL from the server's `publicHost`
/// (`localhost`); when the app talks to the server on another host (the
/// emulator's `10.0.2.2`), the URL gets that host and port. Cloud storage
/// URLs and anything that isn't a description are returned unchanged.
String reachableUploadDescription(String description, Uri serverUrl) {
  final Object? data;
  try {
    data = jsonDecode(description);
  } on FormatException {
    return description;
  }
  if (data is! Map<String, dynamic> || data['url'] is! String) {
    return description;
  }
  final url = Uri.parse(data['url'] as String);
  if (!_localHosts.contains(url.host) || url.host == serverUrl.host) {
    return description;
  }
  return jsonEncode({
    ...data,
    'url': url
        .replace(
          scheme: serverUrl.scheme,
          host: serverUrl.host,
          port: serverUrl.port,
        )
        .toString(),
  });
}
