// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stage_form_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StageFormEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is StageFormEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'StageFormEvent()';
}


}

/// @nodoc
class $StageFormEventCopyWith<$Res>  {
$StageFormEventCopyWith(StageFormEvent _, $Res Function(StageFormEvent) __);
}


/// Adds pattern-matching-related methods to [StageFormEvent].
extension StageFormEventPatterns on StageFormEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Load value)?  load,TResult Function( _SaveRequested value)?  saveRequested,TResult Function( _ResetFlowStep value)?  resetFlowStep,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Load() when load != null:
return load(_that);case _SaveRequested() when saveRequested != null:
return saveRequested(_that);case _ResetFlowStep() when resetFlowStep != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Load value)  load,required TResult Function( _SaveRequested value)  saveRequested,required TResult Function( _ResetFlowStep value)  resetFlowStep,}){
final _that = this;
switch (_that) {
case _Load():
return load(_that);case _SaveRequested():
return saveRequested(_that);case _ResetFlowStep():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Load value)?  load,TResult? Function( _SaveRequested value)?  saveRequested,TResult? Function( _ResetFlowStep value)?  resetFlowStep,}){
final _that = this;
switch (_that) {
case _Load() when load != null:
return load(_that);case _SaveRequested() when saveRequested != null:
return saveRequested(_that);case _ResetFlowStep() when resetFlowStep != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int projectId,  int? stageId)?  load,TResult Function( StageDraft draft)?  saveRequested,TResult Function()?  resetFlowStep,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Load() when load != null:
return load(_that.projectId,_that.stageId);case _SaveRequested() when saveRequested != null:
return saveRequested(_that.draft);case _ResetFlowStep() when resetFlowStep != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int projectId,  int? stageId)  load,required TResult Function( StageDraft draft)  saveRequested,required TResult Function()  resetFlowStep,}) {final _that = this;
switch (_that) {
case _Load():
return load(_that.projectId,_that.stageId);case _SaveRequested():
return saveRequested(_that.draft);case _ResetFlowStep():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int projectId,  int? stageId)?  load,TResult? Function( StageDraft draft)?  saveRequested,TResult? Function()?  resetFlowStep,}) {final _that = this;
switch (_that) {
case _Load() when load != null:
return load(_that.projectId,_that.stageId);case _SaveRequested() when saveRequested != null:
return saveRequested(_that.draft);case _ResetFlowStep() when resetFlowStep != null:
return resetFlowStep();case _:
  return null;

}
}

}

/// @nodoc


class _Load implements StageFormEvent {
  const _Load({required this.projectId, this.stageId});
  

 final  int projectId;
 final  int? stageId;

/// Create a copy of StageFormEvent
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
    return 'StageFormEvent.load(projectId: $projectId, stageId: $stageId)';
}


}

