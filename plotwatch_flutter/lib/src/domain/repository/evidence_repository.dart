import 'dart:developer';
import 'dart:typed_data';

import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// Captures: commit, upload, finalize, viewing and retract (doc/04d). The
/// capture flow chains the three sending steps so it can retry the one that
/// failed. Errors are logged and rethrown (RULE-012).
class EvidenceRepository {
  EvidenceRepository({EvidenceApiProvider? apiProvider})
    : _apiProvider = apiProvider ?? EvidenceApiProvider();

  final EvidenceApiProvider _apiProvider;

  Future<EvidenceCommitResult> commit(int projectId, EvidenceCommit commit) =>
      _logged(
        'committing a capture',
        () => _apiProvider.commit(projectId, commit),
      );

  /// A new upload description while the capture is still committed.
  Future<String> uploadDescription(int projectId, int evidenceId) => _logged(
    'renewing an upload description',
    () => _apiProvider.uploadDescription(projectId, evidenceId),
  );

  /// Throws [UploadException] when the storage refuses the bytes.
  Future<void> upload(String uploadDescription, Uint8List bytes) =>
      _logged('uploading a photo', () async {
        if (!await _apiProvider.upload(uploadDescription, bytes)) {
          throw const UploadException();
        }
      });

  Future<Evidence> finalize(int projectId, int evidenceId) => _logged(
    'finalizing a capture',
    () => _apiProvider.finalize(projectId, evidenceId),
  );

  Future<List<Evidence>> fetchStageEvidence(int projectId, int stageId) =>
      _logged(
        'fetching captures',
        () => _apiProvider.list(projectId, stageId),
      );

  Future<Evidence> fetchEvidence(int projectId, int evidenceId) => _logged(
    'fetching a capture',
    () => _apiProvider.get(projectId, evidenceId),
  );

  /// The photo or thumbnail bytes (decision M4-4).
  Future<Uint8List> media(
    int projectId,
    int evidenceId,
    MediaVariant variant,
  ) => _logged('fetching a photo', () async {
    final data = await _apiProvider.media(projectId, evidenceId, variant);
    return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  });

  Future<Evidence> retract(int projectId, int evidenceId, String reason) =>
      _logged(
        'retracting a capture',
        () => _apiProvider.retract(projectId, evidenceId, reason),
      );

  Future<T> _logged<T>(String what, Future<T> Function() call) async {
    try {
      return await call();
    } catch (e) {
      log('Error $what: $e');
      rethrow;
    }
  }
}
