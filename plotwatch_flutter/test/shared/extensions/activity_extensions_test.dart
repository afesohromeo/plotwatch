import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

import '../../helpers/helpers.dart';

// Plan: doc/04e-m5-review-realtime.md, decision M5-7 and group E: every
// event and notification type has a sentence in EN and FR; tapping opens
// its source.
void main() {
  final en = lookupAppLocalizations(const Locale('en'));
  final fr = lookupAppLocalizations(const Locale('fr'));

  group('Given every feed event type', () {
    for (final type in ActivityType.values) {
      test('then ${type.name} has a sentence in English and French', () {
        final entry = testActivity(
          type: type,
          payload: const {
            'name': 'Foundation',
            'status': 'active',
            'role': 'siteManager',
            'from': 'viewer',
            'to': 'coFunder',
            'verificationLevel': 'verified',
            'excerpt': 'Concrete poured',
            'stageId': '2',
          },
        );
        for (final l10n in [en, fr]) {
          final sentence = entry.sentence(l10n);
          expect(sentence, contains('Ada'));
          expect(sentence, isNot(contains('{')));
        }
      });
    }
  });

  group('Given every notification type', () {
    for (final type in NotificationType.values) {
      test('then ${type.name} has a sentence in English and French', () {
        final notification = testNotification(
          type: type,
          payload: const {
            'stageId': '2',
            'stageName': 'Foundation',
            'projectName': 'Maison Douala',
            'actorName': 'Bob',
            'reviewerName': 'Bob',
            'memberName': 'Bob',
            'role': 'siteManager',
            'comment': 'Retake the corner',
          },
        );
        for (final l10n in [en, fr]) {
          final sentence = notification.sentence(l10n);
          expect(sentence, contains('Bob'));
          expect(sentence, isNot(contains('{')));
        }
      });
    }
  });

  test('Given an approval then the sentence names who and which stage', () {
    expect(
      testActivity().sentence(en),
      en.activityStageApproved('Ada', 'Foundation'),
    );
  });

  test('Given a photo then the sentence gives its badge', () {
    final entry = testActivity(
      type: ActivityType.evidenceCaptured,
      targetType: 'evidence',
      targetId: 9,
      payload: const {'verificationLevel': 'verified', 'stageId': '2'},
    );

    expect(
      entry.sentence(en),
      en.activityEvidenceCaptured('Ada', en.verificationVerified),
    );
  });

  test('Given an unknown actor then the sentence still reads', () {
    expect(
      testActivity(actorName: null).sentence(en),
      en.activityStageApproved(en.someone, 'Foundation'),
    );
  });

  group('Given an event when it is tapped then it opens its source', () {
    test('a photo opens its evidence page', () {
      final source = testActivity(
        type: ActivityType.evidenceCaptured,
        targetType: 'evidence',
        targetId: 9,
        payload: const {'verificationLevel': 'verified', 'stageId': '2'},
      ).source;

      expect(source?.name, evidenceRouteName);
      expect(source?.pathParameters, {
        'projectId': '1',
        'stageId': '2',
        'evidenceId': '9',
      });
    });

    test('a review opens the stage', () {
      final source = testActivity().source;

      expect(source?.name, stageRouteName);
      expect(source?.pathParameters, {'projectId': '1', 'stageId': '2'});
    });

    test('a plan change opens the plan (the stage may be gone)', () {
      expect(
        testActivity(type: ActivityType.stagePlanChanged).source?.name,
        stagesRouteName,
      );
    });

    test('a member event opens the members page, a site event the project', () {
      expect(
        testActivity(type: ActivityType.memberJoined).source?.name,
        membersRouteName,
      );
      expect(
        testActivity(type: ActivityType.siteChanged).source?.name,
        projectRouteName,
      );
    });

    test('an update opens the update', () {
      final source = testActivity(
        type: ActivityType.progressUpdatePosted,
        targetType: 'progress_update',
        targetId: 4,
      ).source;

      expect(source?.name, updateRouteName);
      expect(source?.pathParameters, {'projectId': '1', 'updateId': '4'});
    });
  });

  group('Given a notification when it is tapped then it opens its source', () {
    test('a stage notification opens the stage', () {
      final source = testNotification().source;

      expect(source?.name, stageRouteName);
      expect(source?.pathParameters, {'projectId': '1', 'stageId': '2'});
    });

    test('a member joining opens the members page', () {
      expect(
        testNotification(type: NotificationType.memberJoined).source?.name,
        membersRouteName,
      );
    });
  });
}
