// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_form_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UpdateFormEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateFormEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'UpdateFormEvent()';
}


}

/// @nodoc
class $UpdateFormEventCopyWith<$Res>  {
$UpdateFormEventCopyWith(UpdateFormEvent _, $Res Function(UpdateFormEvent) __);
}


/// Adds pattern-matching-related methods to [UpdateFormEvent].
extension UpdateFormEventPatterns on UpdateFormEvent {
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int projectId)?  load,TResult Function( ProgressUpdateDraft draft)?  saveRequested,TResult Function()?  resetFlowStep,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Load() when load != null:
return load(_that.projectId);case _SaveRequested() when saveRequested != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int projectId)  load,required TResult Function( ProgressUpdateDraft draft)  saveRequested,required TResult Function()  resetFlowStep,}) {final _that = this;
switch (_that) {
case _Load():
return load(_that.projectId);case _SaveRequested():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int projectId)?  load,TResult? Function( ProgressUpdateDraft draft)?  saveRequested,TResult? Function()?  resetFlowStep,}) {final _that = this;
switch (_that) {
case _Load() when load != null:
return load(_that.projectId);case _SaveRequested() when saveRequested != null:
return saveRequested(_that.draft);case _ResetFlowStep() when resetFlowStep != null:
return resetFlowStep();case _:
  return null;

}
}

}

/// @nodoc


class _Load implements UpdateFormEvent {
  const _Load({required this.projectId});
  

 final  int projectId;

/// Create a copy of UpdateFormEvent
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
    return 'UpdateFormEvent.load(projectId: $projectId)';
}


}

/// @nodoc
abstract mixin class _$LoadCopyWith<$Res> implements $UpdateFormEventCopyWith<$Res> {
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

/// Create a copy of UpdateFormEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? projectId = null,}) {
  return _then(_Load(
projectId: null == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _SaveRequested implements UpdateFormEvent {
  const _SaveRequested(this.draft);
  

 final  ProgressUpdateDraft draft;

/// Create a copy of UpdateFormEvent
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
    return 'UpdateFormEvent.saveRequested(draft: $draft)';
}


}

/// @nodoc
abstract mixin class _$SaveRequestedCopyWith<$Res> implements $UpdateFormEventCopyWith<$Res> {
  factory _$SaveRequestedCopyWith(_SaveRequested value, $Res Function(_SaveRequested) _then) = __$SaveRequestedCopyWithImpl;
@useResult
$Res call({
 ProgressUpdateDraft draft
});




}
/// @nodoc
class __$SaveRequestedCopyWithImpl<$Res>
    implements _$SaveRequestedCopyWith<$Res> {
  __$SaveRequestedCopyWithImpl(this._self, this._then);

  final _SaveRequested _self;
  final $Res Function(_SaveRequested) _then;

/// Create a copy of UpdateFormEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? draft = null,}) {
  return _then(_SaveRequested(
null == draft ? _self.draft : draft // ignore: cast_nullable_to_non_nullable
as ProgressUpdateDraft,
  ));
}


}

/// @nodoc


class _ResetFlowStep implements UpdateFormEvent {
  const _ResetFlowStep();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResetFlowStep);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'UpdateFormEvent.resetFlowStep()';
}


}




/// @nodoc
mixin _$UpdateFormState {

 int? get projectId;/// For the stage picker, in plan order.
 List<Stage> get stages; GenericStatus get loadStatus; String? get loadErrorMessage; GenericStatus get actionStatus; String? get actionErrorMessage;/// The update as the server saved it.
 ProgressUpdate? get saved;
/// Create a copy of UpdateFormState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateFormStateCopyWith<UpdateFormState> get copyWith => _$UpdateFormStateCopyWithImpl<UpdateFormState>(this as UpdateFormState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as UpdateFormState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateFormState&&(identical(other.projectId, _this.projectId) || other.projectId == _this.projectId)&&const DeepCollectionEquality().equals(other.stages, _this.stages)&&(identical(other.loadStatus, _this.loadStatus) || other.loadStatus == _this.loadStatus)&&(identical(other.loadErrorMessage, _this.loadErrorMessage) || other.loadErrorMessage == _this.loadErrorMessage)&&(identical(other.actionStatus, _this.actionStatus) || other.actionStatus == _this.actionStatus)&&(identical(other.actionErrorMessage, _this.actionErrorMessage) || other.actionErrorMessage == _this.actionErrorMessage)&&(identical(other.saved, _this.saved) || other.saved == _this.saved));
}


