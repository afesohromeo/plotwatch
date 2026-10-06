// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sign_up_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SignUpEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is SignUpEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'SignUpEvent()';
}


}

/// @nodoc
class $SignUpEventCopyWith<$Res>  {
$SignUpEventCopyWith(SignUpEvent _, $Res Function(SignUpEvent) __);
}


/// Adds pattern-matching-related methods to [SignUpEvent].
extension SignUpEventPatterns on SignUpEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _DetailsSubmitted value)?  detailsSubmitted,TResult Function( _CodeSubmitted value)?  codeSubmitted,TResult Function( _CodeResent value)?  codeResent,TResult Function( _PasswordSubmitted value)?  passwordSubmitted,TResult Function( _PasswordVisibilityToggled value)?  passwordVisibilityToggled,TResult Function( _ConfirmPasswordVisibilityToggled value)?  confirmPasswordVisibilityToggled,TResult Function( _Reset value)?  reset,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DetailsSubmitted() when detailsSubmitted != null:
return detailsSubmitted(_that);case _CodeSubmitted() when codeSubmitted != null:
return codeSubmitted(_that);case _CodeResent() when codeResent != null:
return codeResent(_that);case _PasswordSubmitted() when passwordSubmitted != null:
return passwordSubmitted(_that);case _PasswordVisibilityToggled() when passwordVisibilityToggled != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _DetailsSubmitted value)  detailsSubmitted,required TResult Function( _CodeSubmitted value)  codeSubmitted,required TResult Function( _CodeResent value)  codeResent,required TResult Function( _PasswordSubmitted value)  passwordSubmitted,required TResult Function( _PasswordVisibilityToggled value)  passwordVisibilityToggled,required TResult Function( _ConfirmPasswordVisibilityToggled value)  confirmPasswordVisibilityToggled,required TResult Function( _Reset value)  reset,}){
final _that = this;
switch (_that) {
case _DetailsSubmitted():
return detailsSubmitted(_that);case _CodeSubmitted():
return codeSubmitted(_that);case _CodeResent():
return codeResent(_that);case _PasswordSubmitted():
return passwordSubmitted(_that);case _PasswordVisibilityToggled():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _DetailsSubmitted value)?  detailsSubmitted,TResult? Function( _CodeSubmitted value)?  codeSubmitted,TResult? Function( _CodeResent value)?  codeResent,TResult? Function( _PasswordSubmitted value)?  passwordSubmitted,TResult? Function( _PasswordVisibilityToggled value)?  passwordVisibilityToggled,TResult? Function( _ConfirmPasswordVisibilityToggled value)?  confirmPasswordVisibilityToggled,TResult? Function( _Reset value)?  reset,}){
final _that = this;
switch (_that) {
case _DetailsSubmitted() when detailsSubmitted != null:
return detailsSubmitted(_that);case _CodeSubmitted() when codeSubmitted != null:
return codeSubmitted(_that);case _CodeResent() when codeResent != null:
return codeResent(_that);case _PasswordSubmitted() when passwordSubmitted != null:
return passwordSubmitted(_that);case _PasswordVisibilityToggled() when passwordVisibilityToggled != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String fullName,  String email)?  detailsSubmitted,TResult Function( String code)?  codeSubmitted,TResult Function()?  codeResent,TResult Function( String password,  String locale)?  passwordSubmitted,TResult Function()?  passwordVisibilityToggled,TResult Function()?  confirmPasswordVisibilityToggled,TResult Function()?  reset,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DetailsSubmitted() when detailsSubmitted != null:
return detailsSubmitted(_that.fullName,_that.email);case _CodeSubmitted() when codeSubmitted != null:
return codeSubmitted(_that.code);case _CodeResent() when codeResent != null:
return codeResent();case _PasswordSubmitted() when passwordSubmitted != null:
return passwordSubmitted(_that.password,_that.locale);case _PasswordVisibilityToggled() when passwordVisibilityToggled != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String fullName,  String email)  detailsSubmitted,required TResult Function( String code)  codeSubmitted,required TResult Function()  codeResent,required TResult Function( String password,  String locale)  passwordSubmitted,required TResult Function()  passwordVisibilityToggled,required TResult Function()  confirmPasswordVisibilityToggled,required TResult Function()  reset,}) {final _that = this;
switch (_that) {
case _DetailsSubmitted():
return detailsSubmitted(_that.fullName,_that.email);case _CodeSubmitted():
return codeSubmitted(_that.code);case _CodeResent():
return codeResent();case _PasswordSubmitted():
return passwordSubmitted(_that.password,_that.locale);case _PasswordVisibilityToggled():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String fullName,  String email)?  detailsSubmitted,TResult? Function( String code)?  codeSubmitted,TResult? Function()?  codeResent,TResult? Function( String password,  String locale)?  passwordSubmitted,TResult? Function()?  passwordVisibilityToggled,TResult? Function()?  confirmPasswordVisibilityToggled,TResult? Function()?  reset,}) {final _that = this;
switch (_that) {
case _DetailsSubmitted() when detailsSubmitted != null:
return detailsSubmitted(_that.fullName,_that.email);case _CodeSubmitted() when codeSubmitted != null:
return codeSubmitted(_that.code);case _CodeResent() when codeResent != null:
return codeResent();case _PasswordSubmitted() when passwordSubmitted != null:
return passwordSubmitted(_that.password,_that.locale);case _PasswordVisibilityToggled() when passwordVisibilityToggled != null:
return passwordVisibilityToggled();case _ConfirmPasswordVisibilityToggled() when confirmPasswordVisibilityToggled != null:
return confirmPasswordVisibilityToggled();case _Reset() when reset != null:
return reset();case _:
  return null;

}
}

}

