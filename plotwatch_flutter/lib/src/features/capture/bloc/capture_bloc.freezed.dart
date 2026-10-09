// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'capture_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CaptureEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is CaptureEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'CaptureEvent()';
}


}

/// @nodoc
class $CaptureEventCopyWith<$Res>  {
$CaptureEventCopyWith(CaptureEvent _, $Res Function(CaptureEvent) __);
}


/// Adds pattern-matching-related methods to [CaptureEvent].
extension CaptureEventPatterns on CaptureEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _CameraSettingsRequested value)?  cameraSettingsRequested,TResult Function( _ShutterPressed value)?  shutterPressed,TResult Function( _RetakeRequested value)?  retakeRequested,TResult Function( _SendRequested value)?  sendRequested,TResult Function( _RetryRequested value)?  retryRequested,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _CameraSettingsRequested() when cameraSettingsRequested != null:
return cameraSettingsRequested(_that);case _ShutterPressed() when shutterPressed != null:
return shutterPressed(_that);case _RetakeRequested() when retakeRequested != null:
return retakeRequested(_that);case _SendRequested() when sendRequested != null:
return sendRequested(_that);case _RetryRequested() when retryRequested != null:
return retryRequested(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _CameraSettingsRequested value)  cameraSettingsRequested,required TResult Function( _ShutterPressed value)  shutterPressed,required TResult Function( _RetakeRequested value)  retakeRequested,required TResult Function( _SendRequested value)  sendRequested,required TResult Function( _RetryRequested value)  retryRequested,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _CameraSettingsRequested():
return cameraSettingsRequested(_that);case _ShutterPressed():
return shutterPressed(_that);case _RetakeRequested():
return retakeRequested(_that);case _SendRequested():
return sendRequested(_that);case _RetryRequested():
return retryRequested(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _CameraSettingsRequested value)?  cameraSettingsRequested,TResult? Function( _ShutterPressed value)?  shutterPressed,TResult? Function( _RetakeRequested value)?  retakeRequested,TResult? Function( _SendRequested value)?  sendRequested,TResult? Function( _RetryRequested value)?  retryRequested,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _CameraSettingsRequested() when cameraSettingsRequested != null:
return cameraSettingsRequested(_that);case _ShutterPressed() when shutterPressed != null:
return shutterPressed(_that);case _RetakeRequested() when retakeRequested != null:
return retakeRequested(_that);case _SendRequested() when sendRequested != null:
return sendRequested(_that);case _RetryRequested() when retryRequested != null:
return retryRequested(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int projectId,  int stageId,  int itemId)?  started,TResult Function()?  cameraSettingsRequested,TResult Function()?  shutterPressed,TResult Function()?  retakeRequested,TResult Function( String? caption)?  sendRequested,TResult Function()?  retryRequested,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that.projectId,_that.stageId,_that.itemId);case _CameraSettingsRequested() when cameraSettingsRequested != null:
return cameraSettingsRequested();case _ShutterPressed() when shutterPressed != null:
return shutterPressed();case _RetakeRequested() when retakeRequested != null:
return retakeRequested();case _SendRequested() when sendRequested != null:
return sendRequested(_that.caption);case _RetryRequested() when retryRequested != null:
return retryRequested();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int projectId,  int stageId,  int itemId)  started,required TResult Function()  cameraSettingsRequested,required TResult Function()  shutterPressed,required TResult Function()  retakeRequested,required TResult Function( String? caption)  sendRequested,required TResult Function()  retryRequested,}) {final _that = this;
switch (_that) {
case _Started():
return started(_that.projectId,_that.stageId,_that.itemId);case _CameraSettingsRequested():
return cameraSettingsRequested();case _ShutterPressed():
return shutterPressed();case _RetakeRequested():
return retakeRequested();case _SendRequested():
return sendRequested(_that.caption);case _RetryRequested():
return retryRequested();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int projectId,  int stageId,  int itemId)?  started,TResult? Function()?  cameraSettingsRequested,TResult? Function()?  shutterPressed,TResult? Function()?  retakeRequested,TResult? Function( String? caption)?  sendRequested,TResult? Function()?  retryRequested,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that.projectId,_that.stageId,_that.itemId);case _CameraSettingsRequested() when cameraSettingsRequested != null:
return cameraSettingsRequested();case _ShutterPressed() when shutterPressed != null:
return shutterPressed();case _RetakeRequested() when retakeRequested != null:
return retakeRequested();case _SendRequested() when sendRequested != null:
return sendRequested(_that.caption);case _RetryRequested() when retryRequested != null:
return retryRequested();case _:
  return null;

}
}

}

