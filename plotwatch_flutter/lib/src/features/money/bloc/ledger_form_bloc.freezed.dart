// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ledger_form_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LedgerFormEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is LedgerFormEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'LedgerFormEvent()';
}


}

/// @nodoc
class $LedgerFormEventCopyWith<$Res>  {
$LedgerFormEventCopyWith(LedgerFormEvent _, $Res Function(LedgerFormEvent) __);
}


/// Adds pattern-matching-related methods to [LedgerFormEvent].
extension LedgerFormEventPatterns on LedgerFormEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Load value)?  load,TResult Function( _SaveRelease value)?  saveRelease,TResult Function( _SaveExpense value)?  saveExpense,TResult Function( _ResetFlowStep value)?  resetFlowStep,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Load() when load != null:
return load(_that);case _SaveRelease() when saveRelease != null:
return saveRelease(_that);case _SaveExpense() when saveExpense != null:
return saveExpense(_that);case _ResetFlowStep() when resetFlowStep != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Load value)  load,required TResult Function( _SaveRelease value)  saveRelease,required TResult Function( _SaveExpense value)  saveExpense,required TResult Function( _ResetFlowStep value)  resetFlowStep,}){
final _that = this;
switch (_that) {
case _Load():
return load(_that);case _SaveRelease():
return saveRelease(_that);case _SaveExpense():
return saveExpense(_that);case _ResetFlowStep():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Load value)?  load,TResult? Function( _SaveRelease value)?  saveRelease,TResult? Function( _SaveExpense value)?  saveExpense,TResult? Function( _ResetFlowStep value)?  resetFlowStep,}){
final _that = this;
switch (_that) {
case _Load() when load != null:
return load(_that);case _SaveRelease() when saveRelease != null:
return saveRelease(_that);case _SaveExpense() when saveExpense != null:
return saveExpense(_that);case _ResetFlowStep() when resetFlowStep != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int projectId)?  load,TResult Function( ReleaseDraft draft)?  saveRelease,TResult Function( ExpenseDraft draft,  Uint8List? receipt)?  saveExpense,TResult Function()?  resetFlowStep,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Load() when load != null:
return load(_that.projectId);case _SaveRelease() when saveRelease != null:
return saveRelease(_that.draft);case _SaveExpense() when saveExpense != null:
return saveExpense(_that.draft,_that.receipt);case _ResetFlowStep() when resetFlowStep != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int projectId)  load,required TResult Function( ReleaseDraft draft)  saveRelease,required TResult Function( ExpenseDraft draft,  Uint8List? receipt)  saveExpense,required TResult Function()  resetFlowStep,}) {final _that = this;
switch (_that) {
case _Load():
return load(_that.projectId);case _SaveRelease():
return saveRelease(_that.draft);case _SaveExpense():
return saveExpense(_that.draft,_that.receipt);case _ResetFlowStep():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int projectId)?  load,TResult? Function( ReleaseDraft draft)?  saveRelease,TResult? Function( ExpenseDraft draft,  Uint8List? receipt)?  saveExpense,TResult? Function()?  resetFlowStep,}) {final _that = this;
switch (_that) {
case _Load() when load != null:
return load(_that.projectId);case _SaveRelease() when saveRelease != null:
return saveRelease(_that.draft);case _SaveExpense() when saveExpense != null:
return saveExpense(_that.draft,_that.receipt);case _ResetFlowStep() when resetFlowStep != null:
return resetFlowStep();case _:
  return null;

}
}

}

/// @nodoc


class _Load implements LedgerFormEvent {
  const _Load({required this.projectId});
  

 final  int projectId;

/// Create a copy of LedgerFormEvent
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
    return 'LedgerFormEvent.load(projectId: $projectId)';
}


}

