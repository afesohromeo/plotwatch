// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'localize_site_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LocalizeSiteEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is LocalizeSiteEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'LocalizeSiteEvent()';
}


}

/// @nodoc
class $LocalizeSiteEventCopyWith<$Res>  {
$LocalizeSiteEventCopyWith(LocalizeSiteEvent _, $Res Function(LocalizeSiteEvent) __);
}


/// Adds pattern-matching-related methods to [LocalizeSiteEvent].
extension LocalizeSiteEventPatterns on LocalizeSiteEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _SettingsRequested value)?  settingsRequested,TResult Function( _ProposeRequested value)?  proposeRequested,TResult Function( _ResetFlowStep value)?  resetFlowStep,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _SettingsRequested() when settingsRequested != null:
return settingsRequested(_that);case _ProposeRequested() when proposeRequested != null:
return proposeRequested(_that);case _ResetFlowStep() when resetFlowStep != null:
return resetFlowStep(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _SettingsRequested value)  settingsRequested,required TResult Function( _ProposeRequested value)  proposeRequested,required TResult Function( _ResetFlowStep value)  resetFlowStep,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _SettingsRequested():
return settingsRequested(_that);case _ProposeRequested():
return proposeRequested(_that);case _ResetFlowStep():
return resetFlowStep(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _SettingsRequested value)?  settingsRequested,TResult? Function( _ProposeRequested value)?  proposeRequested,TResult? Function( _ResetFlowStep value)?  resetFlowStep,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _SettingsRequested() when settingsRequested != null:
return settingsRequested(_that);case _ProposeRequested() when proposeRequested != null:
return proposeRequested(_that);case _ResetFlowStep() when resetFlowStep != null:
return resetFlowStep(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int projectId)?  started,TResult Function()?  settingsRequested,TResult Function( int projectId)?  proposeRequested,TResult Function()?  resetFlowStep,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that.projectId);case _SettingsRequested() when settingsRequested != null:
return settingsRequested();case _ProposeRequested() when proposeRequested != null:
return proposeRequested(_that.projectId);case _ResetFlowStep() when resetFlowStep != null:
return resetFlowStep();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int projectId)  started,required TResult Function()  settingsRequested,required TResult Function( int projectId)  proposeRequested,required TResult Function()  resetFlowStep,}) {final _that = this;
switch (_that) {
case _Started():
return started(_that.projectId);case _SettingsRequested():
return settingsRequested();case _ProposeRequested():
return proposeRequested(_that.projectId);case _ResetFlowStep():
return resetFlowStep();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int projectId)?  started,TResult? Function()?  settingsRequested,TResult? Function( int projectId)?  proposeRequested,TResult? Function()?  resetFlowStep,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that.projectId);case _SettingsRequested() when settingsRequested != null:
return settingsRequested();case _ProposeRequested() when proposeRequested != null:
return proposeRequested(_that.projectId);case _ResetFlowStep() when resetFlowStep != null:
return resetFlowStep();case _:
  return null;

}
}

}

/// @nodoc


class _Started implements LocalizeSiteEvent {
  const _Started({required this.projectId});
  

 final  int projectId;

/// Create a copy of LocalizeSiteEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StartedCopyWith<_Started> get copyWith => __$StartedCopyWithImpl<_Started>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started&&(identical(other.projectId, projectId) || other.projectId == projectId));
}


@override
int get hashCode {
    return Object.hash(runtimeType,projectId);
}

@override
String toString() {
    return 'LocalizeSiteEvent.started(projectId: $projectId)';
}


}

