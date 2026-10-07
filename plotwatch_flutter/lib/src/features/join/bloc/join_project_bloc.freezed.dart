// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'join_project_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$JoinProjectEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is JoinProjectEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'JoinProjectEvent()';
}


}

/// @nodoc
class $JoinProjectEventCopyWith<$Res>  {
$JoinProjectEventCopyWith(JoinProjectEvent _, $Res Function(JoinProjectEvent) __);
}


/// Adds pattern-matching-related methods to [JoinProjectEvent].
extension JoinProjectEventPatterns on JoinProjectEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _PreviewRequested value)?  previewRequested,TResult Function( _JoinRequested value)?  joinRequested,TResult Function( _ResetFlowStep value)?  resetFlowStep,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PreviewRequested() when previewRequested != null:
return previewRequested(_that);case _JoinRequested() when joinRequested != null:
return joinRequested(_that);case _ResetFlowStep() when resetFlowStep != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _PreviewRequested value)  previewRequested,required TResult Function( _JoinRequested value)  joinRequested,required TResult Function( _ResetFlowStep value)  resetFlowStep,}){
final _that = this;
switch (_that) {
case _PreviewRequested():
return previewRequested(_that);case _JoinRequested():
return joinRequested(_that);case _ResetFlowStep():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _PreviewRequested value)?  previewRequested,TResult? Function( _JoinRequested value)?  joinRequested,TResult? Function( _ResetFlowStep value)?  resetFlowStep,}){
final _that = this;
switch (_that) {
case _PreviewRequested() when previewRequested != null:
return previewRequested(_that);case _JoinRequested() when joinRequested != null:
return joinRequested(_that);case _ResetFlowStep() when resetFlowStep != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String code)?  previewRequested,TResult Function()?  joinRequested,TResult Function()?  resetFlowStep,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PreviewRequested() when previewRequested != null:
return previewRequested(_that.code);case _JoinRequested() when joinRequested != null:
return joinRequested();case _ResetFlowStep() when resetFlowStep != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String code)  previewRequested,required TResult Function()  joinRequested,required TResult Function()  resetFlowStep,}) {final _that = this;
switch (_that) {
case _PreviewRequested():
return previewRequested(_that.code);case _JoinRequested():
return joinRequested();case _ResetFlowStep():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String code)?  previewRequested,TResult? Function()?  joinRequested,TResult? Function()?  resetFlowStep,}) {final _that = this;
switch (_that) {
case _PreviewRequested() when previewRequested != null:
return previewRequested(_that.code);case _JoinRequested() when joinRequested != null:
return joinRequested();case _ResetFlowStep() when resetFlowStep != null:
return resetFlowStep();case _:
  return null;

}
}

}

/// @nodoc


class _PreviewRequested implements JoinProjectEvent {
  const _PreviewRequested({required this.code});
  

 final  String code;

/// Create a copy of JoinProjectEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PreviewRequestedCopyWith<_PreviewRequested> get copyWith => __$PreviewRequestedCopyWithImpl<_PreviewRequested>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PreviewRequested&&(identical(other.code, code) || other.code == code));
}


@override
int get hashCode {
    return Object.hash(runtimeType,code);
}

@override
String toString() {
    return 'JoinProjectEvent.previewRequested(code: $code)';
}


}

/// @nodoc
abstract mixin class _$PreviewRequestedCopyWith<$Res> implements $JoinProjectEventCopyWith<$Res> {
  factory _$PreviewRequestedCopyWith(_PreviewRequested value, $Res Function(_PreviewRequested) _then) = __$PreviewRequestedCopyWithImpl;
@useResult
$Res call({
 String code
});




}
/// @nodoc
class __$PreviewRequestedCopyWithImpl<$Res>
    implements _$PreviewRequestedCopyWith<$Res> {
  __$PreviewRequestedCopyWithImpl(this._self, this._then);

  final _PreviewRequested _self;
  final $Res Function(_PreviewRequested) _then;

/// Create a copy of JoinProjectEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? code = null,}) {
  return _then(_PreviewRequested(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _JoinRequested implements JoinProjectEvent {
  const _JoinRequested();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _JoinRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'JoinProjectEvent.joinRequested()';
}


}




/// @nodoc


class _ResetFlowStep implements JoinProjectEvent {
  const _ResetFlowStep();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResetFlowStep);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'JoinProjectEvent.resetFlowStep()';
}


}