/// @nodoc
abstract mixin class _$LoadCopyWith<$Res> implements $StageFormEventCopyWith<$Res> {
  factory _$LoadCopyWith(_Load value, $Res Function(_Load) _then) = __$LoadCopyWithImpl;
@useResult
$Res call({
 int projectId, int? stageId
});




}
/// @nodoc
class __$LoadCopyWithImpl<$Res>
    implements _$LoadCopyWith<$Res> {
  __$LoadCopyWithImpl(this._self, this._then);

  final _Load _self;
  final $Res Function(_Load) _then;

/// Create a copy of StageFormEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? projectId = null,Object? stageId = freezed,}) {
  return _then(_Load(
projectId: null == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as int,stageId: freezed == stageId ? _self.stageId : stageId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc


class _SaveRequested implements StageFormEvent {
  const _SaveRequested({required this.draft});
  

 final  StageDraft draft;

/// Create a copy of StageFormEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SaveRequestedCopyWith<_SaveRequested> get copyWith => __$SaveRequestedCopyWithImpl<_SaveRequested>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SaveRequested&&(identical(other.draft, draft) || other.draft == draft));
}


@override
int get hashCode {
    return Object.hash(runtimeType,draft);
}

@override
String toString() {
    return 'StageFormEvent.saveRequested(draft: $draft)';
}


}

/// @nodoc
abstract mixin class _$SaveRequestedCopyWith<$Res> implements $StageFormEventCopyWith<$Res> {
  factory _$SaveRequestedCopyWith(_SaveRequested value, $Res Function(_SaveRequested) _then) = __$SaveRequestedCopyWithImpl;
@useResult
$Res call({
 StageDraft draft
});




}
/// @nodoc
class __$SaveRequestedCopyWithImpl<$Res>
    implements _$SaveRequestedCopyWith<$Res> {
  __$SaveRequestedCopyWithImpl(this._self, this._then);

  final _SaveRequested _self;
  final $Res Function(_SaveRequested) _then;

/// Create a copy of StageFormEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? draft = null,}) {
  return _then(_SaveRequested(
draft: null == draft ? _self.draft : draft // ignore: cast_nullable_to_non_nullable
as StageDraft,
  ));
}


}

/// @nodoc


class _ResetFlowStep implements StageFormEvent {
  const _ResetFlowStep();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResetFlowStep);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'StageFormEvent.resetFlowStep()';
}


}




/// @nodoc
mixin _$StageFormState {

 int? get projectId;/// Null for a new stage.
 int? get stageId; ProjectOverview? get overview;/// The stage being edited; null for a new one.
 StageView? get view; GenericStatus get loadStatus; String? get loadErrorMessage; GenericStatus get actionStatus; String? get actionErrorMessage;/// The stage as the server saved it; the page then opens it.
 StageView? get saved;
/// Create a copy of StageFormState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StageFormStateCopyWith<StageFormState> get copyWith => _$StageFormStateCopyWithImpl<StageFormState>(this as StageFormState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as StageFormState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StageFormState&&(identical(other.projectId, _this.projectId) || other.projectId == _this.projectId)&&(identical(other.stageId, _this.stageId) || other.stageId == _this.stageId)&&(identical(other.overview, _this.overview) || other.overview == _this.overview)&&(identical(other.view, _this.view) || other.view == _this.view)&&(identical(other.loadStatus, _this.loadStatus) || other.loadStatus == _this.loadStatus)&&(identical(other.loadErrorMessage, _this.loadErrorMessage) || other.loadErrorMessage == _this.loadErrorMessage)&&(identical(other.actionStatus, _this.actionStatus) || other.actionStatus == _this.actionStatus)&&(identical(other.actionErrorMessage, _this.actionErrorMessage) || other.actionErrorMessage == _this.actionErrorMessage)&&(identical(other.saved, _this.saved) || other.saved == _this.saved));
}


@override
int get hashCode {
  final _this = this as StageFormState;
  return Object.hash(runtimeType,_this.projectId,_this.stageId,_this.overview,_this.view,_this.loadStatus,_this.loadErrorMessage,_this.actionStatus,_this.actionErrorMessage,_this.saved);
}

@override
String toString() {
  final _this = this as StageFormState;
  return 'StageFormState(projectId: ${_this.projectId}, stageId: ${_this.stageId}, overview: ${_this.overview}, view: ${_this.view}, loadStatus: ${_this.loadStatus}, loadErrorMessage: ${_this.loadErrorMessage}, actionStatus: ${_this.actionStatus}, actionErrorMessage: ${_this.actionErrorMessage}, saved: ${_this.saved})';
}


}

