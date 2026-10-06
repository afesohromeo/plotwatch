// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'password_reset_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PasswordResetEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is PasswordResetEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'PasswordResetEvent()';
}


}

/// @nodoc
class $PasswordResetEventCopyWith<$Res>  {
$PasswordResetEventCopyWith(PasswordResetEvent _, $Res Function(PasswordResetEvent) __);
}


/// Adds pattern-matching-related methods to [PasswordResetEvent].
extension PasswordResetEventPatterns on PasswordResetEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _EmailSubmitted value)?  emailSubmitted,TResult Function( _CodeSubmitted value)?  codeSubmitted,TResult Function( _CodeResent value)?  codeResent,TResult Function( _NewPasswordSubmitted value)?  newPasswordSubmitted,TResult Function( _PasswordVisibilityToggled value)?  passwordVisibilityToggled,TResult Function( _ConfirmPasswordVisibilityToggled value)?  confirmPasswordVisibilityToggled,TResult Function( _Reset value)?  reset,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EmailSubmitted() when emailSubmitted != null:
return emailSubmitted(_that);case _CodeSubmitted() when codeSubmitted != null:
return codeSubmitted(_that);case _CodeResent() when codeResent != null:
return codeResent(_that);case _NewPasswordSubmitted() when newPasswordSubmitted != null:
return newPasswordSubmitted(_that);case _PasswordVisibilityToggled() when passwordVisibilityToggled != null:
return passwordVisibilityToggled(_that);case _ConfirmPasswordVisibilityToggled() when confirmPasswordVisibilityToggled != null:
return confirmPasswordVisibilityToggled(_that);case _Reset() when reset != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _EmailSubmitted value)  emailSubmitted,required TResult Function( _CodeSubmitted value)  codeSubmitted,required TResult Function( _CodeResent value)  codeResent,required TResult Function( _NewPasswordSubmitted value)  newPasswordSubmitted,required TResult Function( _PasswordVisibilityToggled value)  passwordVisibilityToggled,required TResult Function( _ConfirmPasswordVisibilityToggled value)  confirmPasswordVisibilityToggled,required TResult Function( _Reset value)  reset,}){
final _that = this;
switch (_that) {
case _EmailSubmitted():
return emailSubmitted(_that);case _CodeSubmitted():
return codeSubmitted(_that);case _CodeResent():
return codeResent(_that);case _NewPasswordSubmitted():
return newPasswordSubmitted(_that);case _PasswordVisibilityToggled():
return passwordVisibilityToggled(_that);case _ConfirmPasswordVisibilityToggled():
return confirmPasswordVisibilityToggled(_that);case _Reset():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _EmailSubmitted value)?  emailSubmitted,TResult? Function( _CodeSubmitted value)?  codeSubmitted,TResult? Function( _CodeResent value)?  codeResent,TResult? Function( _NewPasswordSubmitted value)?  newPasswordSubmitted,TResult? Function( _PasswordVisibilityToggled value)?  passwordVisibilityToggled,TResult? Function( _ConfirmPasswordVisibilityToggled value)?  confirmPasswordVisibilityToggled,TResult? Function( _Reset value)?  reset,}){
final _that = this;
switch (_that) {
case _EmailSubmitted() when emailSubmitted != null:
return emailSubmitted(_that);case _CodeSubmitted() when codeSubmitted != null:
return codeSubmitted(_that);case _CodeResent() when codeResent != null:
return codeResent(_that);case _NewPasswordSubmitted() when newPasswordSubmitted != null:
return newPasswordSubmitted(_that);case _PasswordVisibilityToggled() when passwordVisibilityToggled != null:
return passwordVisibilityToggled(_that);case _ConfirmPasswordVisibilityToggled() when confirmPasswordVisibilityToggled != null:
return confirmPasswordVisibilityToggled(_that);case _Reset() when reset != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String email)?  emailSubmitted,TResult Function( String code)?  codeSubmitted,TResult Function()?  codeResent,TResult Function( String password)?  newPasswordSubmitted,TResult Function()?  passwordVisibilityToggled,TResult Function()?  confirmPasswordVisibilityToggled,TResult Function()?  reset,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EmailSubmitted() when emailSubmitted != null:
return emailSubmitted(_that.email);case _CodeSubmitted() when codeSubmitted != null:
return codeSubmitted(_that.code);case _CodeResent() when codeResent != null:
return codeResent();case _NewPasswordSubmitted() when newPasswordSubmitted != null:
return newPasswordSubmitted(_that.password);case _PasswordVisibilityToggled() when passwordVisibilityToggled != null:
return passwordVisibilityToggled();case _ConfirmPasswordVisibilityToggled() when confirmPasswordVisibilityToggled != null:
return confirmPasswordVisibilityToggled();case _Reset() when reset != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String email)  emailSubmitted,required TResult Function( String code)  codeSubmitted,required TResult Function()  codeResent,required TResult Function( String password)  newPasswordSubmitted,required TResult Function()  passwordVisibilityToggled,required TResult Function()  confirmPasswordVisibilityToggled,required TResult Function()  reset,}) {final _that = this;
switch (_that) {
case _EmailSubmitted():
return emailSubmitted(_that.email);case _CodeSubmitted():
return codeSubmitted(_that.code);case _CodeResent():
return codeResent();case _NewPasswordSubmitted():
return newPasswordSubmitted(_that.password);case _PasswordVisibilityToggled():
return passwordVisibilityToggled();case _ConfirmPasswordVisibilityToggled():
return confirmPasswordVisibilityToggled();case _Reset():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String email)?  emailSubmitted,TResult? Function( String code)?  codeSubmitted,TResult? Function()?  codeResent,TResult? Function( String password)?  newPasswordSubmitted,TResult? Function()?  passwordVisibilityToggled,TResult? Function()?  confirmPasswordVisibilityToggled,TResult? Function()?  reset,}) {final _that = this;
switch (_that) {
case _EmailSubmitted() when emailSubmitted != null:
return emailSubmitted(_that.email);case _CodeSubmitted() when codeSubmitted != null:
return codeSubmitted(_that.code);case _CodeResent() when codeResent != null:
return codeResent();case _NewPasswordSubmitted() when newPasswordSubmitted != null:
return newPasswordSubmitted(_that.password);case _PasswordVisibilityToggled() when passwordVisibilityToggled != null:
return passwordVisibilityToggled();case _ConfirmPasswordVisibilityToggled() when confirmPasswordVisibilityToggled != null:
return confirmPasswordVisibilityToggled();case _Reset() when reset != null:
return reset();case _:
  return null;

}
}

}

