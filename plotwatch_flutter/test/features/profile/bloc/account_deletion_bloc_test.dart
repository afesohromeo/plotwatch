import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

import '../../../helpers/helpers.dart';

// Plan: doc/04g-m8-hardening.md, step 6 (account deletion).
void main() {
  late AppLocalizations l10n;
  late MockAuthRepository repository;

  setUpAll(() => l10n = setUpTestLocalization());
  setUp(() => repository = MockAuthRepository());

  AccountDeletionBloc build() =>
      AccountDeletionBloc(authRepository: repository);

  group('Given the account deletion bloc', () {
    blocTest<AccountDeletionBloc, AccountDeletionState>(
      'when the check finds shared projects then it lists them',
      setUp: () => when(
        () => repository.deletionBlockers(),
      ).thenAnswer((_) async => ['Maison Douala']),
      build: build,
      act: (bloc) => bloc.add(const AccountDeletionEvent.checkRequested()),
      expect: () => const [
        AccountDeletionState(checkStatus: GenericStatus.loading),
        AccountDeletionState(
          checkStatus: GenericStatus.success,
          blockers: ['Maison Douala'],
        ),
      ],
    );

    blocTest<AccountDeletionBloc, AccountDeletionState>(
      'when the deletion succeeds then it says so',
      setUp: () => when(
        () => repository.deleteAccount(),
      ).thenAnswer((_) async {}),
      build: build,
      seed: () =>
          const AccountDeletionState(checkStatus: GenericStatus.success),
      act: (bloc) => bloc.add(const AccountDeletionEvent.deleteRequested()),
      expect: () => const [
        AccountDeletionState(
          checkStatus: GenericStatus.success,
          deleteStatus: GenericStatus.loading,
        ),
        AccountDeletionState(
          checkStatus: GenericStatus.success,
          deleteStatus: GenericStatus.success,
        ),
      ],
      verify: (_) => verify(() => repository.deleteAccount()).called(1),
    );

    blocTest<AccountDeletionBloc, AccountDeletionState>(
      'when a shared project appeared meanwhile then it fails with that '
      'message',
      setUp: () => when(() => repository.deleteAccount()).thenThrow(
        const HttpException400(code: AppErrorCode.accountOwnsSharedProjects),
      ),
      build: build,
      seed: () =>
          const AccountDeletionState(checkStatus: GenericStatus.success),
      act: (bloc) => bloc.add(const AccountDeletionEvent.deleteRequested()),
      skip: 1,
      expect: () => [
        AccountDeletionState(
          checkStatus: GenericStatus.success,
          deleteStatus: GenericStatus.failure,
          errorMessage: l10n.errorAccountOwnsSharedProjects,
        ),
      ],
    );
  });
}
