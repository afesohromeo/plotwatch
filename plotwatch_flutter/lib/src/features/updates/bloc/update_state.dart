part of 'update_bloc.dart';

@freezed
sealed class UpdateState with _$UpdateState {
  const factory UpdateState({
    ProgressUpdate? update,

    /// The stage it is about, if any.
    String? stageName,
    @Default(GenericStatus.initial) GenericStatus loadStatus,
    String? loadErrorMessage,
  }) = _UpdateState;
}
