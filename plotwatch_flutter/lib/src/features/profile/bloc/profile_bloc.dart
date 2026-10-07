import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

part 'profile_event.dart';
part 'profile_state.dart';
part 'profile_bloc.freezed.dart';

/// The signed-in user's profile, provided app-wide: the profile page edits
/// it, and the app language follows it (decision M1-6).
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({required this._profileRepository})
    : super(const ProfileState()) {
    on<_FetchMe>(_onFetchMe);
    on<_UpdateMe>(_onUpdateMe);
    on<_ResetFlowStep>(_onResetFlowStep);
    on<_Reset>(_onReset);
  }

  final ProfileRepository _profileRepository;

  Future<void> _onFetchMe(_FetchMe event, Emitter<ProfileState> emit) async {
    emit(
      state.copyWith(
        profileStatus: GenericStatus.loading,
        profileErrorMessage: null,
      ),
    );
    try {
      final profile = await _profileRepository.fetchMe();
      emit(
        state.copyWith(profileStatus: GenericStatus.success, profile: profile),
      );
    } on HttpException400 catch (e) {
      emit(
        state.copyWith(
          profileStatus: GenericStatus.failure,
          profileErrorMessage: e.code.message(LocalizationService.localization),
        ),
      );
    } on HttpException401 catch (_) {
      emit(
        state.copyWith(
          profileStatus: GenericStatus.failure,
          profileErrorMessage:
              LocalizationService.localization.errorUnauthorized,
        ),
      );
    } on NetworkException catch (_) {
      emit(
        state.copyWith(
          profileStatus: GenericStatus.failure,
          profileErrorMessage: LocalizationService.localization.networkError,
        ),
      );
    } catch (e) {
      log('ProfileBloc._onFetchMe error: $e');
      emit(
        state.copyWith(
          profileStatus: GenericStatus.failure,
          profileErrorMessage:
              LocalizationService.localization.errorProfileLoad,
        ),
      );
    }
  }

  Future<void> _onUpdateMe(_UpdateMe event, Emitter<ProfileState> emit) async {
    emit(
      state.copyWith(
        flowStep: GenericFlowStep.updatingItem,
        profileActionStatus: GenericStatus.loading,
        profileActionErrorMessage: null,
      ),
    );
    try {
      final profile = await _profileRepository.updateMe(
        fullName: event.fullName,
        countryCode: event.countryCode,
        locale: event.locale,
      );
      emit(
        state.copyWith(
          profileActionStatus: GenericStatus.success,
          profile: profile,
        ),
      );
    } on HttpException400 catch (e) {
      emit(
        state.copyWith(
          profileActionStatus: GenericStatus.failure,
          profileActionErrorMessage: e.code.message(
            LocalizationService.localization,
          ),
        ),
      );
    } on HttpException401 catch (_) {
      emit(
        state.copyWith(
          profileActionStatus: GenericStatus.failure,
          profileActionErrorMessage:
              LocalizationService.localization.errorUnauthorized,
        ),
      );
    } on NetworkException catch (_) {
      emit(
        state.copyWith(
          profileActionStatus: GenericStatus.failure,
          profileActionErrorMessage:
              LocalizationService.localization.networkError,
        ),
      );
    } catch (e) {
      log('ProfileBloc._onUpdateMe error: $e');
      emit(
        state.copyWith(
          profileActionStatus: GenericStatus.failure,
          profileActionErrorMessage:
              LocalizationService.localization.errorProfileSave,
        ),
      );
    }
  }

  void _onResetFlowStep(_ResetFlowStep event, Emitter<ProfileState> emit) {
    emit(
      state.copyWith(
        flowStep: GenericFlowStep.none,
        profileActionStatus: GenericStatus.initial,
        profileActionErrorMessage: null,
      ),
    );
  }

  void _onReset(_Reset event, Emitter<ProfileState> emit) {
    emit(const ProfileState());
  }
}
