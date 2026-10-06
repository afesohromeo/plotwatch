import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import '../generated/protocol.dart';

/// Profile and settings of the signed-in user (PROF-01–03).
///
/// Name and email are kept in the auth module's profile; country and
/// language in [UserSettings] (decision M1-1).
class ProfileService {
  const ProfileService();

  static const supportedLocales = {'en', 'fr'};
  static const defaultLocale = 'en';
  static const maxFullNameLength = 100;
  static final _countryCode = RegExp(r'^[A-Z]{2}$');

  /// Throws [AppException] when an update value is invalid (decision M1-2).
  static void validateUpdate({
    required String fullName,
    required String? countryCode,
    required String locale,
  }) {
    final name = fullName.trim();
    if (name.isEmpty || name.length > maxFullNameLength) {
      throw AppException(code: AppErrorCode.invalidFullName);
    }
    if (countryCode != null && !_countryCode.hasMatch(countryCode)) {
      throw AppException(code: AppErrorCode.invalidCountryCode);
    }
    if (!supportedLocales.contains(locale)) {
      throw AppException(code: AppErrorCode.invalidLocale);
    }
  }

  /// Read-only: a user without settings gets the defaults. Only [updateMe]
  /// creates the settings row, so a fetch and a save running at the same time
  /// can't both insert it (Cloud bug of 2026-10-06).
  Future<MyProfile> getMe(Session session, UuidValue authUserId) async {
    final settings = await UserSettings.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authUserId),
    );
    return _toMyProfile(
      session,
      authUserId,
      countryCode: settings?.countryCode,
      locale: settings?.locale ?? defaultLocale,
    );
  }

  /// Saves validated values: the name in the auth profile, the rest in
  /// [UserSettings], in one transaction (`_standards/14` §4.2.4).
  Future<MyProfile> updateMe(
    Session session,
    UuidValue authUserId, {
    required String fullName,
    required String? countryCode,
    required String locale,
  }) {
    return session.db.transaction((transaction) async {
      final settings = await _findOrCreateSettings(
        session,
        authUserId,
        transaction: transaction,
      );
      final saved = await UserSettings.db.updateRow(
        session,
        settings.copyWith(
          countryCode: countryCode,
          locale: locale,
          updatedAt: DateTime.now().toUtc(),
        ),
        transaction: transaction,
      );
      await AuthServices.instance.userProfiles.changeFullName(
        session,
        authUserId,
        fullName.trim(),
        transaction: transaction,
      );
      return _toMyProfile(
        session,
        authUserId,
        countryCode: saved.countryCode,
        locale: saved.locale,
        transaction: transaction,
      );
    });
  }

  Future<UserSettings> _findOrCreateSettings(
    Session session,
    UuidValue authUserId, {
    Transaction? transaction,
  }) async {
    final existing = await UserSettings.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authUserId),
      transaction: transaction,
    );
    if (existing != null) return existing;

    final now = DateTime.now().toUtc();
    return UserSettings.db.insertRow(
      session,
      UserSettings(
        authUserId: authUserId,
        locale: defaultLocale,
        createdAt: now,
        updatedAt: now,
      ),
      transaction: transaction,
    );
  }

  Future<MyProfile> _toMyProfile(
    Session session,
    UuidValue authUserId, {
    required String? countryCode,
    required String locale,
    Transaction? transaction,
  }) async {
    final profile = await AuthServices.instance.userProfiles
        .maybeFindUserProfileByUserId(
      session,
      authUserId,
      transaction: transaction,
    );
    return MyProfile(
      fullName: profile?.fullName,
      email: profile?.email,
      countryCode: countryCode,
      locale: locale,
    );
  }
}
