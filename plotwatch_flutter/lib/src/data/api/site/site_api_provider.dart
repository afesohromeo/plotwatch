import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// The site's location (`client.site`, SITE-03, 04, 07).
class SiteApiProvider {
  Client get _client => ApiProvider().client;

  Future<Site?> get(int projectId) async {
    try {
      return await _client.site.get(projectId);
    } catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }

  Future<SiteProposal> propose(
    int projectId, {
    required double lat,
    required double lng,
    required double accuracyM,
    required bool isMocked,
  }) async {
    try {
      return await _client.site.propose(
        projectId,
        lat: lat,
        lng: lng,
        accuracyM: accuracyM,
        isMocked: isMocked,
      );
    } catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }

  Future<List<SiteProposal>> listProposals(int projectId) async {
    try {
      return await _client.site.listProposals(projectId);
    } catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }

  Future<Site> validate(
    int projectId,
    int proposalId, {
    required int radiusM,
    String? addressText,
  }) async {
    try {
      return await _client.site.validate(
        projectId,
        proposalId,
        radiusM: radiusM,
        addressText: addressText,
      );
    } catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }

  Future<void> reject(int projectId, int proposalId, {String? reason}) async {
    try {
      await _client.site.reject(projectId, proposalId, reason: reason);
    } catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }
}
