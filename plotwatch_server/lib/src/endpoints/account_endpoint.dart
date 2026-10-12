import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import '../services/account_service.dart';

/// The signed-in user's account (doc/04g step 6).
/// Thin: sign-in → one service call (`_standards/14` §4.2).
class AccountEndpoint extends Endpoint {
  static const _service = AccountService();

  @override
  bool get requireLogin => true;

  /// The names of the projects that must be completed or archived before
  /// the account can be deleted.
  Future<List<String>> deletionBlockers(Session session) async => [
    for (final project in await _service.blockers(
      session,
      session.authenticated!.authUserId,
    ))
      project.name,
  ];

  /// Deletes the account: the person, not the shared history.
  Future<void> deleteMe(Session session) =>
      _service.deleteAccount(session, session.authenticated!.authUserId);
}
