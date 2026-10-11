// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ledger_entry_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LedgerEntryEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is LedgerEntryEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'LedgerEntryEvent()';
}


}

/// @nodoc
class $LedgerEntryEventCopyWith<$Res>  {
$LedgerEntryEventCopyWith(LedgerEntryEvent _, $Res Function(LedgerEntryEvent) __);
}


/// Adds pattern-matching-related methods to [LedgerEntryEvent].
extension LedgerEntryEventPatterns on LedgerEntryEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Load value)?  load,TResult Function( _ConfirmRequested value)?  confirmRequested,TResult Function( _ReverseRequested value)?  reverseRequested,TResult Function( _ResetFlowStep value)?  resetFlowStep,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Load() when load != null:
return load(_that);case _ConfirmRequested() when confirmRequested != null:
return confirmRequested(_that);case _ReverseRequested() when reverseRequested != null:
return reverseRequested(_that);case _ResetFlowStep() when resetFlowStep != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Load value)  load,required TResult Function( _ConfirmRequested value)  confirmRequested,required TResult Function( _ReverseRequested value)  reverseRequested,required TResult Function( _ResetFlowStep value)  resetFlowStep,}){
final _that = this;
switch (_that) {
case _Load():
return load(_that);case _ConfirmRequested():
return confirmRequested(_that);case _ReverseRequested():
return reverseRequested(_that);case _ResetFlowStep():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Load value)?  load,TResult? Function( _ConfirmRequested value)?  confirmRequested,TResult? Function( _ReverseRequested value)?  reverseRequested,TResult? Function( _ResetFlowStep value)?  resetFlowStep,}){
final _that = this;
switch (_that) {
case _Load() when load != null:
return load(_that);case _ConfirmRequested() when confirmRequested != null:
return confirmRequested(_that);case _ReverseRequested() when reverseRequested != null:
return reverseRequested(_that);case _ResetFlowStep() when resetFlowStep != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int projectId,  int entryId)?  load,TResult Function()?  confirmRequested,TResult Function( String reason)?  reverseRequested,TResult Function()?  resetFlowStep,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Load() when load != null:
return load(_that.projectId,_that.entryId);case _ConfirmRequested() when confirmRequested != null:
return confirmRequested();case _ReverseRequested() when reverseRequested != null:
return reverseRequested(_that.reason);case _ResetFlowStep() when resetFlowStep != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int projectId,  int entryId)  load,required TResult Function()  confirmRequested,required TResult Function( String reason)  reverseRequested,required TResult Function()  resetFlowStep,}) {final _that = this;
switch (_that) {
case _Load():
return load(_that.projectId,_that.entryId);case _ConfirmRequested():
return confirmRequested();case _ReverseRequested():
return reverseRequested(_that.reason);case _ResetFlowStep():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int projectId,  int entryId)?  load,TResult? Function()?  confirmRequested,TResult? Function( String reason)?  reverseRequested,TResult? Function()?  resetFlowStep,}) {final _that = this;
switch (_that) {
case _Load() when load != null:
return load(_that.projectId,_that.entryId);case _ConfirmRequested() when confirmRequested != null:
return confirmRequested();case _ReverseRequested() when reverseRequested != null:
return reverseRequested(_that.reason);case _ResetFlowStep() when resetFlowStep != null:
return resetFlowStep();case _:
  return null;

}
}

}

/// @nodoc


class _Load implements LedgerEntryEvent {
  const _Load({required this.projectId, required this.entryId});
  

 final  int projectId;
 final  int entryId;

/// Create a copy of LedgerEntryEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadCopyWith<_Load> get copyWith => __$LoadCopyWithImpl<_Load>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Load&&(identical(other.projectId, projectId) || other.projectId == projectId)&&(identical(other.entryId, entryId) || other.entryId == entryId));
}


@override
int get hashCode {
    return Object.hash(runtimeType,projectId,entryId);
}