/// @nodoc


class _Started implements CaptureEvent {
  const _Started({required this.projectId, required this.stageId, required this.itemId});
  

 final  int projectId;
 final  int stageId;
 final  int itemId;

/// Create a copy of CaptureEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StartedCopyWith<_Started> get copyWith => __$StartedCopyWithImpl<_Started>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started&&(identical(other.projectId, projectId) || other.projectId == projectId)&&(identical(other.stageId, stageId) || other.stageId == stageId)&&(identical(other.itemId, itemId) || other.itemId == itemId));
}


@override
int get hashCode {
    return Object.hash(runtimeType,projectId,stageId,itemId);
}

@override
String toString() {
    return 'CaptureEvent.started(projectId: $projectId, stageId: $stageId, itemId: $itemId)';
}


}

/// @nodoc
abstract mixin class _$StartedCopyWith<$Res> implements $CaptureEventCopyWith<$Res> {
  factory _$StartedCopyWith(_Started value, $Res Function(_Started) _then) = __$StartedCopyWithImpl;
@useResult
$Res call({
 int projectId, int stageId, int itemId
});




}
/// @nodoc
class __$StartedCopyWithImpl<$Res>
    implements _$StartedCopyWith<$Res> {
  __$StartedCopyWithImpl(this._self, this._then);

  final _Started _self;
  final $Res Function(_Started) _then;

/// Create a copy of CaptureEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? projectId = null,Object? stageId = null,Object? itemId = null,}) {
  return _then(_Started(
projectId: null == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as int,stageId: null == stageId ? _self.stageId : stageId // ignore: cast_nullable_to_non_nullable
as int,itemId: null == itemId ? _self.itemId : itemId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _CameraSettingsRequested implements CaptureEvent {
  const _CameraSettingsRequested();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CameraSettingsRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'CaptureEvent.cameraSettingsRequested()';
}


}




/// @nodoc


class _ShutterPressed implements CaptureEvent {
  const _ShutterPressed();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShutterPressed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'CaptureEvent.shutterPressed()';
}


}




/// @nodoc


class _RetakeRequested implements CaptureEvent {
  const _RetakeRequested();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RetakeRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'CaptureEvent.retakeRequested()';
}


}




/// @nodoc


class _SendRequested implements CaptureEvent {
  const _SendRequested({this.caption});
  

 final  String? caption;

/// Create a copy of CaptureEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SendRequestedCopyWith<_SendRequested> get copyWith => __$SendRequestedCopyWithImpl<_SendRequested>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SendRequested&&(identical(other.caption, caption) || other.caption == caption));
}


@override
int get hashCode {
    return Object.hash(runtimeType,caption);
}

@override
String toString() {
    return 'CaptureEvent.sendRequested(caption: $caption)';
}


}

