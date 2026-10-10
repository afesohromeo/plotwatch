import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/permission_service.dart';
import '../services/site_service.dart';

/// The site's location (SITE-03, 04, 07; decision M2-15). Thin: sign-in →
/// permission → validate → one service call (`_standards/14` §4.2).
class SiteEndpoint extends Endpoint {
  static const _service = SiteService();
  static const _permissions = PermissionService();

  @override
  bool get requireLogin => true;

  /// The validated site, or null while the project waits for one.
  Future<Site?> get(Session session, int projectId) async {
    await _permissions.require(session, projectId, ProjectAction.viewProject);
    return _service.get(session, projectId);
  }

  /// The site manager's GPS reading on the plot (phone app only).
  Future<SiteProposal> propose(
    Session session,
    int projectId, {
    required double lat,
    required double lng,
    required double accuracyM,
    required bool isMocked,
  }) async {
    final siteManager = await _permissions.requireOpen(
      session,
      projectId,
      ProjectAction.proposeSite,
    );
    SiteService.validateProposal(
      lat: lat,
      lng: lng,
      accuracyM: accuracyM,
      isMocked: isMocked,
    );
    return _service.propose(
      session,
      siteManager,
      lat: lat,
      lng: lng,
      accuracyM: accuracyM,
    );
  }

  Future<List<SiteProposal>> listProposals(
    Session session,
    int projectId,
  ) async {
    await _permissions.require(session, projectId, ProjectAction.viewProject);
    return _service.listProposals(session, projectId);
  }

  Future<Site> validate(
    Session session,
    int projectId,
    int proposalId, {
    required int radiusM,
    String? addressText,
  }) async {
    final owner = await _permissions.requireOpen(
      session,
      projectId,
      ProjectAction.editProject,
    );
    final address = SiteService.validateValidation(
      radiusM: radiusM,
      addressText: addressText,
    );
    return _service.validate(
      session,
      owner,
      proposalId,
      radiusM: radiusM,
      addressText: address,
    );
  }

  /// The owner changes the radius and the address of the validated site
  /// without a new GPS reading (doc/04b H-3); a blank address removes it.
  Future<Site> update(
    Session session,
    int projectId, {
    required int radiusM,
    String? addressText,
  }) async {
    final owner = await _permissions.requireOpen(
      session,
      projectId,
      ProjectAction.editProject,
    );
    final address = SiteService.validateValidation(
      radiusM: radiusM,
      addressText: addressText,
    );
    return _service.update(
      session,
      owner,
      radiusM: radiusM,
      addressText: address,
    );
  }

  Future<void> reject(
    Session session,
    int projectId,
    int proposalId, {
    String? reason,
  }) async {
    final owner = await _permissions.requireOpen(
      session,
      projectId,
      ProjectAction.editProject,
    );
    return _service.reject(
      session,
      owner,
      proposalId,
      reason: SiteService.validateRejectReason(reason),
    );
  }
}