@override
String toString() {
    return 'LedgerEntryEvent.load(projectId: $projectId, entryId: $entryId)';
}


}

/// @nodoc
abstract mixin class _$LoadCopyWith<$Res> implements $LedgerEntryEventCopyWith<$Res> {
  factory _$LoadCopyWith(_Load value, $Res Function(_Load) _then) = __$LoadCopyWithImpl;
@useResult
$Res call({
 int projectId, int entryId
});




}
/// @nodoc
class __$LoadCopyWithImpl<$Res>
    implements _$LoadCopyWith<$Res> {
  __$LoadCopyWithImpl(this._self, this._then);

  final _Load _self;
  final $Res Function(_Load) _then;

/// Create a copy of LedgerEntryEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? projectId = null,Object? entryId = null,}) {
  return _then(_Load(
projectId: null == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as int,entryId: null == entryId ? _self.entryId : entryId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _ConfirmRequested implements LedgerEntryEvent {
  const _ConfirmRequested();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConfirmRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'LedgerEntryEvent.confirmRequested()';
}


}




/// @nodoc


class _ReverseRequested implements LedgerEntryEvent {
  const _ReverseRequested(this.reason);
  

 final  String reason;

/// Create a copy of LedgerEntryEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReverseRequestedCopyWith<_ReverseRequested> get copyWith => __$ReverseRequestedCopyWithImpl<_ReverseRequested>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReverseRequested&&(identical(other.reason, reason) || other.reason == reason));
}


@override
int get hashCode {
    return Object.hash(runtimeType,reason);
}

@override
String toString() {
    return 'LedgerEntryEvent.reverseRequested(reason: $reason)';
}


}

/// @nodoc
abstract mixin class _$ReverseRequestedCopyWith<$Res> implements $LedgerEntryEventCopyWith<$Res> {
  factory _$ReverseRequestedCopyWith(_ReverseRequested value, $Res Function(_ReverseRequested) _then) = __$ReverseRequestedCopyWithImpl;
@useResult
$Res call({
 String reason
});




}
/// @nodoc
class __$ReverseRequestedCopyWithImpl<$Res>
    implements _$ReverseRequestedCopyWith<$Res> {
  __$ReverseRequestedCopyWithImpl(this._self, this._then);

  final _ReverseRequested _self;
  final $Res Function(_ReverseRequested) _then;

/// Create a copy of LedgerEntryEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? reason = null,}) {
  return _then(_ReverseRequested(
null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _ResetFlowStep implements LedgerEntryEvent {
  const _ResetFlowStep();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResetFlowStep);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'LedgerEntryEvent.resetFlowStep()';
}


}




/// @nodoc
mixin _$LedgerEntryState {

 int? get projectId; int? get entryId; LedgerEntry? get entry; ProjectOverview? get overview;/// The receipt photo's bytes, once loaded.
 Uint8List? get receipt;/// The signed-in user.
 UuidValue? get me; GenericStatus get loadStatus; String? get loadErrorMessage; GenericStatus get actionStatus; String? get actionErrorMessage;/// What the last action did, for its message.
 LedgerEntryAction? get lastAction;
/// Create a copy of LedgerEntryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LedgerEntryStateCopyWith<LedgerEntryState> get copyWith => _$LedgerEntryStateCopyWithImpl<LedgerEntryState>(this as LedgerEntryState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as LedgerEntryState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LedgerEntryState&&(identical(other.projectId, _this.projectId) || other.projectId == _this.projectId)&&(identical(other.entryId, _this.entryId) || other.entryId == _this.entryId)&&(identical(other.entry, _this.entry) || other.entry == _this.entry)&&(identical(other.overview, _this.overview) || other.overview == _this.overview)&&const DeepCollectionEquality().equals(other.receipt, _this.receipt)&&(identical(other.me, _this.me) || other.me == _this.me)&&(identical(other.loadStatus, _this.loadStatus) || other.loadStatus == _this.loadStatus)&&(identical(other.loadErrorMessage, _this.loadErrorMessage) || other.loadErrorMessage == _this.loadErrorMessage)&&(identical(other.actionStatus, _this.actionStatus) || other.actionStatus == _this.actionStatus)&&(identical(other.actionErrorMessage, _this.actionErrorMessage) || other.actionErrorMessage == _this.actionErrorMessage)&&(identical(other.lastAction, _this.lastAction) || other.lastAction == _this.lastAction));
}


@override
int get hashCode {
  final _this = this as LedgerEntryState;
  return Object.hash(runtimeType,_this.projectId,_this.entryId,_this.entry,_this.overview,const DeepCollectionEquality().hash(_this.receipt),_this.me,_this.loadStatus,_this.loadErrorMessage,_this.actionStatus,_this.actionErrorMessage,_this.lastAction);
}

@override
String toString() {
  final _this = this as LedgerEntryState;
  return 'LedgerEntryState(projectId: ${_this.projectId}, entryId: ${_this.entryId}, entry: ${_this.entry}, overview: ${_this.overview}, receipt: ${_this.receipt}, me: ${_this.me}, loadStatus: ${_this.loadStatus}, loadErrorMessage: ${_this.loadErrorMessage}, actionStatus: ${_this.actionStatus}, actionErrorMessage: ${_this.actionErrorMessage}, lastAction: ${_this.lastAction})';
}


}

/// @nodoc
abstract mixin class $LedgerEntryStateCopyWith<$Res>  {
  factory $LedgerEntryStateCopyWith(LedgerEntryState value, $Res Function(LedgerEntryState) _then) = _$LedgerEntryStateCopyWithImpl;
@useResult
$Res call({
 int? projectId, int? entryId, LedgerEntry? entry, ProjectOverview? overview, Uint8List? receipt, UuidValue? me, GenericStatus loadStatus, String? loadErrorMessage, GenericStatus actionStatus, String? actionErrorMessage, LedgerEntryAction? lastAction
});




}
/// @nodoc
class _$LedgerEntryStateCopyWithImpl<$Res>
    implements $LedgerEntryStateCopyWith<$Res> {
  _$LedgerEntryStateCopyWithImpl(this._self, this._then);

  final LedgerEntryState _self;
  final $Res Function(LedgerEntryState) _then;

/// Create a copy of LedgerEntryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? projectId = freezed,Object? entryId = freezed,Object? entry = freezed,Object? overview = freezed,Object? receipt = freezed,Object? me = freezed,Object? loadStatus = null,Object? loadErrorMessage = freezed,Object? actionStatus = null,Object? actionErrorMessage = freezed,Object? lastAction = freezed,}) {
  return _then(LedgerEntryState(
projectId: freezed == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as int?,entryId: freezed == entryId ? _self.entryId : entryId // ignore: cast_nullable_to_non_nullable
as int?,entry: freezed == entry ? _self.entry : entry // ignore: cast_nullable_to_non_nullable
as LedgerEntry?,overview: freezed == overview ? _self.overview : overview // ignore: cast_nullable_to_non_nullable
as ProjectOverview?,receipt: freezed == receipt ? _self.receipt : receipt // ignore: cast_nullable_to_non_nullable
as Uint8List?,me: freezed == me ? _self.me : me // ignore: cast_nullable_to_non_nullable
as UuidValue?,loadStatus: null == loadStatus ? _self.loadStatus : loadStatus // ignore: cast_nullable_to_non_nullable
as GenericStatus,loadErrorMessage: freezed == loadErrorMessage ? _self.loadErrorMessage : loadErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,actionStatus: null == actionStatus ? _self.actionStatus : actionStatus // ignore: cast_nullable_to_non_nullable
as GenericStatus,actionErrorMessage: freezed == actionErrorMessage ? _self.actionErrorMessage : actionErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,lastAction: freezed == lastAction ? _self.lastAction : lastAction // ignore: cast_nullable_to_non_nullable
as LedgerEntryAction?,
  ));
}

}


