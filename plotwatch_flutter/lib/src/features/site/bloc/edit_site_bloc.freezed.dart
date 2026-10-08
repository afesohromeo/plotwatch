// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'edit_site_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EditSiteEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is EditSiteEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'EditSiteEvent()';
}


}

/// @nodoc
class $EditSiteEventCopyWith<$Res>  {
$EditSiteEventCopyWith(EditSiteEvent _, $Res Function(EditSiteEvent) __);
}


/// Adds pattern-matching-related methods to [EditSiteEvent].
extension EditSiteEventPatterns on EditSiteEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Load value)?  load,TResult Function( _RadiusChanged value)?  radiusChanged,TResult Function( _SaveRequested value)?  saveRequested,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Load() when load != null:
return load(_that);case _RadiusChanged() when radiusChanged != null:
return radiusChanged(_that);case _SaveRequested() when saveRequested != null:
return saveRequested(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Load value)  load,required TResult Function( _RadiusChanged value)  radiusChanged,required TResult Function( _SaveRequested value)  saveRequested,}){
final _that = this;
switch (_that) {
case _Load():
return load(_that);case _RadiusChanged():
return radiusChanged(_that);case _SaveRequested():
return saveRequested(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Load value)?  load,TResult? Function( _RadiusChanged value)?  radiusChanged,TResult? Function( _SaveRequested value)?  saveRequested,}){
final _that = this;
switch (_that) {
case _Load() when load != null:
return load(_that);case _RadiusChanged() when radiusChanged != null:
return radiusChanged(_that);case _SaveRequested() when saveRequested != null:
return saveRequested(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int projectId)?  load,TResult Function( int radiusM)?  radiusChanged,TResult Function( String? addressText)?  saveRequested,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Load() when load != null:
return load(_that.projectId);case _RadiusChanged() when radiusChanged != null:
return radiusChanged(_that.radiusM);case _SaveRequested() when saveRequested != null:
return saveRequested(_that.addressText);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int projectId)  load,required TResult Function( int radiusM)  radiusChanged,required TResult Function( String? addressText)  saveRequested,}) {final _that = this;
switch (_that) {
case _Load():
return load(_that.projectId);case _RadiusChanged():
return radiusChanged(_that.radiusM);case _SaveRequested():
return saveRequested(_that.addressText);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int projectId)?  load,TResult? Function( int radiusM)?  radiusChanged,TResult? Function( String? addressText)?  saveRequested,}) {final _that = this;
switch (_that) {
case _Load() when load != null:
return load(_that.projectId);case _RadiusChanged() when radiusChanged != null:
return radiusChanged(_that.radiusM);case _SaveRequested() when saveRequested != null:
return saveRequested(_that.addressText);case _:
  return null;

}
}

}

/// @nodoc


class _Load implements EditSiteEvent {
  const _Load({required this.projectId});
  

 final  int projectId;

/// Create a copy of EditSiteEvent
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
    return 'EditSiteEvent.load(projectId: $projectId)';
}


}