/// @nodoc


class _EmailSubmitted implements PasswordResetEvent {
  const _EmailSubmitted({required this.email});
  

 final  String email;

/// Create a copy of PasswordResetEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EmailSubmittedCopyWith<_EmailSubmitted> get copyWith => __$EmailSubmittedCopyWithImpl<_EmailSubmitted>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _EmailSubmitted&&(identical(other.email, email) || other.email == email));
}


@override
int get hashCode {
    return Object.hash(runtimeType,email);
}

@override
String toString() {
    return 'PasswordResetEvent.emailSubmitted(email: $email)';
}


}

/// @nodoc
abstract mixin class _$EmailSubmittedCopyWith<$Res> implements $PasswordResetEventCopyWith<$Res> {
  factory _$EmailSubmittedCopyWith(_EmailSubmitted value, $Res Function(_EmailSubmitted) _then) = __$EmailSubmittedCopyWithImpl;
@useResult
$Res call({
 String email
});




}
/// @nodoc
class __$EmailSubmittedCopyWithImpl<$Res>
    implements _$EmailSubmittedCopyWith<$Res> {
  __$EmailSubmittedCopyWithImpl(this._self, this._then);

  final _EmailSubmitted _self;
  final $Res Function(_EmailSubmitted) _then;

/// Create a copy of PasswordResetEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,}) {
  return _then(_EmailSubmitted(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _CodeSubmitted implements PasswordResetEvent {
  const _CodeSubmitted({required this.code});
  

 final  String code;

/// Create a copy of PasswordResetEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CodeSubmittedCopyWith<_CodeSubmitted> get copyWith => __$CodeSubmittedCopyWithImpl<_CodeSubmitted>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CodeSubmitted&&(identical(other.code, code) || other.code == code));
}


@override
int get hashCode {
    return Object.hash(runtimeType,code);
}

@override
String toString() {
    return 'PasswordResetEvent.codeSubmitted(code: $code)';
}


}

/// @nodoc
abstract mixin class _$CodeSubmittedCopyWith<$Res> implements $PasswordResetEventCopyWith<$Res> {
  factory _$CodeSubmittedCopyWith(_CodeSubmitted value, $Res Function(_CodeSubmitted) _then) = __$CodeSubmittedCopyWithImpl;
@useResult
$Res call({
 String code
});




}
/// @nodoc
class __$CodeSubmittedCopyWithImpl<$Res>
    implements _$CodeSubmittedCopyWith<$Res> {
  __$CodeSubmittedCopyWithImpl(this._self, this._then);

  final _CodeSubmitted _self;
  final $Res Function(_CodeSubmitted) _then;

/// Create a copy of PasswordResetEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? code = null,}) {
  return _then(_CodeSubmitted(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _CodeResent implements PasswordResetEvent {
  const _CodeResent();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CodeResent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'PasswordResetEvent.codeResent()';
}


}




/// @nodoc


class _NewPasswordSubmitted implements PasswordResetEvent {
  const _NewPasswordSubmitted({required this.password});
  

 final  String password;

/// Create a copy of PasswordResetEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NewPasswordSubmittedCopyWith<_NewPasswordSubmitted> get copyWith => __$NewPasswordSubmittedCopyWithImpl<_NewPasswordSubmitted>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _NewPasswordSubmitted&&(identical(other.password, password) || other.password == password));
}


@override
int get hashCode {
    return Object.hash(runtimeType,password);
}

@override
String toString() {
    return 'PasswordResetEvent.newPasswordSubmitted(password: $password)';
}


}

/// @nodoc
abstract mixin class _$NewPasswordSubmittedCopyWith<$Res> implements $PasswordResetEventCopyWith<$Res> {
  factory _$NewPasswordSubmittedCopyWith(_NewPasswordSubmitted value, $Res Function(_NewPasswordSubmitted) _then) = __$NewPasswordSubmittedCopyWithImpl;
@useResult
$Res call({
 String password
});




}
/// @nodoc
class __$NewPasswordSubmittedCopyWithImpl<$Res>
    implements _$NewPasswordSubmittedCopyWith<$Res> {
  __$NewPasswordSubmittedCopyWithImpl(this._self, this._then);

  final _NewPasswordSubmitted _self;
  final $Res Function(_NewPasswordSubmitted) _then;

/// Create a copy of PasswordResetEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? password = null,}) {
  return _then(_NewPasswordSubmitted(
password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _PasswordVisibilityToggled implements PasswordResetEvent {
  const _PasswordVisibilityToggled();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PasswordVisibilityToggled);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'PasswordResetEvent.passwordVisibilityToggled()';
}


}




/// @nodoc


class _ConfirmPasswordVisibilityToggled implements PasswordResetEvent {
  const _ConfirmPasswordVisibilityToggled();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConfirmPasswordVisibilityToggled);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'PasswordResetEvent.confirmPasswordVisibilityToggled()';
}


}




/// @nodoc


class _Reset implements PasswordResetEvent {
  const _Reset();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Reset);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'PasswordResetEvent.reset()';
}


}




