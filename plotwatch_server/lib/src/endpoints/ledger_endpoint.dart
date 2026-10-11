import 'dart:typed_data';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/ledger_service.dart';
import '../services/permission_service.dart';

/// A project's ledger (LED-01–04, 06; doc/04f). Thin: sign-in → permission
/// → validate → one service call (`_standards/14` §4.2). Writing needs an
/// open project (doc/04e C-1).
class LedgerEndpoint extends Endpoint {
  static const _service = LedgerService();
  static const _permissions = PermissionService();

  @override
  bool get requireLogin => true;

  /// By an approver: the owner, or a co-funder allowed to approve.
  Future<LedgerEntry> recordRelease(
    Session session,
    int projectId,
    ReleaseDraft draft,
  ) async {
    final funder = await _permissions.requireOpen(
      session,
      projectId,
      ProjectAction.recordFundReleases,
    );
    return _service.recordRelease(
      session,
      funder,
      LedgerService.validateRelease(draft),
    );
  }

  /// By the site manager, after uploading the receipt photo if there is one.
  Future<LedgerEntry> recordExpense(
    Session session,
    int projectId,
    ExpenseDraft draft,
  ) async {
    final siteManager = await _permissions.requireOpen(
      session,
      projectId,
      ProjectAction.recordExpenses,
    );
    return _service.recordExpense(
      session,
      siteManager,
      LedgerService.validateExpense(draft),
    );
  }

  Future<ReceiptUpload> receiptUpload(Session session, int projectId) async {
    final siteManager = await _permissions.requireOpen(
      session,
      projectId,
      ProjectAction.recordExpenses,
    );
    return _service.receiptUpload(session, siteManager);
  }

  /// The site manager confirms receiving a release (LED-02).
  Future<LedgerEntry> confirmRelease(
    Session session,
    int projectId,
    int entryId,
  ) async {
    final siteManager = await _permissions.requireOpen(
      session,
      projectId,
      ProjectAction.confirmFundReceipt,
    );
    return _service.confirm(session, siteManager, entryId);
  }

  /// Its recorder corrects an entry (LED-06), still allowed to record that
  /// kind.
  Future<LedgerEntry> reverse(
    Session session,
    int projectId,
    int entryId,
    String reason,
  ) async {
    final viewer = await _permissions.require(
      session,
      projectId,
      ProjectAction.viewProject,
    );
    final entry = await _service.get(session, viewer.projectId, entryId);
    final member = await _permissions.requireOpen(
      session,
      projectId,
      entry.kind == LedgerEntryKind.release
          ? ProjectAction.recordFundReleases
          : ProjectAction.recordExpenses,
    );
    return _service.reverse(
      session,
      member,
      entryId,
      LedgerService.validateReason(reason),
    );
  }

  /// Newest first, older than [beforeId], only [kind] and [stageId]'s when
  /// given. Nullable instead of default values: see `ProjectEndpoint.list`.
  Future<LedgerPage> list(
    Session session,
    int projectId, {
    int? beforeId,
    int? pageSize,
    LedgerEntryKind? kind,
    int? stageId,
  }) async {
    await _permissions.require(session, projectId, ProjectAction.viewProject);
    return _service.list(
      session,
      projectId,
      beforeId: beforeId,
      pageSize: pageSize ?? 20,
      kind: kind,
      stageId: stageId,
    );
  }

  Future<LedgerEntry> get(Session session, int projectId, int entryId) async {
    await _permissions.require(session, projectId, ProjectAction.viewProject);
    return _service.get(session, projectId, entryId);
  }

  Future<LedgerSummary> summary(Session session, int projectId) async {
    await _permissions.require(session, projectId, ProjectAction.viewProject);
    return _service.summary(session, projectId);
  }

  Future<ByteData> receipt(
    Session session,
    int projectId,
    int entryId,
  ) async {
    await _permissions.require(session, projectId, ProjectAction.viewProject);
    return _service.receipt(session, projectId, entryId);
  }
}
