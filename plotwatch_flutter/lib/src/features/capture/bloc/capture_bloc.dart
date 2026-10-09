import 'dart:async';
import 'dart:developer';
import 'dart:math' as math;
import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

part 'capture_event.dart';
part 'capture_state.dart';
part 'capture_bloc.freezed.dart';

/// The site manager takes a photo for a checklist item with the in-app
/// camera while the GPS is shown live, reviews it and sends it: commit →
/// upload → finalize, retrying only the step that failed (CAP-01–06;
/// doc/04d M4-2, M4-3, M4-8).
class CaptureBloc extends Bloc<CaptureEvent, CaptureState> {
  CaptureBloc({
    required this._cameraProvider,
    required this._locationProvider,
    required this._deviceInfoProvider,
    required this._evidenceRepository,
    required this._projectRepository,
    required this._stageRepository,
    DateTime Function()? now,
  }) : _now = now ?? (() => DateTime.now().toUtc()),
       super(const CaptureState()) {
    on<_Started>(_onStarted);
    on<_CameraSettingsRequested>(_onCameraSettingsRequested);
    on<_ShutterPressed>(_onShutterPressed);
    on<_RetakeRequested>(_onRetakeRequested);
    on<_SendRequested>(_onSendRequested);
    on<_RetryRequested>(_onRetryRequested);
  }

  final CameraProvider _cameraProvider;
  final LocationProvider _locationProvider;
  final DeviceInfoProvider _deviceInfoProvider;
  final EvidenceRepository _evidenceRepository;
  final ProjectRepository _projectRepository;
  final StageRepository _stageRepository;
  final DateTime Function() _now;

  /// Loads the site and the item, opens the camera, then follows the GPS
  /// for as long as the screen is open.
  Future<void> _onStarted(_Started event, Emitter<CaptureState> emit) async {
    final l10n = LocalizationService.localization;
    emit(
      CaptureState(
        projectId: event.projectId,
        stageId: event.stageId,
        itemId: event.itemId,
        loadStatus: GenericStatus.loading,
      ),
    );
    try {
      final overview = await _projectRepository.fetchProject(event.projectId);
      final stage = await _stageRepository.fetchStage(
        event.projectId,
        event.stageId,
      );
      final item = stage.items.where((i) => i.id == event.itemId).firstOrNull;
      emit(
        state.copyWith(
          loadStatus: GenericStatus.success,
          site: overview.site,
          itemLabel: item?.label,
        ),
      );
    } on HttpException400 catch (e) {
      emit(_loadFailure(e.code.message(l10n)));
      return;
    } on NetworkException catch (_) {
      emit(_loadFailure(l10n.networkError));
      return;
    } catch (e) {
      log('CaptureBloc._onStarted error: $e');
      emit(_loadFailure(l10n.errorStagesLoad));
      return;
    }

    emit(state.copyWith(cameraAccess: await _cameraProvider.open()));
    try {
      emit(state.copyWith(device: await _deviceInfoProvider.details()));
    } catch (e) {
      // Sent as "Unknown" rather than blocking the photo.
      log('CaptureBloc device details error: $e');
    }

    final access = await _locationProvider.ensureAccess();
    emit(state.copyWith(locationAccess: access));
    if (access != LocationAccess.granted) return;
    await emit.forEach<GpsReading>(
      _locationProvider.readings(),
      onData: (reading) => state.copyWith(reading: reading),
      onError: (error, _) {
        log('CaptureBloc readings error: $error');
        return state.copyWith(reading: null);
      },
    );
  }

  Future<void> _onCameraSettingsRequested(
    _CameraSettingsRequested event,
    Emitter<CaptureState> emit,
  ) => _cameraProvider.openSettings();

  /// Keeps the photo, its time and the position at that moment (CAP-03).
  Future<void> _onShutterPressed(
    _ShutterPressed event,
    Emitter<CaptureState> emit,
  ) async {
    if (!state.canShoot) return;
    try {
      final photo = await _cameraProvider.takePicture();
      emit(
        state.copyWith(
          step: CaptureStep.review,
          photo: photo,
          takenAt: _now(),
          shotReading: state.reading,
        ),
      );
    } catch (e) {
      log('CaptureBloc._onShutterPressed error: $e');
      emit(state.copyWith(cameraAccess: CameraAccess.unavailable));
    }
  }

  void _onRetakeRequested(_RetakeRequested event, Emitter<CaptureState> emit) {
    emit(
      state.copyWith(
        step: CaptureStep.camera,
        photo: null,
        takenAt: null,
        shotReading: null,
      ),
    );
  }

