import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'activity_service.dart';
import 'audit_service.dart';
import 'geo_service.dart';

/// The site's location (SITE-03, 04, 07; decision M2-15): the site manager
/// proposes it from GPS on the plot, the owner validates it with a radius or
/// rejects it. Callers check permissions first with `PermissionService`.
class SiteService {
  const SiteService();

  static const _audit = AuditService();
  static const _activity = ActivityService();

  static const maxAccuracyM = 20.0;
  static const minRadiusM = 10;
  static const maxRadiusM = 500;
  static const maxAddressLength = 200;
  static const maxRejectReasonLength = 500;

  /// Throws [AppException] when a GPS reading can't become a proposal
  /// (decision M2-17).
  static void validateProposal({
    required double lat,
    required double lng,
    required double accuracyM,
    required bool isMocked,
  }) {
    final validNumbers = !lat.isNaN && !lng.isNaN && !accuracyM.isNaN;
    if (!validNumbers ||
        lat < -90 ||
        lat > 90 ||
        lng < -180 ||
        lng > 180 ||
        accuracyM < 0) {
      throw AppException(code: AppErrorCode.invalidSiteLocation);
    }
    if (isMocked) {
      throw AppException(code: AppErrorCode.siteMockLocation);
    }
    if (accuracyM > maxAccuracyM) {
      throw AppException(code: AppErrorCode.siteAccuracyTooLow);
    }
  }

  /// Returns the trimmed address (none when blank), or throws [AppException].
  static String? validateValidation({
    required int radiusM,
    required String? addressText,
  }) {
    if (radiusM < minRadiusM || radiusM > maxRadiusM) {
      throw AppException(code: AppErrorCode.invalidSiteRadius);
    }
    return _optionalText(addressText, maxAddressLength);
  }

  /// Returns the trimmed reason (none when blank), or throws [AppException].
  static String? validateRejectReason(String? reason) =>
      _optionalText(reason, maxRejectReasonLength);

  Future<Site?> get(Session session, int projectId) =>
      Site.db.findFirstRow(session, where: (t) => t.projectId.equals(projectId));

  /// Saves a pending proposal; a pending one is superseded (decision M2-18).
  Future<SiteProposal> propose(
    Session session,
    ProjectMember siteManager, {
    required double lat,
    required double lng,
    required double accuracyM,
  }) {
    return session.db.transaction((transaction) async {
      final pending = await SiteProposal.db.find(
        session,
        where: (t) =>
            t.projectId.equals(siteManager.projectId) &
            t.status.equals(SiteProposalStatus.pending),
        transaction: transaction,
      );
      for (final old in pending) {
        await SiteProposal.db.updateRow(
          session,
          old.copyWith(status: SiteProposalStatus.superseded),
          transaction: transaction,
        );
      }
      final proposal = await SiteProposal.db.insertRow(
        session,
        SiteProposal(
          projectId: siteManager.projectId,
          proposedBy: siteManager.authUserId,
          lat: lat,
          lng: lng,
          accuracyM: accuracyM,
          proposedAt: DateTime.now().toUtc(),
          status: SiteProposalStatus.pending,
        ),
        transaction: transaction,
      );
      await _audit.record(
        session,
        actorId: siteManager.authUserId,
        projectId: siteManager.projectId,
        action: 'site.propose',
        entityType: 'site_proposal',
        entityId: proposal.id,
        after: {
          'lat': '${proposal.lat}',
          'lng': '${proposal.lng}',
          'accuracyM': '${proposal.accuracyM}',
        },
        transaction: transaction,
      );
      await _activity.record(
        session,
        projectId: siteManager.projectId,
        actorId: siteManager.authUserId,
        type: ActivityType.siteProposed,
        targetType: 'site_proposal',
        targetId: proposal.id,
        payload: {'accuracyM': '${proposal.accuracyM}'},
        transaction: transaction,
      );
      return proposal;
    });
  }

  /// Newest first: the history of the site's location.
  Future<List<SiteProposal>> listProposals(Session session, int projectId) =>
      SiteProposal.db.find(
        session,
        where: (t) => t.projectId.equals(projectId),
        orderBy: (t) => t.id.desc(),
      );

