// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stage_plan_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StagePlanEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is StagePlanEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'StagePlanEvent()';
}


}

/// @nodoc
class $StagePlanEventCopyWith<$Res>  {
$StagePlanEventCopyWith(StagePlanEvent _, $Res Function(StagePlanEvent) __);
}


/// Adds pattern-matching-related methods to [StagePlanEvent].
extension StagePlanEventPatterns on StagePlanEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Load value)?  load,TResult Function( _ReorderRequested value)?  reorderRequested,TResult Function( _TemplateApplied value)?  templateApplied,TResult Function( _ResetFlowStep value)?  resetFlowStep,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Load() when load != null:
return load(_that);case _ReorderRequested() when reorderRequested != null:
return reorderRequested(_that);case _TemplateApplied() when templateApplied != null:
return templateApplied(_that);case _ResetFlowStep() when resetFlowStep != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Load value)  load,required TResult Function( _ReorderRequested value)  reorderRequested,required TResult Function( _TemplateApplied value)  templateApplied,required TResult Function( _ResetFlowStep value)  resetFlowStep,}){
final _that = this;
switch (_that) {
case _Load():
return load(_that);case _ReorderRequested():
return reorderRequested(_that);case _TemplateApplied():
return templateApplied(_that);case _ResetFlowStep():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Load value)?  load,TResult? Function( _ReorderRequested value)?  reorderRequested,TResult? Function( _TemplateApplied value)?  templateApplied,TResult? Function( _ResetFlowStep value)?  resetFlowStep,}){
final _that = this;
switch (_that) {
case _Load() when load != null:
return load(_that);case _ReorderRequested() when reorderRequested != null:
return reorderRequested(_that);case _TemplateApplied() when templateApplied != null:
return templateApplied(_that);case _ResetFlowStep() when resetFlowStep != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int projectId)?  load,TResult Function( int oldIndex,  int newIndex)?  reorderRequested,TResult Function( StageTemplate template)?  templateApplied,TResult Function()?  resetFlowStep,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Load() when load != null:
return load(_that.projectId);case _ReorderRequested() when reorderRequested != null:
return reorderRequested(_that.oldIndex,_that.newIndex);case _TemplateApplied() when templateApplied != null:
return templateApplied(_that.template);case _ResetFlowStep() when resetFlowStep != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int projectId)  load,required TResult Function( int oldIndex,  int newIndex)  reorderRequested,required TResult Function( StageTemplate template)  templateApplied,required TResult Function()  resetFlowStep,}) {final _that = this;
switch (_that) {
case _Load():
return load(_that.projectId);case _ReorderRequested():
return reorderRequested(_that.oldIndex,_that.newIndex);case _TemplateApplied():
return templateApplied(_that.template);case _ResetFlowStep():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int projectId)?  load,TResult? Function( int oldIndex,  int newIndex)?  reorderRequested,TResult? Function( StageTemplate template)?  templateApplied,TResult? Function()?  resetFlowStep,}) {final _that = this;
switch (_that) {
case _Load() when load != null:
return load(_that.projectId);case _ReorderRequested() when reorderRequested != null:
return reorderRequested(_that.oldIndex,_that.newIndex);case _TemplateApplied() when templateApplied != null:
return templateApplied(_that.template);case _ResetFlowStep() when resetFlowStep != null:
return resetFlowStep();case _:
  return null;

}
}

}

/// @nodoc


class _Load implements StagePlanEvent {
  const _Load({required this.projectId});
  

 final  int projectId;

/// Create a copy of StagePlanEvent
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
    return 'StagePlanEvent.load(projectId: $projectId)';
}


}

