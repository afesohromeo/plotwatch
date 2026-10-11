import 'dart:typed_data';

import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// A project's ledger (`client.ledger`, doc/04f). The receipt photo goes to
/// the storage with Serverpod's `FileUploader`, as site photos do.
class LedgerApiProvider {
  Client get _client => ApiProvider().client;

  Future<LedgerSummary> summary(int projectId) =>
      _call(() => _client.ledger.summary(projectId));

  Future<LedgerPage> list(
    int projectId, {
    int? beforeId,
    int? pageSize,
    LedgerEntryKind? kind,
    int? stageId,
  }) => _call(
    () => _client.ledger.list(
      projectId,
      beforeId: beforeId,
      pageSize: pageSize,
      kind: kind,
      stageId: stageId,
    ),
  );

  Future<LedgerEntry> get(int projectId, int entryId) =>
      _call(() => _client.ledger.get(projectId, entryId));

  Future<LedgerEntry> recordRelease(int projectId, ReleaseDraft draft) =>
      _call(() => _client.ledger.recordRelease(projectId, draft));

  Future<LedgerEntry> recordExpense(int projectId, ExpenseDraft draft) =>
      _call(() => _client.ledger.recordExpense(projectId, draft));

  Future<ReceiptUpload> receiptUpload(int projectId) =>
      _call(() => _client.ledger.receiptUpload(projectId));

  /// True when the storage accepted the bytes (see
  /// `EvidenceApiProvider.upload`).
  Future<bool> upload(String uploadDescription, Uint8List bytes) => _call(
    () => FileUploader(
      reachableUploadDescription(uploadDescription, Uri.parse(_client.host)),
    ).uploadByteData(ByteData.sublistView(bytes)),
  );

  Future<LedgerEntry> confirmRelease(int projectId, int entryId) =>
      _call(() => _client.ledger.confirmRelease(projectId, entryId));

  Future<LedgerEntry> reverse(int projectId, int entryId, String reason) =>
      _call(() => _client.ledger.reverse(projectId, entryId, reason));

  Future<ByteData> receipt(int projectId, int entryId) =>
      _call(() => _client.ledger.receipt(projectId, entryId));

  Future<T> _call<T>(Future<T> Function() call) async {
    try {
      return await call();
    } catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }
}
