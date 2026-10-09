// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stage_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StageEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is StageEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'StageEvent()';
}


}

/// @nodoc
class $StageEventCopyWith<$Res>  {
$StageEventCopyWith(StageEvent _, $Res Function(StageEvent) __);
}


/// Adds pattern-matching-related methods to [StageEvent].
extension StageEventPatterns on StageEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Load value)?  load,TResult Function( _StartRequested value)?  startRequested,TResult Function( _DeleteRequested value)?  deleteRequested,TResult Function( _ResetFlowStep value)?  resetFlowStep,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Load() when load != null:
return load(_that);case _StartRequested() when startRequested != null:
return startRequested(_that);case _DeleteRequested() when deleteRequested != null:
return deleteRequested(_that);case _ResetFlowStep() when resetFlowStep != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Load value)  load,required TResult Function( _StartRequested value)  startRequested,required TResult Function( _DeleteRequested value)  deleteRequested,required TResult Function( _ResetFlowStep value)  resetFlowStep,}){
final _that = this;
switch (_that) {
case _Load():
return load(_that);case _StartRequested():
return startRequested(_that);case _DeleteRequested():
return deleteRequested(_that);case _ResetFlowStep():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Load value)?  load,TResult? Function( _StartRequested value)?  startRequested,TResult? Function( _DeleteRequested value)?  deleteRequested,TResult? Function( _ResetFlowStep value)?  resetFlowStep,}){
final _that = this;
switch (_that) {
case _Load() when load != null:
return load(_that);case _StartRequested() when startRequested != null:
return startRequested(_that);case _DeleteRequested() when deleteRequested != null:
return deleteRequested(_that);case _ResetFlowStep() when resetFlowStep != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int projectId,  int stageId)?  load,TResult Function()?  startRequested,TResult Function()?  deleteRequested,TResult Function()?  resetFlowStep,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Load() when load != null:
return load(_that.projectId,_that.stageId);case _StartRequested() when startRequested != null:
return startRequested();case _DeleteRequested() when deleteRequested != null:
return deleteRequested();case _ResetFlowStep() when resetFlowStep != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int projectId,  int stageId)  load,required TResult Function()  startRequested,required TResult Function()  deleteRequested,required TResult Function()  resetFlowStep,}) {final _that = this;
switch (_that) {
case _Load():
return load(_that.projectId,_that.stageId);case _StartRequested():
return startRequested();case _DeleteRequested():
return deleteRequested();case _ResetFlowStep():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int projectId,  int stageId)?  load,TResult? Function()?  startRequested,TResult? Function()?  deleteRequested,TResult? Function()?  resetFlowStep,}) {final _that = this;
switch (_that) {
case _Load() when load != null:
return load(_that.projectId,_that.stageId);case _StartRequested() when startRequested != null:
return startRequested();case _DeleteRequested() when deleteRequested != null:
return deleteRequested();case _ResetFlowStep() when resetFlowStep != null:
return resetFlowStep();case _:
  return null;

}
}

}

/// @nodoc


class _Load implements StageEvent {
  const _Load({required this.projectId, required this.stageId});
  

 final  int projectId;
 final  int stageId;

/// Create a copy of StageEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadCopyWith<_Load> get copyWith => __$LoadCopyWithImpl<_Load>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Load&&(identical(other.projectId, projectId) || other.projectId == projectId)&&(identical(other.stageId, stageId) || other.stageId == stageId));
}


@override
int get hashCode {
    return Object.hash(runtimeType,projectId,stageId);
}

@override
String toString() {
    return 'StageEvent.load(projectId: $projectId, stageId: $stageId)';
}


}

