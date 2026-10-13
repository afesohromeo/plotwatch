import 'dart:io';
import 'dart:typed_data';

import 'package:serverpod/serverpod.dart';

import '../seed/demo_seed.dart';

/// Seeds the judges' demo project (doc/04g step 7) as a future call: stored
/// in the database and claimed by one server, after a Cloud rollout has
/// settled. Seeding during startup failed there, because a rollout's first
/// server is stopped seconds after it starts.
class DemoSeedFutureCall extends FutureCall {
  /// Scheduled by `server.dart` when the `demoSeed` password is `true`.
  static const identifier = 'demo-seed';

  Future<void> seed(Session session) async {
    final password = session.serverpod.getPassword('demoPassword');
    if (password == null || password.length < 8) {
      session.log(
        'Demo seed skipped: demoPassword must have 8 characters or more.',
        level: LogLevel.warning,
      );
      return;
    }
    Uint8List file(String folder, String name) => File(
      Uri(path: 'web/seed/$folder/$name').toFilePath(),
    ).readAsBytesSync();
    try {
      final outcome = await DemoSeed(
        photo: (name) => file('photos', name),
        receipt: (name) => file('receipts', name),
      ).run(session, password: password);
      session.log(switch (outcome) {
        DemoSeedOutcome.created =>
          'Demo project "${DemoSeed.projectName}" created.',
        DemoSeedOutcome.alreadyThere =>
          'Demo project already there; nothing seeded.',
        DemoSeedOutcome.busy => 'Another server is seeding the demo project.',
      });
    } catch (e, stackTrace) {
      // A half-made demo is replaced on the next run.
      session.log(
        'Demo seed failed',
        level: LogLevel.error,
        exception: e,
        stackTrace: stackTrace,
      );
    }
  }
}