/// @nodoc
abstract mixin class _$LoadCopyWith<$Res> implements $LedgerFormEventCopyWith<$Res> {
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

/// Create a copy of LedgerFormEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? projectId = null,}) {
  return _then(_Load(
projectId: null == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _SaveRelease implements LedgerFormEvent {
  const _SaveRelease(this.draft);
  

 final  ReleaseDraft draft;

/// Create a copy of LedgerFormEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SaveReleaseCopyWith<_SaveRelease> get copyWith => __$SaveReleaseCopyWithImpl<_SaveRelease>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SaveRelease&&(identical(other.draft, draft) || other.draft == draft));
}


@override
int get hashCode {
    return Object.hash(runtimeType,draft);
}

@override
String toString() {
    return 'LedgerFormEvent.saveRelease(draft: $draft)';
}


}

/// @nodoc
abstract mixin class _$SaveReleaseCopyWith<$Res> implements $LedgerFormEventCopyWith<$Res> {
  factory _$SaveReleaseCopyWith(_SaveRelease value, $Res Function(_SaveRelease) _then) = __$SaveReleaseCopyWithImpl;
@useResult
$Res call({
 ReleaseDraft draft
});




}
/// @nodoc
class __$SaveReleaseCopyWithImpl<$Res>
    implements _$SaveReleaseCopyWith<$Res> {
  __$SaveReleaseCopyWithImpl(this._self, this._then);

  final _SaveRelease _self;
  final $Res Function(_SaveRelease) _then;

/// Create a copy of LedgerFormEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? draft = null,}) {
  return _then(_SaveRelease(
null == draft ? _self.draft : draft // ignore: cast_nullable_to_non_nullable
as ReleaseDraft,
  ));
}


}

/// @nodoc


class _SaveExpense implements LedgerFormEvent {
  const _SaveExpense(this.draft, {this.receipt});
  

 final  ExpenseDraft draft;
 final  Uint8List? receipt;

/// Create a copy of LedgerFormEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SaveExpenseCopyWith<_SaveExpense> get copyWith => __$SaveExpenseCopyWithImpl<_SaveExpense>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SaveExpense&&(identical(other.draft, draft) || other.draft == draft)&&const DeepCollectionEquality().equals(other.receipt, receipt));
}


@override
int get hashCode {
    return Object.hash(runtimeType,draft,const DeepCollectionEquality().hash(receipt));
}

@override
String toString() {
    return 'LedgerFormEvent.saveExpense(draft: $draft, receipt: $receipt)';
}


}

/// @nodoc
abstract mixin class _$SaveExpenseCopyWith<$Res> implements $LedgerFormEventCopyWith<$Res> {
  factory _$SaveExpenseCopyWith(_SaveExpense value, $Res Function(_SaveExpense) _then) = __$SaveExpenseCopyWithImpl;
@useResult
$Res call({
 ExpenseDraft draft, Uint8List? receipt
});




}
/// @nodoc
class __$SaveExpenseCopyWithImpl<$Res>
    implements _$SaveExpenseCopyWith<$Res> {
  __$SaveExpenseCopyWithImpl(this._self, this._then);

  final _SaveExpense _self;
  final $Res Function(_SaveExpense) _then;

/// Create a copy of LedgerFormEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? draft = null,Object? receipt = freezed,}) {
  return _then(_SaveExpense(
null == draft ? _self.draft : draft // ignore: cast_nullable_to_non_nullable
as ExpenseDraft,receipt: freezed == receipt ? _self.receipt : receipt // ignore: cast_nullable_to_non_nullable
as Uint8List?,
  ));
}


}

/// @nodoc


class _ResetFlowStep implements LedgerFormEvent {
  const _ResetFlowStep();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResetFlowStep);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'LedgerFormEvent.resetFlowStep()';
}


}




/// @nodoc
mixin _$LedgerFormState {

 int? get projectId; ProjectOverview? get overview;/// For the stage picker, in plan order.
 List<Stage> get stages; GenericStatus get loadStatus; String? get loadErrorMessage; GenericStatus get actionStatus; String? get actionErrorMessage;/// The entry as the server saved it.
 LedgerEntry? get saved;
/// Create a copy of LedgerFormState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LedgerFormStateCopyWith<LedgerFormState> get copyWith => _$LedgerFormStateCopyWithImpl<LedgerFormState>(this as LedgerFormState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as LedgerFormState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LedgerFormState&&(identical(other.projectId, _this.projectId) || other.projectId == _this.projectId)&&(identical(other.overview, _this.overview) || other.overview == _this.overview)&&const DeepCollectionEquality().equals(other.stages, _this.stages)&&(identical(other.loadStatus, _this.loadStatus) || other.loadStatus == _this.loadStatus)&&(identical(other.loadErrorMessage, _this.loadErrorMessage) || other.loadErrorMessage == _this.loadErrorMessage)&&(identical(other.actionStatus, _this.actionStatus) || other.actionStatus == _this.actionStatus)&&(identical(other.actionErrorMessage, _this.actionErrorMessage) || other.actionErrorMessage == _this.actionErrorMessage)&&(identical(other.saved, _this.saved) || other.saved == _this.saved));
}