  /// Sets or moves the site from a pending proposal. The first validation
  /// makes a draft project active (decision M2-4).
  Future<Site> validate(
    Session session,
    ProjectMember owner,
    int proposalId, {
    required int radiusM,
    required String? addressText,
  }) {
    return session.db.transaction((transaction) async {
      final proposal = await _pendingProposal(
        session,
        owner.projectId,
        proposalId,
        transaction,
      );
      final now = DateTime.now().toUtc();
      final existing = await Site.db.findFirstRow(
        session,
        where: (t) => t.projectId.equals(owner.projectId),
        transaction: transaction,
      );
      final located = Site(
        projectId: owner.projectId,
        centerLat: proposal.lat,
        centerLng: proposal.lng,
        plusCode: GeoService.plusCodeFor(proposal.lat, proposal.lng),
        radiusM: radiusM,
        addressText: addressText,
        validatedProposalId: proposal.id!,
        validatedBy: owner.authUserId,
        validatedAt: now,
        updatedAt: now,
      );
      final site = existing == null
          ? await Site.db.insertRow(session, located, transaction: transaction)
          : await Site.db.updateRow(
              session,
              located.copyWith(id: existing.id, timezone: existing.timezone),
              transaction: transaction,
            );
      await SiteProposal.db.updateRow(
        session,
        proposal.copyWith(
          status: SiteProposalStatus.validated,
          decidedBy: owner.authUserId,
          decidedAt: now,
        ),
        transaction: transaction,
      );
      await _audit.record(
        session,
        actorId: owner.authUserId,
        projectId: owner.projectId,
        action: 'site.validate',
        entityType: 'site',
        entityId: site.id,
        before: existing == null ? null : _siteFields(existing),
        after: _siteFields(site),
        transaction: transaction,
      );
      await _activity.record(
        session,
        projectId: owner.projectId,
        actorId: owner.authUserId,
        type: ActivityType.siteChanged,
        targetType: 'site',
        targetId: site.id,
        payload: {'plusCode': site.plusCode, 'radiusM': '${site.radiusM}'},
        transaction: transaction,
      );
      await _activateIfDraft(session, owner, now, transaction);
      return site;
    });
  }

  Future<void> reject(
    Session session,
    ProjectMember owner,
    int proposalId, {
    required String? reason,
  }) {
    return session.db.transaction((transaction) async {
      final proposal = await _pendingProposal(
        session,
        owner.projectId,
        proposalId,
        transaction,
      );
      final rejected = await SiteProposal.db.updateRow(
        session,
        proposal.copyWith(
          status: SiteProposalStatus.rejected,
          decidedBy: owner.authUserId,
          decidedAt: DateTime.now().toUtc(),
          rejectReason: reason,
        ),
        transaction: transaction,
      );
      await _audit.record(
        session,
        actorId: owner.authUserId,
        projectId: owner.projectId,
        action: 'site.reject',
        entityType: 'site_proposal',
        entityId: rejected.id,
        after: {'status': rejected.status.name, 'reason': ?reason},
        transaction: transaction,
      );
      await _activity.record(
        session,
        projectId: owner.projectId,
        actorId: owner.authUserId,
        type: ActivityType.siteProposalRejected,
        targetType: 'site_proposal',
        targetId: rejected.id,
        payload: {'reason': ?reason},
        transaction: transaction,
      );
    });
  }

  /// The proposal, locked for this transaction, if it is still pending.
  Future<SiteProposal> _pendingProposal(
    Session session,
    int projectId,
    int proposalId,
    Transaction transaction,
  ) async {
    final proposal = await SiteProposal.db.findFirstRow(
      session,
      where: (t) => t.id.equals(proposalId) & t.projectId.equals(projectId),
      lockMode: LockMode.forUpdate,
      transaction: transaction,
    );
    if (proposal == null) {
      throw AppException(code: AppErrorCode.siteProposalNotFound);
    }
    if (proposal.status != SiteProposalStatus.pending) {
      throw AppException(code: AppErrorCode.siteProposalNotPending);
    }
    return proposal;
  }

  Future<void> _activateIfDraft(
    Session session,
    ProjectMember owner,
    DateTime now,
    Transaction transaction,
  ) async {
    final project = (await Project.db.findById(
      session,
      owner.projectId,
      transaction: transaction,
    ))!;
    if (project.status != ProjectStatus.draft) return;

    await Project.db.updateRow(
      session,
      project.copyWith(status: ProjectStatus.active, updatedAt: now),
      transaction: transaction,
    );
    await _audit.record(
      session,
      actorId: owner.authUserId,
      projectId: owner.projectId,
      action: 'project.activate',
      entityType: 'project',
      entityId: owner.projectId,
      before: {'status': ProjectStatus.draft.name},
      after: {'status': ProjectStatus.active.name},
      transaction: transaction,
    );
    await _activity.record(
      session,
      projectId: owner.projectId,
      actorId: owner.authUserId,
      type: ActivityType.projectStatusChanged,
      targetType: 'project',
      targetId: owner.projectId,
      payload: {'status': ProjectStatus.active.name},
      transaction: transaction,
    );
  }

  static String? _optionalText(String? text, int maxLength) {
    final trimmed = text?.trim();
    if (trimmed == null || trimmed.isEmpty) return null;
    if (trimmed.length > maxLength) {
      throw AppException(code: AppErrorCode.textTooLong);
    }
    return trimmed;
  }

  static Map<String, String> _siteFields(Site site) => {
        'lat': '${site.centerLat}',
        'lng': '${site.centerLng}',
        'plusCode': site.plusCode,
        'radiusM': '${site.radiusM}',
        'addressText': ?site.addressText,
        'validatedProposalId': '${site.validatedProposalId}',
      };
}