/// @nodoc
mixin _$PasswordResetState {

 PasswordResetStep get step; String get email; UuidValue? get passwordResetRequestId; String? get finishPasswordResetToken; GenericStatus get passwordResetStatus; String? get passwordResetErrorMessage; bool get isPasswordVisible; bool get isConfirmPasswordVisible;
/// Create a copy of PasswordResetState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PasswordResetStateCopyWith<PasswordResetState> get copyWith => _$PasswordResetStateCopyWithImpl<PasswordResetState>(this as PasswordResetState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as PasswordResetState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PasswordResetState&&(identical(other.step, _this.step) || other.step == _this.step)&&(identical(other.email, _this.email) || other.email == _this.email)&&(identical(other.passwordResetRequestId, _this.passwordResetRequestId) || other.passwordResetRequestId == _this.passwordResetRequestId)&&(identical(other.finishPasswordResetToken, _this.finishPasswordResetToken) || other.finishPasswordResetToken == _this.finishPasswordResetToken)&&(identical(other.passwordResetStatus, _this.passwordResetStatus) || other.passwordResetStatus == _this.passwordResetStatus)&&(identical(other.passwordResetErrorMessage, _this.passwordResetErrorMessage) || other.passwordResetErrorMessage == _this.passwordResetErrorMessage)&&(identical(other.isPasswordVisible, _this.isPasswordVisible) || other.isPasswordVisible == _this.isPasswordVisible)&&(identical(other.isConfirmPasswordVisible, _this.isConfirmPasswordVisible) || other.isConfirmPasswordVisible == _this.isConfirmPasswordVisible));
}


