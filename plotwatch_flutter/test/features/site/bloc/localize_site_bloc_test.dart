import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

import '../../../helpers/helpers.dart';

// Plan: doc/04b-m2-projects-site-members.md, group G (decisions M2-15,
// M2-17): the site manager proposes the site from GPS on the plot.
void main() {
  late AppLocalizations l10n;
  late MockSiteRepository repository;
  late MockLocationProvider locationProvider;
  late MockProjectRepository projectRepository;

  setUpAll(() {
    l10n = setUpTestLocalization();
    registerFallbackValue(testReading());
  });
  setUp(() {
    repository = MockSiteRepository();
    locationProvider = MockLocationProvider();
    projectRepository = MockProjectRepository();
    when(
      () => projectRepository.fetchProject(1),
    ).thenAnswer((_) async => testOverview(role: ProjectRole.siteManager));
  });

  LocalizeSiteBloc build() => LocalizeSiteBloc(
    siteRepository: repository,
    projectRepository: projectRepository,
    locationProvider: locationProvider,
  );

  group('Given the localize screen opens', () {
    blocTest<LocalizeSiteBloc, LocalizeSiteState>(
      'when location is allowed then the readings stream in',
      setUp: () {
        when(
          () => locationProvider.ensureAccess(),
        ).thenAnswer((_) async => LocationAccess.granted);
        when(() => locationProvider.readings()).thenAnswer(
          (_) =>
              Stream.fromIterable([testReading(accuracyM: 30), testReading()]),
        );
      },
      build: build,
      act: (bloc) => bloc.add(const LocalizeSiteEvent.started(projectId: 1)),
      expect: () => [
        // The role decides where saving leads (doc/04b G-12).
        const LocalizeSiteState(myRole: ProjectRole.siteManager),
        const LocalizeSiteState(
          myRole: ProjectRole.siteManager,
          access: LocationAccess.granted,
        ),
        LocalizeSiteState(
          myRole: ProjectRole.siteManager,
          access: LocationAccess.granted,
          reading: testReading(accuracyM: 30),
        ),
        LocalizeSiteState(
          myRole: ProjectRole.siteManager,
          access: LocationAccess.granted,
          reading: testReading(),
        ),
      ],
    );

    for (final access in [
      LocationAccess.denied,
      LocationAccess.deniedForever,
      LocationAccess.serviceDisabled,
    ]) {
      blocTest<LocalizeSiteBloc, LocalizeSiteState>(
        'when location is ${access.name} then no reading is asked for',
        setUp: () => when(
          () => locationProvider.ensureAccess(),
        ).thenAnswer((_) async => access),
        build: build,
        act: (bloc) => bloc.add(const LocalizeSiteEvent.started(projectId: 1)),
        skip: 1,
        expect: () => [
          LocalizeSiteState(myRole: ProjectRole.siteManager, access: access),
        ],
        verify: (_) => verifyNever(() => locationProvider.readings()),
      );
    }

    blocTest<LocalizeSiteBloc, LocalizeSiteState>(
      'when the project cannot be opened then it says why and asks no '
      'permission',
      setUp: () => when(
        () => projectRepository.fetchProject(1),
      ).thenThrow(const HttpException400(code: AppErrorCode.projectNotFound)),
      build: build,
      act: (bloc) => bloc.add(const LocalizeSiteEvent.started(projectId: 1)),
      expect: () => [
        LocalizeSiteState(loadErrorMessage: l10n.errorProjectNotFound),
      ],
      verify: (_) => verifyNever(() => locationProvider.ensureAccess()),
    );
  });

  group('Given the accuracy (decision M2-17)', () {
    test('when it is 20 m or better and not mocked then it can be saved', () {
      expect(
        LocalizeSiteState(
          access: LocationAccess.granted,
          reading: testReading(accuracyM: 20),
        ).canPropose,
        isTrue,
      );
    });

    test('when it is worse than 20 m then it cannot be saved yet', () {
      expect(
        LocalizeSiteState(
          access: LocationAccess.granted,
          reading: testReading(accuracyM: 20.5),
        ).canPropose,
        isFalse,
      );
    });

    test('when the position is mocked then it cannot be saved', () {
      expect(
        LocalizeSiteState(
          access: LocationAccess.granted,
          reading: testReading(isMocked: true),
        ).canPropose,
        isFalse,
      );
    });
  });

  group('Given a good reading', () {
    final ready = LocalizeSiteState(
      access: LocationAccess.granted,
      reading: testReading(),
    );
    final proposal = testProposal();

    blocTest<LocalizeSiteBloc, LocalizeSiteState>(
      'when it is saved then the proposal is kept',
      setUp: () => when(
        () => repository.proposeSite(1, testReading()),
      ).thenAnswer((_) async => proposal),
      build: build,
      seed: () => ready,
      act: (bloc) =>
          bloc.add(const LocalizeSiteEvent.proposeRequested(projectId: 1)),
      expect: () => [
        ready.copyWith(proposeStatus: GenericStatus.loading),
        ready.copyWith(
          proposeStatus: GenericStatus.success,
          proposal: proposal,
        ),
      ],
    );

    blocTest<LocalizeSiteBloc, LocalizeSiteState>(
      'when the server finds the accuracy too low then it says so',
      setUp: () => when(() => repository.proposeSite(any(), any())).thenThrow(
        const HttpException400(code: AppErrorCode.siteAccuracyTooLow),
      ),
      build: build,
      seed: () => ready,
      act: (bloc) =>
          bloc.add(const LocalizeSiteEvent.proposeRequested(projectId: 1)),
      skip: 1,
      expect: () => [
        ready.copyWith(
          proposeStatus: GenericStatus.failure,
          proposeErrorMessage: l10n.errorSiteAccuracyTooLow,
        ),
      ],
    );

    blocTest<LocalizeSiteBloc, LocalizeSiteState>(
      'when saving fails unexpectedly then it shows the save message',
      setUp: () => when(
        () => repository.proposeSite(any(), any()),
      ).thenThrow(StateError('x')),
      build: build,
      seed: () => ready,
      act: (bloc) =>
          bloc.add(const LocalizeSiteEvent.proposeRequested(projectId: 1)),
      skip: 1,
      expect: () => [
        ready.copyWith(
          proposeStatus: GenericStatus.failure,
          proposeErrorMessage: l10n.errorSiteProposal,
        ),
      ],
    );

    blocTest<LocalizeSiteBloc, LocalizeSiteState>(
      'when the reading is not good enough then nothing is sent',
      build: build,
      seed: () => LocalizeSiteState(
        access: LocationAccess.granted,
        reading: testReading(accuracyM: 50),
      ),
      act: (bloc) =>
          bloc.add(const LocalizeSiteEvent.proposeRequested(projectId: 1)),
      expect: () => <LocalizeSiteState>[],
      verify: (_) => verifyNever(() => repository.proposeSite(any(), any())),
    );
  });
}