/// @nodoc
abstract mixin class _$StartedCopyWith<$Res> implements $LocalizeSiteEventCopyWith<$Res> {
  factory _$StartedCopyWith(_Started value, $Res Function(_Started) _then) = __$StartedCopyWithImpl;
@useResult
$Res call({
 int projectId
});




}
/// @nodoc
class __$StartedCopyWithImpl<$Res>
    implements _$StartedCopyWith<$Res> {
  __$StartedCopyWithImpl(this._self, this._then);

  final _Started _self;
  final $Res Function(_Started) _then;

/// Create a copy of LocalizeSiteEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? projectId = null,}) {
  return _then(_Started(
projectId: null == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _SettingsRequested implements LocalizeSiteEvent {
  const _SettingsRequested();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SettingsRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'LocalizeSiteEvent.settingsRequested()';
}


}




/// @nodoc


class _ProposeRequested implements LocalizeSiteEvent {
  const _ProposeRequested({required this.projectId});
  

 final  int projectId;

/// Create a copy of LocalizeSiteEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProposeRequestedCopyWith<_ProposeRequested> get copyWith => __$ProposeRequestedCopyWithImpl<_ProposeRequested>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProposeRequested&&(identical(other.projectId, projectId) || other.projectId == projectId));
}


@override
int get hashCode {
    return Object.hash(runtimeType,projectId);
}

@override
String toString() {
    return 'LocalizeSiteEvent.proposeRequested(projectId: $projectId)';
}


}

/// @nodoc
abstract mixin class _$ProposeRequestedCopyWith<$Res> implements $LocalizeSiteEventCopyWith<$Res> {
  factory _$ProposeRequestedCopyWith(_ProposeRequested value, $Res Function(_ProposeRequested) _then) = __$ProposeRequestedCopyWithImpl;
@useResult
$Res call({
 int projectId
});




}
/// @nodoc
class __$ProposeRequestedCopyWithImpl<$Res>
    implements _$ProposeRequestedCopyWith<$Res> {
  __$ProposeRequestedCopyWithImpl(this._self, this._then);

  final _ProposeRequested _self;
  final $Res Function(_ProposeRequested) _then;

/// Create a copy of LocalizeSiteEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? projectId = null,}) {
  return _then(_ProposeRequested(
projectId: null == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _ResetFlowStep implements LocalizeSiteEvent {
  const _ResetFlowStep();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResetFlowStep);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'LocalizeSiteEvent.resetFlowStep()';
}


}




/// @nodoc
mixin _$LocalizeSiteState {

/// Decides where saving leads: the owner validates at once (G-12).
 ProjectRole? get myRole; String? get loadErrorMessage;/// Null while checking.
 LocationAccess? get access; GpsReading? get reading; GenericStatus get proposeStatus; String? get proposeErrorMessage; SiteProposal? get proposal;
/// Create a copy of LocalizeSiteState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LocalizeSiteStateCopyWith<LocalizeSiteState> get copyWith => _$LocalizeSiteStateCopyWithImpl<LocalizeSiteState>(this as LocalizeSiteState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as LocalizeSiteState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocalizeSiteState&&(identical(other.myRole, _this.myRole) || other.myRole == _this.myRole)&&(identical(other.loadErrorMessage, _this.loadErrorMessage) || other.loadErrorMessage == _this.loadErrorMessage)&&(identical(other.access, _this.access) || other.access == _this.access)&&(identical(other.reading, _this.reading) || other.reading == _this.reading)&&(identical(other.proposeStatus, _this.proposeStatus) || other.proposeStatus == _this.proposeStatus)&&(identical(other.proposeErrorMessage, _this.proposeErrorMessage) || other.proposeErrorMessage == _this.proposeErrorMessage)&&(identical(other.proposal, _this.proposal) || other.proposal == _this.proposal));
}


@override
int get hashCode {
  final _this = this as LocalizeSiteState;
  return Object.hash(runtimeType,_this.myRole,_this.loadErrorMessage,_this.access,_this.reading,_this.proposeStatus,_this.proposeErrorMessage,_this.proposal);
}

@override
String toString() {
  final _this = this as LocalizeSiteState;
  return 'LocalizeSiteState(myRole: ${_this.myRole}, loadErrorMessage: ${_this.loadErrorMessage}, access: ${_this.access}, reading: ${_this.reading}, proposeStatus: ${_this.proposeStatus}, proposeErrorMessage: ${_this.proposeErrorMessage}, proposal: ${_this.proposal})';
}


}

/// @nodoc
abstract mixin class $LocalizeSiteStateCopyWith<$Res>  {
  factory $LocalizeSiteStateCopyWith(LocalizeSiteState value, $Res Function(LocalizeSiteState) _then) = _$LocalizeSiteStateCopyWithImpl;
@useResult
$Res call({
 ProjectRole? myRole, String? loadErrorMessage, LocationAccess? access, GpsReading? reading, GenericStatus proposeStatus, String? proposeErrorMessage, SiteProposal? proposal
});


$GpsReadingCopyWith<$Res>? get reading;

}
/// @nodoc
class _$LocalizeSiteStateCopyWithImpl<$Res>
    implements $LocalizeSiteStateCopyWith<$Res> {
  _$LocalizeSiteStateCopyWithImpl(this._self, this._then);

  final LocalizeSiteState _self;
  final $Res Function(LocalizeSiteState) _then;

/// Create a copy of LocalizeSiteState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? myRole = freezed,Object? loadErrorMessage = freezed,Object? access = freezed,Object? reading = freezed,Object? proposeStatus = null,Object? proposeErrorMessage = freezed,Object? proposal = freezed,}) {
  return _then(LocalizeSiteState(
myRole: freezed == myRole ? _self.myRole : myRole // ignore: cast_nullable_to_non_nullable
as ProjectRole?,loadErrorMessage: freezed == loadErrorMessage ? _self.loadErrorMessage : loadErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,access: freezed == access ? _self.access : access // ignore: cast_nullable_to_non_nullable
as LocationAccess?,reading: freezed == reading ? _self.reading : reading // ignore: cast_nullable_to_non_nullable
as GpsReading?,proposeStatus: null == proposeStatus ? _self.proposeStatus : proposeStatus // ignore: cast_nullable_to_non_nullable
as GenericStatus,proposeErrorMessage: freezed == proposeErrorMessage ? _self.proposeErrorMessage : proposeErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,proposal: freezed == proposal ? _self.proposal : proposal // ignore: cast_nullable_to_non_nullable
as SiteProposal?,
  ));
}
/// Create a copy of LocalizeSiteState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GpsReadingCopyWith<$Res>? get reading {
    if (_self.reading == null) {
    return null;
  }

  return $GpsReadingCopyWith<$Res>(_self.reading!, (value) {
    return _then(_self.copyWith(reading: value));
  });
}
}