/// @nodoc


class _DetailsSubmitted implements SignUpEvent {
  const _DetailsSubmitted({required this.fullName, required this.email});
  

 final  String fullName;
 final  String email;

/// Create a copy of SignUpEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DetailsSubmittedCopyWith<_DetailsSubmitted> get copyWith => __$DetailsSubmittedCopyWithImpl<_DetailsSubmitted>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DetailsSubmitted&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.email, email) || other.email == email));
}


@override
int get hashCode {
    return Object.hash(runtimeType,fullName,email);
}

@override
String toString() {
    return 'SignUpEvent.detailsSubmitted(fullName: $fullName, email: $email)';
}


}

/// @nodoc
abstract mixin class _$DetailsSubmittedCopyWith<$Res> implements $SignUpEventCopyWith<$Res> {
  factory _$DetailsSubmittedCopyWith(_DetailsSubmitted value, $Res Function(_DetailsSubmitted) _then) = __$DetailsSubmittedCopyWithImpl;
@useResult
$Res call({
 String fullName, String email
});




}
/// @nodoc
class __$DetailsSubmittedCopyWithImpl<$Res>
    implements _$DetailsSubmittedCopyWith<$Res> {
  __$DetailsSubmittedCopyWithImpl(this._self, this._then);

  final _DetailsSubmitted _self;
  final $Res Function(_DetailsSubmitted) _then;

/// Create a copy of SignUpEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? fullName = null,Object? email = null,}) {
  return _then(_DetailsSubmitted(
fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _CodeSubmitted implements SignUpEvent {
  const _CodeSubmitted({required this.code});
  

 final  String code;

/// Create a copy of SignUpEvent
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
    return 'SignUpEvent.codeSubmitted(code: $code)';
}


}

/// @nodoc
abstract mixin class _$CodeSubmittedCopyWith<$Res> implements $SignUpEventCopyWith<$Res> {
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

/// Create a copy of SignUpEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? code = null,}) {
  return _then(_CodeSubmitted(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _CodeResent implements SignUpEvent {
  const _CodeResent();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CodeResent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'SignUpEvent.codeResent()';
}


}




/// @nodoc


class _PasswordSubmitted implements SignUpEvent {
  const _PasswordSubmitted({required this.password, required this.locale});
  

 final  String password;
 final  String locale;

/// Create a copy of SignUpEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PasswordSubmittedCopyWith<_PasswordSubmitted> get copyWith => __$PasswordSubmittedCopyWithImpl<_PasswordSubmitted>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PasswordSubmitted&&(identical(other.password, password) || other.password == password)&&(identical(other.locale, locale) || other.locale == locale));
}


@override
int get hashCode {
    return Object.hash(runtimeType,password,locale);
}

@override
String toString() {
    return 'SignUpEvent.passwordSubmitted(password: $password, locale: $locale)';
}


}

/// @nodoc
abstract mixin class _$PasswordSubmittedCopyWith<$Res> implements $SignUpEventCopyWith<$Res> {
  factory _$PasswordSubmittedCopyWith(_PasswordSubmitted value, $Res Function(_PasswordSubmitted) _then) = __$PasswordSubmittedCopyWithImpl;
@useResult
$Res call({
 String password, String locale
});




}
/// @nodoc
class __$PasswordSubmittedCopyWithImpl<$Res>
    implements _$PasswordSubmittedCopyWith<$Res> {
  __$PasswordSubmittedCopyWithImpl(this._self, this._then);

  final _PasswordSubmitted _self;
  final $Res Function(_PasswordSubmitted) _then;

/// Create a copy of SignUpEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? password = null,Object? locale = null,}) {
  return _then(_PasswordSubmitted(
password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,locale: null == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _PasswordVisibilityToggled implements SignUpEvent {
  const _PasswordVisibilityToggled();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PasswordVisibilityToggled);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'SignUpEvent.passwordVisibilityToggled()';
}


}




/// @nodoc


class _ConfirmPasswordVisibilityToggled implements SignUpEvent {
  const _ConfirmPasswordVisibilityToggled();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConfirmPasswordVisibilityToggled);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'SignUpEvent.confirmPasswordVisibilityToggled()';
}


}




/// @nodoc


class _Reset implements SignUpEvent {
  const _Reset();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Reset);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'SignUpEvent.reset()';
}


}




