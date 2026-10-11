import 'dart:math';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'activity_service.dart';
import 'audit_service.dart';
import 'notification_service.dart';
import 'people_service.dart';
import 'stage_service.dart';

/// A project's ledger: fund releases recorded by a funder, expenses recorded
/// by the site manager, their summary (LED-01, 03, 04, 06; doc/04f). Record
/// keeping only: no money moves through the app (D-5). Entries are never
/// changed, except a release's confirmation (LED-02); a reversal corrects
/// a mistake.
class LedgerService {
  const LedgerService();

  static const _audit = AuditService();
  static const _activity = ActivityService();
  static const _notifications = NotificationService();
  static const _people = PeopleService();
  static const _stages = StageService();

  static const storageId = 'private';
  static const maxAmountMinor = StageService.maxBudgetMinor;
  static const maxReferenceLength = 100;
  static const maxNoteLength = 500;
  static const maxDescriptionLength = 300;
  static const maxVendorLength = 100;
  static const maxReasonLength = 300;
  static const maxReceiptBytes = 10 * 1024 * 1024;
  static const maxPageSize = 50;

  /// Unaccounted above this share of what was released is highlighted
  /// (LED-05, doc/04f M6-8).
  static const alertShare = 0.2;

  static final _hashPattern = RegExp(r'^[0-9a-fA-F]{64}$');

  // --- Checks -------------------------------------------------------------

  /// [draft] cleaned up, or throws `invalidLedgerEntry`.
  static ReleaseDraft validateRelease(ReleaseDraft draft, {DateTime? now}) {
    final reference = _optional(draft.reference, maxReferenceLength);
    final note = _optional(draft.note, maxNoteLength);
    _checkAmount(draft.amountMinor);
    return draft.copyWith(
      occurredOn: _day(draft.occurredOn, now),
      reference: reference,
      note: note,
    );
  }

  /// [draft] cleaned up, or throws `invalidLedgerEntry`.
  static ExpenseDraft validateExpense(ExpenseDraft draft, {DateTime? now}) {
    final description = draft.description.trim();
    if (description.isEmpty || description.length > maxDescriptionLength) {
      throw AppException(code: AppErrorCode.invalidLedgerEntry);
    }
    final vendor = _optional(draft.vendor, maxVendorLength);
    _checkAmount(draft.amountMinor);
    final path = draft.receiptPath;
    final hash = draft.receiptSha256;
    // A receipt comes with its hash, or not at all.
    if ((path == null) != (hash == null) ||
        (hash != null && !_hashPattern.hasMatch(hash))) {
      throw AppException(code: AppErrorCode.invalidLedgerEntry);
    }
    return draft.copyWith(
      occurredOn: _day(draft.occurredOn, now),
      description: description,
      vendor: vendor,
      receiptSha256: hash?.toLowerCase(),
    );
  }

  /// A reversal's reason, required (LED-06).
  static String validateReason(String reason) {
    final trimmed = reason.trim();
    if (trimmed.isEmpty || trimmed.length > maxReasonLength) {
      throw AppException(code: AppErrorCode.invalidLedgerEntry);
    }
    return trimmed;
  }

  static void _checkAmount(int amountMinor) {
    if (amountMinor <= 0 || amountMinor > maxAmountMinor) {
      throw AppException(code: AppErrorCode.invalidLedgerEntry);
    }
  }

  static String? _optional(String? text, int max) {
    final trimmed = text?.trim();
    if (trimmed == null || trimmed.isEmpty) return null;
    if (trimmed.length > max) {
      throw AppException(code: AppErrorCode.invalidLedgerEntry);
    }
    return trimmed;
  }

  /// The calendar day of [when], at UTC midnight; not after tomorrow, so a
  /// funder ahead of UTC can record today's release.
  static DateTime _day(DateTime when, DateTime? now) {
    final utc = when.toUtc();
    final day = DateTime.utc(utc.year, utc.month, utc.day);
    final today = (now ?? DateTime.now()).toUtc();
    final limit = DateTime.utc(today.year, today.month, today.day + 1);
    if (day.isAfter(limit)) {
      throw AppException(code: AppErrorCode.invalidLedgerEntry);
    }
    return day;
  }

