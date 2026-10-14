// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'evidence_media_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EvidenceMediaEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is EvidenceMediaEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'EvidenceMediaEvent()';
}


}

/// @nodoc
class $EvidenceMediaEventCopyWith<$Res>  {
$EvidenceMediaEventCopyWith(EvidenceMediaEvent _, $Res Function(EvidenceMediaEvent) __);
}


/// Adds pattern-matching-related methods to [EvidenceMediaEvent].
extension EvidenceMediaEventPatterns on EvidenceMediaEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Requested value)?  requested,TResult Function( _Cleared value)?  cleared,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Requested() when requested != null:
return requested(_that);case _Cleared() when cleared != null:
return cleared(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Requested value)  requested,required TResult Function( _Cleared value)  cleared,}){
final _that = this;
switch (_that) {
case _Requested():
return requested(_that);case _Cleared():
return cleared(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Requested value)?  requested,TResult? Function( _Cleared value)?  cleared,}){
final _that = this;
switch (_that) {
case _Requested() when requested != null:
return requested(_that);case _Cleared() when cleared != null:
return cleared(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int projectId,  int evidenceId,  MediaVariant variant)?  requested,TResult Function()?  cleared,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Requested() when requested != null:
return requested(_that.projectId,_that.evidenceId,_that.variant);case _Cleared() when cleared != null:
return cleared();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int projectId,  int evidenceId,  MediaVariant variant)  requested,required TResult Function()  cleared,}) {final _that = this;
switch (_that) {
case _Requested():
return requested(_that.projectId,_that.evidenceId,_that.variant);case _Cleared():
return cleared();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int projectId,  int evidenceId,  MediaVariant variant)?  requested,TResult? Function()?  cleared,}) {final _that = this;
switch (_that) {
case _Requested() when requested != null:
return requested(_that.projectId,_that.evidenceId,_that.variant);case _Cleared() when cleared != null:
return cleared();case _:
  return null;

}
}

}

/// @nodoc


class _Requested implements EvidenceMediaEvent {
  const _Requested({required this.projectId, required this.evidenceId, required this.variant});
  

 final  int projectId;
 final  int evidenceId;
 final  MediaVariant variant;

/// Create a copy of EvidenceMediaEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RequestedCopyWith<_Requested> get copyWith => __$RequestedCopyWithImpl<_Requested>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Requested&&(identical(other.projectId, projectId) || other.projectId == projectId)&&(identical(other.evidenceId, evidenceId) || other.evidenceId == evidenceId)&&(identical(other.variant, variant) || other.variant == variant));
}


@override
int get hashCode {
    return Object.hash(runtimeType,projectId,evidenceId,variant);
}

@override
String toString() {
    return 'EvidenceMediaEvent.requested(projectId: $projectId, evidenceId: $evidenceId, variant: $variant)';
}


}

/// @nodoc
abstract mixin class _$RequestedCopyWith<$Res> implements $EvidenceMediaEventCopyWith<$Res> {
  factory _$RequestedCopyWith(_Requested value, $Res Function(_Requested) _then) = __$RequestedCopyWithImpl;
@useResult
$Res call({
 int projectId, int evidenceId, MediaVariant variant
});




}
/// @nodoc
class __$RequestedCopyWithImpl<$Res>
    implements _$RequestedCopyWith<$Res> {
  __$RequestedCopyWithImpl(this._self, this._then);

  final _Requested _self;
  final $Res Function(_Requested) _then;

/// Create a copy of EvidenceMediaEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? projectId = null,Object? evidenceId = null,Object? variant = null,}) {
  return _then(_Requested(
projectId: null == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as int,evidenceId: null == evidenceId ? _self.evidenceId : evidenceId // ignore: cast_nullable_to_non_nullable
as int,variant: null == variant ? _self.variant : variant // ignore: cast_nullable_to_non_nullable
as MediaVariant,
  ));
}


}

/// @nodoc


class _Cleared implements EvidenceMediaEvent {
  const _Cleared();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Cleared);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'EvidenceMediaEvent.cleared()';
}


}




/// @nodoc
mixin _$EvidenceMediaState {

/// Bytes by [keyFor].
 Map<String, Uint8List> get images; Set<String> get loading; Set<String> get failed;
/// Create a copy of EvidenceMediaState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EvidenceMediaStateCopyWith<EvidenceMediaState> get copyWith => _$EvidenceMediaStateCopyWithImpl<EvidenceMediaState>(this as EvidenceMediaState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as EvidenceMediaState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EvidenceMediaState&&const DeepCollectionEquality().equals(other.images, _this.images)&&const DeepCollectionEquality().equals(other.loading, _this.loading)&&const DeepCollectionEquality().equals(other.failed, _this.failed));
}


@override
int get hashCode {
  final _this = this as EvidenceMediaState;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.images),const DeepCollectionEquality().hash(_this.loading),const DeepCollectionEquality().hash(_this.failed));
}

@override
String toString() {
  final _this = this as EvidenceMediaState;
  return 'EvidenceMediaState(images: ${_this.images}, loading: ${_this.loading}, failed: ${_this.failed})';
}


}

