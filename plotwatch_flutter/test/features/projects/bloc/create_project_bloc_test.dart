import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

import '../../../helpers/helpers.dart';

// Plans: doc/04b-m2-projects-site-members.md, group E (one create request,
// decision M2-3); doc/04c-m3-stages.md, group C (the Stages step: the chosen
// template's stages are created with the project, decision M3-3).
void main() {
  late AppLocalizations l10n;
  late MockProjectRepository repository;

  setUpAll(() {
    l10n = setUpTestLocalization();
    registerFallbackValue(testDetails);
    registerFallbackValue(<StageDraft>[]);
  });
  setUp(() => repository = MockProjectRepository());

  CreateProjectBloc build() => CreateProjectBloc(projectRepository: repository);

  final atStages = CreateProjectState(
    step: CreateProjectStep.stages,
    details: testDetails,
  );
  final atReview = atStages.copyWith(step: CreateProjectStep.review);

  group('Given the create-project wizard', () {
    blocTest<CreateProjectBloc, CreateProjectState>(
      'when the details are submitted then it moves to the stages step, '
      'with the single-storey house chosen',
      build: build,
      act: (bloc) =>
          bloc.add(CreateProjectEvent.detailsSubmitted(details: testDetails)),
      expect: () => [atStages],
      verify: (bloc) =>
          expect(bloc.state.template, StageTemplate.singleStoreyHouse),
    );

    blocTest<CreateProjectBloc, CreateProjectState>(
      'when a template is chosen then it is kept',
      build: build,
      seed: () => atStages,
      act: (bloc) => bloc.add(
        const CreateProjectEvent.templateChosen(
          template: StageTemplate.renovation,
        ),
      ),
      expect: () => [atStages.copyWith(template: StageTemplate.renovation)],
    );

    blocTest<CreateProjectBloc, CreateProjectState>(
      'when the stages are confirmed then it moves to the review step',
      build: build,
      seed: () => atStages,
      act: (bloc) => bloc.add(const CreateProjectEvent.stagesSubmitted()),
      expect: () => [atReview],
    );

    blocTest<CreateProjectBloc, CreateProjectState>(
      'when going back from the review then it returns to the stages, and '
      'from the stages to the details, keeping what was entered',
      build: build,
      seed: () => atReview.copyWith(template: StageTemplate.renovation),
      act: (bloc) => bloc
        ..add(const CreateProjectEvent.stepBack())
        ..add(const CreateProjectEvent.stepBack()),
      expect: () => [
        atStages.copyWith(template: StageTemplate.renovation),
        CreateProjectState(
          details: testDetails,
          template: StageTemplate.renovation,
        ),
      ],
    );

    final created = testOverview(stageCount: 10);
    blocTest<CreateProjectBloc, CreateProjectState>(
      'when the project is created then the template\'s stages go with it '
      'and the new project is kept',
      setUp: () => when(
        () =>
            repository.createProject(testDetails, stages: any(named: 'stages')),
      ).thenAnswer((_) async => created),
      build: build,
      seed: () => atReview,
      act: (bloc) => bloc.add(const CreateProjectEvent.createSubmitted()),
      expect: () => [
        atReview.copyWith(createStatus: GenericStatus.loading),
        atReview.copyWith(
          createStatus: GenericStatus.success,
          created: created,
        ),
      ],
      verify: (_) {
        final stages =
            verify(
                  () => repository.createProject(
                    testDetails,
                    stages: captureAny(named: 'stages'),
                  ),
                ).captured.single
                as List<StageDraft>;
        expect(
          stages.map((s) => s.name),
          StageTemplate.singleStoreyHouse.stages(l10n).map((s) => s.name),
        );
      },
    );

    blocTest<CreateProjectBloc, CreateProjectState>(
      'when Custom was chosen then the project is created without stages',
      setUp: () => when(
        () =>
            repository.createProject(testDetails, stages: any(named: 'stages')),
      ).thenAnswer((_) async => created),
      build: build,
      seed: () => atReview.copyWith(template: StageTemplate.custom),
      act: (bloc) => bloc.add(const CreateProjectEvent.createSubmitted()),
      verify: (_) => expect(
        verify(
          () => repository.createProject(
            testDetails,
            stages: captureAny(named: 'stages'),
          ),
        ).captured.single,
        isEmpty,
      ),
    );

    final failures = <String, (Object, String Function())>{
      'the server refuses the name': (
        const HttpException400(code: AppErrorCode.invalidProjectName),
        () => l10n.errorInvalidProjectName,
      ),
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
        () => l10n.errorProjectCreate,
      ),
    };
    for (final MapEntry(key: when_, value: (error, message))
        in failures.entries) {
      blocTest<CreateProjectBloc, CreateProjectState>(
        'when $when_ then it shows the matching message',
        setUp: () => when(
          () => repository.createProject(any(), stages: any(named: 'stages')),
        ).thenThrow(error),
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
      verify: (_) => verifyNever(
        () => repository.createProject(any(), stages: any(named: 'stages')),
      ),
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