  // --- The summary (LED-04) -----------------------------------------------

  /// The money per stage, for the entries without a stage and for the
  /// project, from [stages] in plan order and every entry of the project
  /// (reversals included: they count by their sign).
  static LedgerSummary summarize({
    required List<Stage> stages,
    required List<LedgerEntry> entries,
  }) {
    final byId = {for (final e in entries) e.id: e};
    // A reversal of an expense with a receipt takes it back from "with
    // receipt" too.
    bool withReceipt(LedgerEntry e) =>
        e.receiptPath != null ||
        (e.reversesId != null && byId[e.reversesId]?.receiptPath != null);

    LedgerLine line(
      Iterable<LedgerEntry> lines, {
      required int budget,
      int? stageId,
      String? stageName,
    }) {
      var released = 0, spent = 0, receipted = 0;
      for (final e in lines) {
        if (e.kind == LedgerEntryKind.release) {
          released += e.amountMinor;
        } else {
          spent += e.amountMinor;
          if (withReceipt(e)) receipted += e.amountMinor;
        }
      }
      return LedgerLine(
        stageId: stageId,
        stageName: stageName,
        budgetMinor: budget,
        releasedMinor: released,
        spentMinor: spent,
        spentWithReceiptMinor: receipted,
        unaccountedMinor: released - receipted,
        remainingMinor: budget - released,
      );
    }

    final stageIds = {for (final s in stages) s.id};
    final unassigned = [
      for (final e in entries)
        if (e.stageId == null || !stageIds.contains(e.stageId)) e,
    ];
    final total = line(
      entries,
      budget: stages.fold(0, (sum, s) => sum + s.budgetMinor),
    );
    return LedgerSummary(
      total: total,
      stages: [
        for (final stage in stages)
          line(
            entries.where((e) => e.stageId == stage.id),
            budget: stage.budgetMinor,
            stageId: stage.id,
            stageName: stage.name,
          ),
      ],
      unassigned: unassigned.isEmpty ? null : line(unassigned, budget: 0),
      unaccountedAlert:
          total.releasedMinor > 0 &&
          total.unaccountedMinor > total.releasedMinor * alertShare,
    );
  }

  // --- Writing ------------------------------------------------------------

  /// A release, by an approver (LED-01). The site managers are notified.
  Future<LedgerEntry> recordRelease(
    Session session,
    ProjectMember funder,
    ReleaseDraft draft,
  ) {
    return session.db.transaction((transaction) async {
      await _checkStage(session, funder.projectId, draft.stageId, transaction);
      final entry = await LedgerEntry.db.insertRow(
        session,
        LedgerEntry(
          projectId: funder.projectId,
          stageId: draft.stageId,
          kind: LedgerEntryKind.release,
          amountMinor: draft.amountMinor,
          occurredOn: draft.occurredOn,
          recordedBy: funder.authUserId,
          method: draft.method,
          reference: draft.reference,
          note: draft.note,
          createdAt: DateTime.now().toUtc(),
        ),
        transaction: transaction,
      );
      await _written(
        session,
        funder,
        entry,
        action: 'ledger.release',
        activity: ActivityType.fundReleased,
        notification: NotificationType.fundReleased,
        notify: await _people.siteManagers(
          session,
          funder.projectId,
          transaction: transaction,
        ),
        transaction: transaction,
      );
      return entry;
    });
  }

