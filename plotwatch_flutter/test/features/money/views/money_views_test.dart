import 'dart:convert';
import 'dart:typed_data';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

import '../../../helpers/helpers.dart';

class MockProjectOverviewBloc
    extends MockBloc<ProjectOverviewEvent, ProjectOverviewState>
    implements ProjectOverviewBloc {}

class MockLedgerEntryBloc extends MockBloc<LedgerEntryEvent, LedgerEntryState>
    implements LedgerEntryBloc {}

class MockLedgerFormBloc extends MockBloc<LedgerFormEvent, LedgerFormState>
    implements LedgerFormBloc {}

// Plan: doc/04f-m6-ledger.md, groups D and E (canvas M-Money, M-Entry,
// M-Expense).
void main() {
  late AppLocalizations l10n;
  late MockProjectOverviewBloc shell;

  setUpAll(() {
    l10n = setUpTestLocalization();
    registerFallbackValue(const MoneyEvent.refreshEntries());
    registerFallbackValue(const LedgerEntryEvent.resetFlowStep());
    registerFallbackValue(const LedgerFormEvent.resetFlowStep());
  });

  setUp(() => shell = MockProjectOverviewBloc());

  void inProject({
    ProjectRole role = ProjectRole.owner,
    bool canApprove = false,
    ProjectStatus status = ProjectStatus.active,
  }) => when(() => shell.state).thenReturn(
    ProjectOverviewState(
      overview: testOverview(
        role: role,
        canApprove: canApprove,
        project: testProject(status: status),
        stages: [
          StageBrief(id: 1, name: 'Foundation', status: StageStatus.approved),
          StageBrief(id: 2, name: 'Walls', status: StageStatus.inProgress),
        ],
      ),
    ),
  );

  group('Given the Money tab', () {
    late MockMoneyBloc bloc;

    setUp(() => bloc = MockMoneyBloc());

    Future<void> pumpMoney(
      WidgetTester tester, {
      LedgerSummary? summary,
      List<LedgerEntry> entries = const [],
    }) async {
      final state = MoneyState(
        projectId: 1,
        summary: summary ?? testLedgerSummary(),
        summaryStatus: GenericStatus.success,
        entries: entries,
        paginatedEntries: entries,
        maxEntries: true,
        entriesListStatus: GenericStatus.success,
      );
      whenListen(
        bloc,
        Stream.value(state),
        initialState: state.copyWith(entriesListStatus: GenericStatus.initial),
      );
      await tester.pumpApp(
        MultiBlocProvider(
          providers: [
            BlocProvider<ProjectOverviewBloc>.value(value: shell),
            BlocProvider<MoneyBloc>.value(value: bloc),
          ],
          child: const MoneyPage(projectId: 1),
        ),
      );
      await tester.pumpAndSettle();
    }

    testWidgets('then it loads the summary', (tester) async {
      inProject();
      await pumpMoney(tester);

      verify(() => bloc.add(const MoneyEvent.load(projectId: 1))).called(1);
    });

    testWidgets('then AC-5 reads: released, spent, with a receipt, and the '
        'unaccounted alert', (tester) async {
      inProject();
      await pumpMoney(tester);

      expect(find.text(formatMoney(500000, 'XAF')), findsOneWidget);
      expect(find.text(formatMoneyInput(350000, 'XAF')), findsOneWidget);
      expect(find.text(formatMoneyInput(300000, 'XAF')), findsOneWidget);
      expect(find.byKey(MoneyPage.alertKey), findsOneWidget);
      expect(
        find.text(l10n.moneyUnaccountedAmount(formatMoney(200000, 'XAF'))),
        findsOneWidget,
      );
    });

    testWidgets('then without much unaccounted there is no alert', (
      tester,
    ) async {
      inProject();
      await pumpMoney(tester, summary: testLedgerSummary(alert: false));

      expect(find.byKey(MoneyPage.alertKey), findsNothing);
    });

    testWidgets('then the entries show with their tags', (tester) async {
      inProject();
      await pumpMoney(
        tester,
        entries: [testExpense(), testRelease(), testExpense(id: 3, receipt: false)],
      );

      expect(find.byKey(LedgerEntryTile.keyFor(2)), findsOneWidget);
      expect(find.text(l10n.tagReceipt), findsOneWidget);
      expect(find.text(l10n.tagNotConfirmed), findsOneWidget);
      expect(find.text(l10n.tagNoReceipt), findsOneWidget);
    });

    for (final (who, role, canApprove, label) in [
      ('owner', ProjectRole.owner, false, 'release'),
      ('co-funder allowed to approve', ProjectRole.coFunder, true, 'release'),
      ('site manager', ProjectRole.siteManager, false, 'expense'),
    ]) {
      testWidgets('then the $who records a $label', (tester) async {
        inProject(role: role, canApprove: canApprove);
        await pumpMoney(tester);

        expect(
          find.text(
            label == 'release'
                ? l10n.recordReleaseAction
                : l10n.recordExpenseAction,
          ),
          findsOneWidget,
        );
      });
    }

    testWidgets('then a viewer or a closed project records nothing', (
      tester,
    ) async {
      inProject(role: ProjectRole.viewer);
      await pumpMoney(tester);
      expect(find.byKey(MoneyPage.recordButtonKey), findsNothing);

      inProject(status: ProjectStatus.completed);
      await pumpMoney(tester);
      expect(find.byKey(MoneyPage.recordButtonKey), findsNothing);
    });
  });

  group('Given an entry page', () {
    late MockLedgerEntryBloc bloc;

    setUp(() => bloc = MockLedgerEntryBloc());

    Future<void> pumpEntry(WidgetTester tester, LedgerEntryState state) async {
      when(() => bloc.state).thenReturn(state);
      await tester.pumpApp(
        MultiBlocProvider(
          providers: [
            BlocProvider<ProjectOverviewBloc>.value(value: shell),
            BlocProvider<LedgerEntryBloc>.value(value: bloc),
          ],
          child: const LedgerEntryPage(projectId: 1, entryId: 1),
        ),
      );
    }

    LedgerEntryState loaded(
      LedgerEntry entry, {
      ProjectRole role = ProjectRole.siteManager,
      String me = testManagerId,
    }) => LedgerEntryState(
      projectId: 1,
      entryId: entry.id,
      entry: entry,
      overview: testOverview(role: role),
      me: UuidValue.fromString(me),
      receipt: Uint8List(0),
      loadStatus: GenericStatus.success,
    );

    testWidgets('when the site manager opens a release then they can '
        'confirm it', (tester) async {
      inProject(role: ProjectRole.siteManager);
      await pumpEntry(tester, loaded(testRelease()));

      await tester.tap(find.byKey(LedgerEntryPage.confirmButtonKey));
      verify(
        () => bloc.add(const LedgerEntryEvent.confirmRequested()),
      ).called(1);
    });

    testWidgets('when its recorder reverses it then a reason is required', (
      tester,
    ) async {
      inProject(role: ProjectRole.siteManager);
      await pumpEntry(tester, loaded(testExpense(receipt: false)));

      await tester.tap(find.byKey(LedgerEntryPage.reverseButtonKey));
      await tester.pumpAndSettle();
      await tester.tap(find.text(l10n.confirm));
      await tester.pump();
      expect(find.text(l10n.reverseReasonRequired), findsOneWidget);

      await tester.enterText(
        find.byKey(LedgerEntryPage.reasonFieldKey),
        'Typo',
      );
      await tester.tap(find.text(l10n.confirm));
      await tester.pumpAndSettle();
      verify(
        () => bloc.add(const LedgerEntryEvent.reverseRequested('Typo')),
      ).called(1);
    });

    testWidgets('when someone else opens it then they can only read it', (
      tester,
    ) async {
      inProject(role: ProjectRole.viewer);
      await pumpEntry(
        tester,
        loaded(
          testExpense(receipt: false),
          role: ProjectRole.viewer,
          me: testOwnerId,
        ),
      );

      expect(find.byKey(LedgerEntryPage.reverseButtonKey), findsNothing);
      expect(find.byKey(LedgerEntryPage.confirmButtonKey), findsNothing);
      expect(find.text(l10n.entryNeverEdited), findsOneWidget);
    });

    testWidgets('when it was reversed then the reason shows', (tester) async {
      inProject();
      await pumpEntry(
        tester,
        loaded(
          testExpense(receipt: false).copyWith(
            reversedById: 9,
            reversalReason: 'Typo',
          ),
        ),
      );

      expect(find.text(l10n.reversedBanner('Typo')), findsOneWidget);
      expect(find.byKey(LedgerEntryPage.reverseButtonKey), findsNothing);
    });
  });

  group('Given the expense form', () {
    late MockLedgerFormBloc bloc;

    setUp(() {
      bloc = MockLedgerFormBloc();
      inProject(role: ProjectRole.siteManager);
      when(() => bloc.state).thenReturn(
        LedgerFormState(
          projectId: 1,
          overview: testOverview(role: ProjectRole.siteManager),
          stages: [testStage(id: 2, name: 'Walls', status: StageStatus.inProgress)],
          loadStatus: GenericStatus.success,
        ),
      );
    });

    Future<void> pumpForm(
      WidgetTester tester, {
      bool isWeb = false,
      Uint8List? photo,
    }) async {
      tester.view.physicalSize = const Size(400, 1400);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      await tester.pumpApp(
        MultiBlocProvider(
          providers: [
            BlocProvider<ProjectOverviewBloc>.value(value: shell),
            BlocProvider<LedgerFormBloc>.value(value: bloc),
          ],
          child: ExpenseFormPage(
            projectId: 1,
            isWeb: isWeb,
            takeReceipt: (_) async => photo,
          ),
        ),
      );
    }

    Future<void> save(WidgetTester tester) async {
      await tester.tap(find.byKey(ExpenseFormPage.saveButtonKey));
      await tester.pump();
    }

    testWidgets('when nothing is filled then the amount and description are '
        'asked for', (tester) async {
      await pumpForm(tester);

      await save(tester);

      expect(find.text(l10n.validateAmountRequired), findsOneWidget);
      expect(find.text(l10n.validateDescriptionRequired), findsOneWidget);
      // Only the load was sent: nothing is saved.
      expect(verify(() => bloc.add(captureAny())).captured, [
        const LedgerFormEvent.load(projectId: 1),
      ]);
    });

    testWidgets('when it is filled with a receipt then the expense is sent '
        'with the photo, for the stage being worked on', (tester) async {
      // A real 1 × 1 PNG, so the preview can decode it.
      final photo = base64Decode(
        'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mP8z8BQDwAEhQGAhKmMIQAAAABJRU5ErkJggg==',
      );
      await pumpForm(tester, photo: photo);

      await tester.enterText(
        find.descendant(
          of: find.byKey(LedgerAmountSection.amountFieldKey),
          matching: find.byType(EditableText),
        ),
        '300000',
      );
      await tester.enterText(
        find.descendant(
          of: find.byKey(ExpenseFormPage.descriptionFieldKey),
          matching: find.byType(EditableText),
        ),
        '20 bags of cement',
      );
      await tester.tap(find.byKey(ExpenseFormPage.takeReceiptKey));
      await tester.pumpAndSettle();
      expect(find.text(l10n.receiptHint), findsOneWidget);
      await save(tester);

      final event =
          verify(() => bloc.add(captureAny())).captured.last as LedgerFormEvent;
      final save_ = event as dynamic;
      expect(save_.receipt, photo);
      final draft = save_.draft as ExpenseDraft;
      expect(draft.amountMinor, 300000);
      expect(draft.description, '20 bags of cement');
      expect(draft.category, ExpenseCategory.materials);
      expect(draft.stageId, 2);
    });

    testWidgets('when on the web then receipts are for the phone', (
      tester,
    ) async {
      await pumpForm(tester, isWeb: true);

      expect(find.byKey(ExpenseFormPage.takeReceiptKey), findsNothing);
      expect(find.text(l10n.receiptPhoneOnly), findsOneWidget);
    });
  });
}
