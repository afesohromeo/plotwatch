// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'validate_site_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ValidateSiteEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ValidateSiteEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'ValidateSiteEvent()';
}


}

/// @nodoc
class $ValidateSiteEventCopyWith<$Res>  {
$ValidateSiteEventCopyWith(ValidateSiteEvent _, $Res Function(ValidateSiteEvent) __);
}


/// Adds pattern-matching-related methods to [ValidateSiteEvent].
extension ValidateSiteEventPatterns on ValidateSiteEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Load value)?  load,TResult Function( _RadiusChanged value)?  radiusChanged,TResult Function( _ValidateRequested value)?  validateRequested,TResult Function( _RejectRequested value)?  rejectRequested,TResult Function( _ResetFlowStep value)?  resetFlowStep,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Load() when load != null:
return load(_that);case _RadiusChanged() when radiusChanged != null:
return radiusChanged(_that);case _ValidateRequested() when validateRequested != null:
return validateRequested(_that);case _RejectRequested() when rejectRequested != null:
return rejectRequested(_that);case _ResetFlowStep() when resetFlowStep != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Load value)  load,required TResult Function( _RadiusChanged value)  radiusChanged,required TResult Function( _ValidateRequested value)  validateRequested,required TResult Function( _RejectRequested value)  rejectRequested,required TResult Function( _ResetFlowStep value)  resetFlowStep,}){
final _that = this;
switch (_that) {
case _Load():
return load(_that);case _RadiusChanged():
return radiusChanged(_that);case _ValidateRequested():
return validateRequested(_that);case _RejectRequested():
return rejectRequested(_that);case _ResetFlowStep():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Load value)?  load,TResult? Function( _RadiusChanged value)?  radiusChanged,TResult? Function( _ValidateRequested value)?  validateRequested,TResult? Function( _RejectRequested value)?  rejectRequested,TResult? Function( _ResetFlowStep value)?  resetFlowStep,}){
final _that = this;
switch (_that) {
case _Load() when load != null:
return load(_that);case _RadiusChanged() when radiusChanged != null:
return radiusChanged(_that);case _ValidateRequested() when validateRequested != null:
return validateRequested(_that);case _RejectRequested() when rejectRequested != null:
return rejectRequested(_that);case _ResetFlowStep() when resetFlowStep != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int projectId)?  load,TResult Function( int radiusM)?  radiusChanged,TResult Function( String? addressText)?  validateRequested,TResult Function( String? reason)?  rejectRequested,TResult Function()?  resetFlowStep,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Load() when load != null:
return load(_that.projectId);case _RadiusChanged() when radiusChanged != null:
return radiusChanged(_that.radiusM);case _ValidateRequested() when validateRequested != null:
return validateRequested(_that.addressText);case _RejectRequested() when rejectRequested != null:
return rejectRequested(_that.reason);case _ResetFlowStep() when resetFlowStep != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int projectId)  load,required TResult Function( int radiusM)  radiusChanged,required TResult Function( String? addressText)  validateRequested,required TResult Function( String? reason)  rejectRequested,required TResult Function()  resetFlowStep,}) {final _that = this;
switch (_that) {
case _Load():
return load(_that.projectId);case _RadiusChanged():
return radiusChanged(_that.radiusM);case _ValidateRequested():
return validateRequested(_that.addressText);case _RejectRequested():
return rejectRequested(_that.reason);case _ResetFlowStep():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int projectId)?  load,TResult? Function( int radiusM)?  radiusChanged,TResult? Function( String? addressText)?  validateRequested,TResult? Function( String? reason)?  rejectRequested,TResult? Function()?  resetFlowStep,}) {final _that = this;
switch (_that) {
case _Load() when load != null:
return load(_that.projectId);case _RadiusChanged() when radiusChanged != null:
return radiusChanged(_that.radiusM);case _ValidateRequested() when validateRequested != null:
return validateRequested(_that.addressText);case _RejectRequested() when rejectRequested != null:
return rejectRequested(_that.reason);case _ResetFlowStep() when resetFlowStep != null:
return resetFlowStep();case _:
  return null;

}
}

}