/// Adds pattern-matching-related methods to [LedgerEntryState].
extension LedgerEntryStatePatterns on LedgerEntryState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LedgerEntryState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LedgerEntryState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LedgerEntryState value)  $default,){
final _that = this;
switch (_that) {
case _LedgerEntryState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LedgerEntryState value)?  $default,){
final _that = this;
switch (_that) {
case _LedgerEntryState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? projectId,  int? entryId,  LedgerEntry? entry,  ProjectOverview? overview,  Uint8List? receipt,  UuidValue? me,  GenericStatus loadStatus,  String? loadErrorMessage,  GenericStatus actionStatus,  String? actionErrorMessage,  LedgerEntryAction? lastAction)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LedgerEntryState() when $default != null:
return $default(_that.projectId,_that.entryId,_that.entry,_that.overview,_that.receipt,_that.me,_that.loadStatus,_that.loadErrorMessage,_that.actionStatus,_that.actionErrorMessage,_that.lastAction);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? projectId,  int? entryId,  LedgerEntry? entry,  ProjectOverview? overview,  Uint8List? receipt,  UuidValue? me,  GenericStatus loadStatus,  String? loadErrorMessage,  GenericStatus actionStatus,  String? actionErrorMessage,  LedgerEntryAction? lastAction)  $default,) {final _that = this;
switch (_that) {
case _LedgerEntryState():
return $default(_that.projectId,_that.entryId,_that.entry,_that.overview,_that.receipt,_that.me,_that.loadStatus,_that.loadErrorMessage,_that.actionStatus,_that.actionErrorMessage,_that.lastAction);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? projectId,  int? entryId,  LedgerEntry? entry,  ProjectOverview? overview,  Uint8List? receipt,  UuidValue? me,  GenericStatus loadStatus,  String? loadErrorMessage,  GenericStatus actionStatus,  String? actionErrorMessage,  LedgerEntryAction? lastAction)?  $default,) {final _that = this;
switch (_that) {
case _LedgerEntryState() when $default != null:
return $default(_that.projectId,_that.entryId,_that.entry,_that.overview,_that.receipt,_that.me,_that.loadStatus,_that.loadErrorMessage,_that.actionStatus,_that.actionErrorMessage,_that.lastAction);case _:
  return null;

}
}

}