/// @nodoc
mixin _$JoinProjectState {

 String get code; InvitationPreview? get preview; GenericStatus get previewStatus; String? get previewErrorMessage; GenericStatus get joinStatus; String? get joinErrorMessage;/// The new membership; the page then opens the project.
 ProjectMember? get joined;
/// Create a copy of JoinProjectState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JoinProjectStateCopyWith<JoinProjectState> get copyWith => _$JoinProjectStateCopyWithImpl<JoinProjectState>(this as JoinProjectState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as JoinProjectState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JoinProjectState&&(identical(other.code, _this.code) || other.code == _this.code)&&(identical(other.preview, _this.preview) || other.preview == _this.preview)&&(identical(other.previewStatus, _this.previewStatus) || other.previewStatus == _this.previewStatus)&&(identical(other.previewErrorMessage, _this.previewErrorMessage) || other.previewErrorMessage == _this.previewErrorMessage)&&(identical(other.joinStatus, _this.joinStatus) || other.joinStatus == _this.joinStatus)&&(identical(other.joinErrorMessage, _this.joinErrorMessage) || other.joinErrorMessage == _this.joinErrorMessage)&&(identical(other.joined, _this.joined) || other.joined == _this.joined));
}


@override
int get hashCode {
  final _this = this as JoinProjectState;
  return Object.hash(runtimeType,_this.code,_this.preview,_this.previewStatus,_this.previewErrorMessage,_this.joinStatus,_this.joinErrorMessage,_this.joined);
}

@override
String toString() {
  final _this = this as JoinProjectState;
  return 'JoinProjectState(code: ${_this.code}, preview: ${_this.preview}, previewStatus: ${_this.previewStatus}, previewErrorMessage: ${_this.previewErrorMessage}, joinStatus: ${_this.joinStatus}, joinErrorMessage: ${_this.joinErrorMessage}, joined: ${_this.joined})';
}


}

/// @nodoc
abstract mixin class $JoinProjectStateCopyWith<$Res>  {
  factory $JoinProjectStateCopyWith(JoinProjectState value, $Res Function(JoinProjectState) _then) = _$JoinProjectStateCopyWithImpl;
@useResult
$Res call({
 String code, InvitationPreview? preview, GenericStatus previewStatus, String? previewErrorMessage, GenericStatus joinStatus, String? joinErrorMessage, ProjectMember? joined
});




}
/// @nodoc
class _$JoinProjectStateCopyWithImpl<$Res>
    implements $JoinProjectStateCopyWith<$Res> {
  _$JoinProjectStateCopyWithImpl(this._self, this._then);

  final JoinProjectState _self;
  final $Res Function(JoinProjectState) _then;

/// Create a copy of JoinProjectState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? preview = freezed,Object? previewStatus = null,Object? previewErrorMessage = freezed,Object? joinStatus = null,Object? joinErrorMessage = freezed,Object? joined = freezed,}) {
  return _then(JoinProjectState(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,preview: freezed == preview ? _self.preview : preview // ignore: cast_nullable_to_non_nullable
as InvitationPreview?,previewStatus: null == previewStatus ? _self.previewStatus : previewStatus // ignore: cast_nullable_to_non_nullable
as GenericStatus,previewErrorMessage: freezed == previewErrorMessage ? _self.previewErrorMessage : previewErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,joinStatus: null == joinStatus ? _self.joinStatus : joinStatus // ignore: cast_nullable_to_non_nullable
as GenericStatus,joinErrorMessage: freezed == joinErrorMessage ? _self.joinErrorMessage : joinErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,joined: freezed == joined ? _self.joined : joined // ignore: cast_nullable_to_non_nullable
as ProjectMember?,
  ));
}

}


/// Adds pattern-matching-related methods to [JoinProjectState].
extension JoinProjectStatePatterns on JoinProjectState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JoinProjectState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JoinProjectState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JoinProjectState value)  $default,){
final _that = this;
switch (_that) {
case _JoinProjectState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JoinProjectState value)?  $default,){
final _that = this;
switch (_that) {
case _JoinProjectState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  InvitationPreview? preview,  GenericStatus previewStatus,  String? previewErrorMessage,  GenericStatus joinStatus,  String? joinErrorMessage,  ProjectMember? joined)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JoinProjectState() when $default != null:
return $default(_that.code,_that.preview,_that.previewStatus,_that.previewErrorMessage,_that.joinStatus,_that.joinErrorMessage,_that.joined);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  InvitationPreview? preview,  GenericStatus previewStatus,  String? previewErrorMessage,  GenericStatus joinStatus,  String? joinErrorMessage,  ProjectMember? joined)  $default,) {final _that = this;
switch (_that) {
case _JoinProjectState():
return $default(_that.code,_that.preview,_that.previewStatus,_that.previewErrorMessage,_that.joinStatus,_that.joinErrorMessage,_that.joined);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  InvitationPreview? preview,  GenericStatus previewStatus,  String? previewErrorMessage,  GenericStatus joinStatus,  String? joinErrorMessage,  ProjectMember? joined)?  $default,) {final _that = this;
switch (_that) {
case _JoinProjectState() when $default != null:
return $default(_that.code,_that.preview,_that.previewStatus,_that.previewErrorMessage,_that.joinStatus,_that.joinErrorMessage,_that.joined);case _:
  return null;

}
}

}

