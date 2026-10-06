// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProfileEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'ProfileEvent()';
}


}

/// @nodoc
class $ProfileEventCopyWith<$Res>  {
$ProfileEventCopyWith(ProfileEvent _, $Res Function(ProfileEvent) __);
}


/// Adds pattern-matching-related methods to [ProfileEvent].
extension ProfileEventPatterns on ProfileEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _FetchMe value)?  fetchMe,TResult Function( _UpdateMe value)?  updateMe,TResult Function( _ResetFlowStep value)?  resetFlowStep,TResult Function( _Reset value)?  reset,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FetchMe() when fetchMe != null:
return fetchMe(_that);case _UpdateMe() when updateMe != null:
return updateMe(_that);case _ResetFlowStep() when resetFlowStep != null:
return resetFlowStep(_that);case _Reset() when reset != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _FetchMe value)  fetchMe,required TResult Function( _UpdateMe value)  updateMe,required TResult Function( _ResetFlowStep value)  resetFlowStep,required TResult Function( _Reset value)  reset,}){
final _that = this;
switch (_that) {
case _FetchMe():
return fetchMe(_that);case _UpdateMe():
return updateMe(_that);case _ResetFlowStep():
return resetFlowStep(_that);case _Reset():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _FetchMe value)?  fetchMe,TResult? Function( _UpdateMe value)?  updateMe,TResult? Function( _ResetFlowStep value)?  resetFlowStep,TResult? Function( _Reset value)?  reset,}){
final _that = this;
switch (_that) {
case _FetchMe() when fetchMe != null:
return fetchMe(_that);case _UpdateMe() when updateMe != null:
return updateMe(_that);case _ResetFlowStep() when resetFlowStep != null:
return resetFlowStep(_that);case _Reset() when reset != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  fetchMe,TResult Function( String fullName,  String? countryCode,  String locale)?  updateMe,TResult Function()?  resetFlowStep,TResult Function()?  reset,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FetchMe() when fetchMe != null:
return fetchMe();case _UpdateMe() when updateMe != null:
return updateMe(_that.fullName,_that.countryCode,_that.locale);case _ResetFlowStep() when resetFlowStep != null:
return resetFlowStep();case _Reset() when reset != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  fetchMe,required TResult Function( String fullName,  String? countryCode,  String locale)  updateMe,required TResult Function()  resetFlowStep,required TResult Function()  reset,}) {final _that = this;
switch (_that) {
case _FetchMe():
return fetchMe();case _UpdateMe():
return updateMe(_that.fullName,_that.countryCode,_that.locale);case _ResetFlowStep():
return resetFlowStep();case _Reset():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  fetchMe,TResult? Function( String fullName,  String? countryCode,  String locale)?  updateMe,TResult? Function()?  resetFlowStep,TResult? Function()?  reset,}) {final _that = this;
switch (_that) {
case _FetchMe() when fetchMe != null:
return fetchMe();case _UpdateMe() when updateMe != null:
return updateMe(_that.fullName,_that.countryCode,_that.locale);case _ResetFlowStep() when resetFlowStep != null:
return resetFlowStep();case _Reset() when reset != null:
return reset();case _:
  return null;

}
}

}

/// @nodoc


class _FetchMe implements ProfileEvent {
  const _FetchMe();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FetchMe);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'ProfileEvent.fetchMe()';
}


}




/// @nodoc


class _UpdateMe implements ProfileEvent {
  const _UpdateMe({required this.fullName, this.countryCode, required this.locale});
  

 final  String fullName;
 final  String? countryCode;
 final  String locale;

/// Create a copy of ProfileEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateMeCopyWith<_UpdateMe> get copyWith => __$UpdateMeCopyWithImpl<_UpdateMe>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateMe&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.countryCode, countryCode) || other.countryCode == countryCode)&&(identical(other.locale, locale) || other.locale == locale));
}


@override
int get hashCode {
    return Object.hash(runtimeType,fullName,countryCode,locale);
}

@override
String toString() {
    return 'ProfileEvent.updateMe(fullName: $fullName, countryCode: $countryCode, locale: $locale)';
}


}

