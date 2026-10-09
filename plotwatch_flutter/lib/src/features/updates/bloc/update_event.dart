part of 'update_bloc.dart';

@freezed
sealed class UpdateEvent with _$UpdateEvent {
  const factory UpdateEvent.load({
    required int projectId,
    required int updateId,
  }) = _Load;
}
