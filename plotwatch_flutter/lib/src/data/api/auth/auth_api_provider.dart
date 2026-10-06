import 'dart:async';

import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';


/// Email sign-in and session calls on the generated Serverpod client
/// (`client.emailIdp`, `client.auth`). No business logic; every error is
/// converted by [ApiErrorHandler] (`_standards/14` §2.4).
class AuthApiProvider {
  Client get _client => ApiProvider().client;

  Future<AuthSuccess> login({
    required String email,
    required String password,
  }) async {
    try {
      return await _client.emailIdp.login(email: email, password: password);
    } catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }

  Future<UuidValue> startRegistration({required String email}) async {
    try {
      return await _client.emailIdp.startRegistration(email: email);
    } catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }

  Future<String> verifyRegistrationCode({
    required UuidValue accountRequestId,
    required String verificationCode,
  }) async {
    try {
      return await _client.emailIdp.verifyRegistrationCode(
        accountRequestId: accountRequestId,
        verificationCode: verificationCode,
      );
    } catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }

  Future<AuthSuccess> finishRegistration({
    required String registrationToken,
    required String password,
  }) async {
    try {
      return await _client.emailIdp.finishRegistration(
        registrationToken: registrationToken,
        password: password,
      );
    } catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }

  Future<UuidValue> startPasswordReset({required String email}) async {
    try {
      return await _client.emailIdp.startPasswordReset(email: email);
    } catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }

  Future<String> verifyPasswordResetCode({
    required UuidValue passwordResetRequestId,
    required String verificationCode,
  }) async {
    try {
      return await _client.emailIdp.verifyPasswordResetCode(
        passwordResetRequestId: passwordResetRequestId,
        verificationCode: verificationCode,
      );
    } catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }

  Future<void> finishPasswordReset({
    required String finishPasswordResetToken,
    required String newPassword,
  }) async {
    try {
      await _client.emailIdp.finishPasswordReset(
        finishPasswordResetToken: finishPasswordResetToken,
        newPassword: newPassword,
      );
    } catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }

  /// Stores the session (secure storage) so later calls are authenticated.
  Future<void> saveSession(AuthSuccess authSuccess) async {
    try {
      await _client.auth.updateSignedInUser(authSuccess);
    } catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }

  Future<void> signOut() async {
    try {
      await _client.auth.signOutDevice();
    } catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }

  bool get isSignedIn => _client.auth.isAuthenticated;

  /// Emits whether a user is signed in each time the session changes.
  Stream<bool> get signedInChanges {
    final listenable = _client.auth.authInfoListenable;
    late final StreamController<bool> controller;
    void onChange() => controller.add(listenable.value != null);
    controller = StreamController<bool>(
      onListen: () => listenable.addListener(onChange),
      onCancel: () => listenable.removeListener(onChange),
    );
    return controller.stream;
  }
}
