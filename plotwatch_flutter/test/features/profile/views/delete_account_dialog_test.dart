import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

import '../../../helpers/helpers.dart';

class MockAccountDeletionBloc
    extends MockBloc<AccountDeletionEvent, AccountDeletionState>
    implements AccountDeletionBloc {}

// Plan: doc/04g-m8-hardening.md, step 6 (account deletion).
void main() {
  late AppLocalizations l10n;
  late MockAccountDeletionBloc bloc;

  setUpAll(() {
    l10n = setUpTestLocalization();
    registerFallbackValue(const AccountDeletionEvent.reset());
  });
  setUp(() => bloc = MockAccountDeletionBloc());

  Future<void> pump(WidgetTester tester, AccountDeletionState state) {
    when(() => bloc.state).thenReturn(state);
    return tester.pumpApp(
      BlocProvider<AccountDeletionBloc>.value(
        value: bloc,
        child: const DeleteAccountDialog(email: 'ada@example.com'),
      ),
    );
  }

  testWidgets('Given shared projects then they are listed and nothing can '
      'be deleted', (tester) async {
    await pump(
      tester,
      const AccountDeletionState(
        checkStatus: GenericStatus.success,
        blockers: ['Maison Douala'],
      ),
    );

    expect(find.text(l10n.deleteAccountBlockedTitle), findsOneWidget);
    expect(find.text('• Maison Douala'), findsOneWidget);
    expect(find.byKey(DeleteAccountDialog.confirmButtonKey), findsNothing);
  });

  testWidgets('Given nothing blocks when the email is typed then the '
      'account can be deleted', (tester) async {
    await pump(
      tester,
      const AccountDeletionState(checkStatus: GenericStatus.success),
    );
    FilledButton confirm() => tester.widget<FilledButton>(
      find.byKey(DeleteAccountDialog.confirmButtonKey),
    );

    expect(find.text(l10n.deleteAccountExplain), findsOneWidget);
    expect(confirm().onPressed, isNull);

    await tester.enterText(
      find.byKey(DeleteAccountDialog.emailFieldKey),
      ' Ada@Example.com ',
    );
    await tester.pump();
    await tester.tap(find.byKey(DeleteAccountDialog.confirmButtonKey));

    verify(
      () => bloc.add(const AccountDeletionEvent.deleteRequested()),
    ).called(1);
  });

  testWidgets('Given another email is typed then deletion stays disabled', (
    tester,
  ) async {
    await pump(
      tester,
      const AccountDeletionState(checkStatus: GenericStatus.success),
    );

    await tester.enterText(
      find.byKey(DeleteAccountDialog.emailFieldKey),
      'bob@example.com',
    );
    await tester.pump();

    expect(
      tester
          .widget<FilledButton>(find.byKey(DeleteAccountDialog.confirmButtonKey))
          .onPressed,
      isNull,
    );
  });
}
