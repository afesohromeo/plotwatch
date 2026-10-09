import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

// Plan: doc/04d-m4-capture.md, M4-F1: in development the server hands out
// an upload URL on localhost, which the Android emulator can't reach.
void main() {
  String description(String url) =>
      jsonEncode({'type': 'binary', 'url': url, 'method': 'POST'});

  final emulatorServer = Uri.parse('http://10.0.2.2:8080/');

  test('Given a localhost upload URL and the emulator\'s server address then '
      'the host and port become the server\'s, the rest is kept', () {
    final rewritten =
        jsonDecode(
              reachableUploadDescription(
                description(
                  'http://localhost:8080/serverpod_cloud_storage?method=upload&path=p',
                ),
                emulatorServer,
              ),
            )
            as Map<String, dynamic>;

    expect(
      rewritten['url'],
      'http://10.0.2.2:8080/serverpod_cloud_storage?method=upload&path=p',
    );
    expect(rewritten['type'], 'binary');
    expect(rewritten['method'], 'POST');
  });

  test('Given 127.0.0.1 then it is rewritten too', () {
    final rewritten =
        jsonDecode(
              reachableUploadDescription(
                description('http://127.0.0.1:8080/serverpod_cloud_storage'),
                emulatorServer,
              ),
            )
            as Map<String, dynamic>;

    expect(rewritten['url'], 'http://10.0.2.2:8080/serverpod_cloud_storage');
  });

  test('Given a cloud storage URL then it is left as it is', () {
    final cloud = description(
      'https://storage.googleapis.com/bucket/projects/1/evidence/9/photo.jpg',
    );

    expect(reachableUploadDescription(cloud, emulatorServer), cloud);
  });

  test('Given the app also talks to localhost (web, desktop) then nothing '
      'changes', () {
    final local = description('http://localhost:8080/serverpod_cloud_storage');

    expect(
      reachableUploadDescription(local, Uri.parse('http://localhost:8080/')),
      local,
    );
  });

  test('Given something that is not a description then it is passed on '
      'unchanged', () {
    expect(reachableUploadDescription('not json', emulatorServer), 'not json');
  });
}
