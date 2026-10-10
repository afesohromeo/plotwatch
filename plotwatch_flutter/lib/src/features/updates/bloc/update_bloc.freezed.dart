// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UpdateEvent {

 int get projectId; int get updateId;
/// Create a copy of UpdateEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateEventCopyWith<UpdateEvent> get copyWith => _$UpdateEventCopyWithImpl<UpdateEvent>(this as UpdateEvent, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as UpdateEvent;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateEvent&&(identical(other.projectId, _this.projectId) || other.projectId == _this.projectId)&&(identical(other.updateId, _this.updateId) || other.updateId == _this.updateId));
}


@override
int get hashCode {
  final _this = this as UpdateEvent;
  return Object.hash(runtimeType,_this.projectId,_this.updateId);
}

@override
String toString() {
  final _this = this as UpdateEvent;
  return 'UpdateEvent(projectId: ${_this.projectId}, updateId: ${_this.updateId})';
}


}

/// @nodoc
abstract mixin class $UpdateEventCopyWith<$Res>  {
  factory $UpdateEventCopyWith(UpdateEvent value, $Res Function(UpdateEvent) _then) = _$UpdateEventCopyWithImpl;
@useResult
$Res call({
 int projectId, int updateId
});




}
/// @nodoc
class _$UpdateEventCopyWithImpl<$Res>
    implements $UpdateEventCopyWith<$Res> {
  _$UpdateEventCopyWithImpl(this._self, this._then);

  final UpdateEvent _self;
  final $Res Function(UpdateEvent) _then;

/// Create a copy of UpdateEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? projectId = null,Object? updateId = null,}) {
  return _then(UpdateEvent.load(
projectId: null == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as int,updateId: null == updateId ? _self.updateId : updateId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [UpdateEvent].
extension UpdateEventPatterns on UpdateEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Load value)?  load,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Load() when load != null:
return load(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Load value)  load,}){
final _that = this;
switch (_that) {
case _Load():
return load(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Load value)?  load,}){
final _that = this;
switch (_that) {
case _Load() when load != null:
return load(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int projectId,  int updateId)?  load,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Load() when load != null:
return load(_that.projectId,_that.updateId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int projectId,  int updateId)  load,}) {final _that = this;
switch (_that) {
case _Load():
return load(_that.projectId,_that.updateId);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int projectId,  int updateId)?  load,}) {final _that = this;
switch (_that) {
case _Load() when load != null:
return load(_that.projectId,_that.updateId);case _:
  return null;

}
}

}

/// @nodoc


class _Load implements UpdateEvent {
  const _Load({required this.projectId, required this.updateId});
  

@override final  int projectId;
@override final  int updateId;

/// Create a copy of UpdateEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadCopyWith<_Load> get copyWith => __$LoadCopyWithImpl<_Load>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Load&&(identical(other.projectId, projectId) || other.projectId == projectId)&&(identical(other.updateId, updateId) || other.updateId == updateId));
}


@override
int get hashCode {
    return Object.hash(runtimeType,projectId,updateId);
}

@override
String toString() {
    return 'UpdateEvent.load(projectId: $projectId, updateId: $updateId)';
}


}

