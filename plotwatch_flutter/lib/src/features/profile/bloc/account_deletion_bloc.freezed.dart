// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_deletion_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AccountDeletionEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountDeletionEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'AccountDeletionEvent()';
}


}

/// @nodoc
class $AccountDeletionEventCopyWith<$Res>  {
$AccountDeletionEventCopyWith(AccountDeletionEvent _, $Res Function(AccountDeletionEvent) __);
}


/// Adds pattern-matching-related methods to [AccountDeletionEvent].
extension AccountDeletionEventPatterns on AccountDeletionEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _CheckRequested value)?  checkRequested,TResult Function( _DeleteRequested value)?  deleteRequested,TResult Function( _Reset value)?  reset,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CheckRequested() when checkRequested != null:
return checkRequested(_that);case _DeleteRequested() when deleteRequested != null:
return deleteRequested(_that);case _Reset() when reset != null:
return reset(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _CheckRequested value)  checkRequested,required TResult Function( _DeleteRequested value)  deleteRequested,required TResult Function( _Reset value)  reset,}){
final _that = this;
switch (_that) {
case _CheckRequested():
return checkRequested(_that);case _DeleteRequested():
return deleteRequested(_that);case _Reset():
return reset(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _CheckRequested value)?  checkRequested,TResult? Function( _DeleteRequested value)?  deleteRequested,TResult? Function( _Reset value)?  reset,}){
final _that = this;
switch (_that) {
case _CheckRequested() when checkRequested != null:
return checkRequested(_that);case _DeleteRequested() when deleteRequested != null:
return deleteRequested(_that);case _Reset() when reset != null:
return reset(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  checkRequested,TResult Function()?  deleteRequested,TResult Function()?  reset,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CheckRequested() when checkRequested != null:
return checkRequested();case _DeleteRequested() when deleteRequested != null:
return deleteRequested();case _Reset() when reset != null:
return reset();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  checkRequested,required TResult Function()  deleteRequested,required TResult Function()  reset,}) {final _that = this;
switch (_that) {
case _CheckRequested():
return checkRequested();case _DeleteRequested():
return deleteRequested();case _Reset():
return reset();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  checkRequested,TResult? Function()?  deleteRequested,TResult? Function()?  reset,}) {final _that = this;
switch (_that) {
case _CheckRequested() when checkRequested != null:
return checkRequested();case _DeleteRequested() when deleteRequested != null:
return deleteRequested();case _Reset() when reset != null:
return reset();case _:
  return null;

}
}

}

/// @nodoc


class _CheckRequested implements AccountDeletionEvent {
  const _CheckRequested();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CheckRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'AccountDeletionEvent.checkRequested()';
}


}




/// @nodoc


class _DeleteRequested implements AccountDeletionEvent {
  const _DeleteRequested();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeleteRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'AccountDeletionEvent.deleteRequested()';
}


}




/// @nodoc


class _Reset implements AccountDeletionEvent {
  const _Reset();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Reset);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'AccountDeletionEvent.reset()';
}


}




/// @nodoc
mixin _$AccountDeletionState {

 GenericStatus get checkStatus;/// Projects to complete or archive first.
 List<String> get blockers; GenericStatus get deleteStatus; String? get errorMessage;
/// Create a copy of AccountDeletionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AccountDeletionStateCopyWith<AccountDeletionState> get copyWith => _$AccountDeletionStateCopyWithImpl<AccountDeletionState>(this as AccountDeletionState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as AccountDeletionState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountDeletionState&&(identical(other.checkStatus, _this.checkStatus) || other.checkStatus == _this.checkStatus)&&const DeepCollectionEquality().equals(other.blockers, _this.blockers)&&(identical(other.deleteStatus, _this.deleteStatus) || other.deleteStatus == _this.deleteStatus)&&(identical(other.errorMessage, _this.errorMessage) || other.errorMessage == _this.errorMessage));
}


@override
int get hashCode {
  final _this = this as AccountDeletionState;
  return Object.hash(runtimeType,_this.checkStatus,const DeepCollectionEquality().hash(_this.blockers),_this.deleteStatus,_this.errorMessage);
}

@override
String toString() {
  final _this = this as AccountDeletionState;
  return 'AccountDeletionState(checkStatus: ${_this.checkStatus}, blockers: ${_this.blockers}, deleteStatus: ${_this.deleteStatus}, errorMessage: ${_this.errorMessage})';
}


}

