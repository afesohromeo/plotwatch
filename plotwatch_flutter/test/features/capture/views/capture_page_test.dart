import 'dart:typed_data';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

import '../../../helpers/helpers.dart';

class MockCaptureBloc extends MockBloc<CaptureEvent, CaptureState>
    implements CaptureBloc {}

// Plan: doc/04d-m4-capture.md, group C: the camera with live GPS, the
// review, the sending steps, the result.
void main() {
  late AppLocalizations l10n;
  late MockCaptureBloc bloc;
  late MockCameraProvider camera;

  const previewKey = Key('test.preview');
  // A 1 × 1 transparent PNG, so Image.memory has something to decode.
  final photo = Uint8List.fromList(const [
    0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, 0x00, 0x00, 0x00, 0x0D, //
    0x49, 0x48, 0x44, 0x52, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01,
    0x08, 0x06, 0x00, 0x00, 0x00, 0x1F, 0x15, 0xC4, 0x89, 0x00, 0x00, 0x00,
    0x0D, 0x49, 0x44, 0x41, 0x54, 0x78, 0x9C, 0x63, 0x00, 0x01, 0x00, 0x00,
    0x05, 0x00, 0x01, 0x0D, 0x0A, 0x2D, 0xB4, 0x00, 0x00, 0x00, 0x00, 0x49,
    0x45, 0x4E, 0x44, 0xAE, 0x42, 0x60, 0x82,
  ]);

  setUpAll(() {
    l10n = setUpTestLocalization();
    registerFallbackValue(const CaptureEvent.retryRequested());
  });
  setUp(() {
    bloc = MockCaptureBloc();
    camera = MockCameraProvider();
    when(() => camera.preview()).thenReturn(const SizedBox(key: previewKey));
  });

  Future<void> pumpWith(
    WidgetTester tester,
    CaptureState state, {
    bool isWeb = false,
  }) {
    when(() => bloc.state).thenReturn(state);
    return tester.pumpApp(
      RepositoryProvider<CameraProvider>.value(
        value: camera,
        child: BlocProvider<CaptureBloc>.value(
          value: bloc,
          child: CapturePage(
            projectId: 1,
            stageId: 1,
            itemId: 10,
            isWeb: isWeb,
          ),
        ),
      ),
    );
  }

  final ready = CaptureState(
    projectId: 1,
    stageId: 1,
    itemId: 10,
    itemLabel: 'Wide shot',
    site: testSite(),
    loadStatus: GenericStatus.success,
    cameraAccess: CameraAccess.ready,
    locationAccess: LocationAccess.granted,
    reading: testReading(),
  );
  final reviewing = ready.copyWith(
    step: CaptureStep.review,
    photo: photo,
    shotReading: testReading(),
  );

  testWidgets('Given the page opens then it starts the camera for that item', (
    tester,
  ) async {
    await pumpWith(tester, const CaptureState());

    verify(
      () => bloc.add(
        const CaptureEvent.started(projectId: 1, stageId: 1, itemId: 10),
      ),
    ).called(1);
  });

  group('Given the camera is on', () {
    testWidgets('then the preview, the item, the accuracy and "inside the '
        'site" are shown', (tester) async {
      await pumpWith(tester, ready);

      expect(find.byKey(previewKey), findsOneWidget);
      expect(find.text('Wide shot'), findsOneWidget);
      expect(find.text(l10n.captureAccuracy(8)), findsOneWidget);
      expect(find.text(l10n.captureInsideSite), findsOneWidget);
    });

    testWidgets('when the phone is about 200 m away then it says so', (
      tester,
    ) async {
      await pumpWith(
        tester,
        ready.copyWith(
          reading: testReading().copyWith(latitude: 5.4778 + 0.0018),
        ),
      );

      expect(find.textContaining(l10n.captureOutsideSite(200)), findsOneWidget);
    });

    testWidgets('when there is no GPS fix yet then it says it is looking', (
      tester,
    ) async {
      await pumpWith(tester, ready.copyWith(reading: null));

      expect(find.text(l10n.captureNoFix), findsOneWidget);
    });

    testWidgets('when the shutter is tapped then a photo is taken', (
      tester,
    ) async {
      await pumpWith(tester, ready);

      await tester.tap(find.byKey(CapturePage.shutterKey));
      await tester.pump();

      verify(() => bloc.add(const CaptureEvent.shutterPressed())).called(1);
    });
  });

  testWidgets('Given the camera is refused then it says so and opens the '
      'settings', (tester) async {
    await pumpWith(tester, ready.copyWith(cameraAccess: CameraAccess.denied));

    expect(find.text(l10n.cameraDenied), findsOneWidget);
    expect(find.byKey(CapturePage.shutterKey), findsNothing);
    await tester.tap(find.byKey(CapturePage.allowCameraKey));
    await tester.pump();

    verify(
      () => bloc.add(const CaptureEvent.cameraSettingsRequested()),
    ).called(1);
  });

  group('Given a photo to review', () {
    testWidgets('when a caption is typed and the photo used then both are '
        'sent', (tester) async {
      await pumpWith(tester, reviewing);

      await tester.enterText(
        find.byKey(CapturePage.captionFieldKey),
        'North wall',
      );
      await tester.ensureVisible(find.byKey(CapturePage.sendKey));
      await tester.tap(find.byKey(CapturePage.sendKey));
      await tester.pump();

      verify(
        () => bloc.add(const CaptureEvent.sendRequested(caption: 'North wall')),
      ).called(1);
    });

    testWidgets('when Retake is tapped then the camera comes back', (
      tester,
    ) async {
      await pumpWith(tester, reviewing);

      await tester.ensureVisible(find.byKey(CapturePage.retakeKey));
      await tester.tap(find.byKey(CapturePage.retakeKey));
      await tester.pump();

      verify(() => bloc.add(const CaptureEvent.retakeRequested())).called(1);
    });
  });

  group('Given the photo is being sent', () {
    testWidgets('then the current step is shown', (tester) async {
      await pumpWith(
        tester,
        reviewing.copyWith(
          step: CaptureStep.sending,
          sendStep: SendStep.uploading,
          sendStatus: GenericStatus.loading,
        ),
      );

      expect(find.text(l10n.sendStepUploading), findsOneWidget);
    });

    testWidgets('when a step fails then it says why and Retry repeats it', (
      tester,
    ) async {
      await pumpWith(
        tester,
        reviewing.copyWith(
          step: CaptureStep.sending,
          sendStep: SendStep.uploading,
          sendStatus: GenericStatus.failure,
          sendErrorMessage: l10n.errorUploadFailed,
        ),
      );

      expect(find.text(l10n.errorUploadFailed), findsOneWidget);
      await tester.tap(find.byKey(CapturePage.retryKey));
      await tester.pump();

      verify(() => bloc.add(const CaptureEvent.retryRequested())).called(1);
    });
  });

  testWidgets('Given the photo was checked then the badge, each check and the '
      '"where and when, not quality" notice are shown', (tester) async {
    await pumpWith(
      tester,
      reviewing.copyWith(
        step: CaptureStep.done,
        sendStatus: GenericStatus.success,
        evidence: testEvidence(level: VerificationLevel.unverified),
      ),
    );

    expect(find.text(l10n.verificationUnverified), findsOneWidget);
    expect(find.text(l10n.checkInsideSiteFailed(137, 58)), findsOneWidget);
    expect(find.text(l10n.verificationNotice), findsOneWidget);
    expect(find.byKey(CapturePage.doneKey), findsOneWidget);
  });

  testWidgets('Given the web then photos are taken with the phone app only', (
    tester,
  ) async {
    await pumpWith(tester, const CaptureState(), isWeb: true);

    expect(find.text(l10n.capturePhoneOnly), findsOneWidget);
    verifyNever(() => bloc.add(any()));
  });
}