/// @nodoc
abstract mixin class _$SendRequestedCopyWith<$Res> implements $CaptureEventCopyWith<$Res> {
  factory _$SendRequestedCopyWith(_SendRequested value, $Res Function(_SendRequested) _then) = __$SendRequestedCopyWithImpl;
@useResult
$Res call({
 String? caption
});




}
/// @nodoc
class __$SendRequestedCopyWithImpl<$Res>
    implements _$SendRequestedCopyWith<$Res> {
  __$SendRequestedCopyWithImpl(this._self, this._then);

  final _SendRequested _self;
  final $Res Function(_SendRequested) _then;

/// Create a copy of CaptureEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? caption = freezed,}) {
  return _then(_SendRequested(
caption: freezed == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _RetryRequested implements CaptureEvent {
  const _RetryRequested();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RetryRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'CaptureEvent.retryRequested()';
}


}




/// @nodoc
mixin _$CaptureState {

 int? get projectId; int? get stageId; int? get itemId; String? get itemLabel;/// The validated site, for the inside-site indicator.
 Site? get site; DeviceDetails? get device; GenericStatus get loadStatus; String? get loadErrorMessage;/// Null while checking.
 CameraAccess? get cameraAccess; LocationAccess? get locationAccess;/// The latest GPS reading; null without a fix.
 GpsReading? get reading; CaptureStep get step;/// The photo exactly as the camera wrote it (decision M4-2).
 Uint8List? get photo; DateTime? get takenAt;/// The position when the shutter was pressed.
 GpsReading? get shotReading; String? get caption; SendStep get sendStep; GenericStatus get sendStatus; String? get sendErrorMessage;/// Kept so a retry doesn't commit twice.
 EvidenceCommitResult? get committed; bool get uploaded;/// An upload failed once: the next one gets a new description.
 bool get uploadFailed;/// The capture as the server checked it.
 Evidence? get evidence;
/// Create a copy of CaptureState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CaptureStateCopyWith<CaptureState> get copyWith => _$CaptureStateCopyWithImpl<CaptureState>(this as CaptureState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as CaptureState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CaptureState&&(identical(other.projectId, _this.projectId) || other.projectId == _this.projectId)&&(identical(other.stageId, _this.stageId) || other.stageId == _this.stageId)&&(identical(other.itemId, _this.itemId) || other.itemId == _this.itemId)&&(identical(other.itemLabel, _this.itemLabel) || other.itemLabel == _this.itemLabel)&&(identical(other.site, _this.site) || other.site == _this.site)&&(identical(other.device, _this.device) || other.device == _this.device)&&(identical(other.loadStatus, _this.loadStatus) || other.loadStatus == _this.loadStatus)&&(identical(other.loadErrorMessage, _this.loadErrorMessage) || other.loadErrorMessage == _this.loadErrorMessage)&&(identical(other.cameraAccess, _this.cameraAccess) || other.cameraAccess == _this.cameraAccess)&&(identical(other.locationAccess, _this.locationAccess) || other.locationAccess == _this.locationAccess)&&(identical(other.reading, _this.reading) || other.reading == _this.reading)&&(identical(other.step, _this.step) || other.step == _this.step)&&const DeepCollectionEquality().equals(other.photo, _this.photo)&&(identical(other.takenAt, _this.takenAt) || other.takenAt == _this.takenAt)&&(identical(other.shotReading, _this.shotReading) || other.shotReading == _this.shotReading)&&(identical(other.caption, _this.caption) || other.caption == _this.caption)&&(identical(other.sendStep, _this.sendStep) || other.sendStep == _this.sendStep)&&(identical(other.sendStatus, _this.sendStatus) || other.sendStatus == _this.sendStatus)&&(identical(other.sendErrorMessage, _this.sendErrorMessage) || other.sendErrorMessage == _this.sendErrorMessage)&&(identical(other.committed, _this.committed) || other.committed == _this.committed)&&(identical(other.uploaded, _this.uploaded) || other.uploaded == _this.uploaded)&&(identical(other.uploadFailed, _this.uploadFailed) || other.uploadFailed == _this.uploadFailed)&&(identical(other.evidence, _this.evidence) || other.evidence == _this.evidence));
}


@override
int get hashCode {
  final _this = this as CaptureState;
  return Object.hashAll([runtimeType,_this.projectId,_this.stageId,_this.itemId,_this.itemLabel,_this.site,_this.device,_this.loadStatus,_this.loadErrorMessage,_this.cameraAccess,_this.locationAccess,_this.reading,_this.step,const DeepCollectionEquality().hash(_this.photo),_this.takenAt,_this.shotReading,_this.caption,_this.sendStep,_this.sendStatus,_this.sendErrorMessage,_this.committed,_this.uploaded,_this.uploadFailed,_this.evidence]);
}

@override
String toString() {
  final _this = this as CaptureState;
  return 'CaptureState(projectId: ${_this.projectId}, stageId: ${_this.stageId}, itemId: ${_this.itemId}, itemLabel: ${_this.itemLabel}, site: ${_this.site}, device: ${_this.device}, loadStatus: ${_this.loadStatus}, loadErrorMessage: ${_this.loadErrorMessage}, cameraAccess: ${_this.cameraAccess}, locationAccess: ${_this.locationAccess}, reading: ${_this.reading}, step: ${_this.step}, photo: ${_this.photo}, takenAt: ${_this.takenAt}, shotReading: ${_this.shotReading}, caption: ${_this.caption}, sendStep: ${_this.sendStep}, sendStatus: ${_this.sendStatus}, sendErrorMessage: ${_this.sendErrorMessage}, committed: ${_this.committed}, uploaded: ${_this.uploaded}, uploadFailed: ${_this.uploadFailed}, evidence: ${_this.evidence})';
}


}

/// @nodoc
abstract mixin class $CaptureStateCopyWith<$Res>  {
  factory $CaptureStateCopyWith(CaptureState value, $Res Function(CaptureState) _then) = _$CaptureStateCopyWithImpl;
@useResult
$Res call({
 int? projectId, int? stageId, int? itemId, String? itemLabel, Site? site, DeviceDetails? device, GenericStatus loadStatus, String? loadErrorMessage, CameraAccess? cameraAccess, LocationAccess? locationAccess, GpsReading? reading, CaptureStep step, Uint8List? photo, DateTime? takenAt, GpsReading? shotReading, String? caption, SendStep sendStep, GenericStatus sendStatus, String? sendErrorMessage, EvidenceCommitResult? committed, bool uploaded, bool uploadFailed, Evidence? evidence
});


$DeviceDetailsCopyWith<$Res>? get device;$GpsReadingCopyWith<$Res>? get reading;$GpsReadingCopyWith<$Res>? get shotReading;

}
/// @nodoc
class _$CaptureStateCopyWithImpl<$Res>
    implements $CaptureStateCopyWith<$Res> {
  _$CaptureStateCopyWithImpl(this._self, this._then);

  final CaptureState _self;
  final $Res Function(CaptureState) _then;

/// Create a copy of CaptureState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? projectId = freezed,Object? stageId = freezed,Object? itemId = freezed,Object? itemLabel = freezed,Object? site = freezed,Object? device = freezed,Object? loadStatus = null,Object? loadErrorMessage = freezed,Object? cameraAccess = freezed,Object? locationAccess = freezed,Object? reading = freezed,Object? step = null,Object? photo = freezed,Object? takenAt = freezed,Object? shotReading = freezed,Object? caption = freezed,Object? sendStep = null,Object? sendStatus = null,Object? sendErrorMessage = freezed,Object? committed = freezed,Object? uploaded = null,Object? uploadFailed = null,Object? evidence = freezed,}) {
  return _then(CaptureState(
projectId: freezed == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as int?,stageId: freezed == stageId ? _self.stageId : stageId // ignore: cast_nullable_to_non_nullable
as int?,itemId: freezed == itemId ? _self.itemId : itemId // ignore: cast_nullable_to_non_nullable
as int?,itemLabel: freezed == itemLabel ? _self.itemLabel : itemLabel // ignore: cast_nullable_to_non_nullable
as String?,site: freezed == site ? _self.site : site // ignore: cast_nullable_to_non_nullable
as Site?,device: freezed == device ? _self.device : device // ignore: cast_nullable_to_non_nullable
as DeviceDetails?,loadStatus: null == loadStatus ? _self.loadStatus : loadStatus // ignore: cast_nullable_to_non_nullable
as GenericStatus,loadErrorMessage: freezed == loadErrorMessage ? _self.loadErrorMessage : loadErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,cameraAccess: freezed == cameraAccess ? _self.cameraAccess : cameraAccess // ignore: cast_nullable_to_non_nullable
as CameraAccess?,locationAccess: freezed == locationAccess ? _self.locationAccess : locationAccess // ignore: cast_nullable_to_non_nullable
as LocationAccess?,reading: freezed == reading ? _self.reading : reading // ignore: cast_nullable_to_non_nullable
as GpsReading?,step: null == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as CaptureStep,photo: freezed == photo ? _self.photo : photo // ignore: cast_nullable_to_non_nullable
as Uint8List?,takenAt: freezed == takenAt ? _self.takenAt : takenAt // ignore: cast_nullable_to_non_nullable
as DateTime?,shotReading: freezed == shotReading ? _self.shotReading : shotReading // ignore: cast_nullable_to_non_nullable
as GpsReading?,caption: freezed == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String?,sendStep: null == sendStep ? _self.sendStep : sendStep // ignore: cast_nullable_to_non_nullable
as SendStep,sendStatus: null == sendStatus ? _self.sendStatus : sendStatus // ignore: cast_nullable_to_non_nullable
as GenericStatus,sendErrorMessage: freezed == sendErrorMessage ? _self.sendErrorMessage : sendErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,committed: freezed == committed ? _self.committed : committed // ignore: cast_nullable_to_non_nullable
as EvidenceCommitResult?,uploaded: null == uploaded ? _self.uploaded : uploaded // ignore: cast_nullable_to_non_nullable
as bool,uploadFailed: null == uploadFailed ? _self.uploadFailed : uploadFailed // ignore: cast_nullable_to_non_nullable
as bool,evidence: freezed == evidence ? _self.evidence : evidence // ignore: cast_nullable_to_non_nullable
as Evidence?,
  ));
}
/// Create a copy of CaptureState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DeviceDetailsCopyWith<$Res>? get device {
    if (_self.device == null) {
    return null;
  }

  return $DeviceDetailsCopyWith<$Res>(_self.device!, (value) {
    return _then(_self.copyWith(device: value));
  });
}/// Create a copy of CaptureState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GpsReadingCopyWith<$Res>? get reading {
    if (_self.reading == null) {
    return null;
  }

  return $GpsReadingCopyWith<$Res>(_self.reading!, (value) {
    return _then(_self.copyWith(reading: value));
  });
}/// Create a copy of CaptureState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GpsReadingCopyWith<$Res>? get shotReading {
    if (_self.shotReading == null) {
    return null;
  }

  return $GpsReadingCopyWith<$Res>(_self.shotReading!, (value) {
    return _then(_self.copyWith(shotReading: value));
  });
}
}