  /// An expense, by the site manager (LED-03), with its receipt photo when
  /// one was uploaded: it must be there and match its hash. The funders who
  /// approve are notified.
  Future<LedgerEntry> recordExpense(
    Session session,
    ProjectMember siteManager,
    ExpenseDraft draft,
  ) async {
    final path = draft.receiptPath;
    if (path != null) {
      await _checkReceipt(session, siteManager.projectId, path, draft);
    }
    return session.db.transaction((transaction) async {
      await _checkStage(
        session,
        siteManager.projectId,
        draft.stageId,
        transaction,
      );
      final entry = await LedgerEntry.db.insertRow(
        session,
        LedgerEntry(
          projectId: siteManager.projectId,
          stageId: draft.stageId,
          kind: LedgerEntryKind.expense,
          amountMinor: draft.amountMinor,
          occurredOn: draft.occurredOn,
          recordedBy: siteManager.authUserId,
          category: draft.category,
          description: draft.description,
          vendor: draft.vendor,
          receiptPath: path,
          receiptSha256: draft.receiptSha256,
          createdAt: DateTime.now().toUtc(),
        ),
        transaction: transaction,
      );
      await _written(
        session,
        siteManager,
        entry,
        action: 'ledger.expense',
        activity: ActivityType.expenseRecorded,
        notification: NotificationType.expenseRecorded,
        notify: await _people.approvers(
          session,
          siteManager.projectId,
          transaction: transaction,
        ),
        transaction: transaction,
      );
      return entry;
    });
  }

  /// Where the site manager uploads a receipt photo before recording the
  /// expense: a new path under the project, never reused.
  Future<ReceiptUpload> receiptUpload(
    Session session,
    ProjectMember siteManager,
  ) async {
    final random = Random.secure().nextInt(1 << 32).toRadixString(16);
    final path =
        'projects/${siteManager.projectId}/receipts/'
        '${DateTime.now().toUtc().microsecondsSinceEpoch}-$random.jpg';
    final description = await session.storage.createUploadDescription(
      storageId: storageId,
      path: path,
      options: const UploadOptions(
        maxFileSize: maxReceiptBytes,
        preventOverwrite: true,
      ),
    );
    return ReceiptUpload(path: path, uploadDescription: description);
  }

  /// The site manager confirms receiving a release, once (LED-02). Its
  /// recorder is notified.
  Future<LedgerEntry> confirm(
    Session session,
    ProjectMember siteManager,
    int entryId,
  ) {
    return session.db.transaction((transaction) async {
      final entry = await _find(
        session,
        siteManager.projectId,
        entryId,
        transaction,
      );
      if (entry.kind != LedgerEntryKind.release || entry.reversesId != null) {
        throw AppException(code: AppErrorCode.invalidLedgerEntry);
      }
      if (entry.confirmedAt != null) {
        throw AppException(code: AppErrorCode.alreadyConfirmed);
      }
      if (await _reversalOf(session, entryId, transaction) != null) {
        throw AppException(code: AppErrorCode.alreadyReversed);
      }
      final confirmed = await LedgerEntry.db.updateRow(
        session,
        entry.copyWith(
          confirmedBy: siteManager.authUserId,
          confirmedAt: DateTime.now().toUtc(),
        ),
        columns: (t) => [t.confirmedBy, t.confirmedAt],
        transaction: transaction,
      );
      await _written(
        session,
        siteManager,
        confirmed,
        action: 'ledger.confirm',
        activity: ActivityType.releaseConfirmed,
        notification: NotificationType.releaseConfirmed,
        notify: [entry.recordedBy],
        transaction: transaction,
      );
      return confirmed;
    });
  }

