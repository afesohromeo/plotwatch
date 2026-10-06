import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/providers/email.dart';

import '../services/profile_service.dart';

/// By extending [EmailIdpBaseEndpoint], the email identity provider endpoints
/// are made available on the server and enable the corresponding sign-in widget
/// on the client.
class EmailIdpEndpoint extends EmailIdpBaseEndpoint {
  static const _profileService = ProfileService();

  /// Last step of Plotwatch's sign-up (decision M1-4): creates the account
  /// and saves the user's name and language **in the same request**, so no
  /// other request can see the new user half-created (Cloud bug of
  /// 2026-10-06). Invalid profile values are refused before the account is
  /// created.
  Future<AuthSuccess> finishRegistrationWithProfile(
    Session session, {
    required String registrationToken,
    required String password,
    required String fullName,
    required String locale,
  }) async {
    ProfileService.validateUpdate(
      fullName: fullName,
      countryCode: null,
      locale: locale,
    );
    final authSuccess = await finishRegistration(
      session,
      registrationToken: registrationToken,
      password: password,
    );
    await _profileService.updateMe(
      session,
      authSuccess.authUserId,
      fullName: fullName,
      countryCode: null,
      locale: locale,
    );
    return authSuccess;
  }
}
