import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/providers/email.dart';

import '../generated/protocol.dart';
import '../services/account_link_service.dart';
import '../services/profile_service.dart';

/// By extending [EmailIdpBaseEndpoint], the email identity provider endpoints
/// are made available on the server and enable the corresponding sign-in widget
/// on the client.
class EmailIdpEndpoint extends EmailIdpBaseEndpoint {
  static const _profileService = ProfileService();
  static const _links = AccountLinkService();

  /// One account per email (AUTH-04b, doc/04g): an email that only a Google
  /// user has is refused, with "use Continue with Google".
  @override
  Future<UuidValue> startRegistration(
    Session session, {
    required String email,
  }) async {
    if (await _links.isGoogleOnlyEmail(session, email)) {
      throw AppException(code: AppErrorCode.emailUsesGoogle);
    }
    return super.startRegistration(session, email: email);
  }

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