@override
int get hashCode {
  final _this = this as PasswordResetState;
  return Object.hash(runtimeType,_this.step,_this.email,_this.passwordResetRequestId,_this.finishPasswordResetToken,_this.passwordResetStatus,_this.passwordResetErrorMessage,_this.isPasswordVisible,_this.isConfirmPasswordVisible);
}

@override
String toString() {
  final _this = this as PasswordResetState;
  return 'PasswordResetState(step: ${_this.step}, email: ${_this.email}, passwordResetRequestId: ${_this.passwordResetRequestId}, finishPasswordResetToken: ${_this.finishPasswordResetToken}, passwordResetStatus: ${_this.passwordResetStatus}, passwordResetErrorMessage: ${_this.passwordResetErrorMessage}, isPasswordVisible: ${_this.isPasswordVisible}, isConfirmPasswordVisible: ${_this.isConfirmPasswordVisible})';
}


}

/// @nodoc
abstract mixin class $PasswordResetStateCopyWith<$Res>  {
  factory $PasswordResetStateCopyWith(PasswordResetState value, $Res Function(PasswordResetState) _then) = _$PasswordResetStateCopyWithImpl;
@useResult
$Res call({
 PasswordResetStep step, String email, UuidValue? passwordResetRequestId, String? finishPasswordResetToken, GenericStatus passwordResetStatus, String? passwordResetErrorMessage, bool isPasswordVisible, bool isConfirmPasswordVisible
});




}
/// @nodoc
class _$PasswordResetStateCopyWithImpl<$Res>
    implements $PasswordResetStateCopyWith<$Res> {
  _$PasswordResetStateCopyWithImpl(this._self, this._then);

  final PasswordResetState _self;
  final $Res Function(PasswordResetState) _then;

/// Create a copy of PasswordResetState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? step = null,Object? email = null,Object? passwordResetRequestId = freezed,Object? finishPasswordResetToken = freezed,Object? passwordResetStatus = null,Object? passwordResetErrorMessage = freezed,Object? isPasswordVisible = null,Object? isConfirmPasswordVisible = null,}) {
  return _then(PasswordResetState(
step: null == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as PasswordResetStep,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,passwordResetRequestId: freezed == passwordResetRequestId ? _self.passwordResetRequestId : passwordResetRequestId // ignore: cast_nullable_to_non_nullable
as UuidValue?,finishPasswordResetToken: freezed == finishPasswordResetToken ? _self.finishPasswordResetToken : finishPasswordResetToken // ignore: cast_nullable_to_non_nullable
as String?,passwordResetStatus: null == passwordResetStatus ? _self.passwordResetStatus : passwordResetStatus // ignore: cast_nullable_to_non_nullable
as GenericStatus,passwordResetErrorMessage: freezed == passwordResetErrorMessage ? _self.passwordResetErrorMessage : passwordResetErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,isPasswordVisible: null == isPasswordVisible ? _self.isPasswordVisible : isPasswordVisible // ignore: cast_nullable_to_non_nullable
as bool,isConfirmPasswordVisible: null == isConfirmPasswordVisible ? _self.isConfirmPasswordVisible : isConfirmPasswordVisible // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PasswordResetState].
extension PasswordResetStatePatterns on PasswordResetState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PasswordResetState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PasswordResetState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PasswordResetState value)  $default,){
final _that = this;
switch (_that) {
case _PasswordResetState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PasswordResetState value)?  $default,){
final _that = this;
switch (_that) {
case _PasswordResetState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PasswordResetStep step,  String email,  UuidValue? passwordResetRequestId,  String? finishPasswordResetToken,  GenericStatus passwordResetStatus,  String? passwordResetErrorMessage,  bool isPasswordVisible,  bool isConfirmPasswordVisible)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PasswordResetState() when $default != null:
return $default(_that.step,_that.email,_that.passwordResetRequestId,_that.finishPasswordResetToken,_that.passwordResetStatus,_that.passwordResetErrorMessage,_that.isPasswordVisible,_that.isConfirmPasswordVisible);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PasswordResetStep step,  String email,  UuidValue? passwordResetRequestId,  String? finishPasswordResetToken,  GenericStatus passwordResetStatus,  String? passwordResetErrorMessage,  bool isPasswordVisible,  bool isConfirmPasswordVisible)  $default,) {final _that = this;
switch (_that) {
case _PasswordResetState():
return $default(_that.step,_that.email,_that.passwordResetRequestId,_that.finishPasswordResetToken,_that.passwordResetStatus,_that.passwordResetErrorMessage,_that.isPasswordVisible,_that.isConfirmPasswordVisible);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PasswordResetStep step,  String email,  UuidValue? passwordResetRequestId,  String? finishPasswordResetToken,  GenericStatus passwordResetStatus,  String? passwordResetErrorMessage,  bool isPasswordVisible,  bool isConfirmPasswordVisible)?  $default,) {final _that = this;
switch (_that) {
case _PasswordResetState() when $default != null:
return $default(_that.step,_that.email,_that.passwordResetRequestId,_that.finishPasswordResetToken,_that.passwordResetStatus,_that.passwordResetErrorMessage,_that.isPasswordVisible,_that.isConfirmPasswordVisible);case _:
  return null;

}
}

}