/// @nodoc
mixin _$SignUpState {

 SignUpStep get step; String get fullName; String get email; UuidValue? get accountRequestId; String? get registrationToken; GenericStatus get signUpStatus; String? get signUpErrorMessage; bool get isPasswordVisible; bool get isConfirmPasswordVisible;
/// Create a copy of SignUpState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignUpStateCopyWith<SignUpState> get copyWith => _$SignUpStateCopyWithImpl<SignUpState>(this as SignUpState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SignUpState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignUpState&&(identical(other.step, _this.step) || other.step == _this.step)&&(identical(other.fullName, _this.fullName) || other.fullName == _this.fullName)&&(identical(other.email, _this.email) || other.email == _this.email)&&(identical(other.accountRequestId, _this.accountRequestId) || other.accountRequestId == _this.accountRequestId)&&(identical(other.registrationToken, _this.registrationToken) || other.registrationToken == _this.registrationToken)&&(identical(other.signUpStatus, _this.signUpStatus) || other.signUpStatus == _this.signUpStatus)&&(identical(other.signUpErrorMessage, _this.signUpErrorMessage) || other.signUpErrorMessage == _this.signUpErrorMessage)&&(identical(other.isPasswordVisible, _this.isPasswordVisible) || other.isPasswordVisible == _this.isPasswordVisible)&&(identical(other.isConfirmPasswordVisible, _this.isConfirmPasswordVisible) || other.isConfirmPasswordVisible == _this.isConfirmPasswordVisible));
}


@override
int get hashCode {
  final _this = this as SignUpState;
  return Object.hash(runtimeType,_this.step,_this.fullName,_this.email,_this.accountRequestId,_this.registrationToken,_this.signUpStatus,_this.signUpErrorMessage,_this.isPasswordVisible,_this.isConfirmPasswordVisible);
}

@override
String toString() {
  final _this = this as SignUpState;
  return 'SignUpState(step: ${_this.step}, fullName: ${_this.fullName}, email: ${_this.email}, accountRequestId: ${_this.accountRequestId}, registrationToken: ${_this.registrationToken}, signUpStatus: ${_this.signUpStatus}, signUpErrorMessage: ${_this.signUpErrorMessage}, isPasswordVisible: ${_this.isPasswordVisible}, isConfirmPasswordVisible: ${_this.isConfirmPasswordVisible})';
}


}

