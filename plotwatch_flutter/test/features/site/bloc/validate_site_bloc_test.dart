import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

import '../../../helpers/helpers.dart';

// Plan: doc/04b-m2-projects-site-members.md, group G (decisions M2-15,
// M2-16, M2-18): the owner validates the proposal with a radius, or rejects.
void main() {
  late AppLocalizations l10n;
  late MockSiteRepository repository;

  final pending = testProposal(id: 7);
  final older = testProposal(id: 6, status: SiteProposalStatus.rejected);

  setUpAll(() => l10n = setUpTestLocalization());
  setUp(() => repository = MockSiteRepository());

  ValidateSiteBloc build() => ValidateSiteBloc(siteRepository: repository);

  final loaded = ValidateSiteState(
    projectId: 1,
    loadStatus: GenericStatus.success,
    proposal: pending,
  );

  group('Given the validate screen opens', () {
    blocTest<ValidateSiteBloc, ValidateSiteState>(
      'when a proposal is pending then it is shown with the default radius',
      setUp: () {
        when(
          () => repository.fetchProposals(1),
        ).thenAnswer((_) async => [pending, older]);
        when(() => repository.fetchSite(1)).thenAnswer((_) async => null);
      },
      build: build,
      act: (bloc) => bloc.add(const ValidateSiteEvent.load(projectId: 1)),
      expect: () => [
        const ValidateSiteState(
          projectId: 1,
          loadStatus: GenericStatus.loading,
        ),
        loaded,
      ],
    );

    blocTest<ValidateSiteBloc, ValidateSiteState>(
      'when the site already exists then its radius is the starting point',
      setUp: () {
        when(
          () => repository.fetchProposals(1),
        ).thenAnswer((_) async => [pending]);
        when(
          () => repository.fetchSite(1),
        ).thenAnswer((_) async => testSite().copyWith(radiusM: 30));
      },
      build: build,
      act: (bloc) => bloc.add(const ValidateSiteEvent.load(projectId: 1)),
      skip: 1,
      expect: () => [loaded.copyWith(radiusM: 30)],
    );

    blocTest<ValidateSiteBloc, ValidateSiteState>(
      'when nothing is pending then there is no proposal',
      setUp: () {
        when(
          () => repository.fetchProposals(1),
        ).thenAnswer((_) async => [older]);
        when(() => repository.fetchSite(1)).thenAnswer((_) async => null);
      },
      build: build,
      act: (bloc) => bloc.add(const ValidateSiteEvent.load(projectId: 1)),
      skip: 1,
      expect: () => [
        const ValidateSiteState(
          projectId: 1,
          loadStatus: GenericStatus.success,
        ),
      ],
    );
  });

  group('Given a pending proposal', () {
    blocTest<ValidateSiteBloc, ValidateSiteState>(
      'when the radius is changed then it stays between 10 and 500 m',
      build: build,
      seed: () => loaded,
      act: (bloc) => bloc
        ..add(const ValidateSiteEvent.radiusChanged(radiusM: 5))
        ..add(const ValidateSiteEvent.radiusChanged(radiusM: 120))
        ..add(const ValidateSiteEvent.radiusChanged(radiusM: 900)),
      expect: () => [
        loaded.copyWith(radiusM: 10),
        loaded.copyWith(radiusM: 120),
        loaded.copyWith(radiusM: 500),
      ],
    );

    blocTest<ValidateSiteBloc, ValidateSiteState>(
      'when the owner validates then the radius and address are sent',
      setUp: () => when(
        () => repository.validateProposal(
          1,
          7,
          radiusM: 50,
          addressText: 'Behind the church',
        ),
      ).thenAnswer((_) async => testSite()),
      build: build,
      seed: () => loaded,
      act: (bloc) => bloc.add(
        const ValidateSiteEvent.validateRequested(
          addressText: 'Behind the church',
        ),
      ),
      expect: () => [
        loaded.copyWith(
          flowStep: GenericFlowStep.updatingItem,
          actionStatus: GenericStatus.loading,
        ),
        loaded.copyWith(
          flowStep: GenericFlowStep.updatingItem,
          actionStatus: GenericStatus.success,
        ),
      ],
    );

    blocTest<ValidateSiteBloc, ValidateSiteState>(
      'when the owner rejects with a reason then it is sent',
      setUp: () => when(
        () => repository.rejectProposal(1, 7, reason: 'Neighbour\'s plot'),
      ).thenAnswer((_) async {}),
      build: build,
      seed: () => loaded,
      act: (bloc) => bloc.add(
        const ValidateSiteEvent.rejectRequested(reason: 'Neighbour\'s plot'),
      ),
      skip: 1,
      expect: () => [
        loaded.copyWith(
          flowStep: GenericFlowStep.deletingItem,
          actionStatus: GenericStatus.success,
        ),
      ],
    );

    blocTest<ValidateSiteBloc, ValidateSiteState>(
      'when the proposal was replaced meanwhile then it says so',
      setUp: () =>
          when(
            () => repository.validateProposal(
              any(),
              any(),
              radiusM: any(named: 'radiusM'),
              addressText: any(named: 'addressText'),
            ),
          ).thenThrow(
            const HttpException400(code: AppErrorCode.siteProposalNotPending),
          ),
      build: build,
      seed: () => loaded,
      act: (bloc) => bloc.add(
        const ValidateSiteEvent.validateRequested(addressText: null),
      ),
      skip: 1,
      expect: () => [
        loaded.copyWith(
          flowStep: GenericFlowStep.updatingItem,
          actionStatus: GenericStatus.failure,
          actionErrorMessage: l10n.errorSiteProposalNotPending,
        ),
      ],
    );
  });
}