/// @nodoc
abstract mixin class _$LoadCopyWith<$Res> implements $StageEventCopyWith<$Res> {
  factory _$LoadCopyWith(_Load value, $Res Function(_Load) _then) = __$LoadCopyWithImpl;
@useResult
$Res call({
 int projectId, int stageId
});




}
/// @nodoc
class __$LoadCopyWithImpl<$Res>
    implements _$LoadCopyWith<$Res> {
  __$LoadCopyWithImpl(this._self, this._then);

  final _Load _self;
  final $Res Function(_Load) _then;

/// Create a copy of StageEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? projectId = null,Object? stageId = null,}) {
  return _then(_Load(
projectId: null == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as int,stageId: null == stageId ? _self.stageId : stageId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _StartRequested implements StageEvent {
  const _StartRequested();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _StartRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'StageEvent.startRequested()';
}


}




/// @nodoc


class _DeleteRequested implements StageEvent {
  const _DeleteRequested();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeleteRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'StageEvent.deleteRequested()';
}


}




/// @nodoc


class _ResetFlowStep implements StageEvent {
  const _ResetFlowStep();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResetFlowStep);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'StageEvent.resetFlowStep()';
}


}




/// @nodoc
mixin _$StageState {

 int? get projectId; int? get stageId; ProjectOverview? get overview; StageView? get view;/// The stage's captures, newest first (doc/04d M4-10).
 List<Evidence> get evidence; GenericStatus get loadStatus; String? get loadErrorMessage;/// `updatingItem` = starting, `deletingItem` = deleting.
 GenericFlowStep get flowStep; GenericStatus get actionStatus; String? get actionErrorMessage;
/// Create a copy of StageState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StageStateCopyWith<StageState> get copyWith => _$StageStateCopyWithImpl<StageState>(this as StageState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as StageState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StageState&&(identical(other.projectId, _this.projectId) || other.projectId == _this.projectId)&&(identical(other.stageId, _this.stageId) || other.stageId == _this.stageId)&&(identical(other.overview, _this.overview) || other.overview == _this.overview)&&(identical(other.view, _this.view) || other.view == _this.view)&&const DeepCollectionEquality().equals(other.evidence, _this.evidence)&&(identical(other.loadStatus, _this.loadStatus) || other.loadStatus == _this.loadStatus)&&(identical(other.loadErrorMessage, _this.loadErrorMessage) || other.loadErrorMessage == _this.loadErrorMessage)&&(identical(other.flowStep, _this.flowStep) || other.flowStep == _this.flowStep)&&(identical(other.actionStatus, _this.actionStatus) || other.actionStatus == _this.actionStatus)&&(identical(other.actionErrorMessage, _this.actionErrorMessage) || other.actionErrorMessage == _this.actionErrorMessage));
}


@override
int get hashCode {
  final _this = this as StageState;
  return Object.hash(runtimeType,_this.projectId,_this.stageId,_this.overview,_this.view,const DeepCollectionEquality().hash(_this.evidence),_this.loadStatus,_this.loadErrorMessage,_this.flowStep,_this.actionStatus,_this.actionErrorMessage);
}

@override
String toString() {
  final _this = this as StageState;
  return 'StageState(projectId: ${_this.projectId}, stageId: ${_this.stageId}, overview: ${_this.overview}, view: ${_this.view}, evidence: ${_this.evidence}, loadStatus: ${_this.loadStatus}, loadErrorMessage: ${_this.loadErrorMessage}, flowStep: ${_this.flowStep}, actionStatus: ${_this.actionStatus}, actionErrorMessage: ${_this.actionErrorMessage})';
}


}

