import 'dart:developer';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';


/// Account and session operations used by the auth BLoCs. Signing in and
/// finishing registration also store the session. Errors are logged and
/// rethrown (RULE-012).
class AuthRepository {
  AuthRepository({AuthApiProvider? apiProvider})
      : _apiProvider = apiProvider ?? AuthApiProvider();

  final AuthApiProvider _apiProvider;

  bool get isSignedIn => _apiProvider.isSignedIn;

  Stream<bool> get signedInChanges => _apiProvider.signedInChanges;

  Future<void> signIn({required String email, required String password}) async {
    try {
      final authSuccess =
          await _apiProvider.login(email: email, password: password);
      await _apiProvider.saveSession(authSuccess);
    } catch (e) {
      log('Error signing in: $e');
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
  }) async {
    try {
      final authSuccess = await _apiProvider.finishRegistration(
        registrationToken: registrationToken,
        password: password,
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
