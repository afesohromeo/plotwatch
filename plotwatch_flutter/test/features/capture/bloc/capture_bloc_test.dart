import 'dart:async';
import 'dart:typed_data';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

import '../../../helpers/helpers.dart';

// Plan: doc/04d-m4-capture.md, group C (decisions M4-2, M4-3, M4-8): the
// camera with live GPS, the shot, the review, and commit → upload →
// finalize with a retry of the step that failed.
void main() {
  late AppLocalizations l10n;
  late MockCameraProvider camera;
  late MockLocationProvider location;
  late MockDeviceInfoProvider deviceInfo;
  late MockEvidenceRepository evidenceRepository;
  late MockProjectRepository projectRepository;
  late MockStageRepository stageRepository;

  final photo = Uint8List.fromList(List.generate(64, (i) => i));
  final shotAt = DateTime.utc(2026, 10, 9, 9, 30);
  const device = DeviceDetails(
    model: 'Google Pixel 7',
    osVersion: 'Android 15',
    appVersion: '1.0.0+1',
  );
  final site = testSite();
  final insideReading = testReading();
  // About 200 m north of the site centre.
  final outsideReading = testReading().copyWith(latitude: 5.4778 + 0.0018);
  final committed = EvidenceCommitResult(
    evidence: testEvidence(status: EvidenceStatus.committed),
    uploadDescription: 'upload-1',
  );
  final finalized = testEvidence();

  setUpAll(() {
    l10n = setUpTestLocalization();
    registerFallbackValue(testEvidenceCommit());
    registerFallbackValue(Uint8List(0));
  });

  setUp(() {
    camera = MockCameraProvider();
    location = MockLocationProvider();
    deviceInfo = MockDeviceInfoProvider();
    evidenceRepository = MockEvidenceRepository();
    projectRepository = MockProjectRepository();
    stageRepository = MockStageRepository();
    when(() => camera.close()).thenAnswer((_) async {});
  });

  CaptureBloc build() => CaptureBloc(
    cameraProvider: camera,
    locationProvider: location,
    deviceInfoProvider: deviceInfo,
    evidenceRepository: evidenceRepository,
    projectRepository: projectRepository,
    stageRepository: stageRepository,
    now: () => shotAt,
  );

  /// Ready to shoot: loaded, camera on, a reading inside the site.
  final ready = CaptureState(
    projectId: 1,
    stageId: 1,
    itemId: 10,
    itemLabel: 'Wide shot',
    site: site,
    device: device,
    loadStatus: GenericStatus.success,
    cameraAccess: CameraAccess.ready,
    locationAccess: LocationAccess.granted,
    reading: insideReading,
  );
  final reviewing = ready.copyWith(
    step: CaptureStep.review,
    photo: photo,
    takenAt: shotAt,
    shotReading: insideReading,
  );

  group('Given the capture screen opens', () {
    blocTest<CaptureBloc, CaptureState>(
      'when everything is allowed then the camera is on and the GPS readings '
      'arrive',
      setUp: () {
        when(
          () => projectRepository.fetchProject(1),
        ).thenAnswer((_) async => testOverview(site: site));
        when(
          () => stageRepository.fetchStage(1, 1),
        ).thenAnswer((_) async => testStageView(id: 1).copyWith());
        when(() => camera.open()).thenAnswer((_) async => CameraAccess.ready);
        when(() => deviceInfo.details()).thenAnswer((_) async => device);
        when(
          () => location.ensureAccess(),
        ).thenAnswer((_) async => LocationAccess.granted);
        when(
          () => location.readings(),
        ).thenAnswer((_) => Stream.value(insideReading));
      },
      build: build,
      act: (bloc) => bloc.add(
        const CaptureEvent.started(projectId: 1, stageId: 1, itemId: 10),
      ),
      verify: (bloc) {
        final state = bloc.state;
        expect(state.loadStatus, GenericStatus.success);
        expect(state.site, site);
        expect(state.itemLabel, 'Wide shot');
        expect(state.cameraAccess, CameraAccess.ready);
        expect(state.locationAccess, LocationAccess.granted);
        expect(state.reading, insideReading);
        expect(state.isInsideSite, isTrue);
        expect(state.canShoot, isTrue);
      },
    );

    blocTest<CaptureBloc, CaptureState>(
      'when the camera is refused then it says so and nothing can be shot',
      setUp: () {
        when(
          () => projectRepository.fetchProject(1),
        ).thenAnswer((_) async => testOverview(site: site));
        when(
          () => stageRepository.fetchStage(1, 1),
        ).thenAnswer((_) async => testStageView(id: 1));
        when(() => camera.open()).thenAnswer((_) async => CameraAccess.denied);
        when(() => deviceInfo.details()).thenAnswer((_) async => device);
        when(
          () => location.ensureAccess(),
        ).thenAnswer((_) async => LocationAccess.denied);
      },
      build: build,
      act: (bloc) => bloc.add(
        const CaptureEvent.started(projectId: 1, stageId: 1, itemId: 10),
      ),
      verify: (bloc) {
        expect(bloc.state.cameraAccess, CameraAccess.denied);
        expect(bloc.state.canShoot, isFalse);
      },
    );

    blocTest<CaptureBloc, CaptureState>(
      'when the stage cannot be loaded then it says so',
      setUp: () {
        when(
          () => projectRepository.fetchProject(1),
        ).thenAnswer((_) async => testOverview(site: site));
        when(
          () => stageRepository.fetchStage(1, 1),
        ).thenThrow(const NetworkException());
      },
      build: build,
      act: (bloc) => bloc.add(
        const CaptureEvent.started(projectId: 1, stageId: 1, itemId: 10),
      ),
      verify: (bloc) {
        expect(bloc.state.loadStatus, GenericStatus.failure);
        expect(bloc.state.loadErrorMessage, l10n.networkError);
        verifyNever(() => camera.open());
      },
    );
  });

  group('Given the GPS position', () {
    test('when it is about 200 m away then it is outside the site', () {
      final outside = ready.copyWith(reading: outsideReading);

      expect(outside.isInsideSite, isFalse);
      expect(outside.distanceFromSiteM, closeTo(200, 2));
    });

    test('when there is no reading yet then inside or outside is unknown', () {
      expect(ready.copyWith(reading: null).isInsideSite, isNull);
    });
  });

  group('Given the camera is on', () {
    blocTest<CaptureBloc, CaptureState>(
      'when the shutter is pressed then the photo, its time and the position '
      'at that moment are kept for review',
      setUp: () =>
          when(() => camera.takePicture()).thenAnswer((_) async => photo),
      build: build,
      seed: () => ready,
      act: (bloc) => bloc.add(const CaptureEvent.shutterPressed()),
      expect: () => [reviewing],
    );

    blocTest<CaptureBloc, CaptureState>(
      'when the photo is retaken then the camera comes back',
      build: build,
      seed: () => reviewing,
      act: (bloc) => bloc.add(const CaptureEvent.retakeRequested()),
      expect: () => [ready],
    );
  });

  group('Given a photo to send', () {
    void stubSend() {
      when(
        () => evidenceRepository.commit(1, any()),
      ).thenAnswer((_) async => committed);
      when(
        () => evidenceRepository.upload('upload-1', photo),
      ).thenAnswer((_) async {});
      when(
        () => evidenceRepository.finalize(1, 9),
      ).thenAnswer((_) async => finalized);
    }

    blocTest<CaptureBloc, CaptureState>(
      'when it is sent then it is committed with its hash and metadata, '
      'uploaded and checked',
      setUp: stubSend,
      build: build,
      seed: () => reviewing,
      act: (bloc) =>
          bloc.add(const CaptureEvent.sendRequested(caption: '  North wall ')),
      verify: (bloc) {
        final sent =
            verify(
                  () => evidenceRepository.commit(1, captureAny()),
                ).captured.single
                as EvidenceCommit;
        expect(sent.stageId, 1);
        expect(sent.checklistItemId, 10);
        expect(sent.sha256, sha256Hex(photo));
        expect(sent.deviceCapturedAt, shotAt);
        expect(sent.lat, insideReading.latitude);
        expect(sent.lng, insideReading.longitude);
        expect(sent.accuracyM, insideReading.accuracyM);
        expect(sent.isMockLocation, isFalse);
        expect(sent.capturedInApp, isTrue);
        expect(sent.deviceModel, 'Google Pixel 7');
        expect(sent.osVersion, 'Android 15');
        expect(sent.appVersion, '1.0.0+1');
        expect(sent.caption, 'North wall');
        verify(() => evidenceRepository.upload('upload-1', photo)).called(1);
        expect(bloc.state.step, CaptureStep.done);
        expect(bloc.state.evidence, finalized);
      },
    );

    blocTest<CaptureBloc, CaptureState>(
      'when there was no GPS fix then it is sent without a position (M4-8)',
      setUp: stubSend,
      build: build,
      seed: () => reviewing.copyWith(shotReading: null),
      act: (bloc) => bloc.add(const CaptureEvent.sendRequested()),
      verify: (_) {
        final sent =
            verify(
                  () => evidenceRepository.commit(1, captureAny()),
                ).captured.single
                as EvidenceCommit;
        expect(sent.lat, isNull);
        expect(sent.accuracyM, isNull);
      },
    );

    blocTest<CaptureBloc, CaptureState>(
      'when the upload fails then it stops there, and Retry uploads again '
      'with a new description before checking',
      setUp: () {
        stubSend();
        var uploads = 0;
        when(() => evidenceRepository.upload(any(), photo)).thenAnswer((_) async {
          if (uploads++ == 0) throw const UploadException();
        });
        when(
          () => evidenceRepository.uploadDescription(1, 9),
        ).thenAnswer((_) async => 'upload-2');
      },
      build: build,
      seed: () => reviewing,
      act: (bloc) async {
        bloc.add(const CaptureEvent.sendRequested());
        await Future<void>.delayed(Duration.zero);
        expect(bloc.state.sendStatus, GenericStatus.failure);
        expect(bloc.state.sendStep, SendStep.uploading);
        expect(bloc.state.sendErrorMessage, l10n.errorUploadFailed);
        bloc.add(const CaptureEvent.retryRequested());
      },
      verify: (bloc) {
        verify(() => evidenceRepository.commit(1, any())).called(1);
        verify(() => evidenceRepository.upload('upload-2', photo)).called(1);
        expect(bloc.state.step, CaptureStep.done);
      },
    );

    blocTest<CaptureBloc, CaptureState>(
      'when the check fails on the network then Retry only checks again',
      setUp: () {
        stubSend();
        var finalizes = 0;
        when(() => evidenceRepository.finalize(1, 9)).thenAnswer((_) async {
          if (finalizes++ == 0) throw const NetworkException();
          return finalized;
        });
      },
      build: build,
      seed: () => reviewing,
      act: (bloc) async {
        bloc.add(const CaptureEvent.sendRequested());
        await Future<void>.delayed(Duration.zero);
        expect(bloc.state.sendStep, SendStep.checking);
        expect(bloc.state.sendErrorMessage, l10n.networkError);
        bloc.add(const CaptureEvent.retryRequested());
      },
      verify: (bloc) {
        verify(() => evidenceRepository.commit(1, any())).called(1);
        verify(() => evidenceRepository.upload(any(), any())).called(1);
        verify(() => evidenceRepository.finalize(1, 9)).called(2);
        expect(bloc.state.evidence, finalized);
      },
    );

    blocTest<CaptureBloc, CaptureState>(
      'when the server says the photo did not arrive then Retry uploads it '
      'again',
      setUp: () {
        stubSend();
        var finalizes = 0;
        when(() => evidenceRepository.finalize(1, 9)).thenAnswer((_) async {
          if (finalizes++ == 0) {
            throw const HttpException400(code: AppErrorCode.uploadMissing);
          }
          return finalized;
        });
        when(
          () => evidenceRepository.uploadDescription(1, 9),
        ).thenAnswer((_) async => 'upload-2');
        when(
          () => evidenceRepository.upload('upload-2', photo),
        ).thenAnswer((_) async {});
      },
      build: build,
      seed: () => reviewing,
      act: (bloc) async {
        bloc.add(const CaptureEvent.sendRequested());
        await Future<void>.delayed(Duration.zero);
        bloc.add(const CaptureEvent.retryRequested());
      },
      verify: (bloc) {
        verify(() => evidenceRepository.upload('upload-2', photo)).called(1);
        expect(bloc.state.step, CaptureStep.done);
      },
    );

    blocTest<CaptureBloc, CaptureState>(
      'when the stage was submitted meanwhile then it shows why',
      setUp: () => when(
        () => evidenceRepository.commit(any(), any()),
      ).thenThrow(const HttpException400(code: AppErrorCode.stageLocked)),
      build: build,
      seed: () => reviewing,
      act: (bloc) => bloc.add(const CaptureEvent.sendRequested()),
      verify: (bloc) {
        expect(bloc.state.sendStatus, GenericStatus.failure);
        expect(bloc.state.sendStep, SendStep.committing);
        expect(bloc.state.sendErrorMessage, l10n.errorStageLocked);
      },
    );
  });

  blocTest<CaptureBloc, CaptureState>(
    'Given the screen closes then the camera is released',
    build: build,
    // blocTest closes the bloc itself after the test.
    verify: (_) => verify(() => camera.close()).called(1),
  );
}
