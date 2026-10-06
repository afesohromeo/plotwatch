import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

import '../../../helpers/helpers.dart';

void main() {
  late AppLocalizations l10n;
  late MockAuthRepository repository;

  setUpAll(() => l10n = setUpTestLocalization());

  setUp(() {
    repository = MockAuthRepository();
    when(() => repository.isSignedIn).thenReturn(false);
    when(() => repository.signedInChanges).thenAnswer((_) => const Stream.empty());
  });

  group('Given the authentication bloc', () {
    test('when the saved session is signed in then it starts authenticated',
        () {
      when(() => repository.isSignedIn).thenReturn(true);

      final bloc = AuthenticationBloc(authRepository: repository);

      expect(bloc.state.status, AuthenticationStatus.authenticated);
    });

    test('when there is no saved session then it starts unauthenticated', () {
      final bloc = AuthenticationBloc(authRepository: repository);

      expect(bloc.state.status, AuthenticationStatus.unauthenticated);
    });

    blocTest<AuthenticationBloc, AuthenticationState>(
      'when started and the session changes then the status follows it',
      setUp: () => when(() => repository.signedInChanges)
          .thenAnswer((_) => Stream.fromIterable([true, false])),
      build: () => AuthenticationBloc(authRepository: repository),
      act: (bloc) => bloc.add(const AuthenticationEvent.started()),
      expect: () => const [
        AuthenticationState(status: AuthenticationStatus.authenticated),
        AuthenticationState(status: AuthenticationStatus.unauthenticated),
      ],
    );

    blocTest<AuthenticationBloc, AuthenticationState>(
      'when sign-out succeeds then it reports success',
      setUp: () => when(() => repository.signOut()).thenAnswer((_) async {}),
      build: () => AuthenticationBloc(authRepository: repository),
      act: (bloc) => bloc.add(const AuthenticationEvent.signOutRequested()),
      expect: () => const [
        AuthenticationState(
          status: AuthenticationStatus.unauthenticated,
          signOutStatus: GenericStatus.loading,
        ),
        AuthenticationState(
          status: AuthenticationStatus.unauthenticated,
          signOutStatus: GenericStatus.success,
        ),
      ],
      verify: (_) => verify(() => repository.signOut()).called(1),
    );

    blocTest<AuthenticationBloc, AuthenticationState>(
      'when sign-out fails offline then it shows the network message',
      setUp: () =>
          when(() => repository.signOut()).thenThrow(const NetworkException()),
      build: () => AuthenticationBloc(authRepository: repository),
      act: (bloc) => bloc.add(const AuthenticationEvent.signOutRequested()),
      skip: 1,
      expect: () => [
        AuthenticationState(
          status: AuthenticationStatus.unauthenticated,
          signOutStatus: GenericStatus.failure,
          signOutErrorMessage: l10n.networkError,
        ),
      ],
    );

    blocTest<AuthenticationBloc, AuthenticationState>(
      'when sign-out fails unexpectedly then it shows the sign-out message',
      setUp: () => when(() => repository.signOut()).thenThrow(StateError('x')),
      build: () => AuthenticationBloc(authRepository: repository),
      act: (bloc) => bloc.add(const AuthenticationEvent.signOutRequested()),
      skip: 1,
      expect: () => [
        AuthenticationState(
          status: AuthenticationStatus.unauthenticated,
          signOutStatus: GenericStatus.failure,
          signOutErrorMessage: l10n.errorSignOut,
        ),
      ],
    );
  });
}