@override
int get hashCode {
  final _this = this as UpdateFormState;
  return Object.hash(runtimeType,_this.projectId,const DeepCollectionEquality().hash(_this.stages),_this.loadStatus,_this.loadErrorMessage,_this.actionStatus,_this.actionErrorMessage,_this.saved);
}

@override
String toString() {
  final _this = this as UpdateFormState;
  return 'UpdateFormState(projectId: ${_this.projectId}, stages: ${_this.stages}, loadStatus: ${_this.loadStatus}, loadErrorMessage: ${_this.loadErrorMessage}, actionStatus: ${_this.actionStatus}, actionErrorMessage: ${_this.actionErrorMessage}, saved: ${_this.saved})';
}


}

/// @nodoc
abstract mixin class $UpdateFormStateCopyWith<$Res>  {
  factory $UpdateFormStateCopyWith(UpdateFormState value, $Res Function(UpdateFormState) _then) = _$UpdateFormStateCopyWithImpl;
@useResult
$Res call({
 int? projectId, List<Stage> stages, GenericStatus loadStatus, String? loadErrorMessage, GenericStatus actionStatus, String? actionErrorMessage, ProgressUpdate? saved
});




}
/// @nodoc
class _$UpdateFormStateCopyWithImpl<$Res>
    implements $UpdateFormStateCopyWith<$Res> {
  _$UpdateFormStateCopyWithImpl(this._self, this._then);

  final UpdateFormState _self;
  final $Res Function(UpdateFormState) _then;

/// Create a copy of UpdateFormState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? projectId = freezed,Object? stages = null,Object? loadStatus = null,Object? loadErrorMessage = freezed,Object? actionStatus = null,Object? actionErrorMessage = freezed,Object? saved = freezed,}) {
  return _then(UpdateFormState(
projectId: freezed == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as int?,stages: null == stages ? _self.stages : stages // ignore: cast_nullable_to_non_nullable
as List<Stage>,loadStatus: null == loadStatus ? _self.loadStatus : loadStatus // ignore: cast_nullable_to_non_nullable
as GenericStatus,loadErrorMessage: freezed == loadErrorMessage ? _self.loadErrorMessage : loadErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,actionStatus: null == actionStatus ? _self.actionStatus : actionStatus // ignore: cast_nullable_to_non_nullable
as GenericStatus,actionErrorMessage: freezed == actionErrorMessage ? _self.actionErrorMessage : actionErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,saved: freezed == saved ? _self.saved : saved // ignore: cast_nullable_to_non_nullable
as ProgressUpdate?,
  ));
}

}


/// Adds pattern-matching-related methods to [UpdateFormState].
extension UpdateFormStatePatterns on UpdateFormState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UpdateFormState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UpdateFormState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UpdateFormState value)  $default,){
final _that = this;
switch (_that) {
case _UpdateFormState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UpdateFormState value)?  $default,){
final _that = this;
switch (_that) {
case _UpdateFormState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? projectId,  List<Stage> stages,  GenericStatus loadStatus,  String? loadErrorMessage,  GenericStatus actionStatus,  String? actionErrorMessage,  ProgressUpdate? saved)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UpdateFormState() when $default != null:
return $default(_that.projectId,_that.stages,_that.loadStatus,_that.loadErrorMessage,_that.actionStatus,_that.actionErrorMessage,_that.saved);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? projectId,  List<Stage> stages,  GenericStatus loadStatus,  String? loadErrorMessage,  GenericStatus actionStatus,  String? actionErrorMessage,  ProgressUpdate? saved)  $default,) {final _that = this;
switch (_that) {
case _UpdateFormState():
return $default(_that.projectId,_that.stages,_that.loadStatus,_that.loadErrorMessage,_that.actionStatus,_that.actionErrorMessage,_that.saved);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? projectId,  List<Stage> stages,  GenericStatus loadStatus,  String? loadErrorMessage,  GenericStatus actionStatus,  String? actionErrorMessage,  ProgressUpdate? saved)?  $default,) {final _that = this;
switch (_that) {
case _UpdateFormState() when $default != null:
return $default(_that.projectId,_that.stages,_that.loadStatus,_that.loadErrorMessage,_that.actionStatus,_that.actionErrorMessage,_that.saved);case _:
  return null;

}
}

}