/// Adds pattern-matching-related methods to [CaptureState].
extension CaptureStatePatterns on CaptureState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CaptureState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CaptureState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CaptureState value)  $default,){
final _that = this;
switch (_that) {
case _CaptureState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CaptureState value)?  $default,){
final _that = this;
switch (_that) {
case _CaptureState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? projectId,  int? stageId,  int? itemId,  String? itemLabel,  Site? site,  DeviceDetails? device,  GenericStatus loadStatus,  String? loadErrorMessage,  CameraAccess? cameraAccess,  LocationAccess? locationAccess,  GpsReading? reading,  CaptureStep step,  Uint8List? photo,  DateTime? takenAt,  GpsReading? shotReading,  String? caption,  SendStep sendStep,  GenericStatus sendStatus,  String? sendErrorMessage,  EvidenceCommitResult? committed,  bool uploaded,  bool uploadFailed,  Evidence? evidence)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CaptureState() when $default != null:
return $default(_that.projectId,_that.stageId,_that.itemId,_that.itemLabel,_that.site,_that.device,_that.loadStatus,_that.loadErrorMessage,_that.cameraAccess,_that.locationAccess,_that.reading,_that.step,_that.photo,_that.takenAt,_that.shotReading,_that.caption,_that.sendStep,_that.sendStatus,_that.sendErrorMessage,_that.committed,_that.uploaded,_that.uploadFailed,_that.evidence);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? projectId,  int? stageId,  int? itemId,  String? itemLabel,  Site? site,  DeviceDetails? device,  GenericStatus loadStatus,  String? loadErrorMessage,  CameraAccess? cameraAccess,  LocationAccess? locationAccess,  GpsReading? reading,  CaptureStep step,  Uint8List? photo,  DateTime? takenAt,  GpsReading? shotReading,  String? caption,  SendStep sendStep,  GenericStatus sendStatus,  String? sendErrorMessage,  EvidenceCommitResult? committed,  bool uploaded,  bool uploadFailed,  Evidence? evidence)  $default,) {final _that = this;
switch (_that) {
case _CaptureState():
return $default(_that.projectId,_that.stageId,_that.itemId,_that.itemLabel,_that.site,_that.device,_that.loadStatus,_that.loadErrorMessage,_that.cameraAccess,_that.locationAccess,_that.reading,_that.step,_that.photo,_that.takenAt,_that.shotReading,_that.caption,_that.sendStep,_that.sendStatus,_that.sendErrorMessage,_that.committed,_that.uploaded,_that.uploadFailed,_that.evidence);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? projectId,  int? stageId,  int? itemId,  String? itemLabel,  Site? site,  DeviceDetails? device,  GenericStatus loadStatus,  String? loadErrorMessage,  CameraAccess? cameraAccess,  LocationAccess? locationAccess,  GpsReading? reading,  CaptureStep step,  Uint8List? photo,  DateTime? takenAt,  GpsReading? shotReading,  String? caption,  SendStep sendStep,  GenericStatus sendStatus,  String? sendErrorMessage,  EvidenceCommitResult? committed,  bool uploaded,  bool uploadFailed,  Evidence? evidence)?  $default,) {final _that = this;
switch (_that) {
case _CaptureState() when $default != null:
return $default(_that.projectId,_that.stageId,_that.itemId,_that.itemLabel,_that.site,_that.device,_that.loadStatus,_that.loadErrorMessage,_that.cameraAccess,_that.locationAccess,_that.reading,_that.step,_that.photo,_that.takenAt,_that.shotReading,_that.caption,_that.sendStep,_that.sendStatus,_that.sendErrorMessage,_that.committed,_that.uploaded,_that.uploadFailed,_that.evidence);case _:
  return null;

}
}

}

