import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/providers/google.dart';

import '../services/account_link_service.dart';

/// By extending [GoogleIdpBaseEndpoint], the Google identity provider
/// endpoints are made available on the server (AUTH-04, doc/04g step 4).
///
/// One account per email (AUTH-04b): before the module's login, a first
/// Google sign-in with the verified email of a password account is linked
/// to that user, instead of creating a second one.
class GoogleIdpEndpoint extends GoogleIdpBaseEndpoint {
  static const _links = AccountLinkService();

  @override
  Future<AuthSuccess> login(
    Session session, {
    required String idToken,
    required String? accessToken,
  }) async {
    final details = await googleIdp.utils.fetchAccountDetails(
      session,
      idToken: idToken,
      accessToken: accessToken,
    );
    await _links.linkGoogleToPasswordAccount(session, details);
    return googleIdp.login(
      session,
      idToken: idToken,
      accessToken: accessToken,
    );
  }

  /// The web flow: the code is exchanged for tokens first, then the same
  /// login as on phones.
  @override
  Future<AuthSuccess> loginWithCode(
    Session session, {
    required String code,
    required String codeVerifier,
    required String redirectUri,
  }) async {
    final tokens = await googleIdp.utils.exchangeCodeForToken(
      session,
      code: code,
      codeVerifier: codeVerifier,
      redirectUri: redirectUri,
    );
    return login(
      session,
      idToken: tokens.idToken,
      accessToken: tokens.accessToken,
    );
  }
}
