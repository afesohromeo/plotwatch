// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'invitation_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$InvitationEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is InvitationEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'InvitationEvent()';
}


}

/// @nodoc
class $InvitationEventCopyWith<$Res>  {
$InvitationEventCopyWith(InvitationEvent _, $Res Function(InvitationEvent) __);
}


/// Adds pattern-matching-related methods to [InvitationEvent].
extension InvitationEventPatterns on InvitationEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _RoleChanged value)?  roleChanged,TResult Function( _CanApproveChanged value)?  canApproveChanged,TResult Function( _CreateSubmitted value)?  createSubmitted,TResult Function( _LinkCopyRequested value)?  linkCopyRequested,TResult Function( _ShareRequested value)?  shareRequested,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RoleChanged() when roleChanged != null:
return roleChanged(_that);case _CanApproveChanged() when canApproveChanged != null:
return canApproveChanged(_that);case _CreateSubmitted() when createSubmitted != null:
return createSubmitted(_that);case _LinkCopyRequested() when linkCopyRequested != null:
return linkCopyRequested(_that);case _ShareRequested() when shareRequested != null:
return shareRequested(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _RoleChanged value)  roleChanged,required TResult Function( _CanApproveChanged value)  canApproveChanged,required TResult Function( _CreateSubmitted value)  createSubmitted,required TResult Function( _LinkCopyRequested value)  linkCopyRequested,required TResult Function( _ShareRequested value)  shareRequested,}){
final _that = this;
switch (_that) {
case _RoleChanged():
return roleChanged(_that);case _CanApproveChanged():
return canApproveChanged(_that);case _CreateSubmitted():
return createSubmitted(_that);case _LinkCopyRequested():
return linkCopyRequested(_that);case _ShareRequested():
return shareRequested(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _RoleChanged value)?  roleChanged,TResult? Function( _CanApproveChanged value)?  canApproveChanged,TResult? Function( _CreateSubmitted value)?  createSubmitted,TResult? Function( _LinkCopyRequested value)?  linkCopyRequested,TResult? Function( _ShareRequested value)?  shareRequested,}){
final _that = this;
switch (_that) {
case _RoleChanged() when roleChanged != null:
return roleChanged(_that);case _CanApproveChanged() when canApproveChanged != null:
return canApproveChanged(_that);case _CreateSubmitted() when createSubmitted != null:
return createSubmitted(_that);case _LinkCopyRequested() when linkCopyRequested != null:
return linkCopyRequested(_that);case _ShareRequested() when shareRequested != null:
return shareRequested(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( ProjectRole role)?  roleChanged,TResult Function( bool canApprove)?  canApproveChanged,TResult Function( int projectId)?  createSubmitted,TResult Function()?  linkCopyRequested,TResult Function()?  shareRequested,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RoleChanged() when roleChanged != null:
return roleChanged(_that.role);case _CanApproveChanged() when canApproveChanged != null:
return canApproveChanged(_that.canApprove);case _CreateSubmitted() when createSubmitted != null:
return createSubmitted(_that.projectId);case _LinkCopyRequested() when linkCopyRequested != null:
return linkCopyRequested();case _ShareRequested() when shareRequested != null:
return shareRequested();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( ProjectRole role)  roleChanged,required TResult Function( bool canApprove)  canApproveChanged,required TResult Function( int projectId)  createSubmitted,required TResult Function()  linkCopyRequested,required TResult Function()  shareRequested,}) {final _that = this;
switch (_that) {
case _RoleChanged():
return roleChanged(_that.role);case _CanApproveChanged():
return canApproveChanged(_that.canApprove);case _CreateSubmitted():
return createSubmitted(_that.projectId);case _LinkCopyRequested():
return linkCopyRequested();case _ShareRequested():
return shareRequested();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( ProjectRole role)?  roleChanged,TResult? Function( bool canApprove)?  canApproveChanged,TResult? Function( int projectId)?  createSubmitted,TResult? Function()?  linkCopyRequested,TResult? Function()?  shareRequested,}) {final _that = this;
switch (_that) {
case _RoleChanged() when roleChanged != null:
return roleChanged(_that.role);case _CanApproveChanged() when canApproveChanged != null:
return canApproveChanged(_that.canApprove);case _CreateSubmitted() when createSubmitted != null:
return createSubmitted(_that.projectId);case _LinkCopyRequested() when linkCopyRequested != null:
return linkCopyRequested();case _ShareRequested() when shareRequested != null:
return shareRequested();case _:
  return null;

}
}

}

