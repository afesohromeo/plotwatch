import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

part 'evidence_media_event.dart';
part 'evidence_media_state.dart';
part 'evidence_media_bloc.freezed.dart';

/// Loads capture photos and thumbnails through the server and keeps them
/// while the page is open (doc/04d M4-4). One per page that shows photos.
class EvidenceMediaBloc extends Bloc<EvidenceMediaEvent, EvidenceMediaState> {
  EvidenceMediaBloc({required this._evidenceRepository})
    : super(const EvidenceMediaState()) {
    on<_Requested>(_onRequested);
  }

  final EvidenceRepository _evidenceRepository;

  Future<void> _onRequested(
    _Requested event,
    Emitter<EvidenceMediaState> emit,
  ) async {
    final key = EvidenceMediaState.keyFor(event.evidenceId, event.variant);
    if (state.images.containsKey(key) || state.loading.contains(key)) return;

    emit(
      state.copyWith(
        loading: {...state.loading, key},
        failed: {...state.failed}..remove(key),
      ),
    );
    try {
      final bytes = await _evidenceRepository.media(
        event.projectId,
        event.evidenceId,
        event.variant,
      );
      emit(
        state.copyWith(
          images: {...state.images, key: bytes},
          loading: {...state.loading}..remove(key),
        ),
      );
    } catch (e) {
      log('EvidenceMediaBloc._onRequested error: $e');
      emit(
        state.copyWith(
          failed: {...state.failed, key},
          loading: {...state.loading}..remove(key),
        ),
      );
    }
  }
}