/// @nodoc


class _PasswordResetState implements PasswordResetState {
  const _PasswordResetState({this.step = PasswordResetStep.email, this.email = '', this.passwordResetRequestId, this.finishPasswordResetToken, this.passwordResetStatus = GenericStatus.initial, this.passwordResetErrorMessage, this.isPasswordVisible = false, this.isConfirmPasswordVisible = false});
  

@override@JsonKey() final  PasswordResetStep step;
@override@JsonKey() final  String email;
@override final  UuidValue? passwordResetRequestId;
@override final  String? finishPasswordResetToken;
@override@JsonKey() final  GenericStatus passwordResetStatus;
@override final  String? passwordResetErrorMessage;
@override@JsonKey() final  bool isPasswordVisible;
@override@JsonKey() final  bool isConfirmPasswordVisible;

/// Create a copy of PasswordResetState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PasswordResetStateCopyWith<_PasswordResetState> get copyWith => __$PasswordResetStateCopyWithImpl<_PasswordResetState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PasswordResetState&&(identical(other.step, step) || other.step == step)&&(identical(other.email, email) || other.email == email)&&(identical(other.passwordResetRequestId, passwordResetRequestId) || other.passwordResetRequestId == passwordResetRequestId)&&(identical(other.finishPasswordResetToken, finishPasswordResetToken) || other.finishPasswordResetToken == finishPasswordResetToken)&&(identical(other.passwordResetStatus, passwordResetStatus) || other.passwordResetStatus == passwordResetStatus)&&(identical(other.passwordResetErrorMessage, passwordResetErrorMessage) || other.passwordResetErrorMessage == passwordResetErrorMessage)&&(identical(other.isPasswordVisible, isPasswordVisible) || other.isPasswordVisible == isPasswordVisible)&&(identical(other.isConfirmPasswordVisible, isConfirmPasswordVisible) || other.isConfirmPasswordVisible == isConfirmPasswordVisible));
}


