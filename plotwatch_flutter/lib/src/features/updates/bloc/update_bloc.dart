import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

part 'update_event.dart';
part 'update_state.dart';
part 'update_bloc.freezed.dart';

/// One progress update, opened from the feed (UPD-02; doc/04e M5-9 b).
class UpdateBloc extends Bloc<UpdateEvent, UpdateState> {
  UpdateBloc({required this._updateRepository, required this._stageRepository})
    : super(const UpdateState()) {
    on<_Load>(_onLoad);
  }

  final UpdateRepository _updateRepository;
  final StageRepository _stageRepository;

  Future<void> _onLoad(_Load event, Emitter<UpdateState> emit) async {
    final l10n = LocalizationService.localization;
    emit(const UpdateState(loadStatus: GenericStatus.loading));
    try {
      final update = await _updateRepository.fetchUpdate(
        event.projectId,
        event.updateId,
      );
      final stageId = update.stageId;
      final stage = stageId == null
          ? null
          : await _stageRepository.fetchStage(event.projectId, stageId);
      emit(
        UpdateState(
          loadStatus: GenericStatus.success,
          update: update,
          stageName: stage?.stage.name,
        ),
      );
    } on HttpException400 catch (e) {
      emit(
        _failure(
          e.code.message(l10n),
        ).copyWith(notFound: e.code == AppErrorCode.updateNotFound),
      );
    } on HttpException401 catch (_) {
      emit(_failure(l10n.errorUnauthorized));
    } on NetworkException catch (_) {
      emit(_failure(l10n.networkError));
    } catch (e) {
      log('UpdateBloc._onLoad error: $e');
      emit(_failure(l10n.errorUpdateLoad));
    }
  }

  UpdateState _failure(String message) => state.copyWith(
    loadStatus: GenericStatus.failure,
    loadErrorMessage: message,
  );
}
