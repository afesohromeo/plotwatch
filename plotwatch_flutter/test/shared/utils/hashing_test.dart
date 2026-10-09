import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

// Plan: doc/04d-m4-capture.md, decision M4-2: the hash of the exact bytes
// that are uploaded, as the server computes it (lower-case hex).
void main() {
  test('Given known bytes then the SHA-256 is the standard one', () {
    expect(
      sha256Hex(Uint8List.fromList(utf8.encode('abc'))),
      'ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad',
    );
  });

  test('Given no bytes then it is the hash of the empty input', () {
    expect(
      sha256Hex(Uint8List(0)),
      'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855',
    );
  });
}