/// @nodoc
abstract mixin class $StageFormStateCopyWith<$Res>  {
  factory $StageFormStateCopyWith(StageFormState value, $Res Function(StageFormState) _then) = _$StageFormStateCopyWithImpl;
@useResult
$Res call({
 int? projectId, int? stageId, ProjectOverview? overview, StageView? view, GenericStatus loadStatus, String? loadErrorMessage, GenericStatus actionStatus, String? actionErrorMessage, StageView? saved
});




}
/// @nodoc
class _$StageFormStateCopyWithImpl<$Res>
    implements $StageFormStateCopyWith<$Res> {
  _$StageFormStateCopyWithImpl(this._self, this._then);

  final StageFormState _self;
  final $Res Function(StageFormState) _then;

/// Create a copy of StageFormState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? projectId = freezed,Object? stageId = freezed,Object? overview = freezed,Object? view = freezed,Object? loadStatus = null,Object? loadErrorMessage = freezed,Object? actionStatus = null,Object? actionErrorMessage = freezed,Object? saved = freezed,}) {
  return _then(StageFormState(
projectId: freezed == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as int?,stageId: freezed == stageId ? _self.stageId : stageId // ignore: cast_nullable_to_non_nullable
as int?,overview: freezed == overview ? _self.overview : overview // ignore: cast_nullable_to_non_nullable
as ProjectOverview?,view: freezed == view ? _self.view : view // ignore: cast_nullable_to_non_nullable
as StageView?,loadStatus: null == loadStatus ? _self.loadStatus : loadStatus // ignore: cast_nullable_to_non_nullable
as GenericStatus,loadErrorMessage: freezed == loadErrorMessage ? _self.loadErrorMessage : loadErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,actionStatus: null == actionStatus ? _self.actionStatus : actionStatus // ignore: cast_nullable_to_non_nullable
as GenericStatus,actionErrorMessage: freezed == actionErrorMessage ? _self.actionErrorMessage : actionErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,saved: freezed == saved ? _self.saved : saved // ignore: cast_nullable_to_non_nullable
as StageView?,
  ));
}

}


/// Adds pattern-matching-related methods to [StageFormState].
extension StageFormStatePatterns on StageFormState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StageFormState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StageFormState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StageFormState value)  $default,){
final _that = this;
switch (_that) {
case _StageFormState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StageFormState value)?  $default,){
final _that = this;
switch (_that) {
case _StageFormState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? projectId,  int? stageId,  ProjectOverview? overview,  StageView? view,  GenericStatus loadStatus,  String? loadErrorMessage,  GenericStatus actionStatus,  String? actionErrorMessage,  StageView? saved)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StageFormState() when $default != null:
return $default(_that.projectId,_that.stageId,_that.overview,_that.view,_that.loadStatus,_that.loadErrorMessage,_that.actionStatus,_that.actionErrorMessage,_that.saved);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? projectId,  int? stageId,  ProjectOverview? overview,  StageView? view,  GenericStatus loadStatus,  String? loadErrorMessage,  GenericStatus actionStatus,  String? actionErrorMessage,  StageView? saved)  $default,) {final _that = this;
switch (_that) {
case _StageFormState():
return $default(_that.projectId,_that.stageId,_that.overview,_that.view,_that.loadStatus,_that.loadErrorMessage,_that.actionStatus,_that.actionErrorMessage,_that.saved);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? projectId,  int? stageId,  ProjectOverview? overview,  StageView? view,  GenericStatus loadStatus,  String? loadErrorMessage,  GenericStatus actionStatus,  String? actionErrorMessage,  StageView? saved)?  $default,) {final _that = this;
switch (_that) {
case _StageFormState() when $default != null:
return $default(_that.projectId,_that.stageId,_that.overview,_that.view,_that.loadStatus,_that.loadErrorMessage,_that.actionStatus,_that.actionErrorMessage,_that.saved);case _:
  return null;

}
}

}

/// @nodoc