/// @nodoc
abstract mixin class $EvidenceMediaStateCopyWith<$Res>  {
  factory $EvidenceMediaStateCopyWith(EvidenceMediaState value, $Res Function(EvidenceMediaState) _then) = _$EvidenceMediaStateCopyWithImpl;
@useResult
$Res call({
 Map<String, Uint8List> images, Set<String> loading, Set<String> failed
});




}
/// @nodoc
class _$EvidenceMediaStateCopyWithImpl<$Res>
    implements $EvidenceMediaStateCopyWith<$Res> {
  _$EvidenceMediaStateCopyWithImpl(this._self, this._then);

  final EvidenceMediaState _self;
  final $Res Function(EvidenceMediaState) _then;

/// Create a copy of EvidenceMediaState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? images = null,Object? loading = null,Object? failed = null,}) {
  return _then(EvidenceMediaState(
images: null == images ? _self.images : images // ignore: cast_nullable_to_non_nullable
as Map<String, Uint8List>,loading: null == loading ? _self.loading : loading // ignore: cast_nullable_to_non_nullable
as Set<String>,failed: null == failed ? _self.failed : failed // ignore: cast_nullable_to_non_nullable
as Set<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [EvidenceMediaState].
extension EvidenceMediaStatePatterns on EvidenceMediaState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EvidenceMediaState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EvidenceMediaState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EvidenceMediaState value)  $default,){
final _that = this;
switch (_that) {
case _EvidenceMediaState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EvidenceMediaState value)?  $default,){
final _that = this;
switch (_that) {
case _EvidenceMediaState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Map<String, Uint8List> images,  Set<String> loading,  Set<String> failed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EvidenceMediaState() when $default != null:
return $default(_that.images,_that.loading,_that.failed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Map<String, Uint8List> images,  Set<String> loading,  Set<String> failed)  $default,) {final _that = this;
switch (_that) {
case _EvidenceMediaState():
return $default(_that.images,_that.loading,_that.failed);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Map<String, Uint8List> images,  Set<String> loading,  Set<String> failed)?  $default,) {final _that = this;
switch (_that) {
case _EvidenceMediaState() when $default != null:
return $default(_that.images,_that.loading,_that.failed);case _:
  return null;

}
}

}

/// @nodoc


class _EvidenceMediaState extends EvidenceMediaState {
  const _EvidenceMediaState({ Map<String, Uint8List> images = const <String, Uint8List>{},  Set<String> loading = const <String>{},  Set<String> failed = const <String>{}}): _images = images,_loading = loading,_failed = failed,super._();
  

/// Bytes by [keyFor].
 final  Map<String, Uint8List> _images;
/// Bytes by [keyFor].
@override@JsonKey() Map<String, Uint8List> get images {
  if (_images is EqualUnmodifiableMapView) return _images;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_images);
}

 final  Set<String> _loading;
@override@JsonKey() Set<String> get loading {
  if (_loading is EqualUnmodifiableSetView) return _loading;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_loading);
}

 final  Set<String> _failed;
@override@JsonKey() Set<String> get failed {
  if (_failed is EqualUnmodifiableSetView) return _failed;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_failed);
}


/// Create a copy of EvidenceMediaState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EvidenceMediaStateCopyWith<_EvidenceMediaState> get copyWith => __$EvidenceMediaStateCopyWithImpl<_EvidenceMediaState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _EvidenceMediaState&&const DeepCollectionEquality().equals(other.images, _images)&&const DeepCollectionEquality().equals(other.loading, _loading)&&const DeepCollectionEquality().equals(other.failed, _failed));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_images),const DeepCollectionEquality().hash(_loading),const DeepCollectionEquality().hash(_failed));
}

@override
String toString() {
    return 'EvidenceMediaState(images: $images, loading: $loading, failed: $failed)';
}


}

/// @nodoc
abstract mixin class _$EvidenceMediaStateCopyWith<$Res> implements $EvidenceMediaStateCopyWith<$Res> {
  factory _$EvidenceMediaStateCopyWith(_EvidenceMediaState value, $Res Function(_EvidenceMediaState) _then) = __$EvidenceMediaStateCopyWithImpl;
@override @useResult
$Res call({
 Map<String, Uint8List> images, Set<String> loading, Set<String> failed
});




}
/// @nodoc
class __$EvidenceMediaStateCopyWithImpl<$Res>
    implements _$EvidenceMediaStateCopyWith<$Res> {
  __$EvidenceMediaStateCopyWithImpl(this._self, this._then);

  final _EvidenceMediaState _self;
  final $Res Function(_EvidenceMediaState) _then;

/// Create a copy of EvidenceMediaState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? images = null,Object? loading = null,Object? failed = null,}) {
  return _then(_EvidenceMediaState(
images: null == images ? _self._images : images // ignore: cast_nullable_to_non_nullable
as Map<String, Uint8List>,loading: null == loading ? _self._loading : loading // ignore: cast_nullable_to_non_nullable
as Set<String>,failed: null == failed ? _self._failed : failed // ignore: cast_nullable_to_non_nullable
as Set<String>,
  ));
}


}

// dart format on