@override
int get hashCode {
  final _this = this as LedgerFormState;
  return Object.hash(runtimeType,_this.projectId,_this.overview,const DeepCollectionEquality().hash(_this.stages),_this.loadStatus,_this.loadErrorMessage,_this.actionStatus,_this.actionErrorMessage,_this.saved);
}

@override
String toString() {
  final _this = this as LedgerFormState;
  return 'LedgerFormState(projectId: ${_this.projectId}, overview: ${_this.overview}, stages: ${_this.stages}, loadStatus: ${_this.loadStatus}, loadErrorMessage: ${_this.loadErrorMessage}, actionStatus: ${_this.actionStatus}, actionErrorMessage: ${_this.actionErrorMessage}, saved: ${_this.saved})';
}


}

/// @nodoc
abstract mixin class $LedgerFormStateCopyWith<$Res>  {
  factory $LedgerFormStateCopyWith(LedgerFormState value, $Res Function(LedgerFormState) _then) = _$LedgerFormStateCopyWithImpl;
@useResult
$Res call({
 int? projectId, ProjectOverview? overview, List<Stage> stages, GenericStatus loadStatus, String? loadErrorMessage, GenericStatus actionStatus, String? actionErrorMessage, LedgerEntry? saved
});




}
/// @nodoc
class _$LedgerFormStateCopyWithImpl<$Res>
    implements $LedgerFormStateCopyWith<$Res> {
  _$LedgerFormStateCopyWithImpl(this._self, this._then);

  final LedgerFormState _self;
  final $Res Function(LedgerFormState) _then;

/// Create a copy of LedgerFormState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? projectId = freezed,Object? overview = freezed,Object? stages = null,Object? loadStatus = null,Object? loadErrorMessage = freezed,Object? actionStatus = null,Object? actionErrorMessage = freezed,Object? saved = freezed,}) {
  return _then(LedgerFormState(
projectId: freezed == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as int?,overview: freezed == overview ? _self.overview : overview // ignore: cast_nullable_to_non_nullable
as ProjectOverview?,stages: null == stages ? _self.stages : stages // ignore: cast_nullable_to_non_nullable
as List<Stage>,loadStatus: null == loadStatus ? _self.loadStatus : loadStatus // ignore: cast_nullable_to_non_nullable
as GenericStatus,loadErrorMessage: freezed == loadErrorMessage ? _self.loadErrorMessage : loadErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,actionStatus: null == actionStatus ? _self.actionStatus : actionStatus // ignore: cast_nullable_to_non_nullable
as GenericStatus,actionErrorMessage: freezed == actionErrorMessage ? _self.actionErrorMessage : actionErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,saved: freezed == saved ? _self.saved : saved // ignore: cast_nullable_to_non_nullable
as LedgerEntry?,
  ));
}

}


/// Adds pattern-matching-related methods to [LedgerFormState].
extension LedgerFormStatePatterns on LedgerFormState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LedgerFormState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LedgerFormState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LedgerFormState value)  $default,){
final _that = this;
switch (_that) {
case _LedgerFormState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LedgerFormState value)?  $default,){
final _that = this;
switch (_that) {
case _LedgerFormState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? projectId,  ProjectOverview? overview,  List<Stage> stages,  GenericStatus loadStatus,  String? loadErrorMessage,  GenericStatus actionStatus,  String? actionErrorMessage,  LedgerEntry? saved)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LedgerFormState() when $default != null:
return $default(_that.projectId,_that.overview,_that.stages,_that.loadStatus,_that.loadErrorMessage,_that.actionStatus,_that.actionErrorMessage,_that.saved);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? projectId,  ProjectOverview? overview,  List<Stage> stages,  GenericStatus loadStatus,  String? loadErrorMessage,  GenericStatus actionStatus,  String? actionErrorMessage,  LedgerEntry? saved)  $default,) {final _that = this;
switch (_that) {
case _LedgerFormState():
return $default(_that.projectId,_that.overview,_that.stages,_that.loadStatus,_that.loadErrorMessage,_that.actionStatus,_that.actionErrorMessage,_that.saved);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? projectId,  ProjectOverview? overview,  List<Stage> stages,  GenericStatus loadStatus,  String? loadErrorMessage,  GenericStatus actionStatus,  String? actionErrorMessage,  LedgerEntry? saved)?  $default,) {final _that = this;
switch (_that) {
case _LedgerFormState() when $default != null:
return $default(_that.projectId,_that.overview,_that.stages,_that.loadStatus,_that.loadErrorMessage,_that.actionStatus,_that.actionErrorMessage,_that.saved);case _:
  return null;

}
}

}