class _StageFormState extends StageFormState {
  const _StageFormState({this.projectId, this.stageId, this.overview, this.view, this.loadStatus = GenericStatus.initial, this.loadErrorMessage, this.actionStatus = GenericStatus.initial, this.actionErrorMessage, this.saved}): super._();
  

@override final  int? projectId;
/// Null for a new stage.
@override final  int? stageId;
@override final  ProjectOverview? overview;
/// The stage being edited; null for a new one.
@override final  StageView? view;
@override@JsonKey() final  GenericStatus loadStatus;
@override final  String? loadErrorMessage;
@override@JsonKey() final  GenericStatus actionStatus;
@override final  String? actionErrorMessage;
/// The stage as the server saved it; the page then opens it.
@override final  StageView? saved;

/// Create a copy of StageFormState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StageFormStateCopyWith<_StageFormState> get copyWith => __$StageFormStateCopyWithImpl<_StageFormState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _StageFormState&&(identical(other.projectId, projectId) || other.projectId == projectId)&&(identical(other.stageId, stageId) || other.stageId == stageId)&&(identical(other.overview, overview) || other.overview == overview)&&(identical(other.view, view) || other.view == view)&&(identical(other.loadStatus, loadStatus) || other.loadStatus == loadStatus)&&(identical(other.loadErrorMessage, loadErrorMessage) || other.loadErrorMessage == loadErrorMessage)&&(identical(other.actionStatus, actionStatus) || other.actionStatus == actionStatus)&&(identical(other.actionErrorMessage, actionErrorMessage) || other.actionErrorMessage == actionErrorMessage)&&(identical(other.saved, saved) || other.saved == saved));
}


@override
int get hashCode {
    return Object.hash(runtimeType,projectId,stageId,overview,view,loadStatus,loadErrorMessage,actionStatus,actionErrorMessage,saved);
}

@override
String toString() {
    return 'StageFormState(projectId: $projectId, stageId: $stageId, overview: $overview, view: $view, loadStatus: $loadStatus, loadErrorMessage: $loadErrorMessage, actionStatus: $actionStatus, actionErrorMessage: $actionErrorMessage, saved: $saved)';
}


}

/// @nodoc
abstract mixin class _$StageFormStateCopyWith<$Res> implements $StageFormStateCopyWith<$Res> {
  factory _$StageFormStateCopyWith(_StageFormState value, $Res Function(_StageFormState) _then) = __$StageFormStateCopyWithImpl;
@override @useResult
$Res call({
 int? projectId, int? stageId, ProjectOverview? overview, StageView? view, GenericStatus loadStatus, String? loadErrorMessage, GenericStatus actionStatus, String? actionErrorMessage, StageView? saved
});




}
/// @nodoc
class __$StageFormStateCopyWithImpl<$Res>
    implements _$StageFormStateCopyWith<$Res> {
  __$StageFormStateCopyWithImpl(this._self, this._then);

  final _StageFormState _self;
  final $Res Function(_StageFormState) _then;

/// Create a copy of StageFormState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? projectId = freezed,Object? stageId = freezed,Object? overview = freezed,Object? view = freezed,Object? loadStatus = null,Object? loadErrorMessage = freezed,Object? actionStatus = null,Object? actionErrorMessage = freezed,Object? saved = freezed,}) {
  return _then(_StageFormState(
projectId: freezed == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as int?,stageId: freezed == stageId ? _self.stageId : stageId // ignore: cast_nullable_to_non_nullable
as int?,overview: freezed == overview ? _self.overview : overview // ignore: cast_nullable_to_non_nullable
as ProjectOverview?,view: freezed == view ? _self.view : view // ignore: cast_nullable_to_non_nullable
as StageView?,loadStatus: null == loadStatus ? _self.loadStatus : loadStatus // ignore: cast_nullable_to_non_nullable
as GenericStatus,loadErrorMessage: freezed == loadErrorMessage ? _self.loadErrorMessage : loadErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,actionStatus: null == actionStatus ? _self.actionStatus : actionStatus // ignore: cast_nullable_to_non_nullable
as GenericStatus,actionErrorMessage: freezed == actionErrorMessage ? _self.actionErrorMessage : actionErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,saved: freezed == saved ? _self.saved : saved // ignore: cast_nullable_to_non_nullable
as StageView?,
  ));
}


}

// dart format on