/// @nodoc


class _JoinProjectState implements JoinProjectState {
  const _JoinProjectState({this.code = '', this.preview, this.previewStatus = GenericStatus.initial, this.previewErrorMessage, this.joinStatus = GenericStatus.initial, this.joinErrorMessage, this.joined});
  

@override@JsonKey() final  String code;
@override final  InvitationPreview? preview;
@override@JsonKey() final  GenericStatus previewStatus;
@override final  String? previewErrorMessage;
@override@JsonKey() final  GenericStatus joinStatus;
@override final  String? joinErrorMessage;
/// The new membership; the page then opens the project.
@override final  ProjectMember? joined;

/// Create a copy of JoinProjectState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JoinProjectStateCopyWith<_JoinProjectState> get copyWith => __$JoinProjectStateCopyWithImpl<_JoinProjectState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _JoinProjectState&&(identical(other.code, code) || other.code == code)&&(identical(other.preview, preview) || other.preview == preview)&&(identical(other.previewStatus, previewStatus) || other.previewStatus == previewStatus)&&(identical(other.previewErrorMessage, previewErrorMessage) || other.previewErrorMessage == previewErrorMessage)&&(identical(other.joinStatus, joinStatus) || other.joinStatus == joinStatus)&&(identical(other.joinErrorMessage, joinErrorMessage) || other.joinErrorMessage == joinErrorMessage)&&(identical(other.joined, joined) || other.joined == joined));
}


@override
int get hashCode {
    return Object.hash(runtimeType,code,preview,previewStatus,previewErrorMessage,joinStatus,joinErrorMessage,joined);
}

@override
String toString() {
    return 'JoinProjectState(code: $code, preview: $preview, previewStatus: $previewStatus, previewErrorMessage: $previewErrorMessage, joinStatus: $joinStatus, joinErrorMessage: $joinErrorMessage, joined: $joined)';
}


}

/// @nodoc
abstract mixin class _$JoinProjectStateCopyWith<$Res> implements $JoinProjectStateCopyWith<$Res> {
  factory _$JoinProjectStateCopyWith(_JoinProjectState value, $Res Function(_JoinProjectState) _then) = __$JoinProjectStateCopyWithImpl;
@override @useResult
$Res call({
 String code, InvitationPreview? preview, GenericStatus previewStatus, String? previewErrorMessage, GenericStatus joinStatus, String? joinErrorMessage, ProjectMember? joined
});




}
/// @nodoc
class __$JoinProjectStateCopyWithImpl<$Res>
    implements _$JoinProjectStateCopyWith<$Res> {
  __$JoinProjectStateCopyWithImpl(this._self, this._then);

  final _JoinProjectState _self;
  final $Res Function(_JoinProjectState) _then;

/// Create a copy of JoinProjectState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? preview = freezed,Object? previewStatus = null,Object? previewErrorMessage = freezed,Object? joinStatus = null,Object? joinErrorMessage = freezed,Object? joined = freezed,}) {
  return _then(_JoinProjectState(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,preview: freezed == preview ? _self.preview : preview // ignore: cast_nullable_to_non_nullable
as InvitationPreview?,previewStatus: null == previewStatus ? _self.previewStatus : previewStatus // ignore: cast_nullable_to_non_nullable
as GenericStatus,previewErrorMessage: freezed == previewErrorMessage ? _self.previewErrorMessage : previewErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,joinStatus: null == joinStatus ? _self.joinStatus : joinStatus // ignore: cast_nullable_to_non_nullable
as GenericStatus,joinErrorMessage: freezed == joinErrorMessage ? _self.joinErrorMessage : joinErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,joined: freezed == joined ? _self.joined : joined // ignore: cast_nullable_to_non_nullable
as ProjectMember?,
  ));
}


}

// dart format on