/// @nodoc
abstract mixin class $AccountDeletionStateCopyWith<$Res>  {
  factory $AccountDeletionStateCopyWith(AccountDeletionState value, $Res Function(AccountDeletionState) _then) = _$AccountDeletionStateCopyWithImpl;
@useResult
$Res call({
 GenericStatus checkStatus, List<String> blockers, GenericStatus deleteStatus, String? errorMessage
});




}
/// @nodoc
class _$AccountDeletionStateCopyWithImpl<$Res>
    implements $AccountDeletionStateCopyWith<$Res> {
  _$AccountDeletionStateCopyWithImpl(this._self, this._then);

  final AccountDeletionState _self;
  final $Res Function(AccountDeletionState) _then;

/// Create a copy of AccountDeletionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? checkStatus = null,Object? blockers = null,Object? deleteStatus = null,Object? errorMessage = freezed,}) {
  return _then(AccountDeletionState(
checkStatus: null == checkStatus ? _self.checkStatus : checkStatus // ignore: cast_nullable_to_non_nullable
as GenericStatus,blockers: null == blockers ? _self.blockers : blockers // ignore: cast_nullable_to_non_nullable
as List<String>,deleteStatus: null == deleteStatus ? _self.deleteStatus : deleteStatus // ignore: cast_nullable_to_non_nullable
as GenericStatus,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AccountDeletionState].
extension AccountDeletionStatePatterns on AccountDeletionState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AccountDeletionState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AccountDeletionState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AccountDeletionState value)  $default,){
final _that = this;
switch (_that) {
case _AccountDeletionState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AccountDeletionState value)?  $default,){
final _that = this;
switch (_that) {
case _AccountDeletionState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( GenericStatus checkStatus,  List<String> blockers,  GenericStatus deleteStatus,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AccountDeletionState() when $default != null:
return $default(_that.checkStatus,_that.blockers,_that.deleteStatus,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( GenericStatus checkStatus,  List<String> blockers,  GenericStatus deleteStatus,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _AccountDeletionState():
return $default(_that.checkStatus,_that.blockers,_that.deleteStatus,_that.errorMessage);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( GenericStatus checkStatus,  List<String> blockers,  GenericStatus deleteStatus,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _AccountDeletionState() when $default != null:
return $default(_that.checkStatus,_that.blockers,_that.deleteStatus,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _AccountDeletionState implements AccountDeletionState {
  const _AccountDeletionState({this.checkStatus = GenericStatus.initial,  List<String> blockers = const <String>[], this.deleteStatus = GenericStatus.initial, this.errorMessage}): _blockers = blockers;
  

@override@JsonKey() final  GenericStatus checkStatus;
/// Projects to complete or archive first.
 final  List<String> _blockers;
/// Projects to complete or archive first.
@override@JsonKey() List<String> get blockers {
  if (_blockers is EqualUnmodifiableListView) return _blockers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_blockers);
}

@override@JsonKey() final  GenericStatus deleteStatus;
@override final  String? errorMessage;

/// Create a copy of AccountDeletionState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AccountDeletionStateCopyWith<_AccountDeletionState> get copyWith => __$AccountDeletionStateCopyWithImpl<_AccountDeletionState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AccountDeletionState&&(identical(other.checkStatus, checkStatus) || other.checkStatus == checkStatus)&&const DeepCollectionEquality().equals(other.blockers, _blockers)&&(identical(other.deleteStatus, deleteStatus) || other.deleteStatus == deleteStatus)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode {
    return Object.hash(runtimeType,checkStatus,const DeepCollectionEquality().hash(_blockers),deleteStatus,errorMessage);
}

@override
String toString() {
    return 'AccountDeletionState(checkStatus: $checkStatus, blockers: $blockers, deleteStatus: $deleteStatus, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$AccountDeletionStateCopyWith<$Res> implements $AccountDeletionStateCopyWith<$Res> {
  factory _$AccountDeletionStateCopyWith(_AccountDeletionState value, $Res Function(_AccountDeletionState) _then) = __$AccountDeletionStateCopyWithImpl;
@override @useResult
$Res call({
 GenericStatus checkStatus, List<String> blockers, GenericStatus deleteStatus, String? errorMessage
});




}
/// @nodoc
class __$AccountDeletionStateCopyWithImpl<$Res>
    implements _$AccountDeletionStateCopyWith<$Res> {
  __$AccountDeletionStateCopyWithImpl(this._self, this._then);

  final _AccountDeletionState _self;
  final $Res Function(_AccountDeletionState) _then;

/// Create a copy of AccountDeletionState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? checkStatus = null,Object? blockers = null,Object? deleteStatus = null,Object? errorMessage = freezed,}) {
  return _then(_AccountDeletionState(
checkStatus: null == checkStatus ? _self.checkStatus : checkStatus // ignore: cast_nullable_to_non_nullable
as GenericStatus,blockers: null == blockers ? _self._blockers : blockers // ignore: cast_nullable_to_non_nullable
as List<String>,deleteStatus: null == deleteStatus ? _self.deleteStatus : deleteStatus // ignore: cast_nullable_to_non_nullable
as GenericStatus,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
