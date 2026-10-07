import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

import '../../../helpers/helpers.dart';

// Plan: doc/04a-m1-foundation.md, group D (decisions M1-6, M1-7).
void main() {
  late AppLocalizations l10n;
  late MockProfileRepository repository;

  final profile = MyProfile(
    fullName: 'Ada Lovelace',
    email: 'ada@example.com',
    countryCode: 'CM',
    locale: 'fr',
  );
  final updated = profile.copyWith(fullName: 'Ada King', locale: 'en');

  setUpAll(() => l10n = setUpTestLocalization());
  setUp(() => repository = MockProfileRepository());

  ProfileBloc build() => ProfileBloc(profileRepository: repository);

  group('Given the profile is fetched', () {
    blocTest<ProfileBloc, ProfileState>(
      'when it loads then the profile is kept',
      setUp: () =>
          when(() => repository.fetchMe()).thenAnswer((_) async => profile),
      build: build,
      act: (bloc) => bloc.add(const ProfileEvent.fetchMe()),
      expect: () => [
        const ProfileState(profileStatus: GenericStatus.loading),
        ProfileState(profileStatus: GenericStatus.success, profile: profile),
      ],
    );

    final failures = <String, (Object, String Function())>{
      'the session expired': (
        const HttpException401(),
        () => l10n.errorUnauthorized,
      ),
      'the device is offline': (
        const NetworkException(),
        () => l10n.networkError,
      ),
      'something unexpected happens': (
        StateError('x'),
        () => l10n.errorProfileLoad,
      ),
    };
    for (final MapEntry(key: when_, value: (error, message))
        in failures.entries) {
      blocTest<ProfileBloc, ProfileState>(
        'when $when_ then it shows the matching message',
        setUp: () => when(() => repository.fetchMe()).thenThrow(error),
        build: build,
        act: (bloc) => bloc.add(const ProfileEvent.fetchMe()),
        skip: 1,
        expect: () => [
          ProfileState(
            profileStatus: GenericStatus.failure,
            profileErrorMessage: message(),
          ),
        ],
      );
    }
  });

  group('Given a loaded profile', () {
    final loaded = ProfileState(
      profileStatus: GenericStatus.success,
      profile: profile,
    );

    blocTest<ProfileBloc, ProfileState>(
      'when it is saved then the server result replaces it',
      setUp: () => when(
        () => repository.updateMe(
          fullName: 'Ada King',
          countryCode: 'CM',
          locale: 'en',
        ),
      ).thenAnswer((_) async => updated),
      build: build,
      seed: () => loaded,
      act: (bloc) => bloc.add(
        const ProfileEvent.updateMe(
          fullName: 'Ada King',
          countryCode: 'CM',
          locale: 'en',
        ),
      ),
      expect: () => [
        loaded.copyWith(
          flowStep: GenericFlowStep.updatingItem,
          profileActionStatus: GenericStatus.loading,
        ),
        loaded.copyWith(
          flowStep: GenericFlowStep.updatingItem,
          profileActionStatus: GenericStatus.success,
          profile: updated,
        ),
      ],
    );

    blocTest<ProfileBloc, ProfileState>(
      'when the server rejects the country then it shows that message and '
      'keeps the old profile',
      setUp: () =>
          when(
            () => repository.updateMe(
              fullName: any(named: 'fullName'),
              countryCode: any(named: 'countryCode'),
              locale: any(named: 'locale'),
            ),
          ).thenThrow(
            const HttpException400(code: AppErrorCode.invalidCountryCode),
          ),
      build: build,
      seed: () => loaded,
      act: (bloc) => bloc.add(
        const ProfileEvent.updateMe(
          fullName: 'Ada',
          countryCode: 'XX',
          locale: 'en',
        ),
      ),
      skip: 1,
      expect: () => [
        loaded.copyWith(
          flowStep: GenericFlowStep.updatingItem,
          profileActionStatus: GenericStatus.failure,
          profileActionErrorMessage: AppErrorCode.invalidCountryCode.message(
            l10n,
          ),
        ),
      ],
    );

    blocTest<ProfileBloc, ProfileState>(
      'when saving fails unexpectedly then it shows the save message',
      setUp: () => when(
        () => repository.updateMe(
          fullName: any(named: 'fullName'),
          countryCode: any(named: 'countryCode'),
          locale: any(named: 'locale'),
        ),
      ).thenThrow(StateError('x')),
      build: build,
      seed: () => loaded,
      act: (bloc) => bloc.add(
        const ProfileEvent.updateMe(
          fullName: 'Ada',
          countryCode: null,
          locale: 'en',
        ),
      ),
      skip: 1,
      expect: () => [
        loaded.copyWith(
          flowStep: GenericFlowStep.updatingItem,
          profileActionStatus: GenericStatus.failure,
          profileActionErrorMessage: l10n.errorProfileSave,
        ),
      ],
    );

    blocTest<ProfileBloc, ProfileState>(
      'when the flow step is reset then the action state is cleared',
      build: build,
      seed: () => loaded.copyWith(
        flowStep: GenericFlowStep.updatingItem,
        profileActionStatus: GenericStatus.failure,
        profileActionErrorMessage: 'x',
      ),
      act: (bloc) => bloc.add(const ProfileEvent.resetFlowStep()),
      expect: () => [loaded],
    );

    blocTest<ProfileBloc, ProfileState>(
      'when reset (sign-out) then the profile is forgotten',
      build: build,
      seed: () => loaded,
      act: (bloc) => bloc.add(const ProfileEvent.reset()),
      expect: () => const [ProfileState()],
    );
  });

  group('Given the app language', () {
    test('when no profile is loaded then it follows the device', () {
      expect(const ProfileState().appLocale, isNull);
    });

    test('when a profile is loaded then it follows the profile', () {
      expect(ProfileState(profile: profile).appLocale, const Locale('fr'));
    });
  });
}