/// @nodoc
abstract mixin class $StageStateCopyWith<$Res>  {
  factory $StageStateCopyWith(StageState value, $Res Function(StageState) _then) = _$StageStateCopyWithImpl;
@useResult
$Res call({
 int? projectId, int? stageId, ProjectOverview? overview, StageView? view, List<Evidence> evidence, GenericStatus loadStatus, String? loadErrorMessage, GenericFlowStep flowStep, GenericStatus actionStatus, String? actionErrorMessage
});




}
/// @nodoc
class _$StageStateCopyWithImpl<$Res>
    implements $StageStateCopyWith<$Res> {
  _$StageStateCopyWithImpl(this._self, this._then);

  final StageState _self;
  final $Res Function(StageState) _then;

/// Create a copy of StageState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? projectId = freezed,Object? stageId = freezed,Object? overview = freezed,Object? view = freezed,Object? evidence = null,Object? loadStatus = null,Object? loadErrorMessage = freezed,Object? flowStep = null,Object? actionStatus = null,Object? actionErrorMessage = freezed,}) {
  return _then(StageState(
projectId: freezed == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as int?,stageId: freezed == stageId ? _self.stageId : stageId // ignore: cast_nullable_to_non_nullable
as int?,overview: freezed == overview ? _self.overview : overview // ignore: cast_nullable_to_non_nullable
as ProjectOverview?,view: freezed == view ? _self.view : view // ignore: cast_nullable_to_non_nullable
as StageView?,evidence: null == evidence ? _self.evidence : evidence // ignore: cast_nullable_to_non_nullable
as List<Evidence>,loadStatus: null == loadStatus ? _self.loadStatus : loadStatus // ignore: cast_nullable_to_non_nullable
as GenericStatus,loadErrorMessage: freezed == loadErrorMessage ? _self.loadErrorMessage : loadErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,flowStep: null == flowStep ? _self.flowStep : flowStep // ignore: cast_nullable_to_non_nullable
as GenericFlowStep,actionStatus: null == actionStatus ? _self.actionStatus : actionStatus // ignore: cast_nullable_to_non_nullable
as GenericStatus,actionErrorMessage: freezed == actionErrorMessage ? _self.actionErrorMessage : actionErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [StageState].
extension StageStatePatterns on StageState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StageState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StageState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StageState value)  $default,){
final _that = this;
switch (_that) {
case _StageState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StageState value)?  $default,){
final _that = this;
switch (_that) {
case _StageState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? projectId,  int? stageId,  ProjectOverview? overview,  StageView? view,  List<Evidence> evidence,  GenericStatus loadStatus,  String? loadErrorMessage,  GenericFlowStep flowStep,  GenericStatus actionStatus,  String? actionErrorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StageState() when $default != null:
return $default(_that.projectId,_that.stageId,_that.overview,_that.view,_that.evidence,_that.loadStatus,_that.loadErrorMessage,_that.flowStep,_that.actionStatus,_that.actionErrorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? projectId,  int? stageId,  ProjectOverview? overview,  StageView? view,  List<Evidence> evidence,  GenericStatus loadStatus,  String? loadErrorMessage,  GenericFlowStep flowStep,  GenericStatus actionStatus,  String? actionErrorMessage)  $default,) {final _that = this;
switch (_that) {
case _StageState():
return $default(_that.projectId,_that.stageId,_that.overview,_that.view,_that.evidence,_that.loadStatus,_that.loadErrorMessage,_that.flowStep,_that.actionStatus,_that.actionErrorMessage);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? projectId,  int? stageId,  ProjectOverview? overview,  StageView? view,  List<Evidence> evidence,  GenericStatus loadStatus,  String? loadErrorMessage,  GenericFlowStep flowStep,  GenericStatus actionStatus,  String? actionErrorMessage)?  $default,) {final _that = this;
switch (_that) {
case _StageState() when $default != null:
return $default(_that.projectId,_that.stageId,_that.overview,_that.view,_that.evidence,_that.loadStatus,_that.loadErrorMessage,_that.flowStep,_that.actionStatus,_that.actionErrorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _StageState extends StageState {
  const _StageState({this.projectId, this.stageId, this.overview, this.view,  List<Evidence> evidence = const <Evidence>[], this.loadStatus = GenericStatus.initial, this.loadErrorMessage, this.flowStep = GenericFlowStep.none, this.actionStatus = GenericStatus.initial, this.actionErrorMessage}): _evidence = evidence,super._();
  

@override final  int? projectId;
@override final  int? stageId;
@override final  ProjectOverview? overview;
@override final  StageView? view;
/// The stage's captures, newest first (doc/04d M4-10).
 final  List<Evidence> _evidence;
/// The stage's captures, newest first (doc/04d M4-10).
@override@JsonKey() List<Evidence> get evidence {
  if (_evidence is EqualUnmodifiableListView) return _evidence;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_evidence);
}

@override@JsonKey() final  GenericStatus loadStatus;
@override final  String? loadErrorMessage;
/// `updatingItem` = starting, `deletingItem` = deleting.
@override@JsonKey() final  GenericFlowStep flowStep;
@override@JsonKey() final  GenericStatus actionStatus;
@override final  String? actionErrorMessage;

/// Create a copy of StageState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StageStateCopyWith<_StageState> get copyWith => __$StageStateCopyWithImpl<_StageState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _StageState&&(identical(other.projectId, projectId) || other.projectId == projectId)&&(identical(other.stageId, stageId) || other.stageId == stageId)&&(identical(other.overview, overview) || other.overview == overview)&&(identical(other.view, view) || other.view == view)&&const DeepCollectionEquality().equals(other.evidence, _evidence)&&(identical(other.loadStatus, loadStatus) || other.loadStatus == loadStatus)&&(identical(other.loadErrorMessage, loadErrorMessage) || other.loadErrorMessage == loadErrorMessage)&&(identical(other.flowStep, flowStep) || other.flowStep == flowStep)&&(identical(other.actionStatus, actionStatus) || other.actionStatus == actionStatus)&&(identical(other.actionErrorMessage, actionErrorMessage) || other.actionErrorMessage == actionErrorMessage));
}


@override
int get hashCode {
    return Object.hash(runtimeType,projectId,stageId,overview,view,const DeepCollectionEquality().hash(_evidence),loadStatus,loadErrorMessage,flowStep,actionStatus,actionErrorMessage);
}

@override
String toString() {
    return 'StageState(projectId: $projectId, stageId: $stageId, overview: $overview, view: $view, evidence: $evidence, loadStatus: $loadStatus, loadErrorMessage: $loadErrorMessage, flowStep: $flowStep, actionStatus: $actionStatus, actionErrorMessage: $actionErrorMessage)';
}


}

/// @nodoc
abstract mixin class _$StageStateCopyWith<$Res> implements $StageStateCopyWith<$Res> {
  factory _$StageStateCopyWith(_StageState value, $Res Function(_StageState) _then) = __$StageStateCopyWithImpl;
@override @useResult
$Res call({
 int? projectId, int? stageId, ProjectOverview? overview, StageView? view, List<Evidence> evidence, GenericStatus loadStatus, String? loadErrorMessage, GenericFlowStep flowStep, GenericStatus actionStatus, String? actionErrorMessage
});




}
/// @nodoc
class __$StageStateCopyWithImpl<$Res>
    implements _$StageStateCopyWith<$Res> {
  __$StageStateCopyWithImpl(this._self, this._then);

  final _StageState _self;
  final $Res Function(_StageState) _then;

/// Create a copy of StageState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? projectId = freezed,Object? stageId = freezed,Object? overview = freezed,Object? view = freezed,Object? evidence = null,Object? loadStatus = null,Object? loadErrorMessage = freezed,Object? flowStep = null,Object? actionStatus = null,Object? actionErrorMessage = freezed,}) {
  return _then(_StageState(
projectId: freezed == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as int?,stageId: freezed == stageId ? _self.stageId : stageId // ignore: cast_nullable_to_non_nullable
as int?,overview: freezed == overview ? _self.overview : overview // ignore: cast_nullable_to_non_nullable
as ProjectOverview?,view: freezed == view ? _self.view : view // ignore: cast_nullable_to_non_nullable
as StageView?,evidence: null == evidence ? _self._evidence : evidence // ignore: cast_nullable_to_non_nullable
as List<Evidence>,loadStatus: null == loadStatus ? _self.loadStatus : loadStatus // ignore: cast_nullable_to_non_nullable
as GenericStatus,loadErrorMessage: freezed == loadErrorMessage ? _self.loadErrorMessage : loadErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,flowStep: null == flowStep ? _self.flowStep : flowStep // ignore: cast_nullable_to_non_nullable
as GenericFlowStep,actionStatus: null == actionStatus ? _self.actionStatus : actionStatus // ignore: cast_nullable_to_non_nullable
as GenericStatus,actionErrorMessage: freezed == actionErrorMessage ? _self.actionErrorMessage : actionErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