/// @nodoc


class _RoleChanged implements InvitationEvent {
  const _RoleChanged({required this.role});
  

 final  ProjectRole role;

/// Create a copy of InvitationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RoleChangedCopyWith<_RoleChanged> get copyWith => __$RoleChangedCopyWithImpl<_RoleChanged>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RoleChanged&&(identical(other.role, role) || other.role == role));
}


@override
int get hashCode {
    return Object.hash(runtimeType,role);
}

@override
String toString() {
    return 'InvitationEvent.roleChanged(role: $role)';
}


}

/// @nodoc
abstract mixin class _$RoleChangedCopyWith<$Res> implements $InvitationEventCopyWith<$Res> {
  factory _$RoleChangedCopyWith(_RoleChanged value, $Res Function(_RoleChanged) _then) = __$RoleChangedCopyWithImpl;
@useResult
$Res call({
 ProjectRole role
});




}
/// @nodoc
class __$RoleChangedCopyWithImpl<$Res>
    implements _$RoleChangedCopyWith<$Res> {
  __$RoleChangedCopyWithImpl(this._self, this._then);

  final _RoleChanged _self;
  final $Res Function(_RoleChanged) _then;

/// Create a copy of InvitationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? role = null,}) {
  return _then(_RoleChanged(
role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as ProjectRole,
  ));
}


}

/// @nodoc


class _CanApproveChanged implements InvitationEvent {
  const _CanApproveChanged({required this.canApprove});
  

 final  bool canApprove;

/// Create a copy of InvitationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CanApproveChangedCopyWith<_CanApproveChanged> get copyWith => __$CanApproveChangedCopyWithImpl<_CanApproveChanged>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CanApproveChanged&&(identical(other.canApprove, canApprove) || other.canApprove == canApprove));
}


@override
int get hashCode {
    return Object.hash(runtimeType,canApprove);
}

@override
String toString() {
    return 'InvitationEvent.canApproveChanged(canApprove: $canApprove)';
}


}

