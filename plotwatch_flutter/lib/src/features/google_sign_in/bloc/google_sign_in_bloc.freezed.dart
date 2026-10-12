// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'google_sign_in_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GoogleSignInEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is GoogleSignInEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'GoogleSignInEvent()';
}


}

/// @nodoc
class $GoogleSignInEventCopyWith<$Res>  {
$GoogleSignInEventCopyWith(GoogleSignInEvent _, $Res Function(GoogleSignInEvent) __);
}


/// Adds pattern-matching-related methods to [GoogleSignInEvent].
extension GoogleSignInEventPatterns on GoogleSignInEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _Reset value)?  reset,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _Reset() when reset != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _Reset value)  reset,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _Reset():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _Reset value)?  reset,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _Reset() when reset != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String locale)?  started,TResult Function()?  reset,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that.locale);case _Reset() when reset != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String locale)  started,required TResult Function()  reset,}) {final _that = this;
switch (_that) {
case _Started():
return started(_that.locale);case _Reset():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String locale)?  started,TResult? Function()?  reset,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that.locale);case _Reset() when reset != null:
return reset();case _:
  return null;

}
}

}

/// @nodoc


class _Started implements GoogleSignInEvent {
  const _Started({required this.locale});
  

 final  String locale;

/// Create a copy of GoogleSignInEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StartedCopyWith<_Started> get copyWith => __$StartedCopyWithImpl<_Started>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started&&(identical(other.locale, locale) || other.locale == locale));
}


@override
int get hashCode {
    return Object.hash(runtimeType,locale);
}

@override
String toString() {
    return 'GoogleSignInEvent.started(locale: $locale)';
}


}

/// @nodoc
abstract mixin class _$StartedCopyWith<$Res> implements $GoogleSignInEventCopyWith<$Res> {
  factory _$StartedCopyWith(_Started value, $Res Function(_Started) _then) = __$StartedCopyWithImpl;
@useResult
$Res call({
 String locale
});




}
/// @nodoc
class __$StartedCopyWithImpl<$Res>
    implements _$StartedCopyWith<$Res> {
  __$StartedCopyWithImpl(this._self, this._then);

  final _Started _self;
  final $Res Function(_Started) _then;

/// Create a copy of GoogleSignInEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? locale = null,}) {
  return _then(_Started(
locale: null == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _Reset implements GoogleSignInEvent {
  const _Reset();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Reset);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'GoogleSignInEvent.reset()';
}


}




/// @nodoc
mixin _$GoogleSignInState {

/// False where Google sign-in isn't configured: the button stays hidden.
 bool get isAvailable; GenericStatus get status; String? get errorMessage;
/// Create a copy of GoogleSignInState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GoogleSignInStateCopyWith<GoogleSignInState> get copyWith => _$GoogleSignInStateCopyWithImpl<GoogleSignInState>(this as GoogleSignInState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as GoogleSignInState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GoogleSignInState&&(identical(other.isAvailable, _this.isAvailable) || other.isAvailable == _this.isAvailable)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.errorMessage, _this.errorMessage) || other.errorMessage == _this.errorMessage));
}


@override
int get hashCode {
  final _this = this as GoogleSignInState;
  return Object.hash(runtimeType,_this.isAvailable,_this.status,_this.errorMessage);
}

@override
String toString() {
  final _this = this as GoogleSignInState;
  return 'GoogleSignInState(isAvailable: ${_this.isAvailable}, status: ${_this.status}, errorMessage: ${_this.errorMessage})';
}


}

/// @nodoc
abstract mixin class $GoogleSignInStateCopyWith<$Res>  {
  factory $GoogleSignInStateCopyWith(GoogleSignInState value, $Res Function(GoogleSignInState) _then) = _$GoogleSignInStateCopyWithImpl;
@useResult
$Res call({
 bool isAvailable, GenericStatus status, String? errorMessage
});




}
/// @nodoc
class _$GoogleSignInStateCopyWithImpl<$Res>
    implements $GoogleSignInStateCopyWith<$Res> {
  _$GoogleSignInStateCopyWithImpl(this._self, this._then);

  final GoogleSignInState _self;
  final $Res Function(GoogleSignInState) _then;

/// Create a copy of GoogleSignInState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isAvailable = null,Object? status = null,Object? errorMessage = freezed,}) {
  return _then(GoogleSignInState(
isAvailable: null == isAvailable ? _self.isAvailable : isAvailable // ignore: cast_nullable_to_non_nullable
as bool,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as GenericStatus,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [GoogleSignInState].
extension GoogleSignInStatePatterns on GoogleSignInState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GoogleSignInState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GoogleSignInState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GoogleSignInState value)  $default,){
final _that = this;
switch (_that) {
case _GoogleSignInState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GoogleSignInState value)?  $default,){
final _that = this;
switch (_that) {
case _GoogleSignInState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isAvailable,  GenericStatus status,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GoogleSignInState() when $default != null:
return $default(_that.isAvailable,_that.status,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isAvailable,  GenericStatus status,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _GoogleSignInState():
return $default(_that.isAvailable,_that.status,_that.errorMessage);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isAvailable,  GenericStatus status,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _GoogleSignInState() when $default != null:
return $default(_that.isAvailable,_that.status,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _GoogleSignInState implements GoogleSignInState {
  const _GoogleSignInState({this.isAvailable = false, this.status = GenericStatus.initial, this.errorMessage});
  

/// False where Google sign-in isn't configured: the button stays hidden.
@override@JsonKey() final  bool isAvailable;
@override@JsonKey() final  GenericStatus status;
@override final  String? errorMessage;

/// Create a copy of GoogleSignInState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GoogleSignInStateCopyWith<_GoogleSignInState> get copyWith => __$GoogleSignInStateCopyWithImpl<_GoogleSignInState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _GoogleSignInState&&(identical(other.isAvailable, isAvailable) || other.isAvailable == isAvailable)&&(identical(other.status, status) || other.status == status)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode {
    return Object.hash(runtimeType,isAvailable,status,errorMessage);
}

@override
String toString() {
    return 'GoogleSignInState(isAvailable: $isAvailable, status: $status, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$GoogleSignInStateCopyWith<$Res> implements $GoogleSignInStateCopyWith<$Res> {
  factory _$GoogleSignInStateCopyWith(_GoogleSignInState value, $Res Function(_GoogleSignInState) _then) = __$GoogleSignInStateCopyWithImpl;
@override @useResult
$Res call({
 bool isAvailable, GenericStatus status, String? errorMessage
});




}
/// @nodoc
class __$GoogleSignInStateCopyWithImpl<$Res>
    implements _$GoogleSignInStateCopyWith<$Res> {
  __$GoogleSignInStateCopyWithImpl(this._self, this._then);

  final _GoogleSignInState _self;
  final $Res Function(_GoogleSignInState) _then;

/// Create a copy of GoogleSignInState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isAvailable = null,Object? status = null,Object? errorMessage = freezed,}) {
  return _then(_GoogleSignInState(
isAvailable: null == isAvailable ? _self.isAvailable : isAvailable // ignore: cast_nullable_to_non_nullable
as bool,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as GenericStatus,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