/// @nodoc


class _UpdateFormState implements UpdateFormState {
  const _UpdateFormState({this.projectId,  List<Stage> stages = const [], this.loadStatus = GenericStatus.initial, this.loadErrorMessage, this.actionStatus = GenericStatus.initial, this.actionErrorMessage, this.saved}): _stages = stages;
  

@override final  int? projectId;
/// For the stage picker, in plan order.
 final  List<Stage> _stages;
/// For the stage picker, in plan order.
@override@JsonKey() List<Stage> get stages {
  if (_stages is EqualUnmodifiableListView) return _stages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stages);
}

@override@JsonKey() final  GenericStatus loadStatus;
@override final  String? loadErrorMessage;
@override@JsonKey() final  GenericStatus actionStatus;
@override final  String? actionErrorMessage;
/// The update as the server saved it.
@override final  ProgressUpdate? saved;

/// Create a copy of UpdateFormState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateFormStateCopyWith<_UpdateFormState> get copyWith => __$UpdateFormStateCopyWithImpl<_UpdateFormState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateFormState&&(identical(other.projectId, projectId) || other.projectId == projectId)&&const DeepCollectionEquality().equals(other.stages, _stages)&&(identical(other.loadStatus, loadStatus) || other.loadStatus == loadStatus)&&(identical(other.loadErrorMessage, loadErrorMessage) || other.loadErrorMessage == loadErrorMessage)&&(identical(other.actionStatus, actionStatus) || other.actionStatus == actionStatus)&&(identical(other.actionErrorMessage, actionErrorMessage) || other.actionErrorMessage == actionErrorMessage)&&(identical(other.saved, saved) || other.saved == saved));
}


@override
int get hashCode {
    return Object.hash(runtimeType,projectId,const DeepCollectionEquality().hash(_stages),loadStatus,loadErrorMessage,actionStatus,actionErrorMessage,saved);
}

@override
String toString() {
    return 'UpdateFormState(projectId: $projectId, stages: $stages, loadStatus: $loadStatus, loadErrorMessage: $loadErrorMessage, actionStatus: $actionStatus, actionErrorMessage: $actionErrorMessage, saved: $saved)';
}


}

/// @nodoc
abstract mixin class _$UpdateFormStateCopyWith<$Res> implements $UpdateFormStateCopyWith<$Res> {
  factory _$UpdateFormStateCopyWith(_UpdateFormState value, $Res Function(_UpdateFormState) _then) = __$UpdateFormStateCopyWithImpl;
@override @useResult
$Res call({
 int? projectId, List<Stage> stages, GenericStatus loadStatus, String? loadErrorMessage, GenericStatus actionStatus, String? actionErrorMessage, ProgressUpdate? saved
});




}
/// @nodoc
class __$UpdateFormStateCopyWithImpl<$Res>
    implements _$UpdateFormStateCopyWith<$Res> {
  __$UpdateFormStateCopyWithImpl(this._self, this._then);

  final _UpdateFormState _self;
  final $Res Function(_UpdateFormState) _then;

/// Create a copy of UpdateFormState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? projectId = freezed,Object? stages = null,Object? loadStatus = null,Object? loadErrorMessage = freezed,Object? actionStatus = null,Object? actionErrorMessage = freezed,Object? saved = freezed,}) {
  return _then(_UpdateFormState(
projectId: freezed == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as int?,stages: null == stages ? _self._stages : stages // ignore: cast_nullable_to_non_nullable
as List<Stage>,loadStatus: null == loadStatus ? _self.loadStatus : loadStatus // ignore: cast_nullable_to_non_nullable
as GenericStatus,loadErrorMessage: freezed == loadErrorMessage ? _self.loadErrorMessage : loadErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,actionStatus: null == actionStatus ? _self.actionStatus : actionStatus // ignore: cast_nullable_to_non_nullable
as GenericStatus,actionErrorMessage: freezed == actionErrorMessage ? _self.actionErrorMessage : actionErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,saved: freezed == saved ? _self.saved : saved // ignore: cast_nullable_to_non_nullable
as ProgressUpdate?,
  ));
}


}

// dart format on
