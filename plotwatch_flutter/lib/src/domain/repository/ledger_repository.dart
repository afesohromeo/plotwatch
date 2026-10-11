import 'dart:developer';
import 'dart:typed_data';

import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// A project's ledger: the summary, the entries a page at a time, recording,
/// confirming and reversing (doc/04f). Errors are logged and rethrown
/// (RULE-012).
class LedgerRepository {
  LedgerRepository({
    LedgerApiProvider? apiProvider,
    this._uploadTimeout = const Duration(seconds: 60),
  }) : _apiProvider = apiProvider ?? LedgerApiProvider();

  final LedgerApiProvider _apiProvider;

  /// See `EvidenceRepository` (doc/04d M4-F2).
  final Duration _uploadTimeout;

  Future<LedgerSummary> fetchSummary(int projectId) => _logged(
    'fetching the ledger summary',
    () => _apiProvider.summary(projectId),
  );

  /// The entries older than [beforeId] (the newest without it), only
  /// [kind] and [stageId]'s when given (doc/05 §9.5).
  Future<PaginatedList<LedgerEntry>> fetchEntries(
    int projectId, {
    int? beforeId,
    required int size,
    LedgerEntryKind? kind,
    int? stageId,
  }) => _logged('fetching ledger entries', () async {
    final page = await _apiProvider.list(
      projectId,
      beforeId: beforeId,
      pageSize: size,
      kind: kind,
      stageId: stageId,
    );
    return PaginatedList(
      content: page.items,
      pagination: Pagination(size: size),
    );
  });

  Future<LedgerEntry> fetchEntry(int projectId, int entryId) => _logged(
    'fetching a ledger entry',
    () => _apiProvider.get(projectId, entryId),
  );

  Future<LedgerEntry> recordRelease(int projectId, ReleaseDraft draft) =>
      _logged(
        'recording a release',
        () => _apiProvider.recordRelease(projectId, draft),
      );

  /// Uploads [receipt] first when there is one, then records the expense
  /// with its path and SHA-256 (doc/04f M6-5 a). Throws [UploadException]
  /// when the storage refuses the photo.
  Future<LedgerEntry> recordExpense(
    int projectId,
    ExpenseDraft draft, {
    Uint8List? receipt,
  }) => _logged('recording an expense', () async {
    var withReceipt = draft;
    if (receipt != null) {
      final upload = await _apiProvider.receiptUpload(projectId);
      final uploaded = await _apiProvider
          .upload(upload.uploadDescription, receipt)
          .timeout(_uploadTimeout, onTimeout: () => false);
      if (!uploaded) throw const UploadException();
      withReceipt = draft.copyWith(
        receiptPath: upload.path,
        receiptSha256: sha256Hex(receipt),
      );
    }
    return _apiProvider.recordExpense(projectId, withReceipt);
  });

  Future<LedgerEntry> confirmRelease(int projectId, int entryId) => _logged(
    'confirming a release',
    () => _apiProvider.confirmRelease(projectId, entryId),
  );

  Future<LedgerEntry> reverse(int projectId, int entryId, String reason) =>
      _logged(
        'reversing an entry',
        () => _apiProvider.reverse(projectId, entryId, reason),
      );

  Future<Uint8List> receipt(int projectId, int entryId) =>
      _logged('fetching a receipt', () async {
        final data = await _apiProvider.receipt(projectId, entryId);
        return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      });

  Future<T> _logged<T>(String what, Future<T> Function() call) async {
    try {
      return await call();
    } catch (e) {
      log('Error $what: $e');
      rethrow;
    }
  }
}
