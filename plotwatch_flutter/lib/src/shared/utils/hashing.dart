import 'dart:typed_data';

import 'package:crypto/crypto.dart';

/// SHA-256 of [bytes] as lower-case hex, as the server computes it on the
/// stored photo (CAP-04, doc/04d M4-2).
String sha256Hex(Uint8List bytes) => sha256.convert(bytes).toString();
