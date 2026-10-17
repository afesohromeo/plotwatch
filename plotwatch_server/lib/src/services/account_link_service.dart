import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_auth_idp_server/providers/google.dart';

/// One account per email (AUTH-04b, doc/04g). Serverpod's Google provider
/// finds users by Google's account ID only, so a first Google sign-in with
/// the email of a password account would create a second user.
class AccountLinkService {
  const AccountLinkService();

  /// Before a Google login: a Google account seen for the first time, whose
  /// **verified** email a password account has, is linked to that user. The
  /// module's login then finds it and signs that user in. Anything else is
  /// left to the module (a returning user, or a new user).
  Future<void> linkGoogleToPasswordAccount(
    Session session,
    GoogleAccountDetails details,
  ) async {
    if (details.verifiedEmail != true) return;
    final known = await GoogleAccount.db.findFirstRow(
      session,
      where: (t) => t.userIdentifier.equals(details.userIdentifier),
    );
    if (known != null) return;
    final passwordAccount = await EmailAccount.db.findFirstRow(
      session,
      where: (t) => t.email.equals(_normalized(details.email)),
    );
    if (passwordAccount == null) return;
    await AuthServices.instance.googleIdp.utils.linkGoogleAuthentication(
      session,
      authUserId: passwordAccount.authUserId,
      accountDetails: details,
    );
  }

  /// Whether an email belongs to a Google user without a password: email
  /// sign-up is then refused with "use Continue with Google". When the user
  /// has both, the module's own silent refusal applies.
  Future<bool> isGoogleOnlyEmail(Session session, String email) async {
    final normalized = _normalized(email);
    final google = await GoogleAccount.db.findFirstRow(
      session,
      where: (t) => t.email.equals(normalized),
    );
    if (google == null) return false;
    final password = await EmailAccount.db.findFirstRow(
      session,
      where: (t) => t.email.equals(normalized),
    );
    return password == null;
  }

  /// Whether an email/password account already uses [email]: sign-up is
  /// then refused with that reason instead of a code that never comes
  /// (developer, 2026-10-17; this reveals that the email is registered,
  /// which the developer accepted).
  Future<bool> isRegisteredEmail(Session session, String email) async =>
      await EmailAccount.db.findFirstRow(
        session,
        where: (t) => t.email.equals(_normalized(email)),
      ) !=
      null;

  /// As both providers store emails.
  static String _normalized(String email) => email.trim().toLowerCase();
}