/// @nodoc
abstract mixin class _$CanApproveChangedCopyWith<$Res> implements $InvitationEventCopyWith<$Res> {
  factory _$CanApproveChangedCopyWith(_CanApproveChanged value, $Res Function(_CanApproveChanged) _then) = __$CanApproveChangedCopyWithImpl;
@useResult
$Res call({
 bool canApprove
});




}
/// @nodoc
class __$CanApproveChangedCopyWithImpl<$Res>
    implements _$CanApproveChangedCopyWith<$Res> {
  __$CanApproveChangedCopyWithImpl(this._self, this._then);

  final _CanApproveChanged _self;
  final $Res Function(_CanApproveChanged) _then;

/// Create a copy of InvitationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? canApprove = null,}) {
  return _then(_CanApproveChanged(
canApprove: null == canApprove ? _self.canApprove : canApprove // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class _CreateSubmitted implements InvitationEvent {
  const _CreateSubmitted({required this.projectId});
  

 final  int projectId;

/// Create a copy of InvitationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateSubmittedCopyWith<_CreateSubmitted> get copyWith => __$CreateSubmittedCopyWithImpl<_CreateSubmitted>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateSubmitted&&(identical(other.projectId, projectId) || other.projectId == projectId));
}


@override
int get hashCode {
    return Object.hash(runtimeType,projectId);
}

@override
String toString() {
    return 'InvitationEvent.createSubmitted(projectId: $projectId)';
}


}

/// @nodoc
abstract mixin class _$CreateSubmittedCopyWith<$Res> implements $InvitationEventCopyWith<$Res> {
  factory _$CreateSubmittedCopyWith(_CreateSubmitted value, $Res Function(_CreateSubmitted) _then) = __$CreateSubmittedCopyWithImpl;
@useResult
$Res call({
 int projectId
});




}
/// @nodoc
class __$CreateSubmittedCopyWithImpl<$Res>
    implements _$CreateSubmittedCopyWith<$Res> {
  __$CreateSubmittedCopyWithImpl(this._self, this._then);

  final _CreateSubmitted _self;
  final $Res Function(_CreateSubmitted) _then;

/// Create a copy of InvitationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? projectId = null,}) {
  return _then(_CreateSubmitted(
projectId: null == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _LinkCopyRequested implements InvitationEvent {
  const _LinkCopyRequested();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LinkCopyRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'InvitationEvent.linkCopyRequested()';
}


}




/// @nodoc


class _ShareRequested implements InvitationEvent {
  const _ShareRequested();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShareRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'InvitationEvent.shareRequested()';
}


}




/// @nodoc
mixin _$InvitationState {

 ProjectRole get role; bool get canApprove; GenericStatus get createStatus; String? get createErrorMessage;/// The created invitation; the sheet then shows its code and link.
 Invitation? get invitation;/// The link was copied; the Copy button says so.
 bool get linkCopied;
/// Create a copy of InvitationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InvitationStateCopyWith<InvitationState> get copyWith => _$InvitationStateCopyWithImpl<InvitationState>(this as InvitationState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as InvitationState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InvitationState&&(identical(other.role, _this.role) || other.role == _this.role)&&(identical(other.canApprove, _this.canApprove) || other.canApprove == _this.canApprove)&&(identical(other.createStatus, _this.createStatus) || other.createStatus == _this.createStatus)&&(identical(other.createErrorMessage, _this.createErrorMessage) || other.createErrorMessage == _this.createErrorMessage)&&(identical(other.invitation, _this.invitation) || other.invitation == _this.invitation)&&(identical(other.linkCopied, _this.linkCopied) || other.linkCopied == _this.linkCopied));
}


@override
int get hashCode {
  final _this = this as InvitationState;
  return Object.hash(runtimeType,_this.role,_this.canApprove,_this.createStatus,_this.createErrorMessage,_this.invitation,_this.linkCopied);
}

@override
String toString() {
  final _this = this as InvitationState;
  return 'InvitationState(role: ${_this.role}, canApprove: ${_this.canApprove}, createStatus: ${_this.createStatus}, createErrorMessage: ${_this.createErrorMessage}, invitation: ${_this.invitation}, linkCopied: ${_this.linkCopied})';
}


}

/// @nodoc
abstract mixin class $InvitationStateCopyWith<$Res>  {
  factory $InvitationStateCopyWith(InvitationState value, $Res Function(InvitationState) _then) = _$InvitationStateCopyWithImpl;
@useResult
$Res call({
 ProjectRole role, bool canApprove, GenericStatus createStatus, String? createErrorMessage, Invitation? invitation, bool linkCopied
});




}
/// @nodoc
class _$InvitationStateCopyWithImpl<$Res>
    implements $InvitationStateCopyWith<$Res> {
  _$InvitationStateCopyWithImpl(this._self, this._then);

  final InvitationState _self;
  final $Res Function(InvitationState) _then;

/// Create a copy of InvitationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? role = null,Object? canApprove = null,Object? createStatus = null,Object? createErrorMessage = freezed,Object? invitation = freezed,Object? linkCopied = null,}) {
  return _then(InvitationState(
role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as ProjectRole,canApprove: null == canApprove ? _self.canApprove : canApprove // ignore: cast_nullable_to_non_nullable
as bool,createStatus: null == createStatus ? _self.createStatus : createStatus // ignore: cast_nullable_to_non_nullable
as GenericStatus,createErrorMessage: freezed == createErrorMessage ? _self.createErrorMessage : createErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,invitation: freezed == invitation ? _self.invitation : invitation // ignore: cast_nullable_to_non_nullable
as Invitation?,linkCopied: null == linkCopied ? _self.linkCopied : linkCopied // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [InvitationState].
extension InvitationStatePatterns on InvitationState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InvitationState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InvitationState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InvitationState value)  $default,){
final _that = this;
switch (_that) {
case _InvitationState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InvitationState value)?  $default,){
final _that = this;
switch (_that) {
case _InvitationState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ProjectRole role,  bool canApprove,  GenericStatus createStatus,  String? createErrorMessage,  Invitation? invitation,  bool linkCopied)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InvitationState() when $default != null:
return $default(_that.role,_that.canApprove,_that.createStatus,_that.createErrorMessage,_that.invitation,_that.linkCopied);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ProjectRole role,  bool canApprove,  GenericStatus createStatus,  String? createErrorMessage,  Invitation? invitation,  bool linkCopied)  $default,) {final _that = this;
switch (_that) {
case _InvitationState():
return $default(_that.role,_that.canApprove,_that.createStatus,_that.createErrorMessage,_that.invitation,_that.linkCopied);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ProjectRole role,  bool canApprove,  GenericStatus createStatus,  String? createErrorMessage,  Invitation? invitation,  bool linkCopied)?  $default,) {final _that = this;
switch (_that) {
case _InvitationState() when $default != null:
return $default(_that.role,_that.canApprove,_that.createStatus,_that.createErrorMessage,_that.invitation,_that.linkCopied);case _:
  return null;

}
}

}

