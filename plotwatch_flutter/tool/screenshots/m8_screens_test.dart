// The screens added in M6 to M8, for the design and French checks
// (doc/04g steps 5 and 8). See harness.dart.
import 'dart:typed_data';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

import '../../test/helpers/helpers.dart';
import 'harness.dart';

class MockLedgerEntryBloc extends MockBloc<LedgerEntryEvent, LedgerEntryState>
    implements LedgerEntryBloc {}

class MockLedgerFormBloc extends MockBloc<LedgerFormEvent, LedgerFormState>
    implements LedgerFormBloc {}

class MockSignInBloc extends MockBloc<SignInEvent, SignInState>
    implements SignInBloc {}

class MockSignUpBloc extends MockBloc<SignUpEvent, SignUpState>
    implements SignUpBloc {}

class MockAccountDeletionBloc
    extends MockBloc<AccountDeletionEvent, AccountDeletionState>
    implements AccountDeletionBloc {}

void main() {
  setUpAll(() async {
    setUpTestLocalization(const Locale(shotLocale));
    await loadFonts();
  });

  MockProjectOverviewBloc shell({ProjectRole role = ProjectRole.owner}) {
    final bloc = MockProjectOverviewBloc();
    when(() => bloc.state).thenReturn(
      ProjectOverviewState(
        overviewStatus: GenericStatus.success,
        overview: overview().copyWith(myRole: role),
        members: members,
      ),
    );
    return bloc;
  }

  // --- Money tab, inside the shell.
  Widget moneyPage() => MultiBlocProvider(
    providers: [
      ...signedIn(),
      BlocProvider<ProjectOverviewBloc>.value(value: shell()),
      BlocProvider<MoneyBloc>.value(value: moneyBloc()),
    ],
    child: const ProjectShell(
      projectId: 1,
      location: '/projects/1/money',
      child: MoneyPage(projectId: 1),
    ),
  );

  for (final (name, size) in [('phone', phone), ('desktop', desktop)]) {
    testWidgets('money $name', (tester) async {
      await shot(tester, 'money_$name', size, moneyPage());
    });
  }

  // --- The release and expense forms.
  MockLedgerFormBloc formBloc(ProjectRole role) {
    final bloc = MockLedgerFormBloc();
    when(() => bloc.state).thenReturn(
      LedgerFormState(
        projectId: 1,
        overview: overview().copyWith(myRole: role),
        stages: [
          testStage(id: 3, name: 'Walls', status: StageStatus.submitted),
          testStage(id: 4, name: 'Roof'),
        ],
        loadStatus: GenericStatus.success,
      ),
    );
    return bloc;
  }

  testWidgets('release form phone', (tester) async {
    await shot(
      tester,
      'release_form_phone',
      const Size(390, 1100),
      MultiBlocProvider(
        providers: [
          ...signedIn(),
          BlocProvider<ProjectOverviewBloc>.value(value: shell()),
          BlocProvider<LedgerFormBloc>.value(
            value: formBloc(ProjectRole.owner),
          ),
        ],
        child: const ReleaseFormPage(projectId: 1, initialStageId: 4),
      ),
    );
  });

  testWidgets('expense form phone', (tester) async {
    await shot(
      tester,
      'expense_form_phone',
      const Size(390, 1300),
      MultiBlocProvider(
        providers: [
          ...signedIn(),
          BlocProvider<ProjectOverviewBloc>.value(
            value: shell(role: ProjectRole.siteManager),
          ),
          BlocProvider<LedgerFormBloc>.value(
            value: formBloc(ProjectRole.siteManager),
          ),
        ],
        child: ExpenseFormPage(projectId: 1, takeReceipt: (_) async => null),
      ),
    );
  });

  // --- A release waiting for the site manager.
  testWidgets('ledger entry phone', (tester) async {
    final bloc = MockLedgerEntryBloc();
    when(() => bloc.state).thenReturn(
      LedgerEntryState(
        projectId: 1,
        entryId: 1,
        entry: testRelease(),
        overview: overview().copyWith(myRole: ProjectRole.siteManager),
        me: UuidValue.fromString(testManagerId),
        receipt: Uint8List(0),
        loadStatus: GenericStatus.success,
      ),
    );
    await shot(
      tester,
      'ledger_entry_phone',
      phone,
      MultiBlocProvider(
        providers: [
          ...signedIn(),
          BlocProvider<ProjectOverviewBloc>.value(
            value: shell(role: ProjectRole.siteManager),
          ),
          BlocProvider<LedgerEntryBloc>.value(value: bloc),
        ],
        child: const LedgerEntryPage(projectId: 1, entryId: 1),
      ),
    );
  });

  // --- A new user's project list (doc/04g step 2).
  testWidgets('first run phone', (tester) async {
    final bloc = MockProjectListBloc();
    whenListen(
      bloc,
      Stream.value(
        const ProjectListState(
          projectsListStatus: GenericStatus.success,
          maxProjects: true,
        ),
      ),
      initialState: const ProjectListState(),
    );
    await shot(
      tester,
      'first_run_phone',
      phone,
      MultiBlocProvider(
        providers: [
          ...signedIn(unread: 0),
          BlocProvider<ProjectListBloc>.value(value: bloc),
          BlocProvider<EvidenceMediaBloc>.value(value: mediaFor([])),
        ],
        child: const ProjectListPage(),
      ),
    );
  });

  // --- Sign-in with Google, and sign-up's code step (doc/04g step 4).
  MockGoogleSignInBloc google() {
    final bloc = MockGoogleSignInBloc();
    when(
      () => bloc.state,
    ).thenReturn(const GoogleSignInState(isAvailable: true));
    return bloc;
  }

  for (final (name, size) in [('phone', phone), ('desktop', desktop)]) {
    testWidgets('sign in $name', (tester) async {
      final bloc = MockSignInBloc();
      when(() => bloc.state).thenReturn(const SignInState());
      await shot(
        tester,
        'sign_in_$name',
        size,
        MultiBlocProvider(
          providers: [
            BlocProvider<SignInBloc>.value(value: bloc),
            BlocProvider<GoogleSignInBloc>.value(value: google()),
          ],
          child: const SignInPage(),
        ),
      );
    });
  }

  testWidgets('sign up code phone', (tester) async {
    final bloc = MockSignUpBloc();
    when(() => bloc.state).thenReturn(
      const SignUpState(
        step: SignUpStep.verifyCode,
        email: 'ada.lovelace@example.com',
      ),
    );
    await shot(
      tester,
      'sign_up_code_phone',
      phone,
      MultiBlocProvider(
        providers: [
          BlocProvider<SignUpBloc>.value(value: bloc),
          BlocProvider<GoogleSignInBloc>.value(value: google()),
        ],
        child: const SignUpPage(),
      ),
    );
  });

  // --- Delete account, on a wide screen (doc/04g step 6).
  for (final (name, state) in [
    (
      'confirm',
      const AccountDeletionState(checkStatus: GenericStatus.success),
    ),
    (
      'blocked',
      const AccountDeletionState(
        checkStatus: GenericStatus.success,
        blockers: ['Maison Douala', 'Duplex Bafoussam'],
      ),
    ),
  ]) {
    testWidgets('delete account $name desktop', (tester) async {
      final bloc = MockAccountDeletionBloc();
      when(() => bloc.state).thenReturn(state);
      await shot(
        tester,
        'delete_account_${name}_desktop',
        desktop,
        Scaffold(
          body: BlocProvider<AccountDeletionBloc>.value(
            value: bloc,
            child: const Center(
              child: DeleteAccountDialog(email: 'ada.lovelace@example.com'),
            ),
          ),
        ),
      );
    });
  }
}