/// Adds pattern-matching-related methods to [LocalizeSiteState].
extension LocalizeSiteStatePatterns on LocalizeSiteState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LocalizeSiteState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LocalizeSiteState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LocalizeSiteState value)  $default,){
final _that = this;
switch (_that) {
case _LocalizeSiteState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LocalizeSiteState value)?  $default,){
final _that = this;
switch (_that) {
case _LocalizeSiteState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ProjectRole? myRole,  String? loadErrorMessage,  LocationAccess? access,  GpsReading? reading,  GenericStatus proposeStatus,  String? proposeErrorMessage,  SiteProposal? proposal)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LocalizeSiteState() when $default != null:
return $default(_that.myRole,_that.loadErrorMessage,_that.access,_that.reading,_that.proposeStatus,_that.proposeErrorMessage,_that.proposal);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ProjectRole? myRole,  String? loadErrorMessage,  LocationAccess? access,  GpsReading? reading,  GenericStatus proposeStatus,  String? proposeErrorMessage,  SiteProposal? proposal)  $default,) {final _that = this;
switch (_that) {
case _LocalizeSiteState():
return $default(_that.myRole,_that.loadErrorMessage,_that.access,_that.reading,_that.proposeStatus,_that.proposeErrorMessage,_that.proposal);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ProjectRole? myRole,  String? loadErrorMessage,  LocationAccess? access,  GpsReading? reading,  GenericStatus proposeStatus,  String? proposeErrorMessage,  SiteProposal? proposal)?  $default,) {final _that = this;
switch (_that) {
case _LocalizeSiteState() when $default != null:
return $default(_that.myRole,_that.loadErrorMessage,_that.access,_that.reading,_that.proposeStatus,_that.proposeErrorMessage,_that.proposal);case _:
  return null;

}
}

}

/// @nodoc


