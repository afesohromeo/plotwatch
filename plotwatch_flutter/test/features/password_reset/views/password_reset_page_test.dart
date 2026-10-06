import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

import '../../../helpers/helpers.dart';

class MockPasswordResetBloc
    extends MockBloc<PasswordResetEvent, PasswordResetState>
    implements PasswordResetBloc {}

void main() {
  late AppLocalizations l10n;
  late MockPasswordResetBloc bloc;

  setUpAll(() {
    l10n = setUpTestLocalization();
    registerFallbackValue(const PasswordResetEvent.reset());
  });

  setUp(() {
    bloc = MockPasswordResetBloc();
    when(() => bloc.state).thenReturn(const PasswordResetState(
      step: PasswordResetStep.newPassword,
      email: 'ada@example.com',
    ));
  });

  Future<void> pumpPage(WidgetTester tester) => tester.pumpApp(
        BlocProvider<PasswordResetBloc>.value(
          value: bloc,
          child: const PasswordResetPage(),
        ),
      );

  group('Given the new-password step', () {
    testWidgets('when the bloc shows the confirmation then only it is readable',
        (tester) async {
      when(() => bloc.state).thenReturn(const PasswordResetState(
        step: PasswordResetStep.newPassword,
        isConfirmPasswordVisible: true,
      ));
      await pumpPage(tester);

      expect(isObscured(tester, PasswordResetPage.passwordFieldKey), isTrue);
      expect(isObscured(tester, PasswordResetPage.confirmPasswordFieldKey),
          isFalse);
    });

    testWidgets('when each eye button is tapped then it toggles its own field',
        (tester) async {
      await pumpPage(tester);

      await tester
          .tap(find.byKey(PasswordResetPage.passwordVisibilityButtonKey));
      await tester.tap(
          find.byKey(PasswordResetPage.confirmPasswordVisibilityButtonKey));
      await tester.pump();

      verify(() =>
              bloc.add(const PasswordResetEvent.passwordVisibilityToggled()))
          .called(1);
      verify(() => bloc.add(
          const PasswordResetEvent.confirmPasswordVisibilityToggled())).called(1);
    });

    testWidgets('when shown then it asks for the new password twice',
        (tester) async {
      await pumpPage(tester);

      expect(find.byKey(PasswordResetPage.passwordFieldKey), findsOneWidget);
      expect(find.byKey(PasswordResetPage.confirmPasswordFieldKey),
          findsOneWidget);
    });

    testWidgets(
        'when the two passwords differ then it says so and sends nothing',
        (tester) async {
      await pumpPage(tester);

      await tester.enterText(
          find.byKey(PasswordResetPage.passwordFieldKey), 'newSecret1');
      await tester.enterText(
          find.byKey(PasswordResetPage.confirmPasswordFieldKey), 'newSecret2');
      await tester.tap(find.byKey(PasswordResetPage.submitButtonKey));
      await tester.pump();

      expect(find.text(l10n.validatePasswordMismatch), findsOneWidget);
      verifyNever(() => bloc.add(any()));
    });

    testWidgets('when the two passwords match then it sets the new password',
        (tester) async {
      await pumpPage(tester);

      await tester.enterText(
          find.byKey(PasswordResetPage.passwordFieldKey), 'newSecret1');
      await tester.enterText(
          find.byKey(PasswordResetPage.confirmPasswordFieldKey), 'newSecret1');
      await tester.tap(find.byKey(PasswordResetPage.submitButtonKey));
      await tester.pump();

      verify(() => bloc.add(const PasswordResetEvent.newPasswordSubmitted(
            password: 'newSecret1',
          ))).called(1);
    });
  });

  group('Given the browser or phone password manager', () {
    testWidgets('when the email step is shown then the email is marked for '
        'autofill', (tester) async {
      when(() => bloc.state).thenReturn(const PasswordResetState());
      await pumpPage(tester);

      expect(autofillHintsOf(tester, PasswordResetPage.emailFieldKey),
          containsAll([AutofillHints.email, AutofillHints.username]));
    });

    testWidgets(
        'when the new-password step is shown then both fields ask for a new '
        'password and the account email is shown read-only', (tester) async {
      await pumpPage(tester);

      expect(autofillHintsOf(tester, PasswordResetPage.passwordFieldKey),
          [AutofillHints.newPassword]);
      expect(autofillHintsOf(tester, PasswordResetPage.confirmPasswordFieldKey),
          [AutofillHints.newPassword]);
      // The password manager updates the password saved under this email.
      expect(fieldText(tester, PasswordResetPage.accountEmailFieldKey),
          'ada@example.com');
      expect(isReadOnly(tester, PasswordResetPage.accountEmailFieldKey), isTrue);
      expect(autofillHintsOf(tester, PasswordResetPage.accountEmailFieldKey),
          [AutofillHints.username]);
    });

    testWidgets(
        'when the new password is set then it is asked to save the login',
        (tester) async {
      const atNewPassword = PasswordResetState(
        step: PasswordResetStep.newPassword,
        email: 'ada@example.com',
      );
      whenListen(
        bloc,
        Stream.fromIterable([
          atNewPassword.copyWith(passwordResetStatus: GenericStatus.loading),
          atNewPassword.copyWith(passwordResetStatus: GenericStatus.success),
        ]),
        initialState: atNewPassword,
      );
      await pumpPage(tester);
      await tester.pump();

      expect(autofillContextsFinished(tester), [true]);
    });

    testWidgets(
        'when an earlier step succeeds then nothing is offered for saving yet',
        (tester) async {
      whenListen(
        bloc,
        Stream.fromIterable(const [
          PasswordResetState(passwordResetStatus: GenericStatus.loading),
          PasswordResetState(
            passwordResetStatus: GenericStatus.success,
            step: PasswordResetStep.verifyCode,
            email: 'ada@example.com',
          ),
        ]),
        initialState: const PasswordResetState(),
      );
      await pumpPage(tester);
      await tester.pump();

      expect(autofillContextsFinished(tester), isEmpty);
    });

    testWidgets(
        'when the page is left before the password is set then nothing is '
        'offered for saving', (tester) async {
      await pumpPage(tester);

      await tester.pumpWidget(const SizedBox());

      expect(autofillContextsFinished(tester), [false]);
    });
  });
}
