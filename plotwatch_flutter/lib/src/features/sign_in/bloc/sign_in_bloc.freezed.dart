// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sign_in_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SignInEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is SignInEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'SignInEvent()';
}


}

/// @nodoc
class $SignInEventCopyWith<$Res>  {
$SignInEventCopyWith(SignInEvent _, $Res Function(SignInEvent) __);
}


/// Adds pattern-matching-related methods to [SignInEvent].
extension SignInEventPatterns on SignInEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _SignInSubmitted value)?  signInSubmitted,TResult Function( _PasswordVisibilityToggled value)?  passwordVisibilityToggled,TResult Function( _Reset value)?  reset,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SignInSubmitted() when signInSubmitted != null:
return signInSubmitted(_that);case _PasswordVisibilityToggled() when passwordVisibilityToggled != null:
return passwordVisibilityToggled(_that);case _Reset() when reset != null:
return reset(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _SignInSubmitted value)  signInSubmitted,required TResult Function( _PasswordVisibilityToggled value)  passwordVisibilityToggled,required TResult Function( _Reset value)  reset,}){
final _that = this;
switch (_that) {
case _SignInSubmitted():
return signInSubmitted(_that);case _PasswordVisibilityToggled():
return passwordVisibilityToggled(_that);case _Reset():
return reset(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _SignInSubmitted value)?  signInSubmitted,TResult? Function( _PasswordVisibilityToggled value)?  passwordVisibilityToggled,TResult? Function( _Reset value)?  reset,}){
final _that = this;
switch (_that) {
case _SignInSubmitted() when signInSubmitted != null:
return signInSubmitted(_that);case _PasswordVisibilityToggled() when passwordVisibilityToggled != null:
return passwordVisibilityToggled(_that);case _Reset() when reset != null:
return reset(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String email,  String password)?  signInSubmitted,TResult Function()?  passwordVisibilityToggled,TResult Function()?  reset,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SignInSubmitted() when signInSubmitted != null:
return signInSubmitted(_that.email,_that.password);case _PasswordVisibilityToggled() when passwordVisibilityToggled != null:
return passwordVisibilityToggled();case _Reset() when reset != null:
return reset();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String email,  String password)  signInSubmitted,required TResult Function()  passwordVisibilityToggled,required TResult Function()  reset,}) {final _that = this;
switch (_that) {
case _SignInSubmitted():
return signInSubmitted(_that.email,_that.password);case _PasswordVisibilityToggled():
return passwordVisibilityToggled();case _Reset():
return reset();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String email,  String password)?  signInSubmitted,TResult? Function()?  passwordVisibilityToggled,TResult? Function()?  reset,}) {final _that = this;
switch (_that) {
case _SignInSubmitted() when signInSubmitted != null:
return signInSubmitted(_that.email,_that.password);case _PasswordVisibilityToggled() when passwordVisibilityToggled != null:
return passwordVisibilityToggled();case _Reset() when reset != null:
return reset();case _:
  return null;

}
}

}

/// @nodoc


class _SignInSubmitted implements SignInEvent {
  const _SignInSubmitted({required this.email, required this.password});
  

 final  String email;
 final  String password;

/// Create a copy of SignInEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SignInSubmittedCopyWith<_SignInSubmitted> get copyWith => __$SignInSubmittedCopyWithImpl<_SignInSubmitted>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignInSubmitted&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password));
}


@override
int get hashCode {
    return Object.hash(runtimeType,email,password);
}

@override
String toString() {
    return 'SignInEvent.signInSubmitted(email: $email, password: $password)';
}


}

/// @nodoc
abstract mixin class _$SignInSubmittedCopyWith<$Res> implements $SignInEventCopyWith<$Res> {
  factory _$SignInSubmittedCopyWith(_SignInSubmitted value, $Res Function(_SignInSubmitted) _then) = __$SignInSubmittedCopyWithImpl;
@useResult
$Res call({
 String email, String password
});




}
/// @nodoc
class __$SignInSubmittedCopyWithImpl<$Res>
    implements _$SignInSubmittedCopyWith<$Res> {
  __$SignInSubmittedCopyWithImpl(this._self, this._then);

  final _SignInSubmitted _self;
  final $Res Function(_SignInSubmitted) _then;

/// Create a copy of SignInEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,Object? password = null,}) {
  return _then(_SignInSubmitted(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _PasswordVisibilityToggled implements SignInEvent {
  const _PasswordVisibilityToggled();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PasswordVisibilityToggled);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'SignInEvent.passwordVisibilityToggled()';
}


}




/// @nodoc


class _Reset implements SignInEvent {
  const _Reset();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Reset);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'SignInEvent.reset()';
}


}




/// @nodoc
mixin _$SignInState {

 GenericStatus get signInStatus; String? get signInErrorMessage; bool get isPasswordVisible;
/// Create a copy of SignInState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignInStateCopyWith<SignInState> get copyWith => _$SignInStateCopyWithImpl<SignInState>(this as SignInState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SignInState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignInState&&(identical(other.signInStatus, _this.signInStatus) || other.signInStatus == _this.signInStatus)&&(identical(other.signInErrorMessage, _this.signInErrorMessage) || other.signInErrorMessage == _this.signInErrorMessage)&&(identical(other.isPasswordVisible, _this.isPasswordVisible) || other.isPasswordVisible == _this.isPasswordVisible));
}


