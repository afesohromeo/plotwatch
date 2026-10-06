import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

import '../../../helpers/helpers.dart';

// Plan: doc/04b-m2-projects-site-members.md, group E (wizard: Details →
// Review; one create request, decision M2-3).
void main() {
  late AppLocalizations l10n;
  late MockProjectRepository repository;

  setUpAll(() {
    l10n = setUpTestLocalization();
    registerFallbackValue(testDetails);
  });
  setUp(() => repository = MockProjectRepository());

  CreateProjectBloc build() => CreateProjectBloc(projectRepository: repository);

  final atReview =
      CreateProjectState(step: CreateProjectStep.review, details: testDetails);

  group('Given the create-project wizard', () {
    blocTest<CreateProjectBloc, CreateProjectState>(
      'when the details are submitted then it moves to the review step',
      build: build,
      act: (bloc) =>
          bloc.add(CreateProjectEvent.detailsSubmitted(details: testDetails)),
      expect: () => [atReview],
    );

    blocTest<CreateProjectBloc, CreateProjectState>(
      'when going back from the review then the details are kept',
      build: build,
      seed: () => atReview,
      act: (bloc) => bloc.add(const CreateProjectEvent.backToDetails()),
      expect: () => [
        CreateProjectState(details: testDetails),
      ],
    );

    final created = testOverview();
    blocTest<CreateProjectBloc, CreateProjectState>(
      'when the project is created then the new project is kept',
      setUp: () => when(() => repository.createProject(testDetails))
          .thenAnswer((_) async => created),
      build: build,
      seed: () => atReview,
      act: (bloc) => bloc.add(const CreateProjectEvent.createSubmitted()),
      expect: () => [
        atReview.copyWith(createStatus: GenericStatus.loading),
        atReview.copyWith(createStatus: GenericStatus.success, created: created),
      ],
      verify: (_) =>
          verify(() => repository.createProject(testDetails)).called(1),
    );

    final failures = <String, (Object, String Function())>{
      'the server refuses the name': (
        const HttpException400(code: AppErrorCode.invalidProjectName),
        () => l10n.errorInvalidProjectName
      ),
      'the session expired': (
        const HttpException401(),
        () => l10n.errorUnauthorized
      ),
      'the device is offline': (
        const NetworkException(),
        () => l10n.networkError
      ),
      'something unexpected happens': (
        StateError('x'),
        () => l10n.errorProjectCreate
      ),
    };
    for (final MapEntry(key: when_, value: (error, message))
        in failures.entries) {
      blocTest<CreateProjectBloc, CreateProjectState>(
        'when $when_ then it shows the matching message',
        setUp: () => when(() => repository.createProject(any()))
            .thenThrow(error),
        build: build,
        seed: () => atReview,
        act: (bloc) => bloc.add(const CreateProjectEvent.createSubmitted()),
        skip: 1,
        expect: () => [
          atReview.copyWith(
            createStatus: GenericStatus.failure,
            createErrorMessage: message(),
          ),
        ],
      );
    }

    blocTest<CreateProjectBloc, CreateProjectState>(
      'when creating without details then nothing is sent',
      build: build,
      act: (bloc) => bloc.add(const CreateProjectEvent.createSubmitted()),
      expect: () => <CreateProjectState>[],
      verify: (_) => verifyNever(() => repository.createProject(any())),
    );

    blocTest<CreateProjectBloc, CreateProjectState>(
      'when the error has been shown then the status is reset',
      build: build,
      seed: () => atReview.copyWith(
        createStatus: GenericStatus.failure,
        createErrorMessage: 'x',
      ),
      act: (bloc) => bloc.add(const CreateProjectEvent.resetFlowStep()),
      expect: () => [atReview],
    );
  });
}
