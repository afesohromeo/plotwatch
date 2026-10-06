import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

import '../../../helpers/helpers.dart';

class MockSignInBloc extends MockBloc<SignInEvent, SignInState>
    implements SignInBloc {}

void main() {
  late AppLocalizations l10n;
  late MockSignInBloc bloc;

  setUpAll(() {
    l10n = setUpTestLocalization();
    registerFallbackValue(const SignInEvent.reset());
  });

  setUp(() {
    bloc = MockSignInBloc();
    when(() => bloc.state).thenReturn(const SignInState());
  });

  Future<void> pumpPage(WidgetTester tester) => tester.pumpApp(
        BlocProvider<SignInBloc>.value(value: bloc, child: const SignInPage()),
      );

  testWidgets(
      'Given the sign-in page when submitted empty then it shows the field '
      'messages and sends nothing', (tester) async {
    await pumpPage(tester);

    await tester.tap(find.byKey(SignInPage.submitButtonKey));
    await tester.pump();

    expect(find.text(l10n.validateEmailRequired), findsOneWidget);
    expect(find.text(l10n.validatePasswordRequired), findsOneWidget);
    verifyNever(() => bloc.add(any()));
  });

  testWidgets(
      'Given the sign-in page when valid credentials are submitted then it '
      'sends them to the bloc', (tester) async {
    await pumpPage(tester);

    await tester.enterText(
        find.byKey(SignInPage.emailFieldKey), 'ada@example.com');
    await tester.enterText(
        find.byKey(SignInPage.passwordFieldKey), 'secret123');
    await tester.tap(find.byKey(SignInPage.submitButtonKey));
    await tester.pump();

    verify(() => bloc.add(const SignInEvent.signInSubmitted(
          email: 'ada@example.com',
          password: 'secret123',
        ))).called(1);
  });

  group('Given the password field', () {
    testWidgets('when the bloc hides the password then the text is hidden',
        (tester) async {
      await pumpPage(tester);

      expect(isObscured(tester, SignInPage.passwordFieldKey), isTrue);
    });

    testWidgets('when the bloc shows the password then the text is visible',
        (tester) async {
      when(() => bloc.state)
          .thenReturn(const SignInState(isPasswordVisible: true));
      await pumpPage(tester);

      expect(isObscured(tester, SignInPage.passwordFieldKey), isFalse);
    });

    testWidgets('when the eye button is tapped then it asks the bloc to toggle',
        (tester) async {
      await pumpPage(tester);

      await tester.tap(find.byKey(SignInPage.passwordVisibilityButtonKey));
      await tester.pump();

      verify(() => bloc.add(const SignInEvent.passwordVisibilityToggled()))
          .called(1);
    });
  });
}
