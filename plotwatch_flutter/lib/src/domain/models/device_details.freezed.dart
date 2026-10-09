// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'device_details.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DeviceDetails {

/// E.g. "Google Pixel 7".
 String get model;/// E.g. "Android 15".
 String get osVersion;/// E.g. "1.0.0+1".
 String get appVersion;
/// Create a copy of DeviceDetails
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeviceDetailsCopyWith<DeviceDetails> get copyWith => _$DeviceDetailsCopyWithImpl<DeviceDetails>(this as DeviceDetails, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as DeviceDetails;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeviceDetails&&(identical(other.model, _this.model) || other.model == _this.model)&&(identical(other.osVersion, _this.osVersion) || other.osVersion == _this.osVersion)&&(identical(other.appVersion, _this.appVersion) || other.appVersion == _this.appVersion));
}


@override
int get hashCode {
  final _this = this as DeviceDetails;
  return Object.hash(runtimeType,_this.model,_this.osVersion,_this.appVersion);
}

@override
String toString() {
  final _this = this as DeviceDetails;
  return 'DeviceDetails(model: ${_this.model}, osVersion: ${_this.osVersion}, appVersion: ${_this.appVersion})';
}


}

/// @nodoc
abstract mixin class $DeviceDetailsCopyWith<$Res>  {
  factory $DeviceDetailsCopyWith(DeviceDetails value, $Res Function(DeviceDetails) _then) = _$DeviceDetailsCopyWithImpl;
@useResult
$Res call({
 String model, String osVersion, String appVersion
});




}
/// @nodoc
class _$DeviceDetailsCopyWithImpl<$Res>
    implements $DeviceDetailsCopyWith<$Res> {
  _$DeviceDetailsCopyWithImpl(this._self, this._then);

  final DeviceDetails _self;
  final $Res Function(DeviceDetails) _then;

/// Create a copy of DeviceDetails
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? model = null,Object? osVersion = null,Object? appVersion = null,}) {
  return _then(DeviceDetails(
model: null == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String,osVersion: null == osVersion ? _self.osVersion : osVersion // ignore: cast_nullable_to_non_nullable
as String,appVersion: null == appVersion ? _self.appVersion : appVersion // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [DeviceDetails].
extension DeviceDetailsPatterns on DeviceDetails {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DeviceDetails value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DeviceDetails() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DeviceDetails value)  $default,){
final _that = this;
switch (_that) {
case _DeviceDetails():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DeviceDetails value)?  $default,){
final _that = this;
switch (_that) {
case _DeviceDetails() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String model,  String osVersion,  String appVersion)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeviceDetails() when $default != null:
return $default(_that.model,_that.osVersion,_that.appVersion);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String model,  String osVersion,  String appVersion)  $default,) {final _that = this;
switch (_that) {
case _DeviceDetails():
return $default(_that.model,_that.osVersion,_that.appVersion);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String model,  String osVersion,  String appVersion)?  $default,) {final _that = this;
switch (_that) {
case _DeviceDetails() when $default != null:
return $default(_that.model,_that.osVersion,_that.appVersion);case _:
  return null;

}
}

}

/// @nodoc


class _DeviceDetails implements DeviceDetails {
  const _DeviceDetails({required this.model, required this.osVersion, required this.appVersion});
  

/// E.g. "Google Pixel 7".
@override final  String model;
/// E.g. "Android 15".
@override final  String osVersion;
/// E.g. "1.0.0+1".
@override final  String appVersion;

/// Create a copy of DeviceDetails
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeviceDetailsCopyWith<_DeviceDetails> get copyWith => __$DeviceDetailsCopyWithImpl<_DeviceDetails>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeviceDetails&&(identical(other.model, model) || other.model == model)&&(identical(other.osVersion, osVersion) || other.osVersion == osVersion)&&(identical(other.appVersion, appVersion) || other.appVersion == appVersion));
}


@override
int get hashCode {
    return Object.hash(runtimeType,model,osVersion,appVersion);
}

@override
String toString() {
    return 'DeviceDetails(model: $model, osVersion: $osVersion, appVersion: $appVersion)';
}


}

/// @nodoc
abstract mixin class _$DeviceDetailsCopyWith<$Res> implements $DeviceDetailsCopyWith<$Res> {
  factory _$DeviceDetailsCopyWith(_DeviceDetails value, $Res Function(_DeviceDetails) _then) = __$DeviceDetailsCopyWithImpl;
@override @useResult
$Res call({
 String model, String osVersion, String appVersion
});




}
/// @nodoc
class __$DeviceDetailsCopyWithImpl<$Res>
    implements _$DeviceDetailsCopyWith<$Res> {
  __$DeviceDetailsCopyWithImpl(this._self, this._then);

  final _DeviceDetails _self;
  final $Res Function(_DeviceDetails) _then;

/// Create a copy of DeviceDetails
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? model = null,Object? osVersion = null,Object? appVersion = null,}) {
  return _then(_DeviceDetails(
model: null == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String,osVersion: null == osVersion ? _self.osVersion : osVersion // ignore: cast_nullable_to_non_nullable
as String,appVersion: null == appVersion ? _self.appVersion : appVersion // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