/// @nodoc


class _Load implements ValidateSiteEvent {
  const _Load({required this.projectId});
  

 final  int projectId;

/// Create a copy of ValidateSiteEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadCopyWith<_Load> get copyWith => __$LoadCopyWithImpl<_Load>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Load&&(identical(other.projectId, projectId) || other.projectId == projectId));
}


@override
int get hashCode {
    return Object.hash(runtimeType,projectId);
}

@override
String toString() {
    return 'ValidateSiteEvent.load(projectId: $projectId)';
}


}

/// @nodoc
abstract mixin class _$LoadCopyWith<$Res> implements $ValidateSiteEventCopyWith<$Res> {
  factory _$LoadCopyWith(_Load value, $Res Function(_Load) _then) = __$LoadCopyWithImpl;
@useResult
$Res call({
 int projectId
});




}
/// @nodoc
class __$LoadCopyWithImpl<$Res>
    implements _$LoadCopyWith<$Res> {
  __$LoadCopyWithImpl(this._self, this._then);

  final _Load _self;
  final $Res Function(_Load) _then;

/// Create a copy of ValidateSiteEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? projectId = null,}) {
  return _then(_Load(
projectId: null == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _RadiusChanged implements ValidateSiteEvent {
  const _RadiusChanged({required this.radiusM});
  

 final  int radiusM;

/// Create a copy of ValidateSiteEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RadiusChangedCopyWith<_RadiusChanged> get copyWith => __$RadiusChangedCopyWithImpl<_RadiusChanged>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RadiusChanged&&(identical(other.radiusM, radiusM) || other.radiusM == radiusM));
}


@override
int get hashCode {
    return Object.hash(runtimeType,radiusM);
}

@override
String toString() {
    return 'ValidateSiteEvent.radiusChanged(radiusM: $radiusM)';
}


}

/// @nodoc
abstract mixin class _$RadiusChangedCopyWith<$Res> implements $ValidateSiteEventCopyWith<$Res> {
  factory _$RadiusChangedCopyWith(_RadiusChanged value, $Res Function(_RadiusChanged) _then) = __$RadiusChangedCopyWithImpl;
@useResult
$Res call({
 int radiusM
});




}
/// @nodoc
class __$RadiusChangedCopyWithImpl<$Res>
    implements _$RadiusChangedCopyWith<$Res> {
  __$RadiusChangedCopyWithImpl(this._self, this._then);

  final _RadiusChanged _self;
  final $Res Function(_RadiusChanged) _then;

/// Create a copy of ValidateSiteEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? radiusM = null,}) {
  return _then(_RadiusChanged(
radiusM: null == radiusM ? _self.radiusM : radiusM // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _ValidateRequested implements ValidateSiteEvent {
  const _ValidateRequested({this.addressText});
  

 final  String? addressText;

/// Create a copy of ValidateSiteEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ValidateRequestedCopyWith<_ValidateRequested> get copyWith => __$ValidateRequestedCopyWithImpl<_ValidateRequested>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ValidateRequested&&(identical(other.addressText, addressText) || other.addressText == addressText));
}


@override
int get hashCode {
    return Object.hash(runtimeType,addressText);
}

@override
String toString() {
    return 'ValidateSiteEvent.validateRequested(addressText: $addressText)';
}


}

/// @nodoc
abstract mixin class _$ValidateRequestedCopyWith<$Res> implements $ValidateSiteEventCopyWith<$Res> {
  factory _$ValidateRequestedCopyWith(_ValidateRequested value, $Res Function(_ValidateRequested) _then) = __$ValidateRequestedCopyWithImpl;
@useResult
$Res call({
 String? addressText
});




}
/// @nodoc
class __$ValidateRequestedCopyWithImpl<$Res>
    implements _$ValidateRequestedCopyWith<$Res> {
  __$ValidateRequestedCopyWithImpl(this._self, this._then);

  final _ValidateRequested _self;
  final $Res Function(_ValidateRequested) _then;

/// Create a copy of ValidateSiteEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? addressText = freezed,}) {
  return _then(_ValidateRequested(
addressText: freezed == addressText ? _self.addressText : addressText // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _RejectRequested implements ValidateSiteEvent {
  const _RejectRequested({this.reason});
  

 final  String? reason;

/// Create a copy of ValidateSiteEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RejectRequestedCopyWith<_RejectRequested> get copyWith => __$RejectRequestedCopyWithImpl<_RejectRequested>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RejectRequested&&(identical(other.reason, reason) || other.reason == reason));
}


@override
int get hashCode {
    return Object.hash(runtimeType,reason);
}

@override
String toString() {
    return 'ValidateSiteEvent.rejectRequested(reason: $reason)';
}


}

/// @nodoc
abstract mixin class _$RejectRequestedCopyWith<$Res> implements $ValidateSiteEventCopyWith<$Res> {
  factory _$RejectRequestedCopyWith(_RejectRequested value, $Res Function(_RejectRequested) _then) = __$RejectRequestedCopyWithImpl;
@useResult
$Res call({
 String? reason
});




}
/// @nodoc
class __$RejectRequestedCopyWithImpl<$Res>
    implements _$RejectRequestedCopyWith<$Res> {
  __$RejectRequestedCopyWithImpl(this._self, this._then);

  final _RejectRequested _self;
  final $Res Function(_RejectRequested) _then;

/// Create a copy of ValidateSiteEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? reason = freezed,}) {
  return _then(_RejectRequested(
reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _ResetFlowStep implements ValidateSiteEvent {
  const _ResetFlowStep();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResetFlowStep);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'ValidateSiteEvent.resetFlowStep()';
}


}




/// @nodoc
mixin _$ValidateSiteState {

 int? get projectId;/// The proposal waiting for the owner; null when none is pending.
 SiteProposal? get proposal; int get radiusM; GenericStatus get loadStatus; String? get loadErrorMessage;/// `updatingItem` = validating, `deletingItem` = rejecting.
 GenericFlowStep get flowStep; GenericStatus get actionStatus; String? get actionErrorMessage;
/// Create a copy of ValidateSiteState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ValidateSiteStateCopyWith<ValidateSiteState> get copyWith => _$ValidateSiteStateCopyWithImpl<ValidateSiteState>(this as ValidateSiteState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ValidateSiteState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ValidateSiteState&&(identical(other.projectId, _this.projectId) || other.projectId == _this.projectId)&&(identical(other.proposal, _this.proposal) || other.proposal == _this.proposal)&&(identical(other.radiusM, _this.radiusM) || other.radiusM == _this.radiusM)&&(identical(other.loadStatus, _this.loadStatus) || other.loadStatus == _this.loadStatus)&&(identical(other.loadErrorMessage, _this.loadErrorMessage) || other.loadErrorMessage == _this.loadErrorMessage)&&(identical(other.flowStep, _this.flowStep) || other.flowStep == _this.flowStep)&&(identical(other.actionStatus, _this.actionStatus) || other.actionStatus == _this.actionStatus)&&(identical(other.actionErrorMessage, _this.actionErrorMessage) || other.actionErrorMessage == _this.actionErrorMessage));
}


@override
int get hashCode {
  final _this = this as ValidateSiteState;
  return Object.hash(runtimeType,_this.projectId,_this.proposal,_this.radiusM,_this.loadStatus,_this.loadErrorMessage,_this.flowStep,_this.actionStatus,_this.actionErrorMessage);
}

@override
String toString() {
  final _this = this as ValidateSiteState;
  return 'ValidateSiteState(projectId: ${_this.projectId}, proposal: ${_this.proposal}, radiusM: ${_this.radiusM}, loadStatus: ${_this.loadStatus}, loadErrorMessage: ${_this.loadErrorMessage}, flowStep: ${_this.flowStep}, actionStatus: ${_this.actionStatus}, actionErrorMessage: ${_this.actionErrorMessage})';
}


}

/// @nodoc
abstract mixin class $ValidateSiteStateCopyWith<$Res>  {
  factory $ValidateSiteStateCopyWith(ValidateSiteState value, $Res Function(ValidateSiteState) _then) = _$ValidateSiteStateCopyWithImpl;
@useResult
$Res call({
 int? projectId, SiteProposal? proposal, int radiusM, GenericStatus loadStatus, String? loadErrorMessage, GenericFlowStep flowStep, GenericStatus actionStatus, String? actionErrorMessage
});




}
/// @nodoc
class _$ValidateSiteStateCopyWithImpl<$Res>
    implements $ValidateSiteStateCopyWith<$Res> {
  _$ValidateSiteStateCopyWithImpl(this._self, this._then);

  final ValidateSiteState _self;
  final $Res Function(ValidateSiteState) _then;

/// Create a copy of ValidateSiteState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? projectId = freezed,Object? proposal = freezed,Object? radiusM = null,Object? loadStatus = null,Object? loadErrorMessage = freezed,Object? flowStep = null,Object? actionStatus = null,Object? actionErrorMessage = freezed,}) {
  return _then(ValidateSiteState(
projectId: freezed == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as int?,proposal: freezed == proposal ? _self.proposal : proposal // ignore: cast_nullable_to_non_nullable
as SiteProposal?,radiusM: null == radiusM ? _self.radiusM : radiusM // ignore: cast_nullable_to_non_nullable
as int,loadStatus: null == loadStatus ? _self.loadStatus : loadStatus // ignore: cast_nullable_to_non_nullable
as GenericStatus,loadErrorMessage: freezed == loadErrorMessage ? _self.loadErrorMessage : loadErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,flowStep: null == flowStep ? _self.flowStep : flowStep // ignore: cast_nullable_to_non_nullable
as GenericFlowStep,actionStatus: null == actionStatus ? _self.actionStatus : actionStatus // ignore: cast_nullable_to_non_nullable
as GenericStatus,actionErrorMessage: freezed == actionErrorMessage ? _self.actionErrorMessage : actionErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ValidateSiteState].
extension ValidateSiteStatePatterns on ValidateSiteState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ValidateSiteState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ValidateSiteState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ValidateSiteState value)  $default,){
final _that = this;
switch (_that) {
case _ValidateSiteState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ValidateSiteState value)?  $default,){
final _that = this;
switch (_that) {
case _ValidateSiteState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? projectId,  SiteProposal? proposal,  int radiusM,  GenericStatus loadStatus,  String? loadErrorMessage,  GenericFlowStep flowStep,  GenericStatus actionStatus,  String? actionErrorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ValidateSiteState() when $default != null:
return $default(_that.projectId,_that.proposal,_that.radiusM,_that.loadStatus,_that.loadErrorMessage,_that.flowStep,_that.actionStatus,_that.actionErrorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? projectId,  SiteProposal? proposal,  int radiusM,  GenericStatus loadStatus,  String? loadErrorMessage,  GenericFlowStep flowStep,  GenericStatus actionStatus,  String? actionErrorMessage)  $default,) {final _that = this;
switch (_that) {
case _ValidateSiteState():
return $default(_that.projectId,_that.proposal,_that.radiusM,_that.loadStatus,_that.loadErrorMessage,_that.flowStep,_that.actionStatus,_that.actionErrorMessage);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? projectId,  SiteProposal? proposal,  int radiusM,  GenericStatus loadStatus,  String? loadErrorMessage,  GenericFlowStep flowStep,  GenericStatus actionStatus,  String? actionErrorMessage)?  $default,) {final _that = this;
switch (_that) {
case _ValidateSiteState() when $default != null:
return $default(_that.projectId,_that.proposal,_that.radiusM,_that.loadStatus,_that.loadErrorMessage,_that.flowStep,_that.actionStatus,_that.actionErrorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _ValidateSiteState implements ValidateSiteState {
  const _ValidateSiteState({this.projectId, this.proposal, this.radiusM = defaultSiteRadiusM, this.loadStatus = GenericStatus.initial, this.loadErrorMessage, this.flowStep = GenericFlowStep.none, this.actionStatus = GenericStatus.initial, this.actionErrorMessage});
  

@override final  int? projectId;
/// The proposal waiting for the owner; null when none is pending.
@override final  SiteProposal? proposal;
@override@JsonKey() final  int radiusM;
@override@JsonKey() final  GenericStatus loadStatus;
@override final  String? loadErrorMessage;
/// `updatingItem` = validating, `deletingItem` = rejecting.
@override@JsonKey() final  GenericFlowStep flowStep;
@override@JsonKey() final  GenericStatus actionStatus;
@override final  String? actionErrorMessage;

/// Create a copy of ValidateSiteState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ValidateSiteStateCopyWith<_ValidateSiteState> get copyWith => __$ValidateSiteStateCopyWithImpl<_ValidateSiteState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ValidateSiteState&&(identical(other.projectId, projectId) || other.projectId == projectId)&&(identical(other.proposal, proposal) || other.proposal == proposal)&&(identical(other.radiusM, radiusM) || other.radiusM == radiusM)&&(identical(other.loadStatus, loadStatus) || other.loadStatus == loadStatus)&&(identical(other.loadErrorMessage, loadErrorMessage) || other.loadErrorMessage == loadErrorMessage)&&(identical(other.flowStep, flowStep) || other.flowStep == flowStep)&&(identical(other.actionStatus, actionStatus) || other.actionStatus == actionStatus)&&(identical(other.actionErrorMessage, actionErrorMessage) || other.actionErrorMessage == actionErrorMessage));
}


@override
int get hashCode {
    return Object.hash(runtimeType,projectId,proposal,radiusM,loadStatus,loadErrorMessage,flowStep,actionStatus,actionErrorMessage);
}

@override
String toString() {
    return 'ValidateSiteState(projectId: $projectId, proposal: $proposal, radiusM: $radiusM, loadStatus: $loadStatus, loadErrorMessage: $loadErrorMessage, flowStep: $flowStep, actionStatus: $actionStatus, actionErrorMessage: $actionErrorMessage)';
}


}

/// @nodoc
abstract mixin class _$ValidateSiteStateCopyWith<$Res> implements $ValidateSiteStateCopyWith<$Res> {
  factory _$ValidateSiteStateCopyWith(_ValidateSiteState value, $Res Function(_ValidateSiteState) _then) = __$ValidateSiteStateCopyWithImpl;
@override @useResult
$Res call({
 int? projectId, SiteProposal? proposal, int radiusM, GenericStatus loadStatus, String? loadErrorMessage, GenericFlowStep flowStep, GenericStatus actionStatus, String? actionErrorMessage
});




}
/// @nodoc
class __$ValidateSiteStateCopyWithImpl<$Res>
    implements _$ValidateSiteStateCopyWith<$Res> {
  __$ValidateSiteStateCopyWithImpl(this._self, this._then);

  final _ValidateSiteState _self;
  final $Res Function(_ValidateSiteState) _then;

/// Create a copy of ValidateSiteState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? projectId = freezed,Object? proposal = freezed,Object? radiusM = null,Object? loadStatus = null,Object? loadErrorMessage = freezed,Object? flowStep = null,Object? actionStatus = null,Object? actionErrorMessage = freezed,}) {
  return _then(_ValidateSiteState(
projectId: freezed == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as int?,proposal: freezed == proposal ? _self.proposal : proposal // ignore: cast_nullable_to_non_nullable
as SiteProposal?,radiusM: null == radiusM ? _self.radiusM : radiusM // ignore: cast_nullable_to_non_nullable
as int,loadStatus: null == loadStatus ? _self.loadStatus : loadStatus // ignore: cast_nullable_to_non_nullable
as GenericStatus,loadErrorMessage: freezed == loadErrorMessage ? _self.loadErrorMessage : loadErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,flowStep: null == flowStep ? _self.flowStep : flowStep // ignore: cast_nullable_to_non_nullable
as GenericFlowStep,actionStatus: null == actionStatus ? _self.actionStatus : actionStatus // ignore: cast_nullable_to_non_nullable
as GenericStatus,actionErrorMessage: freezed == actionErrorMessage ? _self.actionErrorMessage : actionErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
