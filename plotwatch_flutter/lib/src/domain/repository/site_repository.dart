import 'dart:developer';

import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// The site's location: proposals from GPS on the plot and the owner's
/// decision (decision M2-15). Errors are logged and rethrown (RULE-012).
class SiteRepository {
  SiteRepository({SiteApiProvider? apiProvider})
    : _apiProvider = apiProvider ?? SiteApiProvider();

  final SiteApiProvider _apiProvider;

  Future<Site?> fetchSite(int projectId) =>
      _logged('fetching the site', () => _apiProvider.get(projectId));

  Future<SiteProposal> proposeSite(int projectId, GpsReading reading) =>
      _logged(
        'proposing the site',
        () => _apiProvider.propose(
          projectId,
          lat: reading.latitude,
          lng: reading.longitude,
          accuracyM: reading.accuracyM,
          isMocked: reading.isMocked,
        ),
      );

  Future<List<SiteProposal>> fetchProposals(int projectId) => _logged(
    'fetching site proposals',
    () => _apiProvider.listProposals(projectId),
  );

  Future<Site> validateProposal(
    int projectId,
    int proposalId, {
    required int radiusM,
    String? addressText,
  }) => _logged(
    'validating a site proposal',
    () => _apiProvider.validate(
      projectId,
      proposalId,
      radiusM: radiusM,
      addressText: addressText,
    ),
  );

  /// Changes the radius and the address, not the point (doc/04b H-3).
  Future<Site> updateSite(
    int projectId, {
    required int radiusM,
    String? addressText,
  }) => _logged(
    'updating the site',
    () => _apiProvider.update(
      projectId,
      radiusM: radiusM,
      addressText: addressText,
    ),
  );

  Future<void> rejectProposal(
    int projectId,
    int proposalId, {
    String? reason,
  }) => _logged(
    'rejecting a site proposal',
    () => _apiProvider.reject(projectId, proposalId, reason: reason),
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
