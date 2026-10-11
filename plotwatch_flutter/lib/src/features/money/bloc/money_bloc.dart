import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

part 'money_event.dart';
part 'money_state.dart';
part 'money_bloc.freezed.dart';

const kLedgerPageSize = 20;

/// The Money tab (doc/04f M6-10): the summary, the entries as an infinite
/// list filtered on the server, both refreshed live when a release, an
/// expense, a confirmation or a reversal happens on the project.
class MoneyBloc extends Bloc<MoneyEvent, MoneyState> {
  MoneyBloc({
    required this._ledgerRepository,
    required this._activityRepository,
  }) : super(const MoneyState()) {
    on<_Load>(_onLoad);
    on<_FetchEntries>(_onFetchEntries);
    on<_RefreshEntries>(_onRefreshEntries);
    on<_LiveUpdateReceived>(_onLiveUpdateReceived);
  }

  final LedgerRepository _ledgerRepository;
  final ActivityRepository _activityRepository;
  StreamSubscription<LiveUpdate<ActivityEntry>>? _live;

  Future<void> _onLoad(_Load event, Emitter<MoneyState> emit) async {
    emit(
      state.copyWith(
        projectId: event.projectId,
        summaryStatus: state.summary == null
            ? GenericStatus.loading
            : state.summaryStatus,
        summaryError: null,
      ),
    );
    await _loadSummary(event.projectId, emit);
    // Only what happens from now on: the summary was just read.
    _live ??= _activityRepository
        .watchActivity(event.projectId)
        .listen(
          (update) => add(MoneyEvent.liveUpdateReceived(update)),
          onError: (Object e) => log('MoneyBloc live stream ended: $e'),
        );
  }

  Future<void> _loadSummary(int projectId, Emitter<MoneyState> emit) async {
    final l10n = LocalizationService.localization;
    try {
      final summary = await _ledgerRepository.fetchSummary(projectId);
      emit(
        state.copyWith(summary: summary, summaryStatus: GenericStatus.success),
      );
    } on HttpException400 catch (e) {
      emit(_summaryFailure(e.code.message(l10n)));
    } on HttpException401 catch (_) {
      emit(_summaryFailure(l10n.errorUnauthorized));
    } on NetworkException catch (_) {
      emit(_summaryFailure(l10n.networkError));
    } catch (e) {
      log('MoneyBloc._loadSummary error: $e');
      emit(_summaryFailure(l10n.errorLedgerLoad));
    }
  }

  Future<void> _onFetchEntries(
    _FetchEntries event,
    Emitter<MoneyState> emit,
  ) async {
    final l10n = LocalizationService.localization;
    final size = event.size ?? kLedgerPageSize;
    emit(
      state.copyWith(
        projectId: event.projectId,
        entriesListStatus: GenericStatus.loading,
        entriesListError: null,
        entries: event.pageKey == 0 ? [] : state.entries,
        entriesRefreshController: false,
      ),
    );
    try {
      final result = await _ledgerRepository.fetchEntries(
        event.projectId,
        beforeId: event.pageKey == 0 ? null : event.pageKey,
        size: size,
        kind: event.kind,
        stageId: event.stageId,
      );
      final page = result.content;
      emit(
        state.copyWith(
          entriesListStatus: GenericStatus.success,
          paginatedEntries: page,
          maxEntries: page.length < (result.pagination.size ?? size),
          entriesPageKey: page.isEmpty ? event.pageKey : page.last.id!,
          entries: [...state.entries, ...page],
        ),
      );
    } on HttpException400 catch (e) {
      emit(_entriesFailure(e.code.message(l10n)));
    } on HttpException401 catch (_) {
      emit(_entriesFailure(l10n.errorUnauthorized));
    } on NetworkException catch (_) {
      emit(_entriesFailure(l10n.networkError));
    } catch (e) {
      log('MoneyBloc._onFetchEntries error: $e');
      emit(_entriesFailure(l10n.errorLedgerLoad));
    }
  }

  void _onRefreshEntries(_RefreshEntries event, Emitter<MoneyState> emit) {
    emit(
      state.copyWith(
        entriesListStatus: GenericStatus.initial,
        entries: [],
        paginatedEntries: [],
        entriesPageKey: 0,
        maxEntries: false,
        entriesRefreshController: true,
      ),
    );
  }

  Future<void> _onLiveUpdateReceived(
    _LiveUpdateReceived event,
    Emitter<MoneyState> emit,
  ) async {
    switch (event.update) {
      case LiveItem(:final item):
        emit(state.copyWith(reconnecting: false));
        final projectId = state.projectId;
        if (projectId == null ||
            !ActivityKind.money.types.contains(item.event.type)) {
          return;
        }
        await _loadSummary(projectId, emit);
        add(const MoneyEvent.refreshEntries());
      case LiveReconnecting():
        emit(state.copyWith(reconnecting: true));
      case LiveConnected():
        emit(state.copyWith(reconnecting: false));
    }
  }

  MoneyState _summaryFailure(String message) => state.copyWith(
    summaryStatus: GenericStatus.failure,
    summaryError: message,
  );

  MoneyState _entriesFailure(String message) => state.copyWith(
    entriesListStatus: GenericStatus.failure,
    entriesListError: message,
  );

  @override
  Future<void> close() async {
    await _live?.cancel();
    return super.close();
  }
}
