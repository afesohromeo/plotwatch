// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'evidence_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EvidenceEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is EvidenceEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'EvidenceEvent()';
}


}

/// @nodoc
class $EvidenceEventCopyWith<$Res>  {
$EvidenceEventCopyWith(EvidenceEvent _, $Res Function(EvidenceEvent) __);
}


/// Adds pattern-matching-related methods to [EvidenceEvent].
extension EvidenceEventPatterns on EvidenceEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Load value)?  load,TResult Function( _RetractRequested value)?  retractRequested,TResult Function( _ResetFlowStep value)?  resetFlowStep,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Load() when load != null:
return load(_that);case _RetractRequested() when retractRequested != null:
return retractRequested(_that);case _ResetFlowStep() when resetFlowStep != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Load value)  load,required TResult Function( _RetractRequested value)  retractRequested,required TResult Function( _ResetFlowStep value)  resetFlowStep,}){
final _that = this;
switch (_that) {
case _Load():
return load(_that);case _RetractRequested():
return retractRequested(_that);case _ResetFlowStep():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Load value)?  load,TResult? Function( _RetractRequested value)?  retractRequested,TResult? Function( _ResetFlowStep value)?  resetFlowStep,}){
final _that = this;
switch (_that) {
case _Load() when load != null:
return load(_that);case _RetractRequested() when retractRequested != null:
return retractRequested(_that);case _ResetFlowStep() when resetFlowStep != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int projectId,  int stageId,  int evidenceId)?  load,TResult Function( String reason)?  retractRequested,TResult Function()?  resetFlowStep,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Load() when load != null:
return load(_that.projectId,_that.stageId,_that.evidenceId);case _RetractRequested() when retractRequested != null:
return retractRequested(_that.reason);case _ResetFlowStep() when resetFlowStep != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int projectId,  int stageId,  int evidenceId)  load,required TResult Function( String reason)  retractRequested,required TResult Function()  resetFlowStep,}) {final _that = this;
switch (_that) {
case _Load():
return load(_that.projectId,_that.stageId,_that.evidenceId);case _RetractRequested():
return retractRequested(_that.reason);case _ResetFlowStep():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int projectId,  int stageId,  int evidenceId)?  load,TResult? Function( String reason)?  retractRequested,TResult? Function()?  resetFlowStep,}) {final _that = this;
switch (_that) {
case _Load() when load != null:
return load(_that.projectId,_that.stageId,_that.evidenceId);case _RetractRequested() when retractRequested != null:
return retractRequested(_that.reason);case _ResetFlowStep() when resetFlowStep != null:
return resetFlowStep();case _:
  return null;

}
}

}

/// @nodoc


class _Load implements EvidenceEvent {
  const _Load({required this.projectId, required this.stageId, required this.evidenceId});
  

 final  int projectId;
 final  int stageId;
 final  int evidenceId;

/// Create a copy of EvidenceEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadCopyWith<_Load> get copyWith => __$LoadCopyWithImpl<_Load>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Load&&(identical(other.projectId, projectId) || other.projectId == projectId)&&(identical(other.stageId, stageId) || other.stageId == stageId)&&(identical(other.evidenceId, evidenceId) || other.evidenceId == evidenceId));
}


@override
int get hashCode {
    return Object.hash(runtimeType,projectId,stageId,evidenceId);
}

@override
String toString() {
    return 'EvidenceEvent.load(projectId: $projectId, stageId: $stageId, evidenceId: $evidenceId)';
}


}

