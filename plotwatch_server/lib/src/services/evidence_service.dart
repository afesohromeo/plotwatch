import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:image/image.dart' as img;
import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'activity_service.dart';
import 'audit_service.dart';
import 'people_service.dart';
import 'verification_service.dart';

/// Captures: commit → upload → finalize with the checks, viewing, retract
/// (CAP-01–09, VER-01–04; doc/02 §9.1, doc/04d). Callers check the role
/// first with `PermissionService`; this service checks that a site manager
/// only finalizes and retracts their own captures.
class EvidenceService {
  const EvidenceService();

  static const _audit = AuditService();
  static const _activity = ActivityService();
  static const _people = PeopleService();

  /// Photos are private to the project's members (decision M4-4).
  static const storageId = 'private';
  static const maxFileBytes = 10 * 1024 * 1024;
  static const maxCaptionLength = 500;
  static const maxReasonLength = 500;
  static const maxDeviceTextLength = 100;
  static const thumbnailWidth = 400;

  /// The large views' size (doc/04g step 10b): enough for a full screen,
  /// a fraction of a phone photo's weight.
  static const displayWidth = 1280;

  /// A capture still committed after this is shown as failed (M4-12).
  static const uploadFailedAfter = Duration(hours: 24);

  static final _hashPattern = RegExp(r'^[0-9a-fA-F]{64}$');

  /// Stage statuses in which photos can be added (decision M4-9).
  static const _capturable = {
    StageStatus.notStarted,
    StageStatus.inProgress,
    StageStatus.changesRequested,
  };

  static String photoPath(int projectId, int evidenceId) =>
      'projects/$projectId/evidence/$evidenceId/photo.jpg';

  static String thumbPath(int projectId, int evidenceId) =>
      'projects/$projectId/evidence/$evidenceId/thumb.jpg';

  static String displayPath(int projectId, int evidenceId) =>
      'projects/$projectId/evidence/$evidenceId/display.jpg';

  /// Returns [commit] cleaned up (lower-case hash, trimmed texts, blank
  /// caption as none), or throws [AppException].
  static EvidenceCommit validateCommit(EvidenceCommit commit) {
    final lat = commit.lat;
    final lng = commit.lng;
    final accuracy = commit.accuracyM;
    final validPosition =
        (lat == null) == (lng == null) &&
        (lat == null || (lat >= -90 && lat <= 90 && !lat.isNaN)) &&
        (lng == null || (lng >= -180 && lng <= 180 && !lng.isNaN)) &&
        (accuracy == null || (accuracy >= 0 && !accuracy.isNaN));
    final device = [commit.deviceModel, commit.osVersion, commit.appVersion];
    if (!_hashPattern.hasMatch(commit.sha256) ||
        !validPosition ||
        device.any((t) => t.trim().isEmpty || t.length > maxDeviceTextLength)) {
      throw AppException(code: AppErrorCode.invalidEvidenceMetadata);
    }
    final caption = commit.caption?.trim();
    if (caption != null && caption.length > maxCaptionLength) {
      throw AppException(code: AppErrorCode.textTooLong);
    }
    return commit.copyWith(
      sha256: commit.sha256.toLowerCase(),
      caption: (caption?.isEmpty ?? true) ? null : caption,
      deviceModel: commit.deviceModel.trim(),
      osVersion: commit.osVersion.trim(),
      appVersion: commit.appVersion.trim(),
    );
  }

  /// Returns the trimmed reason, or throws [AppException] (1–500 characters).
  static String validateReason(String reason) {
    final trimmed = reason.trim();
    if (trimmed.isEmpty) {
      throw AppException(code: AppErrorCode.invalidEvidenceMetadata);
    }
    if (trimmed.length > maxReasonLength) {
      throw AppException(code: AppErrorCode.textTooLong);
    }
    return trimmed;
  }