/// @nodoc
abstract mixin class _$UpdateMeCopyWith<$Res> implements $ProfileEventCopyWith<$Res> {
  factory _$UpdateMeCopyWith(_UpdateMe value, $Res Function(_UpdateMe) _then) = __$UpdateMeCopyWithImpl;
@useResult
$Res call({
 String fullName, String? countryCode, String locale
});




}
/// @nodoc
class __$UpdateMeCopyWithImpl<$Res>
    implements _$UpdateMeCopyWith<$Res> {
  __$UpdateMeCopyWithImpl(this._self, this._then);

  final _UpdateMe _self;
  final $Res Function(_UpdateMe) _then;

/// Create a copy of ProfileEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? fullName = null,Object? countryCode = freezed,Object? locale = null,}) {
  return _then(_UpdateMe(
fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,countryCode: freezed == countryCode ? _self.countryCode : countryCode // ignore: cast_nullable_to_non_nullable
as String?,locale: null == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _ResetFlowStep implements ProfileEvent {
  const _ResetFlowStep();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResetFlowStep);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'ProfileEvent.resetFlowStep()';
}


}




/// @nodoc


class _Reset implements ProfileEvent {
  const _Reset();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Reset);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'ProfileEvent.reset()';
}


}




/// @nodoc
mixin _$ProfileState {

 MyProfile? get profile; GenericStatus get profileStatus; GenericStatus get profileActionStatus; GenericFlowStep get flowStep; String? get profileErrorMessage; String? get profileActionErrorMessage;
/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileStateCopyWith<ProfileState> get copyWith => _$ProfileStateCopyWithImpl<ProfileState>(this as ProfileState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ProfileState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileState&&(identical(other.profile, _this.profile) || other.profile == _this.profile)&&(identical(other.profileStatus, _this.profileStatus) || other.profileStatus == _this.profileStatus)&&(identical(other.profileActionStatus, _this.profileActionStatus) || other.profileActionStatus == _this.profileActionStatus)&&(identical(other.flowStep, _this.flowStep) || other.flowStep == _this.flowStep)&&(identical(other.profileErrorMessage, _this.profileErrorMessage) || other.profileErrorMessage == _this.profileErrorMessage)&&(identical(other.profileActionErrorMessage, _this.profileActionErrorMessage) || other.profileActionErrorMessage == _this.profileActionErrorMessage));
}


@override
int get hashCode {
  final _this = this as ProfileState;
  return Object.hash(runtimeType,_this.profile,_this.profileStatus,_this.profileActionStatus,_this.flowStep,_this.profileErrorMessage,_this.profileActionErrorMessage);
}

@override
String toString() {
  final _this = this as ProfileState;
  return 'ProfileState(profile: ${_this.profile}, profileStatus: ${_this.profileStatus}, profileActionStatus: ${_this.profileActionStatus}, flowStep: ${_this.flowStep}, profileErrorMessage: ${_this.profileErrorMessage}, profileActionErrorMessage: ${_this.profileActionErrorMessage})';
}


}