/// @nodoc
abstract mixin class _$LoadCopyWith<$Res> implements $EvidenceEventCopyWith<$Res> {
  factory _$LoadCopyWith(_Load value, $Res Function(_Load) _then) = __$LoadCopyWithImpl;
@useResult
$Res call({
 int projectId, int stageId, int evidenceId
});




}
/// @nodoc
class __$LoadCopyWithImpl<$Res>
    implements _$LoadCopyWith<$Res> {
  __$LoadCopyWithImpl(this._self, this._then);

  final _Load _self;
  final $Res Function(_Load) _then;

/// Create a copy of EvidenceEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? projectId = null,Object? stageId = null,Object? evidenceId = null,}) {
  return _then(_Load(
projectId: null == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as int,stageId: null == stageId ? _self.stageId : stageId // ignore: cast_nullable_to_non_nullable
as int,evidenceId: null == evidenceId ? _self.evidenceId : evidenceId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _RetractRequested implements EvidenceEvent {
  const _RetractRequested({required this.reason});
  

 final  String reason;

/// Create a copy of EvidenceEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RetractRequestedCopyWith<_RetractRequested> get copyWith => __$RetractRequestedCopyWithImpl<_RetractRequested>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RetractRequested&&(identical(other.reason, reason) || other.reason == reason));
}


@override
int get hashCode {
    return Object.hash(runtimeType,reason);
}

@override
String toString() {
    return 'EvidenceEvent.retractRequested(reason: $reason)';
}


}

/// @nodoc
abstract mixin class _$RetractRequestedCopyWith<$Res> implements $EvidenceEventCopyWith<$Res> {
  factory _$RetractRequestedCopyWith(_RetractRequested value, $Res Function(_RetractRequested) _then) = __$RetractRequestedCopyWithImpl;
@useResult
$Res call({
 String reason
});




}
/// @nodoc
class __$RetractRequestedCopyWithImpl<$Res>
    implements _$RetractRequestedCopyWith<$Res> {
  __$RetractRequestedCopyWithImpl(this._self, this._then);

  final _RetractRequested _self;
  final $Res Function(_RetractRequested) _then;

/// Create a copy of EvidenceEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? reason = null,}) {
  return _then(_RetractRequested(
reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _ResetFlowStep implements EvidenceEvent {
  const _ResetFlowStep();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResetFlowStep);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'EvidenceEvent.resetFlowStep()';
}


}




/// @nodoc
mixin _$EvidenceState {

 int? get projectId; int? get stageId; int? get evidenceId; ProjectOverview? get overview; Evidence? get evidence;/// The capture's stage, for the schedule line (doc/04e M5-10).
 Stage? get stage;/// The checklist item it was taken for: the page's title (doc/05 §9.3).
 String? get itemLabel;/// The signed-in user took the photo.
 bool get isMine; GenericStatus get loadStatus; String? get loadErrorMessage; GenericStatus get actionStatus; String? get actionErrorMessage;
/// Create a copy of EvidenceState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EvidenceStateCopyWith<EvidenceState> get copyWith => _$EvidenceStateCopyWithImpl<EvidenceState>(this as EvidenceState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as EvidenceState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EvidenceState&&(identical(other.projectId, _this.projectId) || other.projectId == _this.projectId)&&(identical(other.stageId, _this.stageId) || other.stageId == _this.stageId)&&(identical(other.evidenceId, _this.evidenceId) || other.evidenceId == _this.evidenceId)&&(identical(other.overview, _this.overview) || other.overview == _this.overview)&&(identical(other.evidence, _this.evidence) || other.evidence == _this.evidence)&&(identical(other.stage, _this.stage) || other.stage == _this.stage)&&(identical(other.itemLabel, _this.itemLabel) || other.itemLabel == _this.itemLabel)&&(identical(other.isMine, _this.isMine) || other.isMine == _this.isMine)&&(identical(other.loadStatus, _this.loadStatus) || other.loadStatus == _this.loadStatus)&&(identical(other.loadErrorMessage, _this.loadErrorMessage) || other.loadErrorMessage == _this.loadErrorMessage)&&(identical(other.actionStatus, _this.actionStatus) || other.actionStatus == _this.actionStatus)&&(identical(other.actionErrorMessage, _this.actionErrorMessage) || other.actionErrorMessage == _this.actionErrorMessage));
}


@override
int get hashCode {
  final _this = this as EvidenceState;
  return Object.hash(runtimeType,_this.projectId,_this.stageId,_this.evidenceId,_this.overview,_this.evidence,_this.stage,_this.itemLabel,_this.isMine,_this.loadStatus,_this.loadErrorMessage,_this.actionStatus,_this.actionErrorMessage);
}

@override
String toString() {
  final _this = this as EvidenceState;
  return 'EvidenceState(projectId: ${_this.projectId}, stageId: ${_this.stageId}, evidenceId: ${_this.evidenceId}, overview: ${_this.overview}, evidence: ${_this.evidence}, stage: ${_this.stage}, itemLabel: ${_this.itemLabel}, isMine: ${_this.isMine}, loadStatus: ${_this.loadStatus}, loadErrorMessage: ${_this.loadErrorMessage}, actionStatus: ${_this.actionStatus}, actionErrorMessage: ${_this.actionErrorMessage})';
}


}

/// @nodoc
abstract mixin class $EvidenceStateCopyWith<$Res>  {
  factory $EvidenceStateCopyWith(EvidenceState value, $Res Function(EvidenceState) _then) = _$EvidenceStateCopyWithImpl;
@useResult
$Res call({
 int? projectId, int? stageId, int? evidenceId, ProjectOverview? overview, Evidence? evidence, Stage? stage, String? itemLabel, bool isMine, GenericStatus loadStatus, String? loadErrorMessage, GenericStatus actionStatus, String? actionErrorMessage
});




}
/// @nodoc
class _$EvidenceStateCopyWithImpl<$Res>
    implements $EvidenceStateCopyWith<$Res> {
  _$EvidenceStateCopyWithImpl(this._self, this._then);

  final EvidenceState _self;
  final $Res Function(EvidenceState) _then;

/// Create a copy of EvidenceState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? projectId = freezed,Object? stageId = freezed,Object? evidenceId = freezed,Object? overview = freezed,Object? evidence = freezed,Object? stage = freezed,Object? itemLabel = freezed,Object? isMine = null,Object? loadStatus = null,Object? loadErrorMessage = freezed,Object? actionStatus = null,Object? actionErrorMessage = freezed,}) {
  return _then(EvidenceState(
projectId: freezed == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as int?,stageId: freezed == stageId ? _self.stageId : stageId // ignore: cast_nullable_to_non_nullable
as int?,evidenceId: freezed == evidenceId ? _self.evidenceId : evidenceId // ignore: cast_nullable_to_non_nullable
as int?,overview: freezed == overview ? _self.overview : overview // ignore: cast_nullable_to_non_nullable
as ProjectOverview?,evidence: freezed == evidence ? _self.evidence : evidence // ignore: cast_nullable_to_non_nullable
as Evidence?,stage: freezed == stage ? _self.stage : stage // ignore: cast_nullable_to_non_nullable
as Stage?,itemLabel: freezed == itemLabel ? _self.itemLabel : itemLabel // ignore: cast_nullable_to_non_nullable
as String?,isMine: null == isMine ? _self.isMine : isMine // ignore: cast_nullable_to_non_nullable
as bool,loadStatus: null == loadStatus ? _self.loadStatus : loadStatus // ignore: cast_nullable_to_non_nullable
as GenericStatus,loadErrorMessage: freezed == loadErrorMessage ? _self.loadErrorMessage : loadErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,actionStatus: null == actionStatus ? _self.actionStatus : actionStatus // ignore: cast_nullable_to_non_nullable
as GenericStatus,actionErrorMessage: freezed == actionErrorMessage ? _self.actionErrorMessage : actionErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [EvidenceState].
extension EvidenceStatePatterns on EvidenceState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EvidenceState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EvidenceState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EvidenceState value)  $default,){
final _that = this;
switch (_that) {
case _EvidenceState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EvidenceState value)?  $default,){
final _that = this;
switch (_that) {
case _EvidenceState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? projectId,  int? stageId,  int? evidenceId,  ProjectOverview? overview,  Evidence? evidence,  Stage? stage,  String? itemLabel,  bool isMine,  GenericStatus loadStatus,  String? loadErrorMessage,  GenericStatus actionStatus,  String? actionErrorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EvidenceState() when $default != null:
return $default(_that.projectId,_that.stageId,_that.evidenceId,_that.overview,_that.evidence,_that.stage,_that.itemLabel,_that.isMine,_that.loadStatus,_that.loadErrorMessage,_that.actionStatus,_that.actionErrorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? projectId,  int? stageId,  int? evidenceId,  ProjectOverview? overview,  Evidence? evidence,  Stage? stage,  String? itemLabel,  bool isMine,  GenericStatus loadStatus,  String? loadErrorMessage,  GenericStatus actionStatus,  String? actionErrorMessage)  $default,) {final _that = this;
switch (_that) {
case _EvidenceState():
return $default(_that.projectId,_that.stageId,_that.evidenceId,_that.overview,_that.evidence,_that.stage,_that.itemLabel,_that.isMine,_that.loadStatus,_that.loadErrorMessage,_that.actionStatus,_that.actionErrorMessage);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? projectId,  int? stageId,  int? evidenceId,  ProjectOverview? overview,  Evidence? evidence,  Stage? stage,  String? itemLabel,  bool isMine,  GenericStatus loadStatus,  String? loadErrorMessage,  GenericStatus actionStatus,  String? actionErrorMessage)?  $default,) {final _that = this;
switch (_that) {
case _EvidenceState() when $default != null:
return $default(_that.projectId,_that.stageId,_that.evidenceId,_that.overview,_that.evidence,_that.stage,_that.itemLabel,_that.isMine,_that.loadStatus,_that.loadErrorMessage,_that.actionStatus,_that.actionErrorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _EvidenceState extends EvidenceState {
  const _EvidenceState({this.projectId, this.stageId, this.evidenceId, this.overview, this.evidence, this.stage, this.itemLabel, this.isMine = false, this.loadStatus = GenericStatus.initial, this.loadErrorMessage, this.actionStatus = GenericStatus.initial, this.actionErrorMessage}): super._();
  

@override final  int? projectId;
@override final  int? stageId;
@override final  int? evidenceId;
@override final  ProjectOverview? overview;
@override final  Evidence? evidence;
/// The capture's stage, for the schedule line (doc/04e M5-10).
@override final  Stage? stage;
/// The checklist item it was taken for: the page's title (doc/05 §9.3).
@override final  String? itemLabel;
/// The signed-in user took the photo.
@override@JsonKey() final  bool isMine;
@override@JsonKey() final  GenericStatus loadStatus;
@override final  String? loadErrorMessage;
@override@JsonKey() final  GenericStatus actionStatus;
@override final  String? actionErrorMessage;

/// Create a copy of EvidenceState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EvidenceStateCopyWith<_EvidenceState> get copyWith => __$EvidenceStateCopyWithImpl<_EvidenceState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _EvidenceState&&(identical(other.projectId, projectId) || other.projectId == projectId)&&(identical(other.stageId, stageId) || other.stageId == stageId)&&(identical(other.evidenceId, evidenceId) || other.evidenceId == evidenceId)&&(identical(other.overview, overview) || other.overview == overview)&&(identical(other.evidence, evidence) || other.evidence == evidence)&&(identical(other.stage, stage) || other.stage == stage)&&(identical(other.itemLabel, itemLabel) || other.itemLabel == itemLabel)&&(identical(other.isMine, isMine) || other.isMine == isMine)&&(identical(other.loadStatus, loadStatus) || other.loadStatus == loadStatus)&&(identical(other.loadErrorMessage, loadErrorMessage) || other.loadErrorMessage == loadErrorMessage)&&(identical(other.actionStatus, actionStatus) || other.actionStatus == actionStatus)&&(identical(other.actionErrorMessage, actionErrorMessage) || other.actionErrorMessage == actionErrorMessage));
}


@override
int get hashCode {
    return Object.hash(runtimeType,projectId,stageId,evidenceId,overview,evidence,stage,itemLabel,isMine,loadStatus,loadErrorMessage,actionStatus,actionErrorMessage);
}

@override
String toString() {
    return 'EvidenceState(projectId: $projectId, stageId: $stageId, evidenceId: $evidenceId, overview: $overview, evidence: $evidence, stage: $stage, itemLabel: $itemLabel, isMine: $isMine, loadStatus: $loadStatus, loadErrorMessage: $loadErrorMessage, actionStatus: $actionStatus, actionErrorMessage: $actionErrorMessage)';
}


}

/// @nodoc
abstract mixin class _$EvidenceStateCopyWith<$Res> implements $EvidenceStateCopyWith<$Res> {
  factory _$EvidenceStateCopyWith(_EvidenceState value, $Res Function(_EvidenceState) _then) = __$EvidenceStateCopyWithImpl;
@override @useResult
$Res call({
 int? projectId, int? stageId, int? evidenceId, ProjectOverview? overview, Evidence? evidence, Stage? stage, String? itemLabel, bool isMine, GenericStatus loadStatus, String? loadErrorMessage, GenericStatus actionStatus, String? actionErrorMessage
});




}
/// @nodoc
class __$EvidenceStateCopyWithImpl<$Res>
    implements _$EvidenceStateCopyWith<$Res> {
  __$EvidenceStateCopyWithImpl(this._self, this._then);

  final _EvidenceState _self;
  final $Res Function(_EvidenceState) _then;

/// Create a copy of EvidenceState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? projectId = freezed,Object? stageId = freezed,Object? evidenceId = freezed,Object? overview = freezed,Object? evidence = freezed,Object? stage = freezed,Object? itemLabel = freezed,Object? isMine = null,Object? loadStatus = null,Object? loadErrorMessage = freezed,Object? actionStatus = null,Object? actionErrorMessage = freezed,}) {
  return _then(_EvidenceState(
projectId: freezed == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as int?,stageId: freezed == stageId ? _self.stageId : stageId // ignore: cast_nullable_to_non_nullable
as int?,evidenceId: freezed == evidenceId ? _self.evidenceId : evidenceId // ignore: cast_nullable_to_non_nullable
as int?,overview: freezed == overview ? _self.overview : overview // ignore: cast_nullable_to_non_nullable
as ProjectOverview?,evidence: freezed == evidence ? _self.evidence : evidence // ignore: cast_nullable_to_non_nullable
as Evidence?,stage: freezed == stage ? _self.stage : stage // ignore: cast_nullable_to_non_nullable
as Stage?,itemLabel: freezed == itemLabel ? _self.itemLabel : itemLabel // ignore: cast_nullable_to_non_nullable
as String?,isMine: null == isMine ? _self.isMine : isMine // ignore: cast_nullable_to_non_nullable
as bool,loadStatus: null == loadStatus ? _self.loadStatus : loadStatus // ignore: cast_nullable_to_non_nullable
as GenericStatus,loadErrorMessage: freezed == loadErrorMessage ? _self.loadErrorMessage : loadErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,actionStatus: null == actionStatus ? _self.actionStatus : actionStatus // ignore: cast_nullable_to_non_nullable
as GenericStatus,actionErrorMessage: freezed == actionErrorMessage ? _self.actionErrorMessage : actionErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
