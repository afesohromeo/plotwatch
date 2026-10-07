import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

import '../../../helpers/helpers.dart';

class MockSignUpBloc extends MockBloc<SignUpEvent, SignUpState>
    implements SignUpBloc {}

void main() {
  late AppLocalizations l10n;
  late MockSignUpBloc bloc;

  setUpAll(() {
    l10n = setUpTestLocalization();
    registerFallbackValue(const SignUpEvent.reset());
  });
  setUp(() => bloc = MockSignUpBloc());

  Future<void> pumpAt(WidgetTester tester, SignUpStep step) {
    when(
      () => bloc.state,
    ).thenReturn(SignUpState(step: step, email: 'ada@example.com'));
    return tester.pumpApp(
      BlocProvider<SignUpBloc>.value(value: bloc, child: const SignUpPage()),
    );
  }

  final expectedField = {
    SignUpStep.details: SignUpPage.emailFieldKey,
    SignUpStep.verifyCode: SignUpPage.codeFieldKey,
    SignUpStep.password: SignUpPage.passwordFieldKey,
  };

  for (final MapEntry(key: step, value: fieldKey) in expectedField.entries) {
    testWidgets(
      'Given the sign-up page when the bloc is at the ${step.name} step then '
      'only that step\'s field is shown',
      (tester) async {
        await pumpAt(tester, step);

        expect(find.byKey(fieldKey), findsOneWidget);
        for (final other in expectedField.values.where((k) => k != fieldKey)) {
          expect(find.byKey(other), findsNothing);
        }
      },
    );
  }

  group('Given the password step', () {
    testWidgets('when the bloc shows only the password then only that field is '
        'readable', (tester) async {
      when(() => bloc.state).thenReturn(
        const SignUpState(step: SignUpStep.password, isPasswordVisible: true),
      );
      await tester.pumpApp(
        BlocProvider<SignUpBloc>.value(value: bloc, child: const SignUpPage()),
      );

      expect(isObscured(tester, SignUpPage.passwordFieldKey), isFalse);
      expect(isObscured(tester, SignUpPage.confirmPasswordFieldKey), isTrue);
    });

    testWidgets(
      'when each eye button is tapped then it toggles its own field',
      (tester) async {
        await pumpAt(tester, SignUpStep.password);

        await tester.tap(find.byKey(SignUpPage.passwordVisibilityButtonKey));
        await tester.tap(
          find.byKey(SignUpPage.confirmPasswordVisibilityButtonKey),
        );
        await tester.pump();

        verify(
          () => bloc.add(const SignUpEvent.passwordVisibilityToggled()),
        ).called(1);
        verify(
          () => bloc.add(const SignUpEvent.confirmPasswordVisibilityToggled()),
        ).called(1);
      },
    );

    testWidgets('when shown then it asks for the password twice', (
      tester,
    ) async {
      await pumpAt(tester, SignUpStep.password);

      expect(find.byKey(SignUpPage.passwordFieldKey), findsOneWidget);
      expect(find.byKey(SignUpPage.confirmPasswordFieldKey), findsOneWidget);
    });

    testWidgets(
      'when the two passwords differ then it says so and sends nothing',
      (tester) async {
        await pumpAt(tester, SignUpStep.password);

        await tester.enterText(
          find.byKey(SignUpPage.passwordFieldKey),
          'secret123',
        );
        await tester.enterText(
          find.byKey(SignUpPage.confirmPasswordFieldKey),
          'secret124',
        );
        await tester.tap(find.byKey(SignUpPage.submitButtonKey));
        await tester.pump();

        expect(find.text(l10n.validatePasswordMismatch), findsOneWidget);
        verifyNever(() => bloc.add(any()));
      },
    );

    testWidgets('when the two passwords match then it creates the account', (
      tester,
    ) async {
      await pumpAt(tester, SignUpStep.password);

      await tester.enterText(
        find.byKey(SignUpPage.passwordFieldKey),
        'secret123',
      );
      await tester.enterText(
        find.byKey(SignUpPage.confirmPasswordFieldKey),
        'secret123',
      );
      await tester.tap(find.byKey(SignUpPage.submitButtonKey));
      await tester.pump();

      verify(
        () => bloc.add(
          const SignUpEvent.passwordSubmitted(
            password: 'secret123',
            locale: 'en',
          ),
        ),
      ).called(1);
    });
  });

  group('Given the browser or phone password manager', () {
    testWidgets(
      'when the details step is shown then the name and email are marked '
      'for autofill',
      (tester) async {
        await pumpAt(tester, SignUpStep.details);

        expect(autofillHintsOf(tester, SignUpPage.nameFieldKey), [
          AutofillHints.name,
        ]);
        expect(
          autofillHintsOf(tester, SignUpPage.emailFieldKey),
          containsAll([AutofillHints.email, AutofillHints.username]),
        );
      },
    );

    testWidgets(
      'when the password step is shown then both fields ask for a new '
      'password and the account email is shown read-only',
      (tester) async {
        await pumpAt(tester, SignUpStep.password);

        expect(autofillHintsOf(tester, SignUpPage.passwordFieldKey), [
          AutofillHints.newPassword,
        ]);
        expect(autofillHintsOf(tester, SignUpPage.confirmPasswordFieldKey), [
          AutofillHints.newPassword,
        ]);
        // The password manager saves the new password under this email.
        expect(
          fieldText(tester, SignUpPage.accountEmailFieldKey),
          'ada@example.com',
        );
        expect(isReadOnly(tester, SignUpPage.accountEmailFieldKey), isTrue);
        expect(autofillHintsOf(tester, SignUpPage.accountEmailFieldKey), [
          AutofillHints.username,
        ]);
      },
    );

    testWidgets(
      'when the account is created then it is asked to save the login',
      (tester) async {
        const atPassword = SignUpState(
          step: SignUpStep.password,
          email: 'ada@example.com',
        );
        whenListen(
          bloc,
          Stream.fromIterable([
            atPassword.copyWith(signUpStatus: GenericStatus.loading),
            atPassword.copyWith(signUpStatus: GenericStatus.success),
          ]),
          initialState: atPassword,
        );
        await tester.pumpApp(
          BlocProvider<SignUpBloc>.value(
            value: bloc,
            child: const SignUpPage(),
          ),
        );
        await tester.pump();

        expect(autofillContextsFinished(tester), [true]);
      },
    );

    testWidgets(
      'when an earlier step succeeds then nothing is offered for saving yet',
      (tester) async {
        whenListen(
          bloc,
          Stream.fromIterable(const [
            SignUpState(signUpStatus: GenericStatus.loading),
            SignUpState(
              signUpStatus: GenericStatus.success,
              step: SignUpStep.verifyCode,
              email: 'ada@example.com',
            ),
          ]),
          initialState: const SignUpState(),
        );
        await tester.pumpApp(
          BlocProvider<SignUpBloc>.value(
            value: bloc,
            child: const SignUpPage(),
          ),
        );
        await tester.pump();

        expect(autofillContextsFinished(tester), isEmpty);
      },
    );

    testWidgets(
      'when the page is left before the account is created then nothing is '
      'offered for saving',
      (tester) async {
        await pumpAt(tester, SignUpStep.password);

        await tester.pumpWidget(const SizedBox());

        expect(autofillContextsFinished(tester), [false]);
      },
    );
  });
}