  /// Corrects a mistake (LED-06): a new entry of the same kind with the
  /// negative amount, pointing at [entryId], with [reason]. Only its
  /// recorder, only once, never a reversal of a reversal. The other side is
  /// notified.
  Future<LedgerEntry> reverse(
    Session session,
    ProjectMember member,
    int entryId,
    String reason,
  ) {
    return session.db.transaction((transaction) async {
      final entry = await _find(session, member.projectId, entryId, transaction);
      if (entry.recordedBy != member.authUserId) {
        throw AppException(code: AppErrorCode.notEntryAuthor);
      }
      if (entry.reversesId != null) {
        throw AppException(code: AppErrorCode.invalidLedgerEntry);
      }
      if (await _reversalOf(session, entryId, transaction) != null) {
        throw AppException(code: AppErrorCode.alreadyReversed);
      }
      final reversal = await LedgerEntry.db.insertRow(
        session,
        LedgerEntry(
          projectId: entry.projectId,
          stageId: entry.stageId,
          kind: entry.kind,
          amountMinor: -entry.amountMinor,
          occurredOn: _day(DateTime.now(), null),
          recordedBy: member.authUserId,
          method: entry.method,
          category: entry.category,
          note: reason,
          reversesId: entry.id,
          createdAt: DateTime.now().toUtc(),
        ),
        transaction: transaction,
      );
      final release = entry.kind == LedgerEntryKind.release;
      await _written(
        session,
        member,
        reversal,
        action: 'ledger.reverse',
        activity: ActivityType.entryReversed,
        notification: NotificationType.entryReversed,
        notify: release
            ? await _people.siteManagers(
                session,
                member.projectId,
                transaction: transaction,
              )
            : await _people.approvers(
                session,
                member.projectId,
                transaction: transaction,
              ),
        transaction: transaction,
      );
      return reversal;
    });
  }

  // --- Reading ------------------------------------------------------------

  /// Newest first, older than [beforeId], only [kind] and [stageId]'s when
  /// given (`_standards/14` §3.3, doc/05 §9.5).
  Future<LedgerPage> list(
    Session session,
    int projectId, {
    int? beforeId,
    required int pageSize,
    LedgerEntryKind? kind,
    int? stageId,
  }) async {
    final entries = await LedgerEntry.db.find(
      session,
      where: (t) {
        var where = t.projectId.equals(projectId);
        if (beforeId != null) where &= t.id < beforeId;
        if (kind != null) where &= t.kind.equals(kind);
        if (stageId != null) where &= t.stageId.equals(stageId);
        return where;
      },
      orderBy: (t) => t.id.desc(),
      limit: pageSize.clamp(1, maxPageSize),
    );
    return LedgerPage(items: await _described(session, projectId, entries));
  }

  Future<LedgerEntry> get(Session session, int projectId, int entryId) async {
    final entry = await _find(session, projectId, entryId, null);
    return (await _described(session, projectId, [entry])).single;
  }

  Future<LedgerSummary> summary(Session session, int projectId) async {
    final stages = await _stages.stagesByProject(session, {projectId});
    final entries = await LedgerEntry.db.find(
      session,
      where: (t) => t.projectId.equals(projectId),
    );
    return summarize(stages: stages[projectId] ?? [], entries: entries);
  }

  /// An expense's receipt photo, for the project's members.
  Future<ByteData> receipt(
    Session session,
    int projectId,
    int entryId,
  ) async {
    final entry = await _find(session, projectId, entryId, null);
    final path = entry.receiptPath;
    if (path == null) {
      throw AppException(code: AppErrorCode.ledgerEntryNotFound);
    }
    final data = await session.storage.retrieveFile(
      storageId: storageId,
      path: path,
    );
    return data;
  }

  // --- Helpers ------------------------------------------------------------

  Future<LedgerEntry> _find(
    Session session,
    int projectId,
    int entryId,
    Transaction? transaction,
  ) async {
    final entry = await LedgerEntry.db.findFirstRow(
      session,
      where: (t) => t.id.equals(entryId) & t.projectId.equals(projectId),
      transaction: transaction,
    );
    if (entry == null) {
      throw AppException(code: AppErrorCode.ledgerEntryNotFound);
    }
    return entry;
  }

  Future<LedgerEntry?> _reversalOf(
    Session session,
    int entryId,
    Transaction? transaction,
  ) => LedgerEntry.db.findFirstRow(
    session,
    where: (t) => t.reversesId.equals(entryId),
    transaction: transaction,
  );