class _LocalizeSiteState extends LocalizeSiteState {
  const _LocalizeSiteState({this.myRole, this.loadErrorMessage, this.access, this.reading, this.proposeStatus = GenericStatus.initial, this.proposeErrorMessage, this.proposal}): super._();
  

/// Decides where saving leads: the owner validates at once (G-12).
@override final  ProjectRole? myRole;
@override final  String? loadErrorMessage;
/// Null while checking.
@override final  LocationAccess? access;
@override final  GpsReading? reading;
@override@JsonKey() final  GenericStatus proposeStatus;
@override final  String? proposeErrorMessage;
@override final  SiteProposal? proposal;

/// Create a copy of LocalizeSiteState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LocalizeSiteStateCopyWith<_LocalizeSiteState> get copyWith => __$LocalizeSiteStateCopyWithImpl<_LocalizeSiteState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LocalizeSiteState&&(identical(other.myRole, myRole) || other.myRole == myRole)&&(identical(other.loadErrorMessage, loadErrorMessage) || other.loadErrorMessage == loadErrorMessage)&&(identical(other.access, access) || other.access == access)&&(identical(other.reading, reading) || other.reading == reading)&&(identical(other.proposeStatus, proposeStatus) || other.proposeStatus == proposeStatus)&&(identical(other.proposeErrorMessage, proposeErrorMessage) || other.proposeErrorMessage == proposeErrorMessage)&&(identical(other.proposal, proposal) || other.proposal == proposal));
}


@override
int get hashCode {
    return Object.hash(runtimeType,myRole,loadErrorMessage,access,reading,proposeStatus,proposeErrorMessage,proposal);
}

@override
String toString() {
    return 'LocalizeSiteState(myRole: $myRole, loadErrorMessage: $loadErrorMessage, access: $access, reading: $reading, proposeStatus: $proposeStatus, proposeErrorMessage: $proposeErrorMessage, proposal: $proposal)';
}


}

/// @nodoc
abstract mixin class _$LocalizeSiteStateCopyWith<$Res> implements $LocalizeSiteStateCopyWith<$Res> {
  factory _$LocalizeSiteStateCopyWith(_LocalizeSiteState value, $Res Function(_LocalizeSiteState) _then) = __$LocalizeSiteStateCopyWithImpl;
@override @useResult
$Res call({
 ProjectRole? myRole, String? loadErrorMessage, LocationAccess? access, GpsReading? reading, GenericStatus proposeStatus, String? proposeErrorMessage, SiteProposal? proposal
});


@override $GpsReadingCopyWith<$Res>? get reading;

}
/// @nodoc
class __$LocalizeSiteStateCopyWithImpl<$Res>
    implements _$LocalizeSiteStateCopyWith<$Res> {
  __$LocalizeSiteStateCopyWithImpl(this._self, this._then);

  final _LocalizeSiteState _self;
  final $Res Function(_LocalizeSiteState) _then;

/// Create a copy of LocalizeSiteState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? myRole = freezed,Object? loadErrorMessage = freezed,Object? access = freezed,Object? reading = freezed,Object? proposeStatus = null,Object? proposeErrorMessage = freezed,Object? proposal = freezed,}) {
  return _then(_LocalizeSiteState(
myRole: freezed == myRole ? _self.myRole : myRole // ignore: cast_nullable_to_non_nullable
as ProjectRole?,loadErrorMessage: freezed == loadErrorMessage ? _self.loadErrorMessage : loadErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,access: freezed == access ? _self.access : access // ignore: cast_nullable_to_non_nullable
as LocationAccess?,reading: freezed == reading ? _self.reading : reading // ignore: cast_nullable_to_non_nullable
as GpsReading?,proposeStatus: null == proposeStatus ? _self.proposeStatus : proposeStatus // ignore: cast_nullable_to_non_nullable
as GenericStatus,proposeErrorMessage: freezed == proposeErrorMessage ? _self.proposeErrorMessage : proposeErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,proposal: freezed == proposal ? _self.proposal : proposal // ignore: cast_nullable_to_non_nullable
as SiteProposal?,
  ));
}

/// Create a copy of LocalizeSiteState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GpsReadingCopyWith<$Res>? get reading {
    if (_self.reading == null) {
    return null;
  }

  return $GpsReadingCopyWith<$Res>(_self.reading!, (value) {
    return _then(_self.copyWith(reading: value));
  });
}
}

// dart format on