/// @nodoc
abstract mixin class _$LoadCopyWith<$Res> implements $StagePlanEventCopyWith<$Res> {
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

/// Create a copy of StagePlanEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? projectId = null,}) {
  return _then(_Load(
projectId: null == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _ReorderRequested implements StagePlanEvent {
  const _ReorderRequested({required this.oldIndex, required this.newIndex});
  

 final  int oldIndex;
 final  int newIndex;

/// Create a copy of StagePlanEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReorderRequestedCopyWith<_ReorderRequested> get copyWith => __$ReorderRequestedCopyWithImpl<_ReorderRequested>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReorderRequested&&(identical(other.oldIndex, oldIndex) || other.oldIndex == oldIndex)&&(identical(other.newIndex, newIndex) || other.newIndex == newIndex));
}


@override
int get hashCode {
    return Object.hash(runtimeType,oldIndex,newIndex);
}

@override
String toString() {
    return 'StagePlanEvent.reorderRequested(oldIndex: $oldIndex, newIndex: $newIndex)';
}


}

/// @nodoc
abstract mixin class _$ReorderRequestedCopyWith<$Res> implements $StagePlanEventCopyWith<$Res> {
  factory _$ReorderRequestedCopyWith(_ReorderRequested value, $Res Function(_ReorderRequested) _then) = __$ReorderRequestedCopyWithImpl;
@useResult
$Res call({
 int oldIndex, int newIndex
});




}
/// @nodoc
class __$ReorderRequestedCopyWithImpl<$Res>
    implements _$ReorderRequestedCopyWith<$Res> {
  __$ReorderRequestedCopyWithImpl(this._self, this._then);

  final _ReorderRequested _self;
  final $Res Function(_ReorderRequested) _then;

/// Create a copy of StagePlanEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? oldIndex = null,Object? newIndex = null,}) {
  return _then(_ReorderRequested(
oldIndex: null == oldIndex ? _self.oldIndex : oldIndex // ignore: cast_nullable_to_non_nullable
as int,newIndex: null == newIndex ? _self.newIndex : newIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _TemplateApplied implements StagePlanEvent {
  const _TemplateApplied({required this.template});
  

 final  StageTemplate template;

/// Create a copy of StagePlanEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TemplateAppliedCopyWith<_TemplateApplied> get copyWith => __$TemplateAppliedCopyWithImpl<_TemplateApplied>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TemplateApplied&&(identical(other.template, template) || other.template == template));
}


@override
int get hashCode {
    return Object.hash(runtimeType,template);
}

@override
String toString() {
    return 'StagePlanEvent.templateApplied(template: $template)';
}


}

/// @nodoc
abstract mixin class _$TemplateAppliedCopyWith<$Res> implements $StagePlanEventCopyWith<$Res> {
  factory _$TemplateAppliedCopyWith(_TemplateApplied value, $Res Function(_TemplateApplied) _then) = __$TemplateAppliedCopyWithImpl;
@useResult
$Res call({
 StageTemplate template
});




}
/// @nodoc
class __$TemplateAppliedCopyWithImpl<$Res>
    implements _$TemplateAppliedCopyWith<$Res> {
  __$TemplateAppliedCopyWithImpl(this._self, this._then);

  final _TemplateApplied _self;
  final $Res Function(_TemplateApplied) _then;

/// Create a copy of StagePlanEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? template = null,}) {
  return _then(_TemplateApplied(
template: null == template ? _self.template : template // ignore: cast_nullable_to_non_nullable
as StageTemplate,
  ));
}


}

/// @nodoc


class _ResetFlowStep implements StagePlanEvent {
  const _ResetFlowStep();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResetFlowStep);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'StagePlanEvent.resetFlowStep()';
}


}




/// @nodoc
mixin _$StagePlanState {

 int? get projectId; ProjectOverview? get overview; StagePlan? get plan; GenericStatus get loadStatus; String? get loadErrorMessage;/// `updatingItem` = reordering, `creatingItem` = applying a template.
 GenericFlowStep get flowStep; GenericStatus get actionStatus; String? get actionErrorMessage;
/// Create a copy of StagePlanState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StagePlanStateCopyWith<StagePlanState> get copyWith => _$StagePlanStateCopyWithImpl<StagePlanState>(this as StagePlanState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as StagePlanState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StagePlanState&&(identical(other.projectId, _this.projectId) || other.projectId == _this.projectId)&&(identical(other.overview, _this.overview) || other.overview == _this.overview)&&(identical(other.plan, _this.plan) || other.plan == _this.plan)&&(identical(other.loadStatus, _this.loadStatus) || other.loadStatus == _this.loadStatus)&&(identical(other.loadErrorMessage, _this.loadErrorMessage) || other.loadErrorMessage == _this.loadErrorMessage)&&(identical(other.flowStep, _this.flowStep) || other.flowStep == _this.flowStep)&&(identical(other.actionStatus, _this.actionStatus) || other.actionStatus == _this.actionStatus)&&(identical(other.actionErrorMessage, _this.actionErrorMessage) || other.actionErrorMessage == _this.actionErrorMessage));
}


@override
int get hashCode {
  final _this = this as StagePlanState;
  return Object.hash(runtimeType,_this.projectId,_this.overview,_this.plan,_this.loadStatus,_this.loadErrorMessage,_this.flowStep,_this.actionStatus,_this.actionErrorMessage);
}

@override
String toString() {
  final _this = this as StagePlanState;
  return 'StagePlanState(projectId: ${_this.projectId}, overview: ${_this.overview}, plan: ${_this.plan}, loadStatus: ${_this.loadStatus}, loadErrorMessage: ${_this.loadErrorMessage}, flowStep: ${_this.flowStep}, actionStatus: ${_this.actionStatus}, actionErrorMessage: ${_this.actionErrorMessage})';
}


}

