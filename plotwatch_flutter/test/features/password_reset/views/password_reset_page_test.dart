import 'package:bloc_test/bloc_test.dart';
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
}