/// @nodoc
abstract mixin class $SignUpStateCopyWith<$Res>  {
  factory $SignUpStateCopyWith(SignUpState value, $Res Function(SignUpState) _then) = _$SignUpStateCopyWithImpl;
@useResult
$Res call({
 SignUpStep step, String fullName, String email, UuidValue? accountRequestId, String? registrationToken, GenericStatus signUpStatus, String? signUpErrorMessage, bool isPasswordVisible, bool isConfirmPasswordVisible
});




}
/// @nodoc
class _$SignUpStateCopyWithImpl<$Res>
    implements $SignUpStateCopyWith<$Res> {
  _$SignUpStateCopyWithImpl(this._self, this._then);

  final SignUpState _self;
  final $Res Function(SignUpState) _then;

/// Create a copy of SignUpState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? step = null,Object? fullName = null,Object? email = null,Object? accountRequestId = freezed,Object? registrationToken = freezed,Object? signUpStatus = null,Object? signUpErrorMessage = freezed,Object? isPasswordVisible = null,Object? isConfirmPasswordVisible = null,}) {
  return _then(SignUpState(
step: null == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as SignUpStep,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,accountRequestId: freezed == accountRequestId ? _self.accountRequestId : accountRequestId // ignore: cast_nullable_to_non_nullable
as UuidValue?,registrationToken: freezed == registrationToken ? _self.registrationToken : registrationToken // ignore: cast_nullable_to_non_nullable
as String?,signUpStatus: null == signUpStatus ? _self.signUpStatus : signUpStatus // ignore: cast_nullable_to_non_nullable
as GenericStatus,signUpErrorMessage: freezed == signUpErrorMessage ? _self.signUpErrorMessage : signUpErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,isPasswordVisible: null == isPasswordVisible ? _self.isPasswordVisible : isPasswordVisible // ignore: cast_nullable_to_non_nullable
as bool,isConfirmPasswordVisible: null == isConfirmPasswordVisible ? _self.isConfirmPasswordVisible : isConfirmPasswordVisible // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SignUpState].
extension SignUpStatePatterns on SignUpState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SignUpState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SignUpState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SignUpState value)  $default,){
final _that = this;
switch (_that) {
case _SignUpState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SignUpState value)?  $default,){
final _that = this;
switch (_that) {
case _SignUpState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SignUpStep step,  String fullName,  String email,  UuidValue? accountRequestId,  String? registrationToken,  GenericStatus signUpStatus,  String? signUpErrorMessage,  bool isPasswordVisible,  bool isConfirmPasswordVisible)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SignUpState() when $default != null:
return $default(_that.step,_that.fullName,_that.email,_that.accountRequestId,_that.registrationToken,_that.signUpStatus,_that.signUpErrorMessage,_that.isPasswordVisible,_that.isConfirmPasswordVisible);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SignUpStep step,  String fullName,  String email,  UuidValue? accountRequestId,  String? registrationToken,  GenericStatus signUpStatus,  String? signUpErrorMessage,  bool isPasswordVisible,  bool isConfirmPasswordVisible)  $default,) {final _that = this;
switch (_that) {
case _SignUpState():
return $default(_that.step,_that.fullName,_that.email,_that.accountRequestId,_that.registrationToken,_that.signUpStatus,_that.signUpErrorMessage,_that.isPasswordVisible,_that.isConfirmPasswordVisible);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SignUpStep step,  String fullName,  String email,  UuidValue? accountRequestId,  String? registrationToken,  GenericStatus signUpStatus,  String? signUpErrorMessage,  bool isPasswordVisible,  bool isConfirmPasswordVisible)?  $default,) {final _that = this;
switch (_that) {
case _SignUpState() when $default != null:
return $default(_that.step,_that.fullName,_that.email,_that.accountRequestId,_that.registrationToken,_that.signUpStatus,_that.signUpErrorMessage,_that.isPasswordVisible,_that.isConfirmPasswordVisible);case _:
  return null;

}
}

}

/// @nodoc