/// @nodoc
abstract mixin class _$LoadCopyWith<$Res> implements $EditSiteEventCopyWith<$Res> {
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

/// Create a copy of EditSiteEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? projectId = null,}) {
  return _then(_Load(
projectId: null == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _RadiusChanged implements EditSiteEvent {
  const _RadiusChanged({required this.radiusM});
  

 final  int radiusM;

/// Create a copy of EditSiteEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RadiusChangedCopyWith<_RadiusChanged> get copyWith => __$RadiusChangedCopyWithImpl<_RadiusChanged>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RadiusChanged&&(identical(other.radiusM, radiusM) || other.radiusM == radiusM));
}


@override
int get hashCode {
    return Object.hash(runtimeType,radiusM);
}

@override
String toString() {
    return 'EditSiteEvent.radiusChanged(radiusM: $radiusM)';
}


}

/// @nodoc
abstract mixin class _$RadiusChangedCopyWith<$Res> implements $EditSiteEventCopyWith<$Res> {
  factory _$RadiusChangedCopyWith(_RadiusChanged value, $Res Function(_RadiusChanged) _then) = __$RadiusChangedCopyWithImpl;
@useResult
$Res call({
 int radiusM
});




}
/// @nodoc
class __$RadiusChangedCopyWithImpl<$Res>
    implements _$RadiusChangedCopyWith<$Res> {
  __$RadiusChangedCopyWithImpl(this._self, this._then);

  final _RadiusChanged _self;
  final $Res Function(_RadiusChanged) _then;

/// Create a copy of EditSiteEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? radiusM = null,}) {
  return _then(_RadiusChanged(
radiusM: null == radiusM ? _self.radiusM : radiusM // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _SaveRequested implements EditSiteEvent {
  const _SaveRequested({this.addressText});
  

 final  String? addressText;

/// Create a copy of EditSiteEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SaveRequestedCopyWith<_SaveRequested> get copyWith => __$SaveRequestedCopyWithImpl<_SaveRequested>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SaveRequested&&(identical(other.addressText, addressText) || other.addressText == addressText));
}


@override
int get hashCode {
    return Object.hash(runtimeType,addressText);
}

@override
String toString() {
    return 'EditSiteEvent.saveRequested(addressText: $addressText)';
}


}

/// @nodoc
abstract mixin class _$SaveRequestedCopyWith<$Res> implements $EditSiteEventCopyWith<$Res> {
  factory _$SaveRequestedCopyWith(_SaveRequested value, $Res Function(_SaveRequested) _then) = __$SaveRequestedCopyWithImpl;
@useResult
$Res call({
 String? addressText
});




}
/// @nodoc
class __$SaveRequestedCopyWithImpl<$Res>
    implements _$SaveRequestedCopyWith<$Res> {
  __$SaveRequestedCopyWithImpl(this._self, this._then);

  final _SaveRequested _self;
  final $Res Function(_SaveRequested) _then;

/// Create a copy of EditSiteEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? addressText = freezed,}) {
  return _then(_SaveRequested(
addressText: freezed == addressText ? _self.addressText : addressText // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$EditSiteState {

 int? get projectId;/// The validated site; null until loaded.
 Site? get site; int get radiusM; GenericStatus get loadStatus; String? get loadErrorMessage; GenericStatus get actionStatus; String? get actionErrorMessage;
/// Create a copy of EditSiteState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EditSiteStateCopyWith<EditSiteState> get copyWith => _$EditSiteStateCopyWithImpl<EditSiteState>(this as EditSiteState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as EditSiteState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EditSiteState&&(identical(other.projectId, _this.projectId) || other.projectId == _this.projectId)&&(identical(other.site, _this.site) || other.site == _this.site)&&(identical(other.radiusM, _this.radiusM) || other.radiusM == _this.radiusM)&&(identical(other.loadStatus, _this.loadStatus) || other.loadStatus == _this.loadStatus)&&(identical(other.loadErrorMessage, _this.loadErrorMessage) || other.loadErrorMessage == _this.loadErrorMessage)&&(identical(other.actionStatus, _this.actionStatus) || other.actionStatus == _this.actionStatus)&&(identical(other.actionErrorMessage, _this.actionErrorMessage) || other.actionErrorMessage == _this.actionErrorMessage));
}


@override
int get hashCode {
  final _this = this as EditSiteState;
  return Object.hash(runtimeType,_this.projectId,_this.site,_this.radiusM,_this.loadStatus,_this.loadErrorMessage,_this.actionStatus,_this.actionErrorMessage);
}

@override
String toString() {
  final _this = this as EditSiteState;
  return 'EditSiteState(projectId: ${_this.projectId}, site: ${_this.site}, radiusM: ${_this.radiusM}, loadStatus: ${_this.loadStatus}, loadErrorMessage: ${_this.loadErrorMessage}, actionStatus: ${_this.actionStatus}, actionErrorMessage: ${_this.actionErrorMessage})';
}


}

/// @nodoc
abstract mixin class $EditSiteStateCopyWith<$Res>  {
  factory $EditSiteStateCopyWith(EditSiteState value, $Res Function(EditSiteState) _then) = _$EditSiteStateCopyWithImpl;
@useResult
$Res call({
 int? projectId, Site? site, int radiusM, GenericStatus loadStatus, String? loadErrorMessage, GenericStatus actionStatus, String? actionErrorMessage
});




}
/// @nodoc
class _$EditSiteStateCopyWithImpl<$Res>
    implements $EditSiteStateCopyWith<$Res> {
  _$EditSiteStateCopyWithImpl(this._self, this._then);

  final EditSiteState _self;
  final $Res Function(EditSiteState) _then;

/// Create a copy of EditSiteState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? projectId = freezed,Object? site = freezed,Object? radiusM = null,Object? loadStatus = null,Object? loadErrorMessage = freezed,Object? actionStatus = null,Object? actionErrorMessage = freezed,}) {
  return _then(EditSiteState(
projectId: freezed == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as int?,site: freezed == site ? _self.site : site // ignore: cast_nullable_to_non_nullable
as Site?,radiusM: null == radiusM ? _self.radiusM : radiusM // ignore: cast_nullable_to_non_nullable
as int,loadStatus: null == loadStatus ? _self.loadStatus : loadStatus // ignore: cast_nullable_to_non_nullable
as GenericStatus,loadErrorMessage: freezed == loadErrorMessage ? _self.loadErrorMessage : loadErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,actionStatus: null == actionStatus ? _self.actionStatus : actionStatus // ignore: cast_nullable_to_non_nullable
as GenericStatus,actionErrorMessage: freezed == actionErrorMessage ? _self.actionErrorMessage : actionErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [EditSiteState].
extension EditSiteStatePatterns on EditSiteState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EditSiteState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EditSiteState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EditSiteState value)  $default,){
final _that = this;
switch (_that) {
case _EditSiteState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EditSiteState value)?  $default,){
final _that = this;
switch (_that) {
case _EditSiteState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? projectId,  Site? site,  int radiusM,  GenericStatus loadStatus,  String? loadErrorMessage,  GenericStatus actionStatus,  String? actionErrorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EditSiteState() when $default != null:
return $default(_that.projectId,_that.site,_that.radiusM,_that.loadStatus,_that.loadErrorMessage,_that.actionStatus,_that.actionErrorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? projectId,  Site? site,  int radiusM,  GenericStatus loadStatus,  String? loadErrorMessage,  GenericStatus actionStatus,  String? actionErrorMessage)  $default,) {final _that = this;
switch (_that) {
case _EditSiteState():
return $default(_that.projectId,_that.site,_that.radiusM,_that.loadStatus,_that.loadErrorMessage,_that.actionStatus,_that.actionErrorMessage);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? projectId,  Site? site,  int radiusM,  GenericStatus loadStatus,  String? loadErrorMessage,  GenericStatus actionStatus,  String? actionErrorMessage)?  $default,) {final _that = this;
switch (_that) {
case _EditSiteState() when $default != null:
return $default(_that.projectId,_that.site,_that.radiusM,_that.loadStatus,_that.loadErrorMessage,_that.actionStatus,_that.actionErrorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _EditSiteState implements EditSiteState {
  const _EditSiteState({this.projectId, this.site, this.radiusM = defaultSiteRadiusM, this.loadStatus = GenericStatus.initial, this.loadErrorMessage, this.actionStatus = GenericStatus.initial, this.actionErrorMessage});
  

@override final  int? projectId;
/// The validated site; null until loaded.
@override final  Site? site;
@override@JsonKey() final  int radiusM;
@override@JsonKey() final  GenericStatus loadStatus;
@override final  String? loadErrorMessage;
@override@JsonKey() final  GenericStatus actionStatus;
@override final  String? actionErrorMessage;

/// Create a copy of EditSiteState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EditSiteStateCopyWith<_EditSiteState> get copyWith => __$EditSiteStateCopyWithImpl<_EditSiteState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _EditSiteState&&(identical(other.projectId, projectId) || other.projectId == projectId)&&(identical(other.site, site) || other.site == site)&&(identical(other.radiusM, radiusM) || other.radiusM == radiusM)&&(identical(other.loadStatus, loadStatus) || other.loadStatus == loadStatus)&&(identical(other.loadErrorMessage, loadErrorMessage) || other.loadErrorMessage == loadErrorMessage)&&(identical(other.actionStatus, actionStatus) || other.actionStatus == actionStatus)&&(identical(other.actionErrorMessage, actionErrorMessage) || other.actionErrorMessage == actionErrorMessage));
}


@override
int get hashCode {
    return Object.hash(runtimeType,projectId,site,radiusM,loadStatus,loadErrorMessage,actionStatus,actionErrorMessage);
}

@override
String toString() {
    return 'EditSiteState(projectId: $projectId, site: $site, radiusM: $radiusM, loadStatus: $loadStatus, loadErrorMessage: $loadErrorMessage, actionStatus: $actionStatus, actionErrorMessage: $actionErrorMessage)';
}


}

/// @nodoc
abstract mixin class _$EditSiteStateCopyWith<$Res> implements $EditSiteStateCopyWith<$Res> {
  factory _$EditSiteStateCopyWith(_EditSiteState value, $Res Function(_EditSiteState) _then) = __$EditSiteStateCopyWithImpl;
@override @useResult
$Res call({
 int? projectId, Site? site, int radiusM, GenericStatus loadStatus, String? loadErrorMessage, GenericStatus actionStatus, String? actionErrorMessage
});




}
/// @nodoc
class __$EditSiteStateCopyWithImpl<$Res>
    implements _$EditSiteStateCopyWith<$Res> {
  __$EditSiteStateCopyWithImpl(this._self, this._then);

  final _EditSiteState _self;
  final $Res Function(_EditSiteState) _then;

/// Create a copy of EditSiteState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? projectId = freezed,Object? site = freezed,Object? radiusM = null,Object? loadStatus = null,Object? loadErrorMessage = freezed,Object? actionStatus = null,Object? actionErrorMessage = freezed,}) {
  return _then(_EditSiteState(
projectId: freezed == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as int?,site: freezed == site ? _self.site : site // ignore: cast_nullable_to_non_nullable
as Site?,radiusM: null == radiusM ? _self.radiusM : radiusM // ignore: cast_nullable_to_non_nullable
as int,loadStatus: null == loadStatus ? _self.loadStatus : loadStatus // ignore: cast_nullable_to_non_nullable
as GenericStatus,loadErrorMessage: freezed == loadErrorMessage ? _self.loadErrorMessage : loadErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,actionStatus: null == actionStatus ? _self.actionStatus : actionStatus // ignore: cast_nullable_to_non_nullable
as GenericStatus,actionErrorMessage: freezed == actionErrorMessage ? _self.actionErrorMessage : actionErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
