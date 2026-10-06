part of 'profile_bloc.dart';

@freezed
sealed class ProfileState with _$ProfileState {
  const ProfileState._();

  const factory ProfileState({
    MyProfile? profile,
    @Default(GenericStatus.initial) GenericStatus profileStatus,
    @Default(GenericStatus.initial) GenericStatus profileActionStatus,
    @Default(GenericFlowStep.none) GenericFlowStep flowStep,
    String? profileErrorMessage,
    String? profileActionErrorMessage,
  }) = _ProfileState;

  /// The app language: the profile's once loaded, else `null` so the app
  /// follows the device (EN or FR, otherwise EN) — decision M1-6.
  Locale? get appLocale => profile == null ? null : Locale(profile!.locale);
}
