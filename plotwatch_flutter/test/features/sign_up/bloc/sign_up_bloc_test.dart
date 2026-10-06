import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

import '../../../helpers/helpers.dart';

// Sign-up flow: decision M1-4 (doc/04a-m1-foundation.md).
void main() {
  late AppLocalizations l10n;
  late MockAuthRepository authRepository;

  final requestId = UuidValue.fromString('11111111-1111-4111-8111-111111111111');
  final newRequestId =
      UuidValue.fromString('22222222-2222-4222-8222-222222222222');

  setUpAll(() {
    l10n = setUpTestLocalization();
    // `any()` on a UuidValue argument needs an example value of that type.
    registerFallbackValue(UuidValue.fromString('00000000-0000-4000-8000-000000000000'));
  });
  setUp(() {
    authRepository = MockAuthRepository();
  });

  SignUpBloc build() => SignUpBloc(authRepository: authRepository);

  final atCodeStep = SignUpState(
    step: SignUpStep.verifyCode,
    fullName: 'Ada Lovelace',
    email: 'ada@example.com',
    accountRequestId: requestId,
  );
  final atPasswordStep = atCodeStep.copyWith(
    step: SignUpStep.password,
    registrationToken: 'token',
  );

  group('Given the details step', () {
    blocTest<SignUpBloc, SignUpState>(
      'when name and email are submitted then a code is requested and the '
      'code step follows',
      setUp: () => when(() => authRepository.startRegistration(email: 'ada@example.com'))
          .thenAnswer((_) async => requestId),
      build: build,
      act: (bloc) => bloc.add(const SignUpEvent.detailsSubmitted(
          fullName: ' Ada Lovelace ', email: ' ada@example.com ')),
      expect: () => [
        const SignUpState(signUpStatus: GenericStatus.loading),
        atCodeStep.copyWith(signUpStatus: GenericStatus.success),
      ],
    );

    blocTest<SignUpBloc, SignUpState>(
      'when the device is offline then it stays on the details step',
      setUp: () => when(() => authRepository.startRegistration(email: any(named: 'email')))
          .thenThrow(const NetworkException()),
      build: build,
      act: (bloc) => bloc.add(const SignUpEvent.detailsSubmitted(
          fullName: 'Ada Lovelace', email: 'ada@example.com')),
      skip: 1,
      expect: () => [
        SignUpState(
          signUpStatus: GenericStatus.failure,
          signUpErrorMessage: l10n.networkError,
        ),
      ],
    );
  });

  group('Given the code step', () {
    blocTest<SignUpBloc, SignUpState>(
      'when the right code is submitted then the password step follows',
      setUp: () => when(() => authRepository.verifyRegistrationCode(
            accountRequestId: requestId,
            code: 'AB12CD34',
          )).thenAnswer((_) async => 'token'),
      build: build,
      seed: () => atCodeStep,
      act: (bloc) => bloc.add(const SignUpEvent.codeSubmitted(code: ' AB12CD34 ')),
      expect: () => [
        atCodeStep.copyWith(signUpStatus: GenericStatus.loading),
        atPasswordStep.copyWith(signUpStatus: GenericStatus.success),
      ],
    );

    blocTest<SignUpBloc, SignUpState>(
      'when the code is wrong then it shows the invalid-code message',
      setUp: () => when(() => authRepository.verifyRegistrationCode(
            accountRequestId: any(named: 'accountRequestId'),
            code: any(named: 'code'),
          )).thenThrow(
              const HttpException400(code: AppErrorCode.authRequestInvalid)),
      build: build,
      seed: () => atCodeStep,
      act: (bloc) => bloc.add(const SignUpEvent.codeSubmitted(code: 'WRONG')),
      skip: 1,
      expect: () => [
        atCodeStep.copyWith(
          signUpStatus: GenericStatus.failure,
          signUpErrorMessage: AppErrorCode.authRequestInvalid.message(l10n),
        ),
      ],
    );

    blocTest<SignUpBloc, SignUpState>(
      'when a new code is requested then the new request replaces the old one',
      setUp: () => when(() => authRepository.startRegistration(email: 'ada@example.com'))
          .thenAnswer((_) async => newRequestId),
      build: build,
      seed: () => atCodeStep,
      act: (bloc) => bloc.add(const SignUpEvent.codeResent()),
      expect: () => [
        atCodeStep.copyWith(signUpStatus: GenericStatus.loading),
        atCodeStep.copyWith(
          accountRequestId: newRequestId,
          signUpStatus: GenericStatus.success,
        ),
      ],
    );
  });

  group('Given the password step', () {
    blocTest<SignUpBloc, SignUpState>(
      'when a valid password is submitted then the account is created with '
      'the name and language in one call',
      setUp: () => when(() => authRepository.finishRegistration(
            registrationToken: 'token',
            password: 'secret123',
            fullName: 'Ada Lovelace',
            locale: 'fr',
          )).thenAnswer((_) async {}),
      build: build,
      seed: () => atPasswordStep,
      act: (bloc) => bloc.add(
          const SignUpEvent.passwordSubmitted(password: 'secret123', locale: 'fr')),
      expect: () => [
        atPasswordStep.copyWith(signUpStatus: GenericStatus.loading),
        atPasswordStep.copyWith(signUpStatus: GenericStatus.success),
      ],
      verify: (_) => verify(() => authRepository.finishRegistration(
            registrationToken: 'token',
            password: 'secret123',
            fullName: 'Ada Lovelace',
            locale: 'fr',
          )).called(1),
    );

    blocTest<SignUpBloc, SignUpState>(
      'when the password breaks the policy then it shows the policy message',
      setUp: () => when(() => authRepository.finishRegistration(
            registrationToken: any(named: 'registrationToken'),
            password: any(named: 'password'),
            fullName: any(named: 'fullName'),
            locale: any(named: 'locale'),
          )).thenThrow(
              const HttpException400(code: AppErrorCode.authPasswordPolicy)),
      build: build,
      seed: () => atPasswordStep,
      act: (bloc) => bloc.add(
          const SignUpEvent.passwordSubmitted(password: 'short', locale: 'en')),
      skip: 1,
      expect: () => [
        atPasswordStep.copyWith(
          signUpStatus: GenericStatus.failure,
          signUpErrorMessage: AppErrorCode.authPasswordPolicy.message(l10n),
        ),
      ],
    );

    blocTest<SignUpBloc, SignUpState>(
      'when something unexpected happens then it shows the sign-up message',
      setUp: () => when(() => authRepository.finishRegistration(
            registrationToken: any(named: 'registrationToken'),
            password: any(named: 'password'),
            fullName: any(named: 'fullName'),
            locale: any(named: 'locale'),
          )).thenThrow(StateError('x')),
      build: build,
      seed: () => atPasswordStep,
      act: (bloc) => bloc.add(
          const SignUpEvent.passwordSubmitted(password: 'secret123', locale: 'en')),
      skip: 1,
      expect: () => [
        atPasswordStep.copyWith(
          signUpStatus: GenericStatus.failure,
          signUpErrorMessage: l10n.errorSignUp,
        ),
      ],
    );
  });

  blocTest<SignUpBloc, SignUpState>(
    'Given any step when reset then it returns to the details step',
    build: build,
    seed: () => atPasswordStep,
    act: (bloc) => bloc.add(const SignUpEvent.reset()),
    expect: () => const [SignUpState()],
  );

  group('Given the password step', () {
    blocTest<SignUpBloc, SignUpState>(
      'when the password visibility is toggled then only the password is '
      'shown',
      build: build,
      seed: () => atPasswordStep,
      act: (bloc) => bloc.add(const SignUpEvent.passwordVisibilityToggled()),
      expect: () => [atPasswordStep.copyWith(isPasswordVisible: true)],
    );

    blocTest<SignUpBloc, SignUpState>(
      'when the confirmation visibility is toggled then only the '
      'confirmation is shown',
      build: build,
      seed: () => atPasswordStep,
      act: (bloc) =>
          bloc.add(const SignUpEvent.confirmPasswordVisibilityToggled()),
      expect: () => [atPasswordStep.copyWith(isConfirmPasswordVisible: true)],
    );
  });
}