  Future<void> _onSendRequested(
    _SendRequested event,
    Emitter<CaptureState> emit,
  ) async {
    final caption = event.caption?.trim();
    emit(state.copyWith(caption: (caption?.isEmpty ?? true) ? null : caption));
    await _send(emit);
  }

  Future<void> _onRetryRequested(
    _RetryRequested event,
    Emitter<CaptureState> emit,
  ) => _send(emit);

  /// Runs the steps not done yet, so a retry repeats only the failed one.
  Future<void> _send(Emitter<CaptureState> emit) async {
    final projectId = state.projectId;
    final photo = state.photo;
    if (projectId == null || photo == null) return;

    final l10n = LocalizationService.localization;
    emit(
      state.copyWith(
        step: CaptureStep.sending,
        sendStatus: GenericStatus.loading,
        sendErrorMessage: null,
      ),
    );
    try {
      var committed = state.committed;
      if (committed == null) {
        emit(state.copyWith(sendStep: SendStep.committing));
        committed = await _evidenceRepository.commit(projectId, _commit(photo));
        emit(state.copyWith(committed: committed));
      }
      final evidenceId = committed.evidence.id!;
      if (!state.uploaded) {
        emit(state.copyWith(sendStep: SendStep.uploading));
        // After a failure the first description may be used up or expired.
        final description = state.uploadFailed
            ? await _evidenceRepository.uploadDescription(projectId, evidenceId)
            : committed.uploadDescription;
        await _evidenceRepository.upload(description, photo);
        emit(state.copyWith(uploaded: true));
      }
      emit(state.copyWith(sendStep: SendStep.checking));
      final evidence = await _evidenceRepository.finalize(
        projectId,
        evidenceId,
      );
      emit(
        state.copyWith(
          step: CaptureStep.done,
          sendStatus: GenericStatus.success,
          evidence: evidence,
        ),
      );
    } on UploadException catch (_) {
      emit(_sendFailure(l10n.errorUploadFailed, uploadFailed: true));
    } on HttpException400 catch (e) {
      // The photo didn't reach the storage: upload it again on retry.
      final missing = e.code == AppErrorCode.uploadMissing;
      emit(
        _sendFailure(
          e.code.message(l10n),
          uploadFailed: missing,
          uploaded: missing ? false : null,
        ),
      );
    } on HttpException401 catch (_) {
      emit(_sendFailure(l10n.errorUnauthorized));
    } on NetworkException catch (_) {
      emit(_sendFailure(l10n.networkError));
    } catch (e) {
      log('CaptureBloc._send error: $e');
      emit(_sendFailure(l10n.errorCaptureSend));
    }
  }

  /// What the phone recorded for the photo (CAP-03, decision M4-2).
  EvidenceCommit _commit(Uint8List photo) {
    final reading = state.shotReading;
    final device = state.device;
    return EvidenceCommit(
      stageId: state.stageId!,
      checklistItemId: state.itemId!,
      sha256: sha256Hex(photo),
      deviceCapturedAt: state.takenAt ?? _now(),
      lat: reading?.latitude,
      lng: reading?.longitude,
      accuracyM: reading?.accuracyM,
      isMockLocation: reading?.isMocked,
      capturedInApp: true,
      deviceModel: device?.model ?? 'Unknown',
      osVersion: device?.osVersion ?? 'Unknown',
      appVersion: device?.appVersion ?? 'Unknown',
      caption: state.caption,
    );
  }

  CaptureState _loadFailure(String message) => state.copyWith(
    loadStatus: GenericStatus.failure,
    loadErrorMessage: message,
  );

  CaptureState _sendFailure(
    String message, {
    bool uploadFailed = false,
    bool? uploaded,
  }) => state.copyWith(
    sendStatus: GenericStatus.failure,
    sendErrorMessage: message,
    uploadFailed: uploadFailed || state.uploadFailed,
    uploaded: uploaded ?? state.uploaded,
  );

  @override
  Future<void> close() async {
    await _cameraProvider.close();
    return super.close();
  }
}

/// Distance in metres from [reading] to the centre of [site].
double _distance(GpsReading reading, Site site) => distanceMeters(
  reading.latitude,
  reading.longitude,
  site.centerLat,
  site.centerLng,
);

/// The server's tolerance for the inside-site check (V4): the radius plus
/// the accuracy, capped at 30 m (doc/02 §8.2, §8.4).
double _allowed(GpsReading reading, Site site) =>
    site.radiusM + math.min(reading.accuracyM, 30).toDouble();