/// @nodoc


class _LedgerFormState implements LedgerFormState {
  const _LedgerFormState({this.projectId, this.overview,  List<Stage> stages = const [], this.loadStatus = GenericStatus.initial, this.loadErrorMessage, this.actionStatus = GenericStatus.initial, this.actionErrorMessage, this.saved}): _stages = stages;
  

@override final  int? projectId;
@override final  ProjectOverview? overview;
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
/// The entry as the server saved it.
@override final  LedgerEntry? saved;

/// Create a copy of LedgerFormState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LedgerFormStateCopyWith<_LedgerFormState> get copyWith => __$LedgerFormStateCopyWithImpl<_LedgerFormState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LedgerFormState&&(identical(other.projectId, projectId) || other.projectId == projectId)&&(identical(other.overview, overview) || other.overview == overview)&&const DeepCollectionEquality().equals(other.stages, _stages)&&(identical(other.loadStatus, loadStatus) || other.loadStatus == loadStatus)&&(identical(other.loadErrorMessage, loadErrorMessage) || other.loadErrorMessage == loadErrorMessage)&&(identical(other.actionStatus, actionStatus) || other.actionStatus == actionStatus)&&(identical(other.actionErrorMessage, actionErrorMessage) || other.actionErrorMessage == actionErrorMessage)&&(identical(other.saved, saved) || other.saved == saved));
}


@override
int get hashCode {
    return Object.hash(runtimeType,projectId,overview,const DeepCollectionEquality().hash(_stages),loadStatus,loadErrorMessage,actionStatus,actionErrorMessage,saved);
}

@override
String toString() {
    return 'LedgerFormState(projectId: $projectId, overview: $overview, stages: $stages, loadStatus: $loadStatus, loadErrorMessage: $loadErrorMessage, actionStatus: $actionStatus, actionErrorMessage: $actionErrorMessage, saved: $saved)';
}


}

/// @nodoc
abstract mixin class _$LedgerFormStateCopyWith<$Res> implements $LedgerFormStateCopyWith<$Res> {
  factory _$LedgerFormStateCopyWith(_LedgerFormState value, $Res Function(_LedgerFormState) _then) = __$LedgerFormStateCopyWithImpl;
@override @useResult
$Res call({
 int? projectId, ProjectOverview? overview, List<Stage> stages, GenericStatus loadStatus, String? loadErrorMessage, GenericStatus actionStatus, String? actionErrorMessage, LedgerEntry? saved
});




}
/// @nodoc
class __$LedgerFormStateCopyWithImpl<$Res>
    implements _$LedgerFormStateCopyWith<$Res> {
  __$LedgerFormStateCopyWithImpl(this._self, this._then);

  final _LedgerFormState _self;
  final $Res Function(_LedgerFormState) _then;

/// Create a copy of LedgerFormState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? projectId = freezed,Object? overview = freezed,Object? stages = null,Object? loadStatus = null,Object? loadErrorMessage = freezed,Object? actionStatus = null,Object? actionErrorMessage = freezed,Object? saved = freezed,}) {
  return _then(_LedgerFormState(
projectId: freezed == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as int?,overview: freezed == overview ? _self.overview : overview // ignore: cast_nullable_to_non_nullable
as ProjectOverview?,stages: null == stages ? _self._stages : stages // ignore: cast_nullable_to_non_nullable
as List<Stage>,loadStatus: null == loadStatus ? _self.loadStatus : loadStatus // ignore: cast_nullable_to_non_nullable
as GenericStatus,loadErrorMessage: freezed == loadErrorMessage ? _self.loadErrorMessage : loadErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,actionStatus: null == actionStatus ? _self.actionStatus : actionStatus // ignore: cast_nullable_to_non_nullable
as GenericStatus,actionErrorMessage: freezed == actionErrorMessage ? _self.actionErrorMessage : actionErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,saved: freezed == saved ? _self.saved : saved // ignore: cast_nullable_to_non_nullable
as LedgerEntry?,
  ));
}


}

// dart format on
