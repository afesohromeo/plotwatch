part of 'update_form_bloc.dart';

@freezed
sealed class UpdateFormState with _$UpdateFormState {
  const factory UpdateFormState({
    int? projectId,

    /// For the stage picker, in plan order.
    @Default([]) List<Stage> stages,
    @Default(GenericStatus.initial) GenericStatus loadStatus,
    String? loadErrorMessage,
    @Default(GenericStatus.initial) GenericStatus actionStatus,
    String? actionErrorMessage,

    /// The update as the server saved it.
    ProgressUpdate? saved,
  }) = _UpdateFormState;
}
