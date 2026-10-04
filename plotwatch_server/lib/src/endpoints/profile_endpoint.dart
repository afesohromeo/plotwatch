import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import '../generated/protocol.dart';
import '../services/profile_service.dart';

/// The signed-in user's own profile (PROF-01–03).
/// Thin: sign-in → validate → one service call (`_standards/14` §4.2).
class ProfileEndpoint extends Endpoint {
  static const _service = ProfileService();

  @override
  bool get requireLogin => true;

  Future<MyProfile> getMe(Session session) =>
      _service.getMe(session, session.authenticated!.authUserId);

  Future<MyProfile> updateMe(
    Session session, {
    required String fullName,
    String? countryCode,
    required String locale,
  }) {
    ProfileService.validateUpdate(
      fullName: fullName,
      countryCode: countryCode,
      locale: locale,
    );
    return _service.updateMe(
      session,
      session.authenticated!.authUserId,
      fullName: fullName,
      countryCode: countryCode,
      locale: locale,
    );
  }
}
