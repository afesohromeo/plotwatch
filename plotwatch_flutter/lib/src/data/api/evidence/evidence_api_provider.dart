import 'dart:typed_data';

import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// Captures (`client.evidence`, doc/04d). The photo itself goes to the
/// storage with Serverpod's `FileUploader` (`_standards/14` §2.4).
class EvidenceApiProvider {
  Client get _client => ApiProvider().client;

  Future<EvidenceCommitResult> commit(int projectId, EvidenceCommit commit) =>
      _call(() => _client.evidence.commit(projectId, commit));

  Future<String> uploadDescription(int projectId, int evidenceId) =>
      _call(() => _client.evidence.uploadDescription(projectId, evidenceId));

  /// True when the storage accepted the bytes. A development upload URL on
  /// localhost is pointed at the server the app uses (doc/04d M4-F1).
  Future<bool> upload(String uploadDescription, Uint8List bytes) => _call(
    () => FileUploader(
      reachableUploadDescription(uploadDescription, Uri.parse(_client.host)),
    ).uploadByteData(ByteData.sublistView(bytes)),
  );

  Future<Evidence> finalize(int projectId, int evidenceId) =>
      _call(() => _client.evidence.finalize(projectId, evidenceId));

  Future<List<Evidence>> list(int projectId, int stageId) =>
      _call(() => _client.evidence.list(projectId, stageId));

  Future<Evidence> get(int projectId, int evidenceId) =>
      _call(() => _client.evidence.get(projectId, evidenceId));

  Future<ByteData> media(int projectId, int evidenceId, MediaVariant variant) =>
      _call(() => _client.evidence.media(projectId, evidenceId, variant));

  Future<Evidence> retract(int projectId, int evidenceId, String reason) =>
      _call(() => _client.evidence.retract(projectId, evidenceId, reason));

  Future<T> _call<T>(Future<T> Function() call) async {
    try {
      return await call();
    } catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }
}