/// @nodoc
abstract mixin class $ProfileStateCopyWith<$Res>  {
  factory $ProfileStateCopyWith(ProfileState value, $Res Function(ProfileState) _then) = _$ProfileStateCopyWithImpl;
@useResult
$Res call({
 MyProfile? profile, GenericStatus profileStatus, GenericStatus profileActionStatus, GenericFlowStep flowStep, String? profileErrorMessage, String? profileActionErrorMessage
});




}
/// @nodoc
class _$ProfileStateCopyWithImpl<$Res>
    implements $ProfileStateCopyWith<$Res> {
  _$ProfileStateCopyWithImpl(this._self, this._then);

  final ProfileState _self;
  final $Res Function(ProfileState) _then;

/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? profile = freezed,Object? profileStatus = null,Object? profileActionStatus = null,Object? flowStep = null,Object? profileErrorMessage = freezed,Object? profileActionErrorMessage = freezed,}) {
  return _then(ProfileState(
profile: freezed == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as MyProfile?,profileStatus: null == profileStatus ? _self.profileStatus : profileStatus // ignore: cast_nullable_to_non_nullable
as GenericStatus,profileActionStatus: null == profileActionStatus ? _self.profileActionStatus : profileActionStatus // ignore: cast_nullable_to_non_nullable
as GenericStatus,flowStep: null == flowStep ? _self.flowStep : flowStep // ignore: cast_nullable_to_non_nullable
as GenericFlowStep,profileErrorMessage: freezed == profileErrorMessage ? _self.profileErrorMessage : profileErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,profileActionErrorMessage: freezed == profileActionErrorMessage ? _self.profileActionErrorMessage : profileActionErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProfileState].
extension ProfileStatePatterns on ProfileState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfileState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfileState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfileState value)  $default,){
final _that = this;
switch (_that) {
case _ProfileState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfileState value)?  $default,){
final _that = this;
switch (_that) {
case _ProfileState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( MyProfile? profile,  GenericStatus profileStatus,  GenericStatus profileActionStatus,  GenericFlowStep flowStep,  String? profileErrorMessage,  String? profileActionErrorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfileState() when $default != null:
return $default(_that.profile,_that.profileStatus,_that.profileActionStatus,_that.flowStep,_that.profileErrorMessage,_that.profileActionErrorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( MyProfile? profile,  GenericStatus profileStatus,  GenericStatus profileActionStatus,  GenericFlowStep flowStep,  String? profileErrorMessage,  String? profileActionErrorMessage)  $default,) {final _that = this;
switch (_that) {
case _ProfileState():
return $default(_that.profile,_that.profileStatus,_that.profileActionStatus,_that.flowStep,_that.profileErrorMessage,_that.profileActionErrorMessage);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( MyProfile? profile,  GenericStatus profileStatus,  GenericStatus profileActionStatus,  GenericFlowStep flowStep,  String? profileErrorMessage,  String? profileActionErrorMessage)?  $default,) {final _that = this;
switch (_that) {
case _ProfileState() when $default != null:
return $default(_that.profile,_that.profileStatus,_that.profileActionStatus,_that.flowStep,_that.profileErrorMessage,_that.profileActionErrorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _ProfileState extends ProfileState {
  const _ProfileState({this.profile, this.profileStatus = GenericStatus.initial, this.profileActionStatus = GenericStatus.initial, this.flowStep = GenericFlowStep.none, this.profileErrorMessage, this.profileActionErrorMessage}): super._();
  

@override final  MyProfile? profile;
@override@JsonKey() final  GenericStatus profileStatus;
@override@JsonKey() final  GenericStatus profileActionStatus;
@override@JsonKey() final  GenericFlowStep flowStep;
@override final  String? profileErrorMessage;
@override final  String? profileActionErrorMessage;

/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileStateCopyWith<_ProfileState> get copyWith => __$ProfileStateCopyWithImpl<_ProfileState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileState&&(identical(other.profile, profile) || other.profile == profile)&&(identical(other.profileStatus, profileStatus) || other.profileStatus == profileStatus)&&(identical(other.profileActionStatus, profileActionStatus) || other.profileActionStatus == profileActionStatus)&&(identical(other.flowStep, flowStep) || other.flowStep == flowStep)&&(identical(other.profileErrorMessage, profileErrorMessage) || other.profileErrorMessage == profileErrorMessage)&&(identical(other.profileActionErrorMessage, profileActionErrorMessage) || other.profileActionErrorMessage == profileActionErrorMessage));
}


@override
int get hashCode {
    return Object.hash(runtimeType,profile,profileStatus,profileActionStatus,flowStep,profileErrorMessage,profileActionErrorMessage);
}

@override
String toString() {
    return 'ProfileState(profile: $profile, profileStatus: $profileStatus, profileActionStatus: $profileActionStatus, flowStep: $flowStep, profileErrorMessage: $profileErrorMessage, profileActionErrorMessage: $profileActionErrorMessage)';
}


}

/// @nodoc
abstract mixin class _$ProfileStateCopyWith<$Res> implements $ProfileStateCopyWith<$Res> {
  factory _$ProfileStateCopyWith(_ProfileState value, $Res Function(_ProfileState) _then) = __$ProfileStateCopyWithImpl;
@override @useResult
$Res call({
 MyProfile? profile, GenericStatus profileStatus, GenericStatus profileActionStatus, GenericFlowStep flowStep, String? profileErrorMessage, String? profileActionErrorMessage
});




}
/// @nodoc
class __$ProfileStateCopyWithImpl<$Res>
    implements _$ProfileStateCopyWith<$Res> {
  __$ProfileStateCopyWithImpl(this._self, this._then);

  final _ProfileState _self;
  final $Res Function(_ProfileState) _then;

/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? profile = freezed,Object? profileStatus = null,Object? profileActionStatus = null,Object? flowStep = null,Object? profileErrorMessage = freezed,Object? profileActionErrorMessage = freezed,}) {
  return _then(_ProfileState(
profile: freezed == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as MyProfile?,profileStatus: null == profileStatus ? _self.profileStatus : profileStatus // ignore: cast_nullable_to_non_nullable
as GenericStatus,profileActionStatus: null == profileActionStatus ? _self.profileActionStatus : profileActionStatus // ignore: cast_nullable_to_non_nullable
as GenericStatus,flowStep: null == flowStep ? _self.flowStep : flowStep // ignore: cast_nullable_to_non_nullable
as GenericFlowStep,profileErrorMessage: freezed == profileErrorMessage ? _self.profileErrorMessage : profileErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,profileActionErrorMessage: freezed == profileActionErrorMessage ? _self.profileActionErrorMessage : profileActionErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
