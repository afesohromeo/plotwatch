// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'project_overview_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProjectOverviewEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ProjectOverviewEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'ProjectOverviewEvent()';
}


}

/// @nodoc
class $ProjectOverviewEventCopyWith<$Res>  {
$ProjectOverviewEventCopyWith(ProjectOverviewEvent _, $Res Function(ProjectOverviewEvent) __);
}


/// Adds pattern-matching-related methods to [ProjectOverviewEvent].
extension ProjectOverviewEventPatterns on ProjectOverviewEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _FetchProject value)?  fetchProject,TResult Function( _UpdateProject value)?  updateProject,TResult Function( _ChangeStatus value)?  changeStatus,TResult Function( _ResetFlowStep value)?  resetFlowStep,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FetchProject() when fetchProject != null:
return fetchProject(_that);case _UpdateProject() when updateProject != null:
return updateProject(_that);case _ChangeStatus() when changeStatus != null:
return changeStatus(_that);case _ResetFlowStep() when resetFlowStep != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _FetchProject value)  fetchProject,required TResult Function( _UpdateProject value)  updateProject,required TResult Function( _ChangeStatus value)  changeStatus,required TResult Function( _ResetFlowStep value)  resetFlowStep,}){
final _that = this;
switch (_that) {
case _FetchProject():
return fetchProject(_that);case _UpdateProject():
return updateProject(_that);case _ChangeStatus():
return changeStatus(_that);case _ResetFlowStep():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _FetchProject value)?  fetchProject,TResult? Function( _UpdateProject value)?  updateProject,TResult? Function( _ChangeStatus value)?  changeStatus,TResult? Function( _ResetFlowStep value)?  resetFlowStep,}){
final _that = this;
switch (_that) {
case _FetchProject() when fetchProject != null:
return fetchProject(_that);case _UpdateProject() when updateProject != null:
return updateProject(_that);case _ChangeStatus() when changeStatus != null:
return changeStatus(_that);case _ResetFlowStep() when resetFlowStep != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int projectId)?  fetchProject,TResult Function( ProjectDetails details)?  updateProject,TResult Function( ProjectStatus status)?  changeStatus,TResult Function()?  resetFlowStep,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FetchProject() when fetchProject != null:
return fetchProject(_that.projectId);case _UpdateProject() when updateProject != null:
return updateProject(_that.details);case _ChangeStatus() when changeStatus != null:
return changeStatus(_that.status);case _ResetFlowStep() when resetFlowStep != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int projectId)  fetchProject,required TResult Function( ProjectDetails details)  updateProject,required TResult Function( ProjectStatus status)  changeStatus,required TResult Function()  resetFlowStep,}) {final _that = this;
switch (_that) {
case _FetchProject():
return fetchProject(_that.projectId);case _UpdateProject():
return updateProject(_that.details);case _ChangeStatus():
return changeStatus(_that.status);case _ResetFlowStep():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int projectId)?  fetchProject,TResult? Function( ProjectDetails details)?  updateProject,TResult? Function( ProjectStatus status)?  changeStatus,TResult? Function()?  resetFlowStep,}) {final _that = this;
switch (_that) {
case _FetchProject() when fetchProject != null:
return fetchProject(_that.projectId);case _UpdateProject() when updateProject != null:
return updateProject(_that.details);case _ChangeStatus() when changeStatus != null:
return changeStatus(_that.status);case _ResetFlowStep() when resetFlowStep != null:
return resetFlowStep();case _:
  return null;

}
}

}

/// @nodoc


class _FetchProject implements ProjectOverviewEvent {
  const _FetchProject({required this.projectId});
  

 final  int projectId;

/// Create a copy of ProjectOverviewEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FetchProjectCopyWith<_FetchProject> get copyWith => __$FetchProjectCopyWithImpl<_FetchProject>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FetchProject&&(identical(other.projectId, projectId) || other.projectId == projectId));
}


@override
int get hashCode {
    return Object.hash(runtimeType,projectId);
}

@override
String toString() {
    return 'ProjectOverviewEvent.fetchProject(projectId: $projectId)';
}


}