/// @nodoc
abstract mixin class _$LoadCopyWith<$Res> implements $UpdateEventCopyWith<$Res> {
  factory _$LoadCopyWith(_Load value, $Res Function(_Load) _then) = __$LoadCopyWithImpl;
@override @useResult
$Res call({
 int projectId, int updateId
});




}
/// @nodoc
class __$LoadCopyWithImpl<$Res>
    implements _$LoadCopyWith<$Res> {
  __$LoadCopyWithImpl(this._self, this._then);

  final _Load _self;
  final $Res Function(_Load) _then;

/// Create a copy of UpdateEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? projectId = null,Object? updateId = null,}) {
  return _then(_Load(
projectId: null == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as int,updateId: null == updateId ? _self.updateId : updateId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$UpdateState {

 ProgressUpdate? get update;/// The stage it is about, if any.
 String? get stageName; GenericStatus get loadStatus; String? get loadErrorMessage;/// The update is gone (or never was): the page says so and offers the
/// way back instead of Retry (doc/05 §9.6).
 bool get notFound;
/// Create a copy of UpdateState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateStateCopyWith<UpdateState> get copyWith => _$UpdateStateCopyWithImpl<UpdateState>(this as UpdateState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as UpdateState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateState&&(identical(other.update, _this.update) || other.update == _this.update)&&(identical(other.stageName, _this.stageName) || other.stageName == _this.stageName)&&(identical(other.loadStatus, _this.loadStatus) || other.loadStatus == _this.loadStatus)&&(identical(other.loadErrorMessage, _this.loadErrorMessage) || other.loadErrorMessage == _this.loadErrorMessage)&&(identical(other.notFound, _this.notFound) || other.notFound == _this.notFound));
}


@override
int get hashCode {
  final _this = this as UpdateState;
  return Object.hash(runtimeType,_this.update,_this.stageName,_this.loadStatus,_this.loadErrorMessage,_this.notFound);
}

@override
String toString() {
  final _this = this as UpdateState;
  return 'UpdateState(update: ${_this.update}, stageName: ${_this.stageName}, loadStatus: ${_this.loadStatus}, loadErrorMessage: ${_this.loadErrorMessage}, notFound: ${_this.notFound})';
}


}

/// @nodoc
abstract mixin class $UpdateStateCopyWith<$Res>  {
  factory $UpdateStateCopyWith(UpdateState value, $Res Function(UpdateState) _then) = _$UpdateStateCopyWithImpl;
@useResult
$Res call({
 ProgressUpdate? update, String? stageName, GenericStatus loadStatus, String? loadErrorMessage, bool notFound
});




}
/// @nodoc
class _$UpdateStateCopyWithImpl<$Res>
    implements $UpdateStateCopyWith<$Res> {
  _$UpdateStateCopyWithImpl(this._self, this._then);

  final UpdateState _self;
  final $Res Function(UpdateState) _then;

/// Create a copy of UpdateState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? update = freezed,Object? stageName = freezed,Object? loadStatus = null,Object? loadErrorMessage = freezed,Object? notFound = null,}) {
  return _then(UpdateState(
update: freezed == update ? _self.update : update // ignore: cast_nullable_to_non_nullable
as ProgressUpdate?,stageName: freezed == stageName ? _self.stageName : stageName // ignore: cast_nullable_to_non_nullable
as String?,loadStatus: null == loadStatus ? _self.loadStatus : loadStatus // ignore: cast_nullable_to_non_nullable
as GenericStatus,loadErrorMessage: freezed == loadErrorMessage ? _self.loadErrorMessage : loadErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,notFound: null == notFound ? _self.notFound : notFound // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [UpdateState].
extension UpdateStatePatterns on UpdateState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UpdateState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UpdateState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UpdateState value)  $default,){
final _that = this;
switch (_that) {
case _UpdateState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UpdateState value)?  $default,){
final _that = this;
switch (_that) {
case _UpdateState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ProgressUpdate? update,  String? stageName,  GenericStatus loadStatus,  String? loadErrorMessage,  bool notFound)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UpdateState() when $default != null:
return $default(_that.update,_that.stageName,_that.loadStatus,_that.loadErrorMessage,_that.notFound);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ProgressUpdate? update,  String? stageName,  GenericStatus loadStatus,  String? loadErrorMessage,  bool notFound)  $default,) {final _that = this;
switch (_that) {
case _UpdateState():
return $default(_that.update,_that.stageName,_that.loadStatus,_that.loadErrorMessage,_that.notFound);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ProgressUpdate? update,  String? stageName,  GenericStatus loadStatus,  String? loadErrorMessage,  bool notFound)?  $default,) {final _that = this;
switch (_that) {
case _UpdateState() when $default != null:
return $default(_that.update,_that.stageName,_that.loadStatus,_that.loadErrorMessage,_that.notFound);case _:
  return null;

}
}

}

/// @nodoc


class _UpdateState implements UpdateState {
  const _UpdateState({this.update, this.stageName, this.loadStatus = GenericStatus.initial, this.loadErrorMessage, this.notFound = false});
  

@override final  ProgressUpdate? update;
/// The stage it is about, if any.
@override final  String? stageName;
@override@JsonKey() final  GenericStatus loadStatus;
@override final  String? loadErrorMessage;
/// The update is gone (or never was): the page says so and offers the
/// way back instead of Retry (doc/05 §9.6).
@override@JsonKey() final  bool notFound;

/// Create a copy of UpdateState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateStateCopyWith<_UpdateState> get copyWith => __$UpdateStateCopyWithImpl<_UpdateState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateState&&(identical(other.update, update) || other.update == update)&&(identical(other.stageName, stageName) || other.stageName == stageName)&&(identical(other.loadStatus, loadStatus) || other.loadStatus == loadStatus)&&(identical(other.loadErrorMessage, loadErrorMessage) || other.loadErrorMessage == loadErrorMessage)&&(identical(other.notFound, notFound) || other.notFound == notFound));
}


@override
int get hashCode {
    return Object.hash(runtimeType,update,stageName,loadStatus,loadErrorMessage,notFound);
}

@override
String toString() {
    return 'UpdateState(update: $update, stageName: $stageName, loadStatus: $loadStatus, loadErrorMessage: $loadErrorMessage, notFound: $notFound)';
}


}

/// @nodoc
abstract mixin class _$UpdateStateCopyWith<$Res> implements $UpdateStateCopyWith<$Res> {
  factory _$UpdateStateCopyWith(_UpdateState value, $Res Function(_UpdateState) _then) = __$UpdateStateCopyWithImpl;
@override @useResult
$Res call({
 ProgressUpdate? update, String? stageName, GenericStatus loadStatus, String? loadErrorMessage, bool notFound
});




}
/// @nodoc
class __$UpdateStateCopyWithImpl<$Res>
    implements _$UpdateStateCopyWith<$Res> {
  __$UpdateStateCopyWithImpl(this._self, this._then);

  final _UpdateState _self;
  final $Res Function(_UpdateState) _then;

/// Create a copy of UpdateState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? update = freezed,Object? stageName = freezed,Object? loadStatus = null,Object? loadErrorMessage = freezed,Object? notFound = null,}) {
  return _then(_UpdateState(
update: freezed == update ? _self.update : update // ignore: cast_nullable_to_non_nullable
as ProgressUpdate?,stageName: freezed == stageName ? _self.stageName : stageName // ignore: cast_nullable_to_non_nullable
as String?,loadStatus: null == loadStatus ? _self.loadStatus : loadStatus // ignore: cast_nullable_to_non_nullable
as GenericStatus,loadErrorMessage: freezed == loadErrorMessage ? _self.loadErrorMessage : loadErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,notFound: null == notFound ? _self.notFound : notFound // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