/// @nodoc


class _InvitationState implements InvitationState {
  const _InvitationState({this.role = ProjectRole.siteManager, this.canApprove = false, this.createStatus = GenericStatus.initial, this.createErrorMessage, this.invitation, this.linkCopied = false});
  

@override@JsonKey() final  ProjectRole role;
@override@JsonKey() final  bool canApprove;
@override@JsonKey() final  GenericStatus createStatus;
@override final  String? createErrorMessage;
/// The created invitation; the sheet then shows its code and link.
@override final  Invitation? invitation;
/// The link was copied; the Copy button says so.
@override@JsonKey() final  bool linkCopied;

/// Create a copy of InvitationState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InvitationStateCopyWith<_InvitationState> get copyWith => __$InvitationStateCopyWithImpl<_InvitationState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _InvitationState&&(identical(other.role, role) || other.role == role)&&(identical(other.canApprove, canApprove) || other.canApprove == canApprove)&&(identical(other.createStatus, createStatus) || other.createStatus == createStatus)&&(identical(other.createErrorMessage, createErrorMessage) || other.createErrorMessage == createErrorMessage)&&(identical(other.invitation, invitation) || other.invitation == invitation)&&(identical(other.linkCopied, linkCopied) || other.linkCopied == linkCopied));
}


@override
int get hashCode {
    return Object.hash(runtimeType,role,canApprove,createStatus,createErrorMessage,invitation,linkCopied);
}

@override
String toString() {
    return 'InvitationState(role: $role, canApprove: $canApprove, createStatus: $createStatus, createErrorMessage: $createErrorMessage, invitation: $invitation, linkCopied: $linkCopied)';
}


}

/// @nodoc
abstract mixin class _$InvitationStateCopyWith<$Res> implements $InvitationStateCopyWith<$Res> {
  factory _$InvitationStateCopyWith(_InvitationState value, $Res Function(_InvitationState) _then) = __$InvitationStateCopyWithImpl;
@override @useResult
$Res call({
 ProjectRole role, bool canApprove, GenericStatus createStatus, String? createErrorMessage, Invitation? invitation, bool linkCopied
});




}
/// @nodoc
class __$InvitationStateCopyWithImpl<$Res>
    implements _$InvitationStateCopyWith<$Res> {
  __$InvitationStateCopyWithImpl(this._self, this._then);

  final _InvitationState _self;
  final $Res Function(_InvitationState) _then;

/// Create a copy of InvitationState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? role = null,Object? canApprove = null,Object? createStatus = null,Object? createErrorMessage = freezed,Object? invitation = freezed,Object? linkCopied = null,}) {
  return _then(_InvitationState(
role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as ProjectRole,canApprove: null == canApprove ? _self.canApprove : canApprove // ignore: cast_nullable_to_non_nullable
as bool,createStatus: null == createStatus ? _self.createStatus : createStatus // ignore: cast_nullable_to_non_nullable
as GenericStatus,createErrorMessage: freezed == createErrorMessage ? _self.createErrorMessage : createErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,invitation: freezed == invitation ? _self.invitation : invitation // ignore: cast_nullable_to_non_nullable
as Invitation?,linkCopied: null == linkCopied ? _self.linkCopied : linkCopied // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