  /// Records the capture with the server's time and returns where to upload
  /// its photo (decisions M4-3, M4-9). The first capture starts the stage.
  Future<EvidenceCommitResult> commit(
    Session session,
    ProjectMember siteManager,
    EvidenceCommit commit,
  ) async {
    final evidence = await session.db.transaction((transaction) async {
      final project = (await Project.db.findById(
        session,
        siteManager.projectId,
        lockMode: LockMode.forUpdate,
        transaction: transaction,
      ))!;
      if (project.status != ProjectStatus.active) {
        throw AppException(code: AppErrorCode.projectNotActive);
      }
      final stage = await Stage.db.findFirstRow(
        session,
        where: (t) =>
            t.id.equals(commit.stageId) &
            t.projectId.equals(siteManager.projectId),
        transaction: transaction,
      );
      if (stage == null) throw AppException(code: AppErrorCode.stageNotFound);
      if (!_capturable.contains(stage.status)) {
        throw AppException(code: AppErrorCode.stageLocked);
      }
      final item = await ChecklistItem.db.findFirstRow(
        session,
        where: (t) =>
            t.id.equals(commit.checklistItemId) & t.stageId.equals(stage.id),
        transaction: transaction,
      );
      if (item == null) {
        throw AppException(code: AppErrorCode.checklistItemNotFound);
      }

      final now = DateTime.now().toUtc();
      final inserted = await Evidence.db.insertRow(
        session,
        Evidence(
          projectId: siteManager.projectId,
          stageId: stage.id!,
          checklistItemId: item.id!,
          capturedBy: siteManager.authUserId,
          status: EvidenceStatus.committed,
          sha256: commit.sha256,
          // Set from the ID just below.
          photoPath: '',
          deviceCapturedAt: commit.deviceCapturedAt.toUtc(),
          serverCommittedAt: now,
          lat: commit.lat,
          lng: commit.lng,
          accuracyM: commit.accuracyM,
          altitudeM: commit.altitudeM,
          isMockLocation: commit.isMockLocation,
          capturedInApp: commit.capturedInApp,
          deviceModel: commit.deviceModel,
          osVersion: commit.osVersion,
          appVersion: commit.appVersion,
          verificationLevel: VerificationLevel.pending,
          caption: commit.caption,
        ),
        transaction: transaction,
      );
      final evidence = await Evidence.db.updateRow(
        session,
        inserted.copyWith(
          photoPath: photoPath(siteManager.projectId, inserted.id!),
        ),
        transaction: transaction,
      );
      if (stage.status == StageStatus.notStarted) {
        await _startStage(session, siteManager, stage, now, transaction);
      }
      await _audit.record(
        session,
        actorId: siteManager.authUserId,
        projectId: siteManager.projectId,
        action: 'evidence.commit',
        entityType: 'evidence',
        entityId: evidence.id,
        after: {
          'sha256': evidence.sha256,
          'stageId': '${evidence.stageId}',
          'checklistItemId': '${evidence.checklistItemId}',
        },
        transaction: transaction,
      );
      return evidence;
    });
    return EvidenceCommitResult(
      evidence: evidence,
      uploadDescription: await _uploadDescription(session, evidence),
    );
  }

  /// A new upload description while the capture is still committed (retry).
  Future<String> uploadDescription(
    Session session,
    ProjectMember siteManager,
    int evidenceId,
  ) async {
    final evidence = await _own(session, siteManager, evidenceId);
    if (evidence.status != EvidenceStatus.committed) {
      throw AppException(code: AppErrorCode.evidenceNotCommitted);
    }
    return _uploadDescription(session, evidence);
  }

  /// Reads the stored photo, makes its thumbnail and runs the checks
  /// (decisions M4-3, M4-5, M4-6). A hash mismatch doesn't throw: the
  /// capture is finalized as unverified (VER-04).
  Future<Evidence> finalize(
    Session session,
    ProjectMember siteManager,
    int evidenceId,
  ) async {
    final evidence = await _own(session, siteManager, evidenceId);
    if (evidence.status != EvidenceStatus.committed) {
      throw AppException(code: AppErrorCode.evidenceNotCommitted);
    }
    final path = evidence.photoPath;
    // A file stored by the server itself, or verified by an earlier
    // finalize, is already verified: then it only has to exist.
    final uploaded =
        await session.storage.verifyUpload(storageId: storageId, path: path) ||
        await session.storage.fileExists(storageId: storageId, path: path);
    if (!uploaded) throw AppException(code: AppErrorCode.uploadMissing);

    final data = await session.storage.retrieveFile(
      storageId: storageId,
      path: path,
    );
    if (data.lengthInBytes > maxFileBytes) {
      throw AppException(code: AppErrorCode.evidenceFileTooLarge);
    }
    final bytes = data.buffer.asUint8List(
      data.offsetInBytes,
      data.lengthInBytes,
    );
    final storedHash = sha256.convert(bytes).toString();
    final thumb = await _storeThumbnail(session, evidence, bytes);
    final site = (await Site.db.findFirstRow(
      session,
      where: (t) => t.projectId.equals(evidence.projectId),
    ))!;
    final checks = VerificationService.runAll(
      evidence,
      storedHash: storedHash,
      site: site,
    );
    final level = VerificationService.level(checks);

    return session.db.transaction((transaction) async {
      final current = (await Evidence.db.findById(
        session,
        evidenceId,
        lockMode: LockMode.forUpdate,
        transaction: transaction,
      ))!;
      // Another finalize of the same capture got here first.
      if (current.status != EvidenceStatus.committed) {
        throw AppException(code: AppErrorCode.evidenceNotCommitted);
      }
      final finalized = await Evidence.db.updateRow(
        session,
        current.copyWith(
          status: EvidenceStatus.finalized,
          thumbPath: thumb,
          fileSizeBytes: data.lengthInBytes,
          finalizedAt: DateTime.now().toUtc(),
          distanceFromSiteM: VerificationService.distanceFromSite(
            lat: current.lat,
            lng: current.lng,
            siteLat: site.centerLat,
            siteLng: site.centerLng,
          ),
          verificationLevel: level,
          checks: checks,
        ),
        transaction: transaction,
      );
      await _audit.record(
        session,
        actorId: siteManager.authUserId,
        projectId: finalized.projectId,
        action: 'evidence.finalize',
        entityType: 'evidence',
        entityId: finalized.id,
        after: {
          'verificationLevel': level.name,
          'storedSha256': storedHash,
          'fileSizeBytes': '${data.lengthInBytes}',
        },
        transaction: transaction,
      );
      await _activity.record(
        session,
        projectId: finalized.projectId,
        actorId: siteManager.authUserId,
        type: ActivityType.evidenceCaptured,
        targetType: 'evidence',
        targetId: finalized.id,
        payload: {
          'verificationLevel': level.name,
          'stageId': '${finalized.stageId}',
        },
        transaction: transaction,
      );
      return finalized;
    });
  }

