import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

import '../../../helpers/helpers.dart';

// Plan: doc/04g-m8-hardening.md, step 4 (AUTH-04).
void main() {
  late AppLocalizations l10n;
  late MockAuthRepository repository;

  setUpAll(() => l10n = setUpTestLocalization());
  setUp(() {
    repository = MockAuthRepository();
    when(() => repository.isGoogleSignInAvailable).thenReturn(true);
  });

  GoogleSignInBloc build() => GoogleSignInBloc(authRepository: repository);
  const start = GoogleSignInEvent.started(locale: 'fr');
  const ready = GoogleSignInState(isAvailable: true);

  test('Given Google is not configured then the bloc says it is not '
      'available', () {
    when(() => repository.isGoogleSignInAvailable).thenReturn(false);

    expect(build().state.isAvailable, isFalse);
  });

  group('Given the Google sign-in bloc', () {
    blocTest<GoogleSignInBloc, GoogleSignInState>(
      'when Google signs the user in then it succeeds, with the app language',
      setUp: () => when(
        () => repository.signInWithGoogle(locale: any(named: 'locale')),
      ).thenAnswer((_) async => true),
      build: build,
      act: (bloc) => bloc.add(start),
      expect: () => [
        ready.copyWith(status: GenericStatus.loading),
        ready.copyWith(status: GenericStatus.success),
      ],
      verify: (_) => verify(
        () => repository.signInWithGoogle(locale: 'fr'),
      ).called(1),
    );

    blocTest<GoogleSignInBloc, GoogleSignInState>(
      'when the user closes Google\'s window then it is back to idle, with '
      'no error',
      setUp: () => when(
        () => repository.signInWithGoogle(locale: any(named: 'locale')),
      ).thenAnswer((_) async => false),
      build: build,
      act: (bloc) => bloc.add(start),
      expect: () => [ready.copyWith(status: GenericStatus.loading), ready],
    );

    final failures = <String, (Object, String Function())>{
      'the network is down': (const NetworkException(), () => l10n.networkError),
      'Google fails': (Exception('boom'), () => l10n.errorGoogleSignIn),
    };
    failures.forEach((name, failure) {
      blocTest<GoogleSignInBloc, GoogleSignInState>(
        'when $name then it fails with its message',
        setUp: () => when(
          () => repository.signInWithGoogle(locale: any(named: 'locale')),
        ).thenThrow(failure.$1),
        build: build,
        act: (bloc) => bloc.add(start),
        expect: () => [
          ready.copyWith(status: GenericStatus.loading),
          ready.copyWith(
            status: GenericStatus.failure,
            errorMessage: failure.$2(),
          ),
        ],
      );
    });
  });
}
