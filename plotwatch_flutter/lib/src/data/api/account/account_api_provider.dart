import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// The signed-in user's account (`client.account`, doc/04g step 6).
class AccountApiProvider {
  Client get _client => ApiProvider().client;

  /// The projects to complete or archive before deleting the account.
  Future<List<String>> deletionBlockers() async {
    try {
      return await _client.account.deletionBlockers();
    } catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }

  Future<void> deleteMe() async {
    try {
      await _client.account.deleteMe();
    } catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }
}
