import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

import '../../../helpers/helpers.dart';

void main() {
  late AppLocalizations l10n;
  late MockAuthRepository repository;

  final requestId = UuidValue.fromString('33333333-3333-4333-8333-333333333333');

  setUpAll(() {
    l10n = setUpTestLocalization();
    // `any()` on a UuidValue argument needs an example value of that type.
    registerFallbackValue(UuidValue.fromString('00000000-0000-4000-8000-000000000000'));
  });
  setUp(() => repository = MockAuthRepository());

  PasswordResetBloc build() => PasswordResetBloc(authRepository: repository);

  final atCodeStep = PasswordResetState(
    step: PasswordResetStep.verifyCode,
    email: 'ada@example.com',
    passwordResetRequestId: requestId,
  );
  final atNewPasswordStep = atCodeStep.copyWith(
    step: PasswordResetStep.newPassword,
    finishPasswordResetToken: 'reset-token',
  );

  blocTest<PasswordResetBloc, PasswordResetState>(
    'Given the email step when an email is submitted then a code is requested '
    'and the code step follows',
    setUp: () => when(() => repository.startPasswordReset(email: 'ada@example.com'))
        .thenAnswer((_) async => requestId),
    build: build,
    act: (bloc) =>
        bloc.add(const PasswordResetEvent.emailSubmitted(email: ' ada@example.com ')),
    expect: () => [
      const PasswordResetState(passwordResetStatus: GenericStatus.loading),
      atCodeStep.copyWith(passwordResetStatus: GenericStatus.success),
    ],
  );

  blocTest<PasswordResetBloc, PasswordResetState>(
    'Given the email step when there were too many attempts then it shows that '
    'message',
    setUp: () => when(() => repository.startPasswordReset(email: any(named: 'email')))
        .thenThrow(const HttpException400(code: AppErrorCode.authTooManyAttempts)),
    build: build,
    act: (bloc) =>
        bloc.add(const PasswordResetEvent.emailSubmitted(email: 'ada@example.com')),
    skip: 1,
    expect: () => [
      PasswordResetState(
        passwordResetStatus: GenericStatus.failure,
        passwordResetErrorMessage: AppErrorCode.authTooManyAttempts.message(l10n),
      ),
    ],
  );

  blocTest<PasswordResetBloc, PasswordResetState>(
    'Given the code step when the right code is submitted then the new-password '
    'step follows',
    setUp: () => when(() => repository.verifyPasswordResetCode(
          passwordResetRequestId: requestId,
          code: 'AB12CD34',
        )).thenAnswer((_) async => 'reset-token'),
    build: build,
    seed: () => atCodeStep,
    act: (bloc) => bloc.add(const PasswordResetEvent.codeSubmitted(code: 'AB12CD34')),
    expect: () => [
      atCodeStep.copyWith(passwordResetStatus: GenericStatus.loading),
      atNewPasswordStep.copyWith(passwordResetStatus: GenericStatus.success),
    ],
  );

  blocTest<PasswordResetBloc, PasswordResetState>(
    'Given the code step when a new code is requested then the new request '
    'replaces the old one',
    setUp: () => when(() => repository.startPasswordReset(email: 'ada@example.com'))
        .thenAnswer((_) async => requestId),
    build: build,
    seed: () => atCodeStep,
    act: (bloc) => bloc.add(const PasswordResetEvent.codeResent()),
    expect: () => [
      atCodeStep.copyWith(passwordResetStatus: GenericStatus.loading),
      atCodeStep.copyWith(passwordResetStatus: GenericStatus.success),
    ],
  );

  blocTest<PasswordResetBloc, PasswordResetState>(
    'Given the new-password step when a valid password is submitted then it is '
    'saved and the user is signed in with it',
    setUp: () {
      when(() => repository.finishPasswordReset(
            finishPasswordResetToken: 'reset-token',
            newPassword: 'newSecret1',
          )).thenAnswer((_) async {});
      when(() => repository.signIn(email: 'ada@example.com', password: 'newSecret1'))
          .thenAnswer((_) async {});
    },
    build: build,
    seed: () => atNewPasswordStep,
    act: (bloc) => bloc.add(
        const PasswordResetEvent.newPasswordSubmitted(password: 'newSecret1')),
    expect: () => [
      atNewPasswordStep.copyWith(passwordResetStatus: GenericStatus.loading),
      atNewPasswordStep.copyWith(passwordResetStatus: GenericStatus.success),
    ],
    verify: (_) => verify(() =>
            repository.signIn(email: 'ada@example.com', password: 'newSecret1'))
        .called(1),
  );

  blocTest<PasswordResetBloc, PasswordResetState>(
    'Given the new-password step when the reset expired then it shows the '
    'expired message',
    setUp: () => when(() => repository.finishPasswordReset(
          finishPasswordResetToken: any(named: 'finishPasswordResetToken'),
          newPassword: any(named: 'newPassword'),
        )).thenThrow(const HttpException400(code: AppErrorCode.authRequestExpired)),
    build: build,
    seed: () => atNewPasswordStep,
    act: (bloc) => bloc.add(
        const PasswordResetEvent.newPasswordSubmitted(password: 'newSecret1')),
    skip: 1,
    expect: () => [
      atNewPasswordStep.copyWith(
        passwordResetStatus: GenericStatus.failure,
        passwordResetErrorMessage: AppErrorCode.authRequestExpired.message(l10n),
      ),
    ],
  );

  blocTest<PasswordResetBloc, PasswordResetState>(
    'Given any step when something unexpected happens then it shows the '
    'password-reset message',
    setUp: () => when(() => repository.verifyPasswordResetCode(
          passwordResetRequestId: any(named: 'passwordResetRequestId'),
          code: any(named: 'code'),
        )).thenThrow(StateError('x')),
    build: build,
    seed: () => atCodeStep,
    act: (bloc) => bloc.add(const PasswordResetEvent.codeSubmitted(code: 'AB12CD34')),
    skip: 1,
    expect: () => [
      atCodeStep.copyWith(
        passwordResetStatus: GenericStatus.failure,
        passwordResetErrorMessage: l10n.errorPasswordReset,
      ),
    ],
  );

  blocTest<PasswordResetBloc, PasswordResetState>(
    'Given the new-password step when the password visibility is toggled '
    'then only the new password is shown',
    build: build,
    seed: () => atNewPasswordStep,
    act: (bloc) =>
        bloc.add(const PasswordResetEvent.passwordVisibilityToggled()),
    expect: () => [atNewPasswordStep.copyWith(isPasswordVisible: true)],
  );

  blocTest<PasswordResetBloc, PasswordResetState>(
    'Given the new-password step when the confirmation visibility is toggled '
    'then only the confirmation is shown',
    build: build,
    seed: () => atNewPasswordStep,
    act: (bloc) =>
        bloc.add(const PasswordResetEvent.confirmPasswordVisibilityToggled()),
    expect: () =>
        [atNewPasswordStep.copyWith(isConfirmPasswordVisible: true)],
  );
}