  /// A stage's captures, newest first (decision M4-10).
  Future<List<Evidence>> list(
    Session session,
    int projectId,
    int stageId,
  ) async {
    final found = await Evidence.db.find(
      session,
      where: (t) => t.projectId.equals(projectId) & t.stageId.equals(stageId),
      orderBy: (t) => t.id.desc(),
    );
    return [
      for (final evidence in found) await _expireIfStuck(session, evidence),
    ];
  }

  /// One capture, with who took it (doc/04e C-2d).
  Future<Evidence> get(Session session, int projectId, int evidenceId) async {
    final evidence = await _expireIfStuck(
      session,
      await _find(session, projectId, evidenceId),
    );
    final author = await _people.person(
      session,
      projectId,
      evidence.capturedBy,
    );
    return evidence.copyWith(
      capturedByName: author.name,
      capturedByFormer: author.former,
    );
  }

  /// The photo or its thumbnail, for members only (decision M4-4). A
  /// capture without a thumbnail gives its photo.
  Future<ByteData> media(
    Session session,
    int projectId,
    int evidenceId,
    MediaVariant variant,
  ) async {
    final evidence = await _find(session, projectId, evidenceId);
    if (evidence.status != EvidenceStatus.finalized &&
        evidence.status != EvidenceStatus.retracted) {
      throw AppException(code: AppErrorCode.evidenceNotFound);
    }
    final path = switch (variant) {
      MediaVariant.thumbnail => evidence.thumbPath ?? evidence.photoPath,
      MediaVariant.display => await _display(session, evidence),
      MediaVariant.photo => evidence.photoPath,
    };
    return session.storage.retrieveFile(storageId: storageId, path: path);
  }

  /// The display size's path, made from the photo the first time it is
  /// asked for: existing photos get one too. The photo itself when it
  /// can't be decoded.
  Future<String> _display(Session session, Evidence evidence) async {
    final path = displayPath(evidence.projectId, evidence.id!);
    if (await session.storage.fileExists(storageId: storageId, path: path)) {
      return path;
    }
    final original = await session.storage.retrieveFile(
      storageId: storageId,
      path: evidence.photoPath,
    );
    final decoded = img.decodeImage(Uint8List.sublistView(original));
    if (decoded == null) return evidence.photoPath;
    final resized = decoded.width > displayWidth
        ? img.copyResize(decoded, width: displayWidth)
        : decoded;
    await session.storage.storeFile(
      storageId: storageId,
      path: path,
      byteData: ByteData.sublistView(img.encodeJpg(resized, quality: 80)),
    );
    return path;
  }