@override
int get hashCode {
    return Object.hash(runtimeType,step,email,passwordResetRequestId,finishPasswordResetToken,passwordResetStatus,passwordResetErrorMessage,isPasswordVisible,isConfirmPasswordVisible);
}

@override
String toString() {
    return 'PasswordResetState(step: $step, email: $email, passwordResetRequestId: $passwordResetRequestId, finishPasswordResetToken: $finishPasswordResetToken, passwordResetStatus: $passwordResetStatus, passwordResetErrorMessage: $passwordResetErrorMessage, isPasswordVisible: $isPasswordVisible, isConfirmPasswordVisible: $isConfirmPasswordVisible)';
}


}

/// @nodoc
abstract mixin class _$PasswordResetStateCopyWith<$Res> implements $PasswordResetStateCopyWith<$Res> {
  factory _$PasswordResetStateCopyWith(_PasswordResetState value, $Res Function(_PasswordResetState) _then) = __$PasswordResetStateCopyWithImpl;
@override @useResult
$Res call({
 PasswordResetStep step, String email, UuidValue? passwordResetRequestId, String? finishPasswordResetToken, GenericStatus passwordResetStatus, String? passwordResetErrorMessage, bool isPasswordVisible, bool isConfirmPasswordVisible
});




}
/// @nodoc
class __$PasswordResetStateCopyWithImpl<$Res>
    implements _$PasswordResetStateCopyWith<$Res> {
  __$PasswordResetStateCopyWithImpl(this._self, this._then);

  final _PasswordResetState _self;
  final $Res Function(_PasswordResetState) _then;

/// Create a copy of PasswordResetState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? step = null,Object? email = null,Object? passwordResetRequestId = freezed,Object? finishPasswordResetToken = freezed,Object? passwordResetStatus = null,Object? passwordResetErrorMessage = freezed,Object? isPasswordVisible = null,Object? isConfirmPasswordVisible = null,}) {
  return _then(_PasswordResetState(
step: null == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as PasswordResetStep,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,passwordResetRequestId: freezed == passwordResetRequestId ? _self.passwordResetRequestId : passwordResetRequestId // ignore: cast_nullable_to_non_nullable
as UuidValue?,finishPasswordResetToken: freezed == finishPasswordResetToken ? _self.finishPasswordResetToken : finishPasswordResetToken // ignore: cast_nullable_to_non_nullable
as String?,passwordResetStatus: null == passwordResetStatus ? _self.passwordResetStatus : passwordResetStatus // ignore: cast_nullable_to_non_nullable
as GenericStatus,passwordResetErrorMessage: freezed == passwordResetErrorMessage ? _self.passwordResetErrorMessage : passwordResetErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,isPasswordVisible: null == isPasswordVisible ? _self.isPasswordVisible : isPasswordVisible // ignore: cast_nullable_to_non_nullable
as bool,isConfirmPasswordVisible: null == isConfirmPasswordVisible ? _self.isConfirmPasswordVisible : isConfirmPasswordVisible // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
