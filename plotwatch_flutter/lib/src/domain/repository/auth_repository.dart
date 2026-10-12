import 'dart:developer';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// Account and session operations used by the auth BLoCs. Signing in and
/// finishing registration also store the session. Errors are logged and
/// rethrown (RULE-012).
class AuthRepository {
  AuthRepository({
    AuthApiProvider? apiProvider,
    ProfileApiProvider? profileApiProvider,
    AccountApiProvider? accountApiProvider,
  }) : _apiProvider = apiProvider ?? AuthApiProvider(),
       _profileApiProvider = profileApiProvider ?? ProfileApiProvider(),
       _accountApiProvider = accountApiProvider ?? AccountApiProvider();

  final AuthApiProvider _apiProvider;
  final ProfileApiProvider _profileApiProvider;
  final AccountApiProvider _accountApiProvider;

  bool get isGoogleSignInAvailable => _apiProvider.isGoogleSignInAvailable;

  bool get isSignedIn => _apiProvider.isSignedIn;

  /// Tells whether a capture is the user's own (doc/04d group D).
  UuidValue? get currentUserId => _apiProvider.currentUserId;

  Stream<bool> get signedInChanges => _apiProvider.signedInChanges;

  Future<void> signIn({required String email, required String password}) async {
    try {
      final authSuccess = await _apiProvider.login(
        email: email,
        password: password,
      );
      await _apiProvider.saveSession(authSuccess);
    } catch (e) {
      log('Error signing in: $e');
      rethrow;
    }
  }

  /// Signs in with Google and stores the session; false when the user
  /// closed Google's window. A new user gets the app's [locale], as with
  /// the email sign-up; failing that never undoes the sign-in.
  Future<bool> signInWithGoogle({required String locale}) async {
    try {
      final authSuccess = await _apiProvider.signInWithGoogle();
      if (authSuccess == null) return false;
      await _apiProvider.saveSession(authSuccess);
      try {
        await _profileApiProvider.adoptLocale(locale: locale);
      } catch (e) {
        log('Error adopting the language after Google sign-in: $e');
      }
      return true;
    } catch (e) {
      log('Error signing in with Google: $e');
      rethrow;
    }
  }

  /// The projects to complete or archive before deleting the account.
  Future<List<String>> deletionBlockers() async {
    try {
      return await _accountApiProvider.deletionBlockers();
    } catch (e) {
      log('Error checking account deletion: $e');
      rethrow;
    }
  }

  /// Deletes the account (doc/04g step 6), then forgets the session here:
  /// the router goes back to the welcome page.
  Future<void> deleteAccount() async {
    try {
      await _accountApiProvider.deleteMe();
      await _apiProvider.clearLocalSession();
    } catch (e) {
      log('Error deleting the account: $e');
      rethrow;
    }
  }

  Future<UuidValue> startRegistration({required String email}) async {
    try {
      return await _apiProvider.startRegistration(email: email);
    } catch (e) {
      log('Error starting registration: $e');
      rethrow;
    }
  }

  Future<String> verifyRegistrationCode({
    required UuidValue accountRequestId,
    required String code,
  }) async {
    try {
      return await _apiProvider.verifyRegistrationCode(
        accountRequestId: accountRequestId,
        verificationCode: code,
      );
    } catch (e) {
      log('Error verifying registration code: $e');
      rethrow;
    }
  }

  Future<void> finishRegistration({
    required String registrationToken,
    required String password,
    required String fullName,
    required String locale,
  }) async {
    try {
      final authSuccess = await _apiProvider.finishRegistration(
        registrationToken: registrationToken,
        password: password,
        fullName: fullName,
        locale: locale,
      );
      await _apiProvider.saveSession(authSuccess);
    } catch (e) {
      log('Error finishing registration: $e');
      rethrow;
    }
  }

  Future<UuidValue> startPasswordReset({required String email}) async {
    try {
      return await _apiProvider.startPasswordReset(email: email);
    } catch (e) {
      log('Error starting password reset: $e');
      rethrow;
    }
  }

  Future<String> verifyPasswordResetCode({
    required UuidValue passwordResetRequestId,
    required String code,
  }) async {
    try {
      return await _apiProvider.verifyPasswordResetCode(
        passwordResetRequestId: passwordResetRequestId,
        verificationCode: code,
      );
    } catch (e) {
      log('Error verifying password reset code: $e');
      rethrow;
    }
  }

  Future<void> finishPasswordReset({
    required String finishPasswordResetToken,
    required String newPassword,
  }) async {
    try {
      await _apiProvider.finishPasswordReset(
        finishPasswordResetToken: finishPasswordResetToken,
        newPassword: newPassword,
      );
    } catch (e) {
      log('Error finishing password reset: $e');
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await _apiProvider.signOut();
    } catch (e) {
      log('Error signing out: $e');
      rethrow;
    }
  }
}
