part of 'authentication_bloc.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

@freezed
sealed class AuthenticationState with _$AuthenticationState {
  const factory AuthenticationState({
    @Default(AuthenticationStatus.unknown) AuthenticationStatus status,
    @Default(GenericStatus.initial) GenericStatus signOutStatus,
    String? signOutErrorMessage,
  }) = _AuthenticationState;
}