  Future<void> _checkStage(
    Session session,
    int projectId,
    int? stageId,
    Transaction transaction,
  ) async {
    if (stageId == null) return;
    final stage = await Stage.db.findFirstRow(
      session,
      where: (t) => t.id.equals(stageId) & t.projectId.equals(projectId),
      transaction: transaction,
    );
    if (stage == null) throw AppException(code: AppErrorCode.stageNotFound);
  }

  /// The receipt was uploaded under this project's receipts, is not too
  /// large and matches its hash.
  Future<void> _checkReceipt(
    Session session,
    int projectId,
    String path,
    ExpenseDraft draft,
  ) async {
    if (!path.startsWith('projects/$projectId/receipts/') ||
        path.contains('..')) {
      throw AppException(code: AppErrorCode.invalidLedgerEntry);
    }
    final uploaded =
        await session.storage.verifyUpload(storageId: storageId, path: path) ||
        await session.storage.fileExists(storageId: storageId, path: path);
    if (!uploaded) throw AppException(code: AppErrorCode.uploadMissing);
    final data = await session.storage.retrieveFile(
      storageId: storageId,
      path: path,
    );
    if (data.lengthInBytes > maxReceiptBytes) {
      throw AppException(code: AppErrorCode.evidenceFileTooLarge);
    }
    final bytes = data.buffer.asUint8List(
      data.offsetInBytes,
      data.lengthInBytes,
    );
    if (sha256.convert(bytes).toString() != draft.receiptSha256) {
      throw AppException(code: AppErrorCode.invalidLedgerEntry);
    }
  }

  /// Audit, the activity event (with the stage, for the feed's filter) and
  /// the notification of a written entry.
  Future<void> _written(
    Session session,
    ProjectMember actor,
    LedgerEntry entry, {
    required String action,
    required ActivityType activity,
    required NotificationType notification,
    required List<UuidValue> notify,
    required Transaction transaction,
  }) async {
    final project = await Project.db.findById(
      session,
      entry.projectId,
      transaction: transaction,
    );
    final payload = {
      'entryId': '${entry.id}',
      'kind': entry.kind.name,
      'amountMinor': '${entry.amountMinor}',
      'currencyCode': ?project?.currencyCode,
      'stageId': ?entry.stageId?.toString(),
      'method': ?entry.method?.name,
      'category': ?entry.category?.name,
    };
    await _audit.record(
      session,
      actorId: actor.authUserId,
      projectId: entry.projectId,
      action: action,
      entityType: 'ledger_entry',
      entityId: entry.id,
      after: payload,
      transaction: transaction,
    );
    await _activity.record(
      session,
      projectId: entry.projectId,
      actorId: actor.authUserId,
      type: activity,
      targetType: 'ledger_entry',
      targetId: entry.id,
      payload: payload,
      transaction: transaction,
    );
    await _notifications.notify(
      session,
      userIds: notify,
      actorId: actor.authUserId,
      projectId: entry.projectId,
      type: notification,
      payload: {
        ...payload,
        'projectName': ?project?.name,
        'actorName': ?await _people.name(session, actor.authUserId),
      },
      transaction: transaction,
    );
  }

  /// With who recorded each entry and, for the reversed ones, the reversal.
  Future<List<LedgerEntry>> _described(
    Session session,
    int projectId,
    List<LedgerEntry> entries,
  ) async {
    if (entries.isEmpty) return entries;
    final names = await _people.names(session, {
      for (final e in entries) e.recordedBy,
    });
    final reversals = await LedgerEntry.db.find(
      session,
      where: (t) => t.reversesId.inSet({for (final e in entries) e.id!}),
    );
    final reversalOf = {for (final r in reversals) r.reversesId!: r};
    return [
      for (final e in entries)
        e.copyWith(
          recordedByName: names[e.recordedBy],
          reversedById: reversalOf[e.id]?.id,
          reversalReason: reversalOf[e.id]?.note,
        ),
    ];
  }
}
