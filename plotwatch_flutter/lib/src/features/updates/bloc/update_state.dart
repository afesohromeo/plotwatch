part of 'update_bloc.dart';

@freezed
sealed class UpdateState with _$UpdateState {
  const factory UpdateState({
    ProgressUpdate? update,

    /// The stage it is about, if any.
    String? stageName,
    @Default(GenericStatus.initial) GenericStatus loadStatus,
    String? loadErrorMessage,

    /// The update is gone (or never was): the page says so and offers the
    /// way back instead of Retry (doc/05 §9.6).
    @Default(false) bool notFound,
  }) = _UpdateState;
}