/// @nodoc


class _LedgerEntryState extends LedgerEntryState {
  const _LedgerEntryState({this.projectId, this.entryId, this.entry, this.overview, this.receipt, this.me, this.loadStatus = GenericStatus.initial, this.loadErrorMessage, this.actionStatus = GenericStatus.initial, this.actionErrorMessage, this.lastAction}): super._();
  

@override final  int? projectId;
@override final  int? entryId;
@override final  LedgerEntry? entry;
@override final  ProjectOverview? overview;
/// The receipt photo's bytes, once loaded.
@override final  Uint8List? receipt;
/// The signed-in user.
@override final  UuidValue? me;
@override@JsonKey() final  GenericStatus loadStatus;
@override final  String? loadErrorMessage;
@override@JsonKey() final  GenericStatus actionStatus;
@override final  String? actionErrorMessage;
/// What the last action did, for its message.
@override final  LedgerEntryAction? lastAction;

/// Create a copy of LedgerEntryState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LedgerEntryStateCopyWith<_LedgerEntryState> get copyWith => __$LedgerEntryStateCopyWithImpl<_LedgerEntryState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LedgerEntryState&&(identical(other.projectId, projectId) || other.projectId == projectId)&&(identical(other.entryId, entryId) || other.entryId == entryId)&&(identical(other.entry, entry) || other.entry == entry)&&(identical(other.overview, overview) || other.overview == overview)&&const DeepCollectionEquality().equals(other.receipt, receipt)&&(identical(other.me, me) || other.me == me)&&(identical(other.loadStatus, loadStatus) || other.loadStatus == loadStatus)&&(identical(other.loadErrorMessage, loadErrorMessage) || other.loadErrorMessage == loadErrorMessage)&&(identical(other.actionStatus, actionStatus) || other.actionStatus == actionStatus)&&(identical(other.actionErrorMessage, actionErrorMessage) || other.actionErrorMessage == actionErrorMessage)&&(identical(other.lastAction, lastAction) || other.lastAction == lastAction));
}


