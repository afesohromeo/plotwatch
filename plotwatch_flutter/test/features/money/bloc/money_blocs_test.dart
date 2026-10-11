import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

import '../../../helpers/helpers.dart';

// Plan: doc/04f-m6-ledger.md, groups D and E.
void main() {
  late MockLedgerRepository ledger;
  late MockActivityRepository activity;
  late MockProjectRepository projects;
  late MockStageRepository stages;
  late MockAuthRepository auth;
  late StreamController<LiveUpdate<ActivityEntry>> live;

  setUpAll(() {
    setUpTestLocalization();
    registerFallbackValue(
      ReleaseDraft(
        amountMinor: 1,
        occurredOn: DateTime.utc(2026),
        method: ReleaseMethod.cash,
      ),
    );
  });

  setUp(() {
    ledger = MockLedgerRepository();
    activity = MockActivityRepository();
    projects = MockProjectRepository();
    stages = MockStageRepository();
    auth = MockAuthRepository();
    live = StreamController<LiveUpdate<ActivityEntry>>();
    when(
      () => activity.watchActivity(1, afterId: any(named: 'afterId')),
    ).thenAnswer((_) => live.stream);
    when(() => ledger.fetchSummary(1)).thenAnswer(
      (_) async => testLedgerSummary(),
    );
  });

  // Not awaited: close() only completes once someone has listened.
  tearDown(() {
    live.close();
  });

  group('Given the Money tab', () {
    MoneyBloc build() =>
        MoneyBloc(ledgerRepository: ledger, activityRepository: activity);

    blocTest<MoneyBloc, MoneyState>(
      'when it loads then the summary comes and the project is followed',
      build: build,
      act: (bloc) => bloc.add(const MoneyEvent.load(projectId: 1)),
      verify: (bloc) {
        expect(bloc.state.summary?.toJson(), testLedgerSummary().toJson());
        expect(bloc.state.summaryStatus, GenericStatus.success);
        verify(() => activity.watchActivity(1)).called(1);
      },
    );

    blocTest<MoneyBloc, MoneyState>(
      'when a page is asked with filters then they are sent',
      setUp: () => when(
        () => ledger.fetchEntries(
          1,
          beforeId: null,
          size: kLedgerPageSize,
          kind: LedgerEntryKind.release,
          stageId: 2,
        ),
      ).thenAnswer(
        (_) async => PaginatedList(
          content: [testRelease()],
          pagination: const Pagination(size: kLedgerPageSize),
        ),
      ),
      build: build,
      act: (bloc) => bloc.add(
        const MoneyEvent.fetchEntries(
          projectId: 1,
          kind: LedgerEntryKind.release,
          stageId: 2,
        ),
      ),
      verify: (bloc) {
        expect(bloc.state.entries.single.id, 1);
        expect(bloc.state.maxEntries, isTrue);
        expect(bloc.state.entriesPageKey, 1);
      },
    );

    blocTest<MoneyBloc, MoneyState>(
      'when a ledger event arrives live then the summary and the list are '
      'refreshed; other events change nothing',
      build: build,
      act: (bloc) async {
        bloc.add(const MoneyEvent.load(projectId: 1));
        await pumpEventQueue();
        live.add(LiveItem(testActivity(id: 20, type: ActivityType.stageApproved)));
        await pumpEventQueue();
        live.add(
          LiveItem(testActivity(id: 21, type: ActivityType.expenseRecorded)),
        );
        await pumpEventQueue();
      },
      verify: (bloc) {
        // Once on load, once for the expense.
        verify(() => ledger.fetchSummary(1)).called(2);
        expect(bloc.state.entriesRefreshController, isTrue);
      },
    );
  });

  group('Given an entry', () {
    LedgerEntryBloc build() => LedgerEntryBloc(
      ledgerRepository: ledger,
      projectRepository: projects,
      authRepository: auth,
    );

    LedgerEntryState loaded(
      LedgerEntry entry, {
      ProjectRole role = ProjectRole.siteManager,
      String me = testManagerId,
      ProjectStatus status = ProjectStatus.active,
    }) => LedgerEntryState(
      projectId: 1,
      entryId: entry.id,
      entry: entry,
      overview: testOverview(role: role, project: testProject(status: status)),
      me: UuidValue.fromString(me),
      loadStatus: GenericStatus.success,
    );

    test('then the site manager confirms a release not confirmed yet', () {
      expect(loaded(testRelease()).canConfirm, isTrue);
      expect(
        loaded(testRelease(confirmedAt: DateTime.utc(2026, 10, 11))).canConfirm,
        isFalse,
      );
      expect(
        loaded(testRelease(), role: ProjectRole.owner, me: testOwnerId)
            .canConfirm,
        isFalse,
      );
      expect(loaded(testExpense()).canConfirm, isFalse);
      expect(
        loaded(testRelease(), status: ProjectStatus.completed).canConfirm,
        isFalse,
      );
    });

    test('then only its recorder reverses it, once, never a reversal', () {
      expect(loaded(testExpense()).canReverse, isTrue);
      expect(
        loaded(testExpense(), role: ProjectRole.owner, me: testOwnerId)
            .canReverse,
        isFalse,
      );
      expect(
        loaded(testRelease(reversedById: 9), me: testOwnerId).canReverse,
        isFalse,
      );
      expect(
        loaded(testRelease(reversesId: 3), me: testOwnerId).canReverse,
        isFalse,
      );
    });

    blocTest<LedgerEntryBloc, LedgerEntryState>(
      'when a reversal is asked then it is sent with the reason and the '
      'entry read again',
      setUp: () {
        when(
          () => ledger.reverse(1, 2, 'Typo'),
        ).thenAnswer((_) async => testExpense(id: 3));
        when(() => ledger.fetchEntry(1, 2)).thenAnswer((_) async => testExpense());
      },
      build: build,
      seed: () => loaded(testExpense()),
      act: (bloc) => bloc.add(const LedgerEntryEvent.reverseRequested('Typo')),
      verify: (bloc) {
        verify(() => ledger.reverse(1, 2, 'Typo')).called(1);
        expect(bloc.state.actionStatus, GenericStatus.success);
        expect(bloc.state.lastAction, LedgerEntryAction.reverse);
      },
    );
  });

  group('Given the release form', () {
    LedgerFormBloc build() => LedgerFormBloc(
      ledgerRepository: ledger,
      projectRepository: projects,
      stageRepository: stages,
    );

    blocTest<LedgerFormBloc, LedgerFormState>(
      'when it loads then the project and its stages come',
      setUp: () {
        when(() => projects.fetchProject(1)).thenAnswer(
          (_) async => testOverview(),
        );
        when(() => stages.fetchPlan(1)).thenAnswer(
          (_) async => testStagePlan(),
        );
      },
      build: build,
      act: (bloc) => bloc.add(const LedgerFormEvent.load(projectId: 1)),
      verify: (bloc) {
        expect(bloc.state.loadStatus, GenericStatus.success);
        expect(bloc.state.stages.map((s) => s.name), ['Foundation', 'Walls']);
      },
    );

    blocTest<LedgerFormBloc, LedgerFormState>(
      'when the server refuses then its message is shown',
      setUp: () => when(() => ledger.recordRelease(1, any())).thenThrow(
        const HttpException400(code: AppErrorCode.invalidLedgerEntry),
      ),
      build: build,
      seed: () => const LedgerFormState(
        projectId: 1,
        loadStatus: GenericStatus.success,
      ),
      act: (bloc) => bloc.add(
        LedgerFormEvent.saveRelease(
          ReleaseDraft(
            amountMinor: 1,
            occurredOn: DateTime.utc(2026, 10, 11),
            method: ReleaseMethod.cash,
          ),
        ),
      ),
      verify: (bloc) {
        expect(bloc.state.actionStatus, GenericStatus.failure);
        expect(
          bloc.state.actionErrorMessage,
          AppErrorCode.invalidLedgerEntry.message(
            LocalizationService.localization,
          ),
        );
      },
    );
  });
}