class _SignUpState implements SignUpState {
  const _SignUpState({this.step = SignUpStep.details, this.fullName = '', this.email = '', this.accountRequestId, this.registrationToken, this.signUpStatus = GenericStatus.initial, this.signUpErrorMessage, this.isPasswordVisible = false, this.isConfirmPasswordVisible = false});
  

@override@JsonKey() final  SignUpStep step;
@override@JsonKey() final  String fullName;
@override@JsonKey() final  String email;
@override final  UuidValue? accountRequestId;
@override final  String? registrationToken;
@override@JsonKey() final  GenericStatus signUpStatus;
@override final  String? signUpErrorMessage;
@override@JsonKey() final  bool isPasswordVisible;
@override@JsonKey() final  bool isConfirmPasswordVisible;

/// Create a copy of SignUpState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SignUpStateCopyWith<_SignUpState> get copyWith => __$SignUpStateCopyWithImpl<_SignUpState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignUpState&&(identical(other.step, step) || other.step == step)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.email, email) || other.email == email)&&(identical(other.accountRequestId, accountRequestId) || other.accountRequestId == accountRequestId)&&(identical(other.registrationToken, registrationToken) || other.registrationToken == registrationToken)&&(identical(other.signUpStatus, signUpStatus) || other.signUpStatus == signUpStatus)&&(identical(other.signUpErrorMessage, signUpErrorMessage) || other.signUpErrorMessage == signUpErrorMessage)&&(identical(other.isPasswordVisible, isPasswordVisible) || other.isPasswordVisible == isPasswordVisible)&&(identical(other.isConfirmPasswordVisible, isConfirmPasswordVisible) || other.isConfirmPasswordVisible == isConfirmPasswordVisible));
}


@override
int get hashCode {
    return Object.hash(runtimeType,step,fullName,email,accountRequestId,registrationToken,signUpStatus,signUpErrorMessage,isPasswordVisible,isConfirmPasswordVisible);
}

@override
String toString() {
    return 'SignUpState(step: $step, fullName: $fullName, email: $email, accountRequestId: $accountRequestId, registrationToken: $registrationToken, signUpStatus: $signUpStatus, signUpErrorMessage: $signUpErrorMessage, isPasswordVisible: $isPasswordVisible, isConfirmPasswordVisible: $isConfirmPasswordVisible)';
}


}

/// @nodoc
abstract mixin class _$SignUpStateCopyWith<$Res> implements $SignUpStateCopyWith<$Res> {
  factory _$SignUpStateCopyWith(_SignUpState value, $Res Function(_SignUpState) _then) = __$SignUpStateCopyWithImpl;
@override @useResult
$Res call({
 SignUpStep step, String fullName, String email, UuidValue? accountRequestId, String? registrationToken, GenericStatus signUpStatus, String? signUpErrorMessage, bool isPasswordVisible, bool isConfirmPasswordVisible
});




}
/// @nodoc
class __$SignUpStateCopyWithImpl<$Res>
    implements _$SignUpStateCopyWith<$Res> {
  __$SignUpStateCopyWithImpl(this._self, this._then);

  final _SignUpState _self;
  final $Res Function(_SignUpState) _then;

/// Create a copy of SignUpState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? step = null,Object? fullName = null,Object? email = null,Object? accountRequestId = freezed,Object? registrationToken = freezed,Object? signUpStatus = null,Object? signUpErrorMessage = freezed,Object? isPasswordVisible = null,Object? isConfirmPasswordVisible = null,}) {
  return _then(_SignUpState(
step: null == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as SignUpStep,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,accountRequestId: freezed == accountRequestId ? _self.accountRequestId : accountRequestId // ignore: cast_nullable_to_non_nullable
as UuidValue?,registrationToken: freezed == registrationToken ? _self.registrationToken : registrationToken // ignore: cast_nullable_to_non_nullable
as String?,signUpStatus: null == signUpStatus ? _self.signUpStatus : signUpStatus // ignore: cast_nullable_to_non_nullable
as GenericStatus,signUpErrorMessage: freezed == signUpErrorMessage ? _self.signUpErrorMessage : signUpErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,isPasswordVisible: null == isPasswordVisible ? _self.isPasswordVisible : isPasswordVisible // ignore: cast_nullable_to_non_nullable
as bool,isConfirmPasswordVisible: null == isConfirmPasswordVisible ? _self.isConfirmPasswordVisible : isConfirmPasswordVisible // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