/// @nodoc
abstract mixin class _$FetchProjectCopyWith<$Res> implements $ProjectOverviewEventCopyWith<$Res> {
  factory _$FetchProjectCopyWith(_FetchProject value, $Res Function(_FetchProject) _then) = __$FetchProjectCopyWithImpl;
@useResult
$Res call({
 int projectId
});




}
/// @nodoc
class __$FetchProjectCopyWithImpl<$Res>
    implements _$FetchProjectCopyWith<$Res> {
  __$FetchProjectCopyWithImpl(this._self, this._then);

  final _FetchProject _self;
  final $Res Function(_FetchProject) _then;

/// Create a copy of ProjectOverviewEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? projectId = null,}) {
  return _then(_FetchProject(
projectId: null == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _UpdateProject implements ProjectOverviewEvent {
  const _UpdateProject({required this.details});
  

 final  ProjectDetails details;

/// Create a copy of ProjectOverviewEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateProjectCopyWith<_UpdateProject> get copyWith => __$UpdateProjectCopyWithImpl<_UpdateProject>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateProject&&(identical(other.details, details) || other.details == details));
}


@override
int get hashCode {
    return Object.hash(runtimeType,details);
}

@override
String toString() {
    return 'ProjectOverviewEvent.updateProject(details: $details)';
}


}

/// @nodoc
abstract mixin class _$UpdateProjectCopyWith<$Res> implements $ProjectOverviewEventCopyWith<$Res> {
  factory _$UpdateProjectCopyWith(_UpdateProject value, $Res Function(_UpdateProject) _then) = __$UpdateProjectCopyWithImpl;
@useResult
$Res call({
 ProjectDetails details
});




}
/// @nodoc
class __$UpdateProjectCopyWithImpl<$Res>
    implements _$UpdateProjectCopyWith<$Res> {
  __$UpdateProjectCopyWithImpl(this._self, this._then);

  final _UpdateProject _self;
  final $Res Function(_UpdateProject) _then;

/// Create a copy of ProjectOverviewEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? details = null,}) {
  return _then(_UpdateProject(
details: null == details ? _self.details : details // ignore: cast_nullable_to_non_nullable
as ProjectDetails,
  ));
}


}

/// @nodoc


class _ChangeStatus implements ProjectOverviewEvent {
  const _ChangeStatus({required this.status});
  

 final  ProjectStatus status;

/// Create a copy of ProjectOverviewEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChangeStatusCopyWith<_ChangeStatus> get copyWith => __$ChangeStatusCopyWithImpl<_ChangeStatus>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChangeStatus&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status);
}

@override
String toString() {
    return 'ProjectOverviewEvent.changeStatus(status: $status)';
}


}

/// @nodoc
abstract mixin class _$ChangeStatusCopyWith<$Res> implements $ProjectOverviewEventCopyWith<$Res> {
  factory _$ChangeStatusCopyWith(_ChangeStatus value, $Res Function(_ChangeStatus) _then) = __$ChangeStatusCopyWithImpl;
@useResult
$Res call({
 ProjectStatus status
});




}
/// @nodoc
class __$ChangeStatusCopyWithImpl<$Res>
    implements _$ChangeStatusCopyWith<$Res> {
  __$ChangeStatusCopyWithImpl(this._self, this._then);

  final _ChangeStatus _self;
  final $Res Function(_ChangeStatus) _then;

/// Create a copy of ProjectOverviewEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? status = null,}) {
  return _then(_ChangeStatus(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ProjectStatus,
  ));
}


}

/// @nodoc


class _ResetFlowStep implements ProjectOverviewEvent {
  const _ResetFlowStep();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResetFlowStep);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'ProjectOverviewEvent.resetFlowStep()';
}


}




/// @nodoc
mixin _$ProjectOverviewState {

 ProjectOverview? get overview;/// For the members card (doc/05 §9 DP-4); empty when not loaded.
 List<MemberView> get members; GenericStatus get overviewStatus; String? get overviewErrorMessage; GenericStatus get actionStatus; GenericFlowStep get flowStep; String? get actionErrorMessage;
/// Create a copy of ProjectOverviewState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProjectOverviewStateCopyWith<ProjectOverviewState> get copyWith => _$ProjectOverviewStateCopyWithImpl<ProjectOverviewState>(this as ProjectOverviewState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ProjectOverviewState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProjectOverviewState&&(identical(other.overview, _this.overview) || other.overview == _this.overview)&&const DeepCollectionEquality().equals(other.members, _this.members)&&(identical(other.overviewStatus, _this.overviewStatus) || other.overviewStatus == _this.overviewStatus)&&(identical(other.overviewErrorMessage, _this.overviewErrorMessage) || other.overviewErrorMessage == _this.overviewErrorMessage)&&(identical(other.actionStatus, _this.actionStatus) || other.actionStatus == _this.actionStatus)&&(identical(other.flowStep, _this.flowStep) || other.flowStep == _this.flowStep)&&(identical(other.actionErrorMessage, _this.actionErrorMessage) || other.actionErrorMessage == _this.actionErrorMessage));
}