@override
int get hashCode {
  final _this = this as SignInState;
  return Object.hash(runtimeType,_this.signInStatus,_this.signInErrorMessage,_this.isPasswordVisible);
}

@override
String toString() {
  final _this = this as SignInState;
  return 'SignInState(signInStatus: ${_this.signInStatus}, signInErrorMessage: ${_this.signInErrorMessage}, isPasswordVisible: ${_this.isPasswordVisible})';
}


}

/// @nodoc
abstract mixin class $SignInStateCopyWith<$Res>  {
  factory $SignInStateCopyWith(SignInState value, $Res Function(SignInState) _then) = _$SignInStateCopyWithImpl;
@useResult
$Res call({
 GenericStatus signInStatus, String? signInErrorMessage, bool isPasswordVisible
});




}
/// @nodoc
class _$SignInStateCopyWithImpl<$Res>
    implements $SignInStateCopyWith<$Res> {
  _$SignInStateCopyWithImpl(this._self, this._then);

  final SignInState _self;
  final $Res Function(SignInState) _then;

/// Create a copy of SignInState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? signInStatus = null,Object? signInErrorMessage = freezed,Object? isPasswordVisible = null,}) {
  return _then(SignInState(
signInStatus: null == signInStatus ? _self.signInStatus : signInStatus // ignore: cast_nullable_to_non_nullable
as GenericStatus,signInErrorMessage: freezed == signInErrorMessage ? _self.signInErrorMessage : signInErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,isPasswordVisible: null == isPasswordVisible ? _self.isPasswordVisible : isPasswordVisible // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SignInState].
extension SignInStatePatterns on SignInState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SignInState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SignInState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SignInState value)  $default,){
final _that = this;
switch (_that) {
case _SignInState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SignInState value)?  $default,){
final _that = this;
switch (_that) {
case _SignInState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( GenericStatus signInStatus,  String? signInErrorMessage,  bool isPasswordVisible)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SignInState() when $default != null:
return $default(_that.signInStatus,_that.signInErrorMessage,_that.isPasswordVisible);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( GenericStatus signInStatus,  String? signInErrorMessage,  bool isPasswordVisible)  $default,) {final _that = this;
switch (_that) {
case _SignInState():
return $default(_that.signInStatus,_that.signInErrorMessage,_that.isPasswordVisible);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( GenericStatus signInStatus,  String? signInErrorMessage,  bool isPasswordVisible)?  $default,) {final _that = this;
switch (_that) {
case _SignInState() when $default != null:
return $default(_that.signInStatus,_that.signInErrorMessage,_that.isPasswordVisible);case _:
  return null;

}
}

}

/// @nodoc


class _SignInState implements SignInState {
  const _SignInState({this.signInStatus = GenericStatus.initial, this.signInErrorMessage, this.isPasswordVisible = false});
  

@override@JsonKey() final  GenericStatus signInStatus;
@override final  String? signInErrorMessage;
@override@JsonKey() final  bool isPasswordVisible;

/// Create a copy of SignInState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SignInStateCopyWith<_SignInState> get copyWith => __$SignInStateCopyWithImpl<_SignInState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignInState&&(identical(other.signInStatus, signInStatus) || other.signInStatus == signInStatus)&&(identical(other.signInErrorMessage, signInErrorMessage) || other.signInErrorMessage == signInErrorMessage)&&(identical(other.isPasswordVisible, isPasswordVisible) || other.isPasswordVisible == isPasswordVisible));
}


@override
int get hashCode {
    return Object.hash(runtimeType,signInStatus,signInErrorMessage,isPasswordVisible);
}

@override
String toString() {
    return 'SignInState(signInStatus: $signInStatus, signInErrorMessage: $signInErrorMessage, isPasswordVisible: $isPasswordVisible)';
}


}

/// @nodoc
abstract mixin class _$SignInStateCopyWith<$Res> implements $SignInStateCopyWith<$Res> {
  factory _$SignInStateCopyWith(_SignInState value, $Res Function(_SignInState) _then) = __$SignInStateCopyWithImpl;
@override @useResult
$Res call({
 GenericStatus signInStatus, String? signInErrorMessage, bool isPasswordVisible
});




}
/// @nodoc
class __$SignInStateCopyWithImpl<$Res>
    implements _$SignInStateCopyWith<$Res> {
  __$SignInStateCopyWithImpl(this._self, this._then);

  final _SignInState _self;
  final $Res Function(_SignInState) _then;

/// Create a copy of SignInState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? signInStatus = null,Object? signInErrorMessage = freezed,Object? isPasswordVisible = null,}) {
  return _then(_SignInState(
signInStatus: null == signInStatus ? _self.signInStatus : signInStatus // ignore: cast_nullable_to_non_nullable
as GenericStatus,signInErrorMessage: freezed == signInErrorMessage ? _self.signInErrorMessage : signInErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,isPasswordVisible: null == isPasswordVisible ? _self.isPasswordVisible : isPasswordVisible // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