@override
int get hashCode {
    return Object.hash(runtimeType,projectId,entryId,entry,overview,const DeepCollectionEquality().hash(receipt),me,loadStatus,loadErrorMessage,actionStatus,actionErrorMessage,lastAction);
}

@override
String toString() {
    return 'LedgerEntryState(projectId: $projectId, entryId: $entryId, entry: $entry, overview: $overview, receipt: $receipt, me: $me, loadStatus: $loadStatus, loadErrorMessage: $loadErrorMessage, actionStatus: $actionStatus, actionErrorMessage: $actionErrorMessage, lastAction: $lastAction)';
}


}

/// @nodoc
abstract mixin class _$LedgerEntryStateCopyWith<$Res> implements $LedgerEntryStateCopyWith<$Res> {
  factory _$LedgerEntryStateCopyWith(_LedgerEntryState value, $Res Function(_LedgerEntryState) _then) = __$LedgerEntryStateCopyWithImpl;
@override @useResult
$Res call({
 int? projectId, int? entryId, LedgerEntry? entry, ProjectOverview? overview, Uint8List? receipt, UuidValue? me, GenericStatus loadStatus, String? loadErrorMessage, GenericStatus actionStatus, String? actionErrorMessage, LedgerEntryAction? lastAction
});




}
/// @nodoc
class __$LedgerEntryStateCopyWithImpl<$Res>
    implements _$LedgerEntryStateCopyWith<$Res> {
  __$LedgerEntryStateCopyWithImpl(this._self, this._then);

  final _LedgerEntryState _self;
  final $Res Function(_LedgerEntryState) _then;

/// Create a copy of LedgerEntryState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? projectId = freezed,Object? entryId = freezed,Object? entry = freezed,Object? overview = freezed,Object? receipt = freezed,Object? me = freezed,Object? loadStatus = null,Object? loadErrorMessage = freezed,Object? actionStatus = null,Object? actionErrorMessage = freezed,Object? lastAction = freezed,}) {
  return _then(_LedgerEntryState(
projectId: freezed == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as int?,entryId: freezed == entryId ? _self.entryId : entryId // ignore: cast_nullable_to_non_nullable
as int?,entry: freezed == entry ? _self.entry : entry // ignore: cast_nullable_to_non_nullable
as LedgerEntry?,overview: freezed == overview ? _self.overview : overview // ignore: cast_nullable_to_non_nullable
as ProjectOverview?,receipt: freezed == receipt ? _self.receipt : receipt // ignore: cast_nullable_to_non_nullable
as Uint8List?,me: freezed == me ? _self.me : me // ignore: cast_nullable_to_non_nullable
as UuidValue?,loadStatus: null == loadStatus ? _self.loadStatus : loadStatus // ignore: cast_nullable_to_non_nullable
as GenericStatus,loadErrorMessage: freezed == loadErrorMessage ? _self.loadErrorMessage : loadErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,actionStatus: null == actionStatus ? _self.actionStatus : actionStatus // ignore: cast_nullable_to_non_nullable
as GenericStatus,actionErrorMessage: freezed == actionErrorMessage ? _self.actionErrorMessage : actionErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,lastAction: freezed == lastAction ? _self.lastAction : lastAction // ignore: cast_nullable_to_non_nullable
as LedgerEntryAction?,
  ));
}


}

// dart format on
