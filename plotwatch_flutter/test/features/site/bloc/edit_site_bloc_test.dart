import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

import '../../../helpers/helpers.dart';

// Plan: doc/04b-m2-projects-site-members.md, group H (H-3): the owner
// changes the radius and the address of the validated site.
void main() {
  late AppLocalizations l10n;
  late MockSiteRepository repository;

  final site = testSite().copyWith(radiusM: 60, addressText: 'Gate');

  setUpAll(() => l10n = setUpTestLocalization());
  setUp(() => repository = MockSiteRepository());

  EditSiteBloc build() => EditSiteBloc(siteRepository: repository);

  final loaded = EditSiteState(
    projectId: 1,
    site: site,
    radiusM: 60,
    loadStatus: GenericStatus.success,
  );

  group('Given the edit screen opens', () {
    blocTest<EditSiteBloc, EditSiteState>(
      'when the site exists then its radius is the starting point',
      setUp: () =>
          when(() => repository.fetchSite(1)).thenAnswer((_) async => site),
      build: build,
      act: (bloc) => bloc.add(const EditSiteEvent.load(projectId: 1)),
      expect: () => [
        const EditSiteState(projectId: 1, loadStatus: GenericStatus.loading),
        loaded,
      ],
    );

    blocTest<EditSiteBloc, EditSiteState>(
      'when there is no site yet then it says so',
      setUp: () =>
          when(() => repository.fetchSite(1)).thenAnswer((_) async => null),
      build: build,
      act: (bloc) => bloc.add(const EditSiteEvent.load(projectId: 1)),
      skip: 1,
      expect: () => [
        EditSiteState(
          projectId: 1,
          loadStatus: GenericStatus.failure,
          loadErrorMessage: l10n.errorSiteNotFound,
        ),
      ],
    );

    blocTest<EditSiteBloc, EditSiteState>(
      'when the network is down then it says so',
      setUp: () => when(
        () => repository.fetchSite(1),
      ).thenThrow(const NetworkException()),
      build: build,
      act: (bloc) => bloc.add(const EditSiteEvent.load(projectId: 1)),
      skip: 1,
      expect: () => [
        EditSiteState(
          projectId: 1,
          loadStatus: GenericStatus.failure,
          loadErrorMessage: l10n.networkError,
        ),
      ],
    );
  });

  group('Given the site is loaded', () {
    blocTest<EditSiteBloc, EditSiteState>(
      'when the radius goes past the limits then it stays within 10–500 m',
      build: build,
      seed: () => loaded,
      act: (bloc) => bloc
        ..add(const EditSiteEvent.radiusChanged(radiusM: 900))
        ..add(const EditSiteEvent.radiusChanged(radiusM: 2)),
      expect: () => [
        loaded.copyWith(radiusM: maxSiteRadiusM),
        loaded.copyWith(radiusM: minSiteRadiusM),
      ],
    );

    blocTest<EditSiteBloc, EditSiteState>(
      'when Save is tapped then the radius and address are sent',
      setUp: () => when(
        () => repository.updateSite(1, radiusM: 60, addressText: 'Market'),
      ).thenAnswer((_) async => site),
      build: build,
      seed: () => loaded,
      act: (bloc) =>
          bloc.add(const EditSiteEvent.saveRequested(addressText: 'Market')),
      expect: () => [
        loaded.copyWith(actionStatus: GenericStatus.loading),
        loaded.copyWith(actionStatus: GenericStatus.success),
      ],
    );

    blocTest<EditSiteBloc, EditSiteState>(
      'when the server refuses the radius then its message is shown',
      setUp: () => when(
        () => repository.updateSite(
          any(),
          radiusM: any(named: 'radiusM'),
          addressText: any(named: 'addressText'),
        ),
      ).thenThrow(const HttpException400(code: AppErrorCode.invalidSiteRadius)),
      build: build,
      seed: () => loaded,
      act: (bloc) => bloc.add(const EditSiteEvent.saveRequested()),
      expect: () => [
        loaded.copyWith(actionStatus: GenericStatus.loading),
        loaded.copyWith(
          actionStatus: GenericStatus.failure,
          actionErrorMessage: AppErrorCode.invalidSiteRadius.message(l10n),
        ),
      ],
    );

    blocTest<EditSiteBloc, EditSiteState>(
      'when the network is down then it says so',
      setUp: () => when(
        () => repository.updateSite(
          any(),
          radiusM: any(named: 'radiusM'),
          addressText: any(named: 'addressText'),
        ),
      ).thenThrow(const NetworkException()),
      build: build,
      seed: () => loaded,
      act: (bloc) => bloc.add(const EditSiteEvent.saveRequested()),
      expect: () => [
        loaded.copyWith(actionStatus: GenericStatus.loading),
        loaded.copyWith(
          actionStatus: GenericStatus.failure,
          actionErrorMessage: l10n.networkError,
        ),
      ],
    );
  });
}