@override
int get hashCode {
  final _this = this as ProjectOverviewState;
  return Object.hash(runtimeType,_this.overview,const DeepCollectionEquality().hash(_this.members),_this.overviewStatus,_this.overviewErrorMessage,_this.actionStatus,_this.flowStep,_this.actionErrorMessage);
}

@override
String toString() {
  final _this = this as ProjectOverviewState;
  return 'ProjectOverviewState(overview: ${_this.overview}, members: ${_this.members}, overviewStatus: ${_this.overviewStatus}, overviewErrorMessage: ${_this.overviewErrorMessage}, actionStatus: ${_this.actionStatus}, flowStep: ${_this.flowStep}, actionErrorMessage: ${_this.actionErrorMessage})';
}


}

/// @nodoc
abstract mixin class $ProjectOverviewStateCopyWith<$Res>  {
  factory $ProjectOverviewStateCopyWith(ProjectOverviewState value, $Res Function(ProjectOverviewState) _then) = _$ProjectOverviewStateCopyWithImpl;
@useResult
$Res call({
 ProjectOverview? overview, List<MemberView> members, GenericStatus overviewStatus, String? overviewErrorMessage, GenericStatus actionStatus, GenericFlowStep flowStep, String? actionErrorMessage
});




}
/// @nodoc
class _$ProjectOverviewStateCopyWithImpl<$Res>
    implements $ProjectOverviewStateCopyWith<$Res> {
  _$ProjectOverviewStateCopyWithImpl(this._self, this._then);

  final ProjectOverviewState _self;
  final $Res Function(ProjectOverviewState) _then;

/// Create a copy of ProjectOverviewState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? overview = freezed,Object? members = null,Object? overviewStatus = null,Object? overviewErrorMessage = freezed,Object? actionStatus = null,Object? flowStep = null,Object? actionErrorMessage = freezed,}) {
  return _then(ProjectOverviewState(
overview: freezed == overview ? _self.overview : overview // ignore: cast_nullable_to_non_nullable
as ProjectOverview?,members: null == members ? _self.members : members // ignore: cast_nullable_to_non_nullable
as List<MemberView>,overviewStatus: null == overviewStatus ? _self.overviewStatus : overviewStatus // ignore: cast_nullable_to_non_nullable
as GenericStatus,overviewErrorMessage: freezed == overviewErrorMessage ? _self.overviewErrorMessage : overviewErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,actionStatus: null == actionStatus ? _self.actionStatus : actionStatus // ignore: cast_nullable_to_non_nullable
as GenericStatus,flowStep: null == flowStep ? _self.flowStep : flowStep // ignore: cast_nullable_to_non_nullable
as GenericFlowStep,actionErrorMessage: freezed == actionErrorMessage ? _self.actionErrorMessage : actionErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProjectOverviewState].
extension ProjectOverviewStatePatterns on ProjectOverviewState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProjectOverviewState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProjectOverviewState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProjectOverviewState value)  $default,){
final _that = this;
switch (_that) {
case _ProjectOverviewState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProjectOverviewState value)?  $default,){
final _that = this;
switch (_that) {
case _ProjectOverviewState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ProjectOverview? overview,  List<MemberView> members,  GenericStatus overviewStatus,  String? overviewErrorMessage,  GenericStatus actionStatus,  GenericFlowStep flowStep,  String? actionErrorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProjectOverviewState() when $default != null:
return $default(_that.overview,_that.members,_that.overviewStatus,_that.overviewErrorMessage,_that.actionStatus,_that.flowStep,_that.actionErrorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ProjectOverview? overview,  List<MemberView> members,  GenericStatus overviewStatus,  String? overviewErrorMessage,  GenericStatus actionStatus,  GenericFlowStep flowStep,  String? actionErrorMessage)  $default,) {final _that = this;
switch (_that) {
case _ProjectOverviewState():
return $default(_that.overview,_that.members,_that.overviewStatus,_that.overviewErrorMessage,_that.actionStatus,_that.flowStep,_that.actionErrorMessage);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ProjectOverview? overview,  List<MemberView> members,  GenericStatus overviewStatus,  String? overviewErrorMessage,  GenericStatus actionStatus,  GenericFlowStep flowStep,  String? actionErrorMessage)?  $default,) {final _that = this;
switch (_that) {
case _ProjectOverviewState() when $default != null:
return $default(_that.overview,_that.members,_that.overviewStatus,_that.overviewErrorMessage,_that.actionStatus,_that.flowStep,_that.actionErrorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _ProjectOverviewState implements ProjectOverviewState {
  const _ProjectOverviewState({this.overview,  List<MemberView> members = const [], this.overviewStatus = GenericStatus.initial, this.overviewErrorMessage, this.actionStatus = GenericStatus.initial, this.flowStep = GenericFlowStep.none, this.actionErrorMessage}): _members = members;
  

@override final  ProjectOverview? overview;
/// For the members card (doc/05 §9 DP-4); empty when not loaded.
 final  List<MemberView> _members;
/// For the members card (doc/05 §9 DP-4); empty when not loaded.
@override@JsonKey() List<MemberView> get members {
  if (_members is EqualUnmodifiableListView) return _members;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_members);
}

@override@JsonKey() final  GenericStatus overviewStatus;
@override final  String? overviewErrorMessage;
@override@JsonKey() final  GenericStatus actionStatus;
@override@JsonKey() final  GenericFlowStep flowStep;
@override final  String? actionErrorMessage;

/// Create a copy of ProjectOverviewState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProjectOverviewStateCopyWith<_ProjectOverviewState> get copyWith => __$ProjectOverviewStateCopyWithImpl<_ProjectOverviewState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProjectOverviewState&&(identical(other.overview, overview) || other.overview == overview)&&const DeepCollectionEquality().equals(other.members, _members)&&(identical(other.overviewStatus, overviewStatus) || other.overviewStatus == overviewStatus)&&(identical(other.overviewErrorMessage, overviewErrorMessage) || other.overviewErrorMessage == overviewErrorMessage)&&(identical(other.actionStatus, actionStatus) || other.actionStatus == actionStatus)&&(identical(other.flowStep, flowStep) || other.flowStep == flowStep)&&(identical(other.actionErrorMessage, actionErrorMessage) || other.actionErrorMessage == actionErrorMessage));
}


@override
int get hashCode {
    return Object.hash(runtimeType,overview,const DeepCollectionEquality().hash(_members),overviewStatus,overviewErrorMessage,actionStatus,flowStep,actionErrorMessage);
}

@override
String toString() {
    return 'ProjectOverviewState(overview: $overview, members: $members, overviewStatus: $overviewStatus, overviewErrorMessage: $overviewErrorMessage, actionStatus: $actionStatus, flowStep: $flowStep, actionErrorMessage: $actionErrorMessage)';
}


}

/// @nodoc
abstract mixin class _$ProjectOverviewStateCopyWith<$Res> implements $ProjectOverviewStateCopyWith<$Res> {
  factory _$ProjectOverviewStateCopyWith(_ProjectOverviewState value, $Res Function(_ProjectOverviewState) _then) = __$ProjectOverviewStateCopyWithImpl;
@override @useResult
$Res call({
 ProjectOverview? overview, List<MemberView> members, GenericStatus overviewStatus, String? overviewErrorMessage, GenericStatus actionStatus, GenericFlowStep flowStep, String? actionErrorMessage
});




}
/// @nodoc
class __$ProjectOverviewStateCopyWithImpl<$Res>
    implements _$ProjectOverviewStateCopyWith<$Res> {
  __$ProjectOverviewStateCopyWithImpl(this._self, this._then);

  final _ProjectOverviewState _self;
  final $Res Function(_ProjectOverviewState) _then;

/// Create a copy of ProjectOverviewState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? overview = freezed,Object? members = null,Object? overviewStatus = null,Object? overviewErrorMessage = freezed,Object? actionStatus = null,Object? flowStep = null,Object? actionErrorMessage = freezed,}) {
  return _then(_ProjectOverviewState(
overview: freezed == overview ? _self.overview : overview // ignore: cast_nullable_to_non_nullable
as ProjectOverview?,members: null == members ? _self._members : members // ignore: cast_nullable_to_non_nullable
as List<MemberView>,overviewStatus: null == overviewStatus ? _self.overviewStatus : overviewStatus // ignore: cast_nullable_to_non_nullable
as GenericStatus,overviewErrorMessage: freezed == overviewErrorMessage ? _self.overviewErrorMessage : overviewErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,actionStatus: null == actionStatus ? _self.actionStatus : actionStatus // ignore: cast_nullable_to_non_nullable
as GenericStatus,flowStep: null == flowStep ? _self.flowStep : flowStep // ignore: cast_nullable_to_non_nullable
as GenericFlowStep,actionErrorMessage: freezed == actionErrorMessage ? _self.actionErrorMessage : actionErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
