import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// The signed-in user's profile (`client.profile`).
class ProfileApiProvider {
  Client get _client => ApiProvider().client;

  Future<MyProfile> getMe() async {
    try {
      return await _client.profile.getMe();
    } catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }

  Future<MyProfile> updateMe({
    required String fullName,
    String? countryCode,
    required String locale,
  }) async {
    try {
      return await _client.profile.updateMe(
        fullName: fullName,
        countryCode: countryCode,
        locale: locale,
      );
    } catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }
}