  /// The author withdraws a capture with a reason; it stays visible and
  /// stops covering its item (CAP-09, decision M4-11).
  Future<Evidence> retract(
    Session session,
    ProjectMember siteManager,
    int evidenceId,
    String reason,
  ) {
    return session.db.transaction((transaction) async {
      final evidence = await _own(
        session,
        siteManager,
        evidenceId,
        transaction: transaction,
      );
      if (evidence.status == EvidenceStatus.retracted) {
        throw AppException(code: AppErrorCode.evidenceAlreadyRetracted);
      }
      final retracted = await Evidence.db.updateRow(
        session,
        evidence.copyWith(
          status: EvidenceStatus.retracted,
          retractedAt: DateTime.now().toUtc(),
          retractedReason: reason,
        ),
        transaction: transaction,
      );
      await _audit.record(
        session,
        actorId: siteManager.authUserId,
        projectId: retracted.projectId,
        action: 'evidence.retract',
        entityType: 'evidence',
        entityId: retracted.id,
        before: {'status': evidence.status.name},
        after: {'status': retracted.status.name, 'reason': reason},
        transaction: transaction,
      );
      await _activity.record(
        session,
        projectId: retracted.projectId,
        actorId: siteManager.authUserId,
        type: ActivityType.evidenceRetracted,
        targetType: 'evidence',
        targetId: retracted.id,
        payload: {'stageId': '${retracted.stageId}'},
        transaction: transaction,
      );
      return retracted;
    });
  }

  Future<String> _uploadDescription(Session session, Evidence evidence) =>
      session.storage.createUploadDescription(
        storageId: storageId,
        path: evidence.photoPath,
        // The stored photo never changes (CAP-07, decision M4-3).
        options: const UploadOptions(
          maxFileSize: maxFileBytes,
          preventOverwrite: true,
        ),
      );

  /// A 400 px wide JPEG of the photo, or none if it can't be decoded
  /// (decision M4-5).
  Future<String?> _storeThumbnail(
    Session session,
    Evidence evidence,
    Uint8List bytes,
  ) async {
    final decoded = img.decodeImage(bytes);
    if (decoded == null) return null;
    final resized = decoded.width > thumbnailWidth
        ? img.copyResize(decoded, width: thumbnailWidth)
        : decoded;
    final path = thumbPath(evidence.projectId, evidence.id!);
    await session.storage.storeFile(
      storageId: storageId,
      path: path,
      byteData: ByteData.sublistView(img.encodeJpg(resized, quality: 75)),
    );
    return path;
  }

  /// `not_started → in_progress` with the first capture (STG-06, M4-9).
  Future<void> _startStage(
    Session session,
    ProjectMember siteManager,
    Stage stage,
    DateTime now,
    Transaction transaction,
  ) async {
    await Stage.db.updateRow(
      session,
      stage.copyWith(
        status: StageStatus.inProgress,
        startedAt: now,
        updatedAt: now,
      ),
      transaction: transaction,
    );
    await _audit.record(
      session,
      actorId: siteManager.authUserId,
      projectId: siteManager.projectId,
      action: 'stage.start',
      entityType: 'stage',
      entityId: stage.id,
      before: {'status': stage.status.name},
      after: {'status': StageStatus.inProgress.name, 'by': 'firstCapture'},
      transaction: transaction,
    );
    await _activity.record(
      session,
      projectId: siteManager.projectId,
      actorId: siteManager.authUserId,
      type: ActivityType.stageStarted,
      targetType: 'stage',
      targetId: stage.id,
      payload: {'name': stage.name},
      transaction: transaction,
    );
  }

  /// A capture still committed after [uploadFailedAfter] becomes
  /// `uploadFailed` when it is read (decision M4-12).
  Future<Evidence> _expireIfStuck(Session session, Evidence evidence) async {
    final cutoff = DateTime.now().toUtc().subtract(uploadFailedAfter);
    if (evidence.status != EvidenceStatus.committed ||
        evidence.serverCommittedAt.isAfter(cutoff)) {
      return evidence;
    }
    return Evidence.db.updateRow(
      session,
      evidence.copyWith(status: EvidenceStatus.uploadFailed),
    );
  }

  Future<Evidence> _find(
    Session session,
    int projectId,
    int evidenceId, {
    Transaction? transaction,
  }) async {
    final evidence = await Evidence.db.findFirstRow(
      session,
      where: (t) => t.id.equals(evidenceId) & t.projectId.equals(projectId),
      lockMode: transaction == null ? null : LockMode.forUpdate,
      transaction: transaction,
    );
    if (evidence == null) {
      throw AppException(code: AppErrorCode.evidenceNotFound);
    }
    return evidence;
  }

  /// The capture, if [siteManager] took it (`notYourCapture` otherwise).
  Future<Evidence> _own(
    Session session,
    ProjectMember siteManager,
    int evidenceId, {
    Transaction? transaction,
  }) async {
    final evidence = await _find(
      session,
      siteManager.projectId,
      evidenceId,
      transaction: transaction,
    );
    if (evidence.capturedBy != siteManager.authUserId) {
      throw AppException(code: AppErrorCode.notYourCapture);
    }
    return evidence;
  }
}
