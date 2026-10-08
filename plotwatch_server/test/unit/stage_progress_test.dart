import 'package:plotwatch_server/src/generated/protocol.dart';
import 'package:plotwatch_server/src/services/stage_service.dart';
import 'package:test/test.dart';

// Plan: doc/04c-m3-stages.md, decision M3-10 (STG-09): project progress is
// the budget-weighted share of approved stages.
void main() {
  final now = DateTime.utc(2026, 10, 8);

  Stage stage(int budgetMinor, StageStatus status) => Stage(
    projectId: 1,
    orderIndex: 0,
    name: 'Stage',
    budgetMinor: budgetMinor,
    status: status,
    createdAt: now,
    updatedAt: now,
  );

  test('Given no stages then progress is 0', () {
    expect(StageService.progressPercent([]), 0);
  });

  test('Given budgets then approved stages count by their budget', () {
    expect(
      StageService.progressPercent([
        stage(300, StageStatus.approved),
        stage(100, StageStatus.approved),
        stage(600, StageStatus.inProgress),
      ]),
      40,
    );
  });

  test('Given every budget is 0 then each stage weighs the same', () {
    expect(
      StageService.progressPercent([
        stage(0, StageStatus.approved),
        stage(0, StageStatus.submitted),
        stage(0, StageStatus.notStarted),
      ]),
      33,
    );
  });

  test('Given only submitted stages then nothing counts yet', () {
    expect(
      StageService.progressPercent([
        stage(500, StageStatus.submitted),
        stage(500, StageStatus.changesRequested),
      ]),
      0,
    );
  });

  test('Given every stage approved then progress is 100', () {
    expect(
      StageService.progressPercent([
        stage(1, StageStatus.approved),
        stage(999999999999, StageStatus.approved),
      ]),
      100,
    );
  });
}
