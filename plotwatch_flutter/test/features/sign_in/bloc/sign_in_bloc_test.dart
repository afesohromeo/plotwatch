import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

import '../../../helpers/helpers.dart';

void main() {
  late AppLocalizations l10n;
  late MockAuthRepository repository;

  setUpAll(() => l10n = setUpTestLocalization());
  setUp(() => repository = MockAuthRepository());

  void signInThrows(Object error) => when(() => repository.signIn(
        email: any(named: 'email'),
        password: any(named: 'password'),
      )).thenThrow(error);

  SignInBloc build() => SignInBloc(authRepository: repository);
  const submit = SignInEvent.signInSubmitted(
      email: ' ada@example.com ', password: 'secret123');

  group('Given the sign-in bloc', () {
    blocTest<SignInBloc, SignInState>(
      'when the credentials are right then it signs in with the trimmed email',
      setUp: () => when(() => repository.signIn(
            email: any(named: 'email'),
            password: any(named: 'password'),
          )).thenAnswer((_) async {}),
      build: build,
      act: (bloc) => bloc.add(submit),
      expect: () => const [
        SignInState(signInStatus: GenericStatus.loading),
        SignInState(signInStatus: GenericStatus.success),
      ],
      verify: (_) => verify(() => repository.signIn(
          email: 'ada@example.com', password: 'secret123')).called(1),
    );

    final failures = <String, (Object, String Function())>{
      'the credentials are wrong': (
        const HttpException400(code: AppErrorCode.authInvalidCredentials),
        () => AppErrorCode.authInvalidCredentials.message(l10n),
      ),
      'the session is refused': (
        const HttpException401(),
        () => l10n.errorUnauthorized,
      ),
      'the device is offline': (
        const NetworkException(),
        () => l10n.networkError,
      ),
      'something unexpected happens': (
        StateError('x'),
        () => l10n.errorSignIn,
      ),
    };

    for (final MapEntry(key: when_, value: (error, message)) in failures.entries) {
      blocTest<SignInBloc, SignInState>(
        'when $when_ then it shows the matching message',
        setUp: () => signInThrows(error),
        build: build,
        act: (bloc) => bloc.add(submit),
        expect: () => [
          const SignInState(signInStatus: GenericStatus.loading),
          SignInState(
            signInStatus: GenericStatus.failure,
            signInErrorMessage: message(),
          ),
        ],
      );
    }

    blocTest<SignInBloc, SignInState>(
      'when reset then it returns to the initial state',
      build: build,
      seed: () => const SignInState(
          signInStatus: GenericStatus.failure, signInErrorMessage: 'x'),
      act: (bloc) => bloc.add(const SignInEvent.reset()),
      expect: () => const [SignInState()],
    );

    blocTest<SignInBloc, SignInState>(
      'when the password visibility is toggled twice then it shows, then '
      'hides the password',
      build: build,
      act: (bloc) => bloc
        ..add(const SignInEvent.passwordVisibilityToggled())
        ..add(const SignInEvent.passwordVisibilityToggled()),
      expect: () => const [
        SignInState(isPasswordVisible: true),
        SignInState(isPasswordVisible: false),
      ],
    );
  });
}
