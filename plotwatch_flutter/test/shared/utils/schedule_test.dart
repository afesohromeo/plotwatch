import 'package:flutter_test/flutter_test.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

import '../../helpers/helpers.dart';

// Plan: doc/04e-m5-review-realtime.md, decision M5-10 (STG-10): a stage is
// late once past its planned end and not approved; a photo taken after the
// planned end says by how many days. Neither changes a badge.
void main() {
  final plannedEnd = DateTime.utc(2026, 10, 12);
  Stage stage({StageStatus status = StageStatus.inProgress, DateTime? end}) =>
      testStage(status: status).copyWith(plannedEnd: end);

  group('Given a stage with a planned end', () {
    test('then it is late the day after, not on the day itself', () {
      final s = stage(end: plannedEnd);

      expect(s.isLateOn(DateTime(2026, 10, 12, 23, 59)), isFalse);
      expect(s.isLateOn(DateTime(2026, 10, 13, 0, 1)), isTrue);
    });

    test('then an approved stage is never late', () {
      expect(
        stage(
          status: StageStatus.approved,
          end: plannedEnd,
        ).isLateOn(DateTime(2026, 11, 1)),
        isFalse,
      );
    });

    test(
      'then a submitted stage past its end is still late (not approved)',
      () {
        expect(
          stage(
            status: StageStatus.submitted,
            end: plannedEnd,
          ).isLateOn(DateTime(2026, 11, 1)),
          isTrue,
        );
      },
    );
  });

  test('Given a stage without a planned end then it is never late', () {
    expect(stage().isLateOn(DateTime(2030)), isFalse);
  });

  group('Given a photo and the stage\'s planned end', () {
    test('when it was taken 5 days after then it says 5', () {
      expect(daysAfterPlannedEnd(DateTime(2026, 10, 17, 10), plannedEnd), 5);
    });

    test('when it was taken on the planned end or before then nothing', () {
      expect(
        daysAfterPlannedEnd(DateTime(2026, 10, 12, 18), plannedEnd),
        isNull,
      );
      expect(daysAfterPlannedEnd(DateTime(2026, 10, 1), plannedEnd), isNull);
    });

    test('when there is no planned end then nothing', () {
      expect(daysAfterPlannedEnd(DateTime(2026, 10, 17), null), isNull);
    });
  });
}