/// @nodoc
abstract mixin class $StagePlanStateCopyWith<$Res>  {
  factory $StagePlanStateCopyWith(StagePlanState value, $Res Function(StagePlanState) _then) = _$StagePlanStateCopyWithImpl;
@useResult
$Res call({
 int? projectId, ProjectOverview? overview, StagePlan? plan, GenericStatus loadStatus, String? loadErrorMessage, GenericFlowStep flowStep, GenericStatus actionStatus, String? actionErrorMessage
});




}
/// @nodoc
class _$StagePlanStateCopyWithImpl<$Res>
    implements $StagePlanStateCopyWith<$Res> {
  _$StagePlanStateCopyWithImpl(this._self, this._then);

  final StagePlanState _self;
  final $Res Function(StagePlanState) _then;

/// Create a copy of StagePlanState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? projectId = freezed,Object? overview = freezed,Object? plan = freezed,Object? loadStatus = null,Object? loadErrorMessage = freezed,Object? flowStep = null,Object? actionStatus = null,Object? actionErrorMessage = freezed,}) {
  return _then(StagePlanState(
projectId: freezed == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as int?,overview: freezed == overview ? _self.overview : overview // ignore: cast_nullable_to_non_nullable
as ProjectOverview?,plan: freezed == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as StagePlan?,loadStatus: null == loadStatus ? _self.loadStatus : loadStatus // ignore: cast_nullable_to_non_nullable
as GenericStatus,loadErrorMessage: freezed == loadErrorMessage ? _self.loadErrorMessage : loadErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,flowStep: null == flowStep ? _self.flowStep : flowStep // ignore: cast_nullable_to_non_nullable
as GenericFlowStep,actionStatus: null == actionStatus ? _self.actionStatus : actionStatus // ignore: cast_nullable_to_non_nullable
as GenericStatus,actionErrorMessage: freezed == actionErrorMessage ? _self.actionErrorMessage : actionErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [StagePlanState].
extension StagePlanStatePatterns on StagePlanState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StagePlanState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StagePlanState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StagePlanState value)  $default,){
final _that = this;
switch (_that) {
case _StagePlanState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StagePlanState value)?  $default,){
final _that = this;
switch (_that) {
case _StagePlanState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? projectId,  ProjectOverview? overview,  StagePlan? plan,  GenericStatus loadStatus,  String? loadErrorMessage,  GenericFlowStep flowStep,  GenericStatus actionStatus,  String? actionErrorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StagePlanState() when $default != null:
return $default(_that.projectId,_that.overview,_that.plan,_that.loadStatus,_that.loadErrorMessage,_that.flowStep,_that.actionStatus,_that.actionErrorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? projectId,  ProjectOverview? overview,  StagePlan? plan,  GenericStatus loadStatus,  String? loadErrorMessage,  GenericFlowStep flowStep,  GenericStatus actionStatus,  String? actionErrorMessage)  $default,) {final _that = this;
switch (_that) {
case _StagePlanState():
return $default(_that.projectId,_that.overview,_that.plan,_that.loadStatus,_that.loadErrorMessage,_that.flowStep,_that.actionStatus,_that.actionErrorMessage);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? projectId,  ProjectOverview? overview,  StagePlan? plan,  GenericStatus loadStatus,  String? loadErrorMessage,  GenericFlowStep flowStep,  GenericStatus actionStatus,  String? actionErrorMessage)?  $default,) {final _that = this;
switch (_that) {
case _StagePlanState() when $default != null:
return $default(_that.projectId,_that.overview,_that.plan,_that.loadStatus,_that.loadErrorMessage,_that.flowStep,_that.actionStatus,_that.actionErrorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _StagePlanState extends StagePlanState {
  const _StagePlanState({this.projectId, this.overview, this.plan, this.loadStatus = GenericStatus.initial, this.loadErrorMessage, this.flowStep = GenericFlowStep.none, this.actionStatus = GenericStatus.initial, this.actionErrorMessage}): super._();
  

@override final  int? projectId;
@override final  ProjectOverview? overview;
@override final  StagePlan? plan;
@override@JsonKey() final  GenericStatus loadStatus;
@override final  String? loadErrorMessage;
/// `updatingItem` = reordering, `creatingItem` = applying a template.
@override@JsonKey() final  GenericFlowStep flowStep;
@override@JsonKey() final  GenericStatus actionStatus;
@override final  String? actionErrorMessage;

/// Create a copy of StagePlanState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StagePlanStateCopyWith<_StagePlanState> get copyWith => __$StagePlanStateCopyWithImpl<_StagePlanState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _StagePlanState&&(identical(other.projectId, projectId) || other.projectId == projectId)&&(identical(other.overview, overview) || other.overview == overview)&&(identical(other.plan, plan) || other.plan == plan)&&(identical(other.loadStatus, loadStatus) || other.loadStatus == loadStatus)&&(identical(other.loadErrorMessage, loadErrorMessage) || other.loadErrorMessage == loadErrorMessage)&&(identical(other.flowStep, flowStep) || other.flowStep == flowStep)&&(identical(other.actionStatus, actionStatus) || other.actionStatus == actionStatus)&&(identical(other.actionErrorMessage, actionErrorMessage) || other.actionErrorMessage == actionErrorMessage));
}


@override
int get hashCode {
    return Object.hash(runtimeType,projectId,overview,plan,loadStatus,loadErrorMessage,flowStep,actionStatus,actionErrorMessage);
}

@override
String toString() {
    return 'StagePlanState(projectId: $projectId, overview: $overview, plan: $plan, loadStatus: $loadStatus, loadErrorMessage: $loadErrorMessage, flowStep: $flowStep, actionStatus: $actionStatus, actionErrorMessage: $actionErrorMessage)';
}


}

/// @nodoc
abstract mixin class _$StagePlanStateCopyWith<$Res> implements $StagePlanStateCopyWith<$Res> {
  factory _$StagePlanStateCopyWith(_StagePlanState value, $Res Function(_StagePlanState) _then) = __$StagePlanStateCopyWithImpl;
@override @useResult
$Res call({
 int? projectId, ProjectOverview? overview, StagePlan? plan, GenericStatus loadStatus, String? loadErrorMessage, GenericFlowStep flowStep, GenericStatus actionStatus, String? actionErrorMessage
});




}
/// @nodoc
class __$StagePlanStateCopyWithImpl<$Res>
    implements _$StagePlanStateCopyWith<$Res> {
  __$StagePlanStateCopyWithImpl(this._self, this._then);

  final _StagePlanState _self;
  final $Res Function(_StagePlanState) _then;

/// Create a copy of StagePlanState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? projectId = freezed,Object? overview = freezed,Object? plan = freezed,Object? loadStatus = null,Object? loadErrorMessage = freezed,Object? flowStep = null,Object? actionStatus = null,Object? actionErrorMessage = freezed,}) {
  return _then(_StagePlanState(
projectId: freezed == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as int?,overview: freezed == overview ? _self.overview : overview // ignore: cast_nullable_to_non_nullable
as ProjectOverview?,plan: freezed == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as StagePlan?,loadStatus: null == loadStatus ? _self.loadStatus : loadStatus // ignore: cast_nullable_to_non_nullable
as GenericStatus,loadErrorMessage: freezed == loadErrorMessage ? _self.loadErrorMessage : loadErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,flowStep: null == flowStep ? _self.flowStep : flowStep // ignore: cast_nullable_to_non_nullable
as GenericFlowStep,actionStatus: null == actionStatus ? _self.actionStatus : actionStatus // ignore: cast_nullable_to_non_nullable
as GenericStatus,actionErrorMessage: freezed == actionErrorMessage ? _self.actionErrorMessage : actionErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