/// @nodoc


class _CaptureState extends CaptureState {
  const _CaptureState({this.projectId, this.stageId, this.itemId, this.itemLabel, this.site, this.device, this.loadStatus = GenericStatus.initial, this.loadErrorMessage, this.cameraAccess, this.locationAccess, this.reading, this.step = CaptureStep.camera, this.photo, this.takenAt, this.shotReading, this.caption, this.sendStep = SendStep.committing, this.sendStatus = GenericStatus.initial, this.sendErrorMessage, this.committed, this.uploaded = false, this.uploadFailed = false, this.evidence}): super._();
  

@override final  int? projectId;
@override final  int? stageId;
@override final  int? itemId;
@override final  String? itemLabel;
/// The validated site, for the inside-site indicator.
@override final  Site? site;
@override final  DeviceDetails? device;
@override@JsonKey() final  GenericStatus loadStatus;
@override final  String? loadErrorMessage;
/// Null while checking.
@override final  CameraAccess? cameraAccess;
@override final  LocationAccess? locationAccess;
/// The latest GPS reading; null without a fix.
@override final  GpsReading? reading;
@override@JsonKey() final  CaptureStep step;
/// The photo exactly as the camera wrote it (decision M4-2).
@override final  Uint8List? photo;
@override final  DateTime? takenAt;
/// The position when the shutter was pressed.
@override final  GpsReading? shotReading;
@override final  String? caption;
@override@JsonKey() final  SendStep sendStep;
@override@JsonKey() final  GenericStatus sendStatus;
@override final  String? sendErrorMessage;
/// Kept so a retry doesn't commit twice.
@override final  EvidenceCommitResult? committed;
@override@JsonKey() final  bool uploaded;
/// An upload failed once: the next one gets a new description.
@override@JsonKey() final  bool uploadFailed;
/// The capture as the server checked it.
@override final  Evidence? evidence;

/// Create a copy of CaptureState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CaptureStateCopyWith<_CaptureState> get copyWith => __$CaptureStateCopyWithImpl<_CaptureState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CaptureState&&(identical(other.projectId, projectId) || other.projectId == projectId)&&(identical(other.stageId, stageId) || other.stageId == stageId)&&(identical(other.itemId, itemId) || other.itemId == itemId)&&(identical(other.itemLabel, itemLabel) || other.itemLabel == itemLabel)&&(identical(other.site, site) || other.site == site)&&(identical(other.device, device) || other.device == device)&&(identical(other.loadStatus, loadStatus) || other.loadStatus == loadStatus)&&(identical(other.loadErrorMessage, loadErrorMessage) || other.loadErrorMessage == loadErrorMessage)&&(identical(other.cameraAccess, cameraAccess) || other.cameraAccess == cameraAccess)&&(identical(other.locationAccess, locationAccess) || other.locationAccess == locationAccess)&&(identical(other.reading, reading) || other.reading == reading)&&(identical(other.step, step) || other.step == step)&&const DeepCollectionEquality().equals(other.photo, photo)&&(identical(other.takenAt, takenAt) || other.takenAt == takenAt)&&(identical(other.shotReading, shotReading) || other.shotReading == shotReading)&&(identical(other.caption, caption) || other.caption == caption)&&(identical(other.sendStep, sendStep) || other.sendStep == sendStep)&&(identical(other.sendStatus, sendStatus) || other.sendStatus == sendStatus)&&(identical(other.sendErrorMessage, sendErrorMessage) || other.sendErrorMessage == sendErrorMessage)&&(identical(other.committed, committed) || other.committed == committed)&&(identical(other.uploaded, uploaded) || other.uploaded == uploaded)&&(identical(other.uploadFailed, uploadFailed) || other.uploadFailed == uploadFailed)&&(identical(other.evidence, evidence) || other.evidence == evidence));
}


