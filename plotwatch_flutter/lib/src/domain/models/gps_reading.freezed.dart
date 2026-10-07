// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gps_reading.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GpsReading {

 double get latitude; double get longitude;/// Radius of the 68 % confidence circle, in metres.
 double get accuracyM;/// Android reports positions from location-faking apps.
 bool get isMocked;
/// Create a copy of GpsReading
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GpsReadingCopyWith<GpsReading> get copyWith => _$GpsReadingCopyWithImpl<GpsReading>(this as GpsReading, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as GpsReading;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GpsReading&&(identical(other.latitude, _this.latitude) || other.latitude == _this.latitude)&&(identical(other.longitude, _this.longitude) || other.longitude == _this.longitude)&&(identical(other.accuracyM, _this.accuracyM) || other.accuracyM == _this.accuracyM)&&(identical(other.isMocked, _this.isMocked) || other.isMocked == _this.isMocked));
}


@override
int get hashCode {
  final _this = this as GpsReading;
  return Object.hash(runtimeType,_this.latitude,_this.longitude,_this.accuracyM,_this.isMocked);
}

@override
String toString() {
  final _this = this as GpsReading;
  return 'GpsReading(latitude: ${_this.latitude}, longitude: ${_this.longitude}, accuracyM: ${_this.accuracyM}, isMocked: ${_this.isMocked})';
}


}

/// @nodoc
abstract mixin class $GpsReadingCopyWith<$Res>  {
  factory $GpsReadingCopyWith(GpsReading value, $Res Function(GpsReading) _then) = _$GpsReadingCopyWithImpl;
@useResult
$Res call({
 double latitude, double longitude, double accuracyM, bool isMocked
});




}
/// @nodoc
class _$GpsReadingCopyWithImpl<$Res>
    implements $GpsReadingCopyWith<$Res> {
  _$GpsReadingCopyWithImpl(this._self, this._then);

  final GpsReading _self;
  final $Res Function(GpsReading) _then;

/// Create a copy of GpsReading
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? latitude = null,Object? longitude = null,Object? accuracyM = null,Object? isMocked = null,}) {
  return _then(GpsReading(
latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,accuracyM: null == accuracyM ? _self.accuracyM : accuracyM // ignore: cast_nullable_to_non_nullable
as double,isMocked: null == isMocked ? _self.isMocked : isMocked // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [GpsReading].
extension GpsReadingPatterns on GpsReading {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GpsReading value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GpsReading() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GpsReading value)  $default,){
final _that = this;
switch (_that) {
case _GpsReading():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GpsReading value)?  $default,){
final _that = this;
switch (_that) {
case _GpsReading() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double latitude,  double longitude,  double accuracyM,  bool isMocked)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GpsReading() when $default != null:
return $default(_that.latitude,_that.longitude,_that.accuracyM,_that.isMocked);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double latitude,  double longitude,  double accuracyM,  bool isMocked)  $default,) {final _that = this;
switch (_that) {
case _GpsReading():
return $default(_that.latitude,_that.longitude,_that.accuracyM,_that.isMocked);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double latitude,  double longitude,  double accuracyM,  bool isMocked)?  $default,) {final _that = this;
switch (_that) {
case _GpsReading() when $default != null:
return $default(_that.latitude,_that.longitude,_that.accuracyM,_that.isMocked);case _:
  return null;

}
}

}

/// @nodoc


class _GpsReading implements GpsReading {
  const _GpsReading({required this.latitude, required this.longitude, required this.accuracyM, required this.isMocked});
  

@override final  double latitude;
@override final  double longitude;
/// Radius of the 68 % confidence circle, in metres.
@override final  double accuracyM;
/// Android reports positions from location-faking apps.
@override final  bool isMocked;

/// Create a copy of GpsReading
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GpsReadingCopyWith<_GpsReading> get copyWith => __$GpsReadingCopyWithImpl<_GpsReading>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _GpsReading&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.accuracyM, accuracyM) || other.accuracyM == accuracyM)&&(identical(other.isMocked, isMocked) || other.isMocked == isMocked));
}


@override
int get hashCode {
    return Object.hash(runtimeType,latitude,longitude,accuracyM,isMocked);
}

@override
String toString() {
    return 'GpsReading(latitude: $latitude, longitude: $longitude, accuracyM: $accuracyM, isMocked: $isMocked)';
}


}

/// @nodoc
abstract mixin class _$GpsReadingCopyWith<$Res> implements $GpsReadingCopyWith<$Res> {
  factory _$GpsReadingCopyWith(_GpsReading value, $Res Function(_GpsReading) _then) = __$GpsReadingCopyWithImpl;
@override @useResult
$Res call({
 double latitude, double longitude, double accuracyM, bool isMocked
});




}
/// @nodoc
class __$GpsReadingCopyWithImpl<$Res>
    implements _$GpsReadingCopyWith<$Res> {
  __$GpsReadingCopyWithImpl(this._self, this._then);

  final _GpsReading _self;
  final $Res Function(_GpsReading) _then;

/// Create a copy of GpsReading
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? latitude = null,Object? longitude = null,Object? accuracyM = null,Object? isMocked = null,}) {
  return _then(_GpsReading(
latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,accuracyM: null == accuracyM ? _self.accuracyM : accuracyM // ignore: cast_nullable_to_non_nullable
as double,isMocked: null == isMocked ? _self.isMocked : isMocked // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
