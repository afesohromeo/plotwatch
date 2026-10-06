// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'authentication_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthenticationEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthenticationEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'AuthenticationEvent()';
}


}

/// @nodoc
class $AuthenticationEventCopyWith<$Res>  {
$AuthenticationEventCopyWith(AuthenticationEvent _, $Res Function(AuthenticationEvent) __);
}


/// Adds pattern-matching-related methods to [AuthenticationEvent].
extension AuthenticationEventPatterns on AuthenticationEvent {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _SignOutRequested value)?  signOutRequested,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _SignOutRequested() when signOutRequested != null:
return signOutRequested(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _SignOutRequested value)  signOutRequested,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _SignOutRequested():
return signOutRequested(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _SignOutRequested value)?  signOutRequested,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _SignOutRequested() when signOutRequested != null:
return signOutRequested(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function()?  signOutRequested,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _SignOutRequested() when signOutRequested != null:
return signOutRequested();case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function()  signOutRequested,}) {final _that = this;
switch (_that) {
case _Started():
return started();case _SignOutRequested():
return signOutRequested();}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function()?  signOutRequested,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _SignOutRequested() when signOutRequested != null:
return signOutRequested();case _:
  return null;

}
}

}

/// @nodoc


class _Started implements AuthenticationEvent {
  const _Started();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'AuthenticationEvent.started()';
}


}




/// @nodoc


class _SignOutRequested implements AuthenticationEvent {
  const _SignOutRequested();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignOutRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'AuthenticationEvent.signOutRequested()';
}


}




/// @nodoc
mixin _$AuthenticationState {

 AuthenticationStatus get status; GenericStatus get signOutStatus; String? get signOutErrorMessage;
/// Create a copy of AuthenticationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthenticationStateCopyWith<AuthenticationState> get copyWith => _$AuthenticationStateCopyWithImpl<AuthenticationState>(this as AuthenticationState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as AuthenticationState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthenticationState&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.signOutStatus, _this.signOutStatus) || other.signOutStatus == _this.signOutStatus)&&(identical(other.signOutErrorMessage, _this.signOutErrorMessage) || other.signOutErrorMessage == _this.signOutErrorMessage));
}


@override
int get hashCode {
  final _this = this as AuthenticationState;
  return Object.hash(runtimeType,_this.status,_this.signOutStatus,_this.signOutErrorMessage);
}

@override
String toString() {
  final _this = this as AuthenticationState;
  return 'AuthenticationState(status: ${_this.status}, signOutStatus: ${_this.signOutStatus}, signOutErrorMessage: ${_this.signOutErrorMessage})';
}


}

/// @nodoc
abstract mixin class $AuthenticationStateCopyWith<$Res>  {
  factory $AuthenticationStateCopyWith(AuthenticationState value, $Res Function(AuthenticationState) _then) = _$AuthenticationStateCopyWithImpl;
@useResult
$Res call({
 AuthenticationStatus status, GenericStatus signOutStatus, String? signOutErrorMessage
});




}
/// @nodoc
class _$AuthenticationStateCopyWithImpl<$Res>
    implements $AuthenticationStateCopyWith<$Res> {
  _$AuthenticationStateCopyWithImpl(this._self, this._then);

  final AuthenticationState _self;
  final $Res Function(AuthenticationState) _then;

/// Create a copy of AuthenticationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? signOutStatus = null,Object? signOutErrorMessage = freezed,}) {
  return _then(AuthenticationState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AuthenticationStatus,signOutStatus: null == signOutStatus ? _self.signOutStatus : signOutStatus // ignore: cast_nullable_to_non_nullable
as GenericStatus,signOutErrorMessage: freezed == signOutErrorMessage ? _self.signOutErrorMessage : signOutErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AuthenticationState].
extension AuthenticationStatePatterns on AuthenticationState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuthenticationState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuthenticationState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuthenticationState value)  $default,){
final _that = this;
switch (_that) {
case _AuthenticationState():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuthenticationState value)?  $default,){
final _that = this;
switch (_that) {
case _AuthenticationState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AuthenticationStatus status,  GenericStatus signOutStatus,  String? signOutErrorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuthenticationState() when $default != null:
return $default(_that.status,_that.signOutStatus,_that.signOutErrorMessage);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AuthenticationStatus status,  GenericStatus signOutStatus,  String? signOutErrorMessage)  $default,) {final _that = this;
switch (_that) {
case _AuthenticationState():
return $default(_that.status,_that.signOutStatus,_that.signOutErrorMessage);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AuthenticationStatus status,  GenericStatus signOutStatus,  String? signOutErrorMessage)?  $default,) {final _that = this;
switch (_that) {
case _AuthenticationState() when $default != null:
return $default(_that.status,_that.signOutStatus,_that.signOutErrorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _AuthenticationState implements AuthenticationState {
  const _AuthenticationState({this.status = AuthenticationStatus.unknown, this.signOutStatus = GenericStatus.initial, this.signOutErrorMessage});
  

@override@JsonKey() final  AuthenticationStatus status;
@override@JsonKey() final  GenericStatus signOutStatus;
@override final  String? signOutErrorMessage;

/// Create a copy of AuthenticationState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthenticationStateCopyWith<_AuthenticationState> get copyWith => __$AuthenticationStateCopyWithImpl<_AuthenticationState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthenticationState&&(identical(other.status, status) || other.status == status)&&(identical(other.signOutStatus, signOutStatus) || other.signOutStatus == signOutStatus)&&(identical(other.signOutErrorMessage, signOutErrorMessage) || other.signOutErrorMessage == signOutErrorMessage));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,signOutStatus,signOutErrorMessage);
}

@override
String toString() {
    return 'AuthenticationState(status: $status, signOutStatus: $signOutStatus, signOutErrorMessage: $signOutErrorMessage)';
}


}

/// @nodoc
abstract mixin class _$AuthenticationStateCopyWith<$Res> implements $AuthenticationStateCopyWith<$Res> {
  factory _$AuthenticationStateCopyWith(_AuthenticationState value, $Res Function(_AuthenticationState) _then) = __$AuthenticationStateCopyWithImpl;
@override @useResult
$Res call({
 AuthenticationStatus status, GenericStatus signOutStatus, String? signOutErrorMessage
});




}
/// @nodoc
class __$AuthenticationStateCopyWithImpl<$Res>
    implements _$AuthenticationStateCopyWith<$Res> {
  __$AuthenticationStateCopyWithImpl(this._self, this._then);

  final _AuthenticationState _self;
  final $Res Function(_AuthenticationState) _then;

/// Create a copy of AuthenticationState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? signOutStatus = null,Object? signOutErrorMessage = freezed,}) {
  return _then(_AuthenticationState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AuthenticationStatus,signOutStatus: null == signOutStatus ? _self.signOutStatus : signOutStatus // ignore: cast_nullable_to_non_nullable
as GenericStatus,signOutErrorMessage: freezed == signOutErrorMessage ? _self.signOutErrorMessage : signOutErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
