import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
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

  /// Creates the account and saves the name and language in one request
  /// (Cloud bug of 2026-10-06).
  Future<AuthSuccess> finishRegistration({
    required String registrationToken,
    required String password,
    required String fullName,
    required String locale,
  }) async {
    try {
      return await _client.emailIdp.finishRegistrationWithProfile(
        registrationToken: registrationToken,
        password: password,
        fullName: fullName,
        locale: locale,
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

  bool get isGoogleSignInAvailable => ApiProvider().isGoogleSignInAvailable;

  /// Google sign-in (AUTH-04, doc/04g step 4), through the auth package's
  /// Google services: the PKCE redirect on the web, the Google account
  /// sheet on phones. Null when the user closes it.
  Future<AuthSuccess?> signInWithGoogle() async {
    const scopes = GoogleAuthController.defaultScopes;
    try {
      if (kIsWeb) {
        // Closing Google's tab leaves no trace: coming back here without a
        // result counts as a cancel (doc/04g step 10e).
        final result = await untilAbandoned(
          GoogleWebSignInService.instance.signIn(scopes: scopes),
          tabReturns(),
        );
        if (result == null) return null;
        return await _client.googleIdp.loginWithCode(
          code: result.code,
          codeVerifier: result.codeVerifier,
          redirectUri: result.redirectUri,
        );
      }
      final account = await GoogleSignIn.instance.authenticate(
        scopeHint: scopes,
      );
      final authorization =
          await account.authorizationClient.authorizationForScopes(scopes) ??
          await account.authorizationClient.authorizeScopes(scopes);
      final idToken = account.authentication.idToken;
      if (idToken == null) throw StateError('Google gave no ID token');
      return await _client.googleIdp.login(
        idToken: idToken,
        accessToken: authorization.accessToken,
      );
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled) return null;
      throw ApiErrorHandler.handle(e);
    } on OAuth2PkceUserCancelledException {
      return null;
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

  /// Forgets the session on this device only: after the account is deleted,
  /// the server has nothing left to sign out of (doc/04g step 6).
  Future<void> clearLocalSession() async {
    try {
      await _client.auth.updateSignedInUser(null);
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

  /// The signed-in user's auth ID, or null when signed out.
  UuidValue? get currentUserId =>
      _client.auth.authInfoListenable.value?.authUserId;

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