@override
int get hashCode {
    return Object.hashAll([runtimeType,projectId,stageId,itemId,itemLabel,site,device,loadStatus,loadErrorMessage,cameraAccess,locationAccess,reading,step,const DeepCollectionEquality().hash(photo),takenAt,shotReading,caption,sendStep,sendStatus,sendErrorMessage,committed,uploaded,uploadFailed,evidence]);
}

@override
String toString() {
    return 'CaptureState(projectId: $projectId, stageId: $stageId, itemId: $itemId, itemLabel: $itemLabel, site: $site, device: $device, loadStatus: $loadStatus, loadErrorMessage: $loadErrorMessage, cameraAccess: $cameraAccess, locationAccess: $locationAccess, reading: $reading, step: $step, photo: $photo, takenAt: $takenAt, shotReading: $shotReading, caption: $caption, sendStep: $sendStep, sendStatus: $sendStatus, sendErrorMessage: $sendErrorMessage, committed: $committed, uploaded: $uploaded, uploadFailed: $uploadFailed, evidence: $evidence)';
}


}

/// @nodoc
abstract mixin class _$CaptureStateCopyWith<$Res> implements $CaptureStateCopyWith<$Res> {
  factory _$CaptureStateCopyWith(_CaptureState value, $Res Function(_CaptureState) _then) = __$CaptureStateCopyWithImpl;
@override @useResult
$Res call({
 int? projectId, int? stageId, int? itemId, String? itemLabel, Site? site, DeviceDetails? device, GenericStatus loadStatus, String? loadErrorMessage, CameraAccess? cameraAccess, LocationAccess? locationAccess, GpsReading? reading, CaptureStep step, Uint8List? photo, DateTime? takenAt, GpsReading? shotReading, String? caption, SendStep sendStep, GenericStatus sendStatus, String? sendErrorMessage, EvidenceCommitResult? committed, bool uploaded, bool uploadFailed, Evidence? evidence
});


@override $DeviceDetailsCopyWith<$Res>? get device;@override $GpsReadingCopyWith<$Res>? get reading;@override $GpsReadingCopyWith<$Res>? get shotReading;

}
/// @nodoc
class __$CaptureStateCopyWithImpl<$Res>
    implements _$CaptureStateCopyWith<$Res> {
  __$CaptureStateCopyWithImpl(this._self, this._then);

  final _CaptureState _self;
  final $Res Function(_CaptureState) _then;

/// Create a copy of CaptureState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? projectId = freezed,Object? stageId = freezed,Object? itemId = freezed,Object? itemLabel = freezed,Object? site = freezed,Object? device = freezed,Object? loadStatus = null,Object? loadErrorMessage = freezed,Object? cameraAccess = freezed,Object? locationAccess = freezed,Object? reading = freezed,Object? step = null,Object? photo = freezed,Object? takenAt = freezed,Object? shotReading = freezed,Object? caption = freezed,Object? sendStep = null,Object? sendStatus = null,Object? sendErrorMessage = freezed,Object? committed = freezed,Object? uploaded = null,Object? uploadFailed = null,Object? evidence = freezed,}) {
  return _then(_CaptureState(
projectId: freezed == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as int?,stageId: freezed == stageId ? _self.stageId : stageId // ignore: cast_nullable_to_non_nullable
as int?,itemId: freezed == itemId ? _self.itemId : itemId // ignore: cast_nullable_to_non_nullable
as int?,itemLabel: freezed == itemLabel ? _self.itemLabel : itemLabel // ignore: cast_nullable_to_non_nullable
as String?,site: freezed == site ? _self.site : site // ignore: cast_nullable_to_non_nullable
as Site?,device: freezed == device ? _self.device : device // ignore: cast_nullable_to_non_nullable
as DeviceDetails?,loadStatus: null == loadStatus ? _self.loadStatus : loadStatus // ignore: cast_nullable_to_non_nullable
as GenericStatus,loadErrorMessage: freezed == loadErrorMessage ? _self.loadErrorMessage : loadErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,cameraAccess: freezed == cameraAccess ? _self.cameraAccess : cameraAccess // ignore: cast_nullable_to_non_nullable
as CameraAccess?,locationAccess: freezed == locationAccess ? _self.locationAccess : locationAccess // ignore: cast_nullable_to_non_nullable
as LocationAccess?,reading: freezed == reading ? _self.reading : reading // ignore: cast_nullable_to_non_nullable
as GpsReading?,step: null == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as CaptureStep,photo: freezed == photo ? _self.photo : photo // ignore: cast_nullable_to_non_nullable
as Uint8List?,takenAt: freezed == takenAt ? _self.takenAt : takenAt // ignore: cast_nullable_to_non_nullable
as DateTime?,shotReading: freezed == shotReading ? _self.shotReading : shotReading // ignore: cast_nullable_to_non_nullable
as GpsReading?,caption: freezed == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String?,sendStep: null == sendStep ? _self.sendStep : sendStep // ignore: cast_nullable_to_non_nullable
as SendStep,sendStatus: null == sendStatus ? _self.sendStatus : sendStatus // ignore: cast_nullable_to_non_nullable
as GenericStatus,sendErrorMessage: freezed == sendErrorMessage ? _self.sendErrorMessage : sendErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,committed: freezed == committed ? _self.committed : committed // ignore: cast_nullable_to_non_nullable
as EvidenceCommitResult?,uploaded: null == uploaded ? _self.uploaded : uploaded // ignore: cast_nullable_to_non_nullable
as bool,uploadFailed: null == uploadFailed ? _self.uploadFailed : uploadFailed // ignore: cast_nullable_to_non_nullable
as bool,evidence: freezed == evidence ? _self.evidence : evidence // ignore: cast_nullable_to_non_nullable
as Evidence?,
  ));
}

/// Create a copy of CaptureState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DeviceDetailsCopyWith<$Res>? get device {
    if (_self.device == null) {
    return null;
  }

  return $DeviceDetailsCopyWith<$Res>(_self.device!, (value) {
    return _then(_self.copyWith(device: value));
  });
}/// Create a copy of CaptureState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GpsReadingCopyWith<$Res>? get reading {
    if (_self.reading == null) {
    return null;
  }

  return $GpsReadingCopyWith<$Res>(_self.reading!, (value) {
    return _then(_self.copyWith(reading: value));
  });
}/// Create a copy of CaptureState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GpsReadingCopyWith<$Res>? get shotReading {
    if (_self.shotReading == null) {
    return null;
  }

  return $GpsReadingCopyWith<$Res>(_self.shotReading!, (value) {
    return _then(_self.copyWith(shotReading: value));
  });
}
}

// dart format on
