import 'dart:developer';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// The signed-in user's profile. Errors are logged and rethrown (RULE-012).
class ProfileRepository {
  ProfileRepository({ProfileApiProvider? apiProvider})
    : _apiProvider = apiProvider ?? ProfileApiProvider();

  final ProfileApiProvider _apiProvider;

  Future<MyProfile> fetchMe() async {
    try {
      return await _apiProvider.getMe();
    } catch (e) {
      log('Error fetching profile: $e');
      rethrow;
    }
  }

  Future<MyProfile> updateMe({
    required String fullName,
    String? countryCode,
    required String locale,
  }) async {
    try {
      return await _apiProvider.updateMe(
        fullName: fullName,
        countryCode: countryCode,
        locale: locale,
      );
    } catch (e) {
      log('Error updating profile: $e');
      rethrow;
    }
  }
}
