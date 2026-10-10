// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'members_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MembersEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is MembersEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'MembersEvent()';
}


}

/// @nodoc
class $MembersEventCopyWith<$Res>  {
$MembersEventCopyWith(MembersEvent _, $Res Function(MembersEvent) __);
}


/// Adds pattern-matching-related methods to [MembersEvent].
extension MembersEventPatterns on MembersEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _FetchMembers value)?  fetchMembers,TResult Function( _RemoveMember value)?  removeMember,TResult Function( _ChangeRole value)?  changeRole,TResult Function( _CancelInvitation value)?  cancelInvitation,TResult Function( _InvitationCreated value)?  invitationCreated,TResult Function( _ResetFlowStep value)?  resetFlowStep,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FetchMembers() when fetchMembers != null:
return fetchMembers(_that);case _RemoveMember() when removeMember != null:
return removeMember(_that);case _ChangeRole() when changeRole != null:
return changeRole(_that);case _CancelInvitation() when cancelInvitation != null:
return cancelInvitation(_that);case _InvitationCreated() when invitationCreated != null:
return invitationCreated(_that);case _ResetFlowStep() when resetFlowStep != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _FetchMembers value)  fetchMembers,required TResult Function( _RemoveMember value)  removeMember,required TResult Function( _ChangeRole value)  changeRole,required TResult Function( _CancelInvitation value)  cancelInvitation,required TResult Function( _InvitationCreated value)  invitationCreated,required TResult Function( _ResetFlowStep value)  resetFlowStep,}){
final _that = this;
switch (_that) {
case _FetchMembers():
return fetchMembers(_that);case _RemoveMember():
return removeMember(_that);case _ChangeRole():
return changeRole(_that);case _CancelInvitation():
return cancelInvitation(_that);case _InvitationCreated():
return invitationCreated(_that);case _ResetFlowStep():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _FetchMembers value)?  fetchMembers,TResult? Function( _RemoveMember value)?  removeMember,TResult? Function( _ChangeRole value)?  changeRole,TResult? Function( _CancelInvitation value)?  cancelInvitation,TResult? Function( _InvitationCreated value)?  invitationCreated,TResult? Function( _ResetFlowStep value)?  resetFlowStep,}){
final _that = this;
switch (_that) {
case _FetchMembers() when fetchMembers != null:
return fetchMembers(_that);case _RemoveMember() when removeMember != null:
return removeMember(_that);case _ChangeRole() when changeRole != null:
return changeRole(_that);case _CancelInvitation() when cancelInvitation != null:
return cancelInvitation(_that);case _InvitationCreated() when invitationCreated != null:
return invitationCreated(_that);case _ResetFlowStep() when resetFlowStep != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int projectId)?  fetchMembers,TResult Function( int memberId)?  removeMember,TResult Function( int memberId,  ProjectRole role)?  changeRole,TResult Function( int invitationId)?  cancelInvitation,TResult Function( Invitation invitation)?  invitationCreated,TResult Function()?  resetFlowStep,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FetchMembers() when fetchMembers != null:
return fetchMembers(_that.projectId);case _RemoveMember() when removeMember != null:
return removeMember(_that.memberId);case _ChangeRole() when changeRole != null:
return changeRole(_that.memberId,_that.role);case _CancelInvitation() when cancelInvitation != null:
return cancelInvitation(_that.invitationId);case _InvitationCreated() when invitationCreated != null:
return invitationCreated(_that.invitation);case _ResetFlowStep() when resetFlowStep != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int projectId)  fetchMembers,required TResult Function( int memberId)  removeMember,required TResult Function( int memberId,  ProjectRole role)  changeRole,required TResult Function( int invitationId)  cancelInvitation,required TResult Function( Invitation invitation)  invitationCreated,required TResult Function()  resetFlowStep,}) {final _that = this;
switch (_that) {
case _FetchMembers():
return fetchMembers(_that.projectId);case _RemoveMember():
return removeMember(_that.memberId);case _ChangeRole():
return changeRole(_that.memberId,_that.role);case _CancelInvitation():
return cancelInvitation(_that.invitationId);case _InvitationCreated():
return invitationCreated(_that.invitation);case _ResetFlowStep():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int projectId)?  fetchMembers,TResult? Function( int memberId)?  removeMember,TResult? Function( int memberId,  ProjectRole role)?  changeRole,TResult? Function( int invitationId)?  cancelInvitation,TResult? Function( Invitation invitation)?  invitationCreated,TResult? Function()?  resetFlowStep,}) {final _that = this;
switch (_that) {
case _FetchMembers() when fetchMembers != null:
return fetchMembers(_that.projectId);case _RemoveMember() when removeMember != null:
return removeMember(_that.memberId);case _ChangeRole() when changeRole != null:
return changeRole(_that.memberId,_that.role);case _CancelInvitation() when cancelInvitation != null:
return cancelInvitation(_that.invitationId);case _InvitationCreated() when invitationCreated != null:
return invitationCreated(_that.invitation);case _ResetFlowStep() when resetFlowStep != null:
return resetFlowStep();case _:
  return null;

}
}

}

/// @nodoc


class _FetchMembers implements MembersEvent {
  const _FetchMembers({required this.projectId});
  

 final  int projectId;

/// Create a copy of MembersEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FetchMembersCopyWith<_FetchMembers> get copyWith => __$FetchMembersCopyWithImpl<_FetchMembers>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FetchMembers&&(identical(other.projectId, projectId) || other.projectId == projectId));
}


@override
int get hashCode {
    return Object.hash(runtimeType,projectId);
}

@override
String toString() {
    return 'MembersEvent.fetchMembers(projectId: $projectId)';
}


}

/// @nodoc
abstract mixin class _$FetchMembersCopyWith<$Res> implements $MembersEventCopyWith<$Res> {
  factory _$FetchMembersCopyWith(_FetchMembers value, $Res Function(_FetchMembers) _then) = __$FetchMembersCopyWithImpl;
@useResult
$Res call({
 int projectId
});




}
/// @nodoc
class __$FetchMembersCopyWithImpl<$Res>
    implements _$FetchMembersCopyWith<$Res> {
  __$FetchMembersCopyWithImpl(this._self, this._then);

  final _FetchMembers _self;
  final $Res Function(_FetchMembers) _then;

/// Create a copy of MembersEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? projectId = null,}) {
  return _then(_FetchMembers(
projectId: null == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _RemoveMember implements MembersEvent {
  const _RemoveMember({required this.memberId});
  

 final  int memberId;

/// Create a copy of MembersEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RemoveMemberCopyWith<_RemoveMember> get copyWith => __$RemoveMemberCopyWithImpl<_RemoveMember>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RemoveMember&&(identical(other.memberId, memberId) || other.memberId == memberId));
}


@override
int get hashCode {
    return Object.hash(runtimeType,memberId);
}

@override
String toString() {
    return 'MembersEvent.removeMember(memberId: $memberId)';
}


}

/// @nodoc
abstract mixin class _$RemoveMemberCopyWith<$Res> implements $MembersEventCopyWith<$Res> {
  factory _$RemoveMemberCopyWith(_RemoveMember value, $Res Function(_RemoveMember) _then) = __$RemoveMemberCopyWithImpl;
@useResult
$Res call({
 int memberId
});




}
/// @nodoc
class __$RemoveMemberCopyWithImpl<$Res>
    implements _$RemoveMemberCopyWith<$Res> {
  __$RemoveMemberCopyWithImpl(this._self, this._then);

  final _RemoveMember _self;
  final $Res Function(_RemoveMember) _then;

/// Create a copy of MembersEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? memberId = null,}) {
  return _then(_RemoveMember(
memberId: null == memberId ? _self.memberId : memberId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _ChangeRole implements MembersEvent {
  const _ChangeRole({required this.memberId, required this.role});
  

 final  int memberId;
 final  ProjectRole role;

/// Create a copy of MembersEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChangeRoleCopyWith<_ChangeRole> get copyWith => __$ChangeRoleCopyWithImpl<_ChangeRole>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChangeRole&&(identical(other.memberId, memberId) || other.memberId == memberId)&&(identical(other.role, role) || other.role == role));
}


@override
int get hashCode {
    return Object.hash(runtimeType,memberId,role);
}

@override
String toString() {
    return 'MembersEvent.changeRole(memberId: $memberId, role: $role)';
}


}

/// @nodoc
abstract mixin class _$ChangeRoleCopyWith<$Res> implements $MembersEventCopyWith<$Res> {
  factory _$ChangeRoleCopyWith(_ChangeRole value, $Res Function(_ChangeRole) _then) = __$ChangeRoleCopyWithImpl;
@useResult
$Res call({
 int memberId, ProjectRole role
});




}
/// @nodoc
class __$ChangeRoleCopyWithImpl<$Res>
    implements _$ChangeRoleCopyWith<$Res> {
  __$ChangeRoleCopyWithImpl(this._self, this._then);

  final _ChangeRole _self;
  final $Res Function(_ChangeRole) _then;

/// Create a copy of MembersEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? memberId = null,Object? role = null,}) {
  return _then(_ChangeRole(
memberId: null == memberId ? _self.memberId : memberId // ignore: cast_nullable_to_non_nullable
as int,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as ProjectRole,
  ));
}


}

/// @nodoc


class _CancelInvitation implements MembersEvent {
  const _CancelInvitation({required this.invitationId});
  

 final  int invitationId;

/// Create a copy of MembersEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CancelInvitationCopyWith<_CancelInvitation> get copyWith => __$CancelInvitationCopyWithImpl<_CancelInvitation>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CancelInvitation&&(identical(other.invitationId, invitationId) || other.invitationId == invitationId));
}


@override
int get hashCode {
    return Object.hash(runtimeType,invitationId);
}

@override
String toString() {
    return 'MembersEvent.cancelInvitation(invitationId: $invitationId)';
}


}

/// @nodoc
abstract mixin class _$CancelInvitationCopyWith<$Res> implements $MembersEventCopyWith<$Res> {
  factory _$CancelInvitationCopyWith(_CancelInvitation value, $Res Function(_CancelInvitation) _then) = __$CancelInvitationCopyWithImpl;
@useResult
$Res call({
 int invitationId
});




}
/// @nodoc
class __$CancelInvitationCopyWithImpl<$Res>
    implements _$CancelInvitationCopyWith<$Res> {
  __$CancelInvitationCopyWithImpl(this._self, this._then);

  final _CancelInvitation _self;
  final $Res Function(_CancelInvitation) _then;

/// Create a copy of MembersEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? invitationId = null,}) {
  return _then(_CancelInvitation(
invitationId: null == invitationId ? _self.invitationId : invitationId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _InvitationCreated implements MembersEvent {
  const _InvitationCreated({required this.invitation});
  

 final  Invitation invitation;

/// Create a copy of MembersEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InvitationCreatedCopyWith<_InvitationCreated> get copyWith => __$InvitationCreatedCopyWithImpl<_InvitationCreated>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _InvitationCreated&&(identical(other.invitation, invitation) || other.invitation == invitation));
}


@override
int get hashCode {
    return Object.hash(runtimeType,invitation);
}

@override
String toString() {
    return 'MembersEvent.invitationCreated(invitation: $invitation)';
}


}

/// @nodoc
abstract mixin class _$InvitationCreatedCopyWith<$Res> implements $MembersEventCopyWith<$Res> {
  factory _$InvitationCreatedCopyWith(_InvitationCreated value, $Res Function(_InvitationCreated) _then) = __$InvitationCreatedCopyWithImpl;
@useResult
$Res call({
 Invitation invitation
});




}
/// @nodoc
class __$InvitationCreatedCopyWithImpl<$Res>
    implements _$InvitationCreatedCopyWith<$Res> {
  __$InvitationCreatedCopyWithImpl(this._self, this._then);

  final _InvitationCreated _self;
  final $Res Function(_InvitationCreated) _then;

/// Create a copy of MembersEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? invitation = null,}) {
  return _then(_InvitationCreated(
invitation: null == invitation ? _self.invitation : invitation // ignore: cast_nullable_to_non_nullable
as Invitation,
  ));
}


}

/// @nodoc


class _ResetFlowStep implements MembersEvent {
  const _ResetFlowStep();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResetFlowStep);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'MembersEvent.resetFlowStep()';
}


}




/// @nodoc
mixin _$MembersState {

 ProjectOverview? get overview; List<MemberView> get members; List<Invitation> get invitations;/// Their actions stay in the history (doc/04e C-2b).
 List<MemberView> get formerMembers; GenericStatus get membersStatus; String? get membersErrorMessage; GenericStatus get actionStatus; GenericFlowStep get flowStep; String? get actionErrorMessage;
/// Create a copy of MembersState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MembersStateCopyWith<MembersState> get copyWith => _$MembersStateCopyWithImpl<MembersState>(this as MembersState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as MembersState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MembersState&&(identical(other.overview, _this.overview) || other.overview == _this.overview)&&const DeepCollectionEquality().equals(other.members, _this.members)&&const DeepCollectionEquality().equals(other.invitations, _this.invitations)&&const DeepCollectionEquality().equals(other.formerMembers, _this.formerMembers)&&(identical(other.membersStatus, _this.membersStatus) || other.membersStatus == _this.membersStatus)&&(identical(other.membersErrorMessage, _this.membersErrorMessage) || other.membersErrorMessage == _this.membersErrorMessage)&&(identical(other.actionStatus, _this.actionStatus) || other.actionStatus == _this.actionStatus)&&(identical(other.flowStep, _this.flowStep) || other.flowStep == _this.flowStep)&&(identical(other.actionErrorMessage, _this.actionErrorMessage) || other.actionErrorMessage == _this.actionErrorMessage));
}


@override
int get hashCode {
  final _this = this as MembersState;
  return Object.hash(runtimeType,_this.overview,const DeepCollectionEquality().hash(_this.members),const DeepCollectionEquality().hash(_this.invitations),const DeepCollectionEquality().hash(_this.formerMembers),_this.membersStatus,_this.membersErrorMessage,_this.actionStatus,_this.flowStep,_this.actionErrorMessage);
}

@override
String toString() {
  final _this = this as MembersState;
  return 'MembersState(overview: ${_this.overview}, members: ${_this.members}, invitations: ${_this.invitations}, formerMembers: ${_this.formerMembers}, membersStatus: ${_this.membersStatus}, membersErrorMessage: ${_this.membersErrorMessage}, actionStatus: ${_this.actionStatus}, flowStep: ${_this.flowStep}, actionErrorMessage: ${_this.actionErrorMessage})';
}


}

/// @nodoc
abstract mixin class $MembersStateCopyWith<$Res>  {
  factory $MembersStateCopyWith(MembersState value, $Res Function(MembersState) _then) = _$MembersStateCopyWithImpl;
@useResult
$Res call({
 ProjectOverview? overview, List<MemberView> members, List<Invitation> invitations, List<MemberView> formerMembers, GenericStatus membersStatus, String? membersErrorMessage, GenericStatus actionStatus, GenericFlowStep flowStep, String? actionErrorMessage
});




}
/// @nodoc
class _$MembersStateCopyWithImpl<$Res>
    implements $MembersStateCopyWith<$Res> {
  _$MembersStateCopyWithImpl(this._self, this._then);

  final MembersState _self;
  final $Res Function(MembersState) _then;

/// Create a copy of MembersState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? overview = freezed,Object? members = null,Object? invitations = null,Object? formerMembers = null,Object? membersStatus = null,Object? membersErrorMessage = freezed,Object? actionStatus = null,Object? flowStep = null,Object? actionErrorMessage = freezed,}) {
  return _then(MembersState(
overview: freezed == overview ? _self.overview : overview // ignore: cast_nullable_to_non_nullable
as ProjectOverview?,members: null == members ? _self.members : members // ignore: cast_nullable_to_non_nullable
as List<MemberView>,invitations: null == invitations ? _self.invitations : invitations // ignore: cast_nullable_to_non_nullable
as List<Invitation>,formerMembers: null == formerMembers ? _self.formerMembers : formerMembers // ignore: cast_nullable_to_non_nullable
as List<MemberView>,membersStatus: null == membersStatus ? _self.membersStatus : membersStatus // ignore: cast_nullable_to_non_nullable
as GenericStatus,membersErrorMessage: freezed == membersErrorMessage ? _self.membersErrorMessage : membersErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,actionStatus: null == actionStatus ? _self.actionStatus : actionStatus // ignore: cast_nullable_to_non_nullable
as GenericStatus,flowStep: null == flowStep ? _self.flowStep : flowStep // ignore: cast_nullable_to_non_nullable
as GenericFlowStep,actionErrorMessage: freezed == actionErrorMessage ? _self.actionErrorMessage : actionErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MembersState].
extension MembersStatePatterns on MembersState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MembersState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MembersState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MembersState value)  $default,){
final _that = this;
switch (_that) {
case _MembersState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MembersState value)?  $default,){
final _that = this;
switch (_that) {
case _MembersState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ProjectOverview? overview,  List<MemberView> members,  List<Invitation> invitations,  List<MemberView> formerMembers,  GenericStatus membersStatus,  String? membersErrorMessage,  GenericStatus actionStatus,  GenericFlowStep flowStep,  String? actionErrorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MembersState() when $default != null:
return $default(_that.overview,_that.members,_that.invitations,_that.formerMembers,_that.membersStatus,_that.membersErrorMessage,_that.actionStatus,_that.flowStep,_that.actionErrorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ProjectOverview? overview,  List<MemberView> members,  List<Invitation> invitations,  List<MemberView> formerMembers,  GenericStatus membersStatus,  String? membersErrorMessage,  GenericStatus actionStatus,  GenericFlowStep flowStep,  String? actionErrorMessage)  $default,) {final _that = this;
switch (_that) {
case _MembersState():
return $default(_that.overview,_that.members,_that.invitations,_that.formerMembers,_that.membersStatus,_that.membersErrorMessage,_that.actionStatus,_that.flowStep,_that.actionErrorMessage);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ProjectOverview? overview,  List<MemberView> members,  List<Invitation> invitations,  List<MemberView> formerMembers,  GenericStatus membersStatus,  String? membersErrorMessage,  GenericStatus actionStatus,  GenericFlowStep flowStep,  String? actionErrorMessage)?  $default,) {final _that = this;
switch (_that) {
case _MembersState() when $default != null:
return $default(_that.overview,_that.members,_that.invitations,_that.formerMembers,_that.membersStatus,_that.membersErrorMessage,_that.actionStatus,_that.flowStep,_that.actionErrorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _MembersState extends MembersState {
  const _MembersState({this.overview,  List<MemberView> members = const [],  List<Invitation> invitations = const [],  List<MemberView> formerMembers = const [], this.membersStatus = GenericStatus.initial, this.membersErrorMessage, this.actionStatus = GenericStatus.initial, this.flowStep = GenericFlowStep.none, this.actionErrorMessage}): _members = members,_invitations = invitations,_formerMembers = formerMembers,super._();
  

@override final  ProjectOverview? overview;
 final  List<MemberView> _members;
@override@JsonKey() List<MemberView> get members {
  if (_members is EqualUnmodifiableListView) return _members;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_members);
}

 final  List<Invitation> _invitations;
@override@JsonKey() List<Invitation> get invitations {
  if (_invitations is EqualUnmodifiableListView) return _invitations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_invitations);
}

/// Their actions stay in the history (doc/04e C-2b).
 final  List<MemberView> _formerMembers;
/// Their actions stay in the history (doc/04e C-2b).
@override@JsonKey() List<MemberView> get formerMembers {
  if (_formerMembers is EqualUnmodifiableListView) return _formerMembers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_formerMembers);
}

@override@JsonKey() final  GenericStatus membersStatus;
@override final  String? membersErrorMessage;
@override@JsonKey() final  GenericStatus actionStatus;
@override@JsonKey() final  GenericFlowStep flowStep;
@override final  String? actionErrorMessage;

/// Create a copy of MembersState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MembersStateCopyWith<_MembersState> get copyWith => __$MembersStateCopyWithImpl<_MembersState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MembersState&&(identical(other.overview, overview) || other.overview == overview)&&const DeepCollectionEquality().equals(other.members, _members)&&const DeepCollectionEquality().equals(other.invitations, _invitations)&&const DeepCollectionEquality().equals(other.formerMembers, _formerMembers)&&(identical(other.membersStatus, membersStatus) || other.membersStatus == membersStatus)&&(identical(other.membersErrorMessage, membersErrorMessage) || other.membersErrorMessage == membersErrorMessage)&&(identical(other.actionStatus, actionStatus) || other.actionStatus == actionStatus)&&(identical(other.flowStep, flowStep) || other.flowStep == flowStep)&&(identical(other.actionErrorMessage, actionErrorMessage) || other.actionErrorMessage == actionErrorMessage));
}


@override
int get hashCode {
    return Object.hash(runtimeType,overview,const DeepCollectionEquality().hash(_members),const DeepCollectionEquality().hash(_invitations),const DeepCollectionEquality().hash(_formerMembers),membersStatus,membersErrorMessage,actionStatus,flowStep,actionErrorMessage);
}

@override
String toString() {
    return 'MembersState(overview: $overview, members: $members, invitations: $invitations, formerMembers: $formerMembers, membersStatus: $membersStatus, membersErrorMessage: $membersErrorMessage, actionStatus: $actionStatus, flowStep: $flowStep, actionErrorMessage: $actionErrorMessage)';
}


}

/// @nodoc
abstract mixin class _$MembersStateCopyWith<$Res> implements $MembersStateCopyWith<$Res> {
  factory _$MembersStateCopyWith(_MembersState value, $Res Function(_MembersState) _then) = __$MembersStateCopyWithImpl;
@override @useResult
$Res call({
 ProjectOverview? overview, List<MemberView> members, List<Invitation> invitations, List<MemberView> formerMembers, GenericStatus membersStatus, String? membersErrorMessage, GenericStatus actionStatus, GenericFlowStep flowStep, String? actionErrorMessage
});




}
/// @nodoc
class __$MembersStateCopyWithImpl<$Res>
    implements _$MembersStateCopyWith<$Res> {
  __$MembersStateCopyWithImpl(this._self, this._then);

  final _MembersState _self;
  final $Res Function(_MembersState) _then;

/// Create a copy of MembersState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? overview = freezed,Object? members = null,Object? invitations = null,Object? formerMembers = null,Object? membersStatus = null,Object? membersErrorMessage = freezed,Object? actionStatus = null,Object? flowStep = null,Object? actionErrorMessage = freezed,}) {
  return _then(_MembersState(
overview: freezed == overview ? _self.overview : overview // ignore: cast_nullable_to_non_nullable
as ProjectOverview?,members: null == members ? _self._members : members // ignore: cast_nullable_to_non_nullable
as List<MemberView>,invitations: null == invitations ? _self._invitations : invitations // ignore: cast_nullable_to_non_nullable
as List<Invitation>,formerMembers: null == formerMembers ? _self._formerMembers : formerMembers // ignore: cast_nullable_to_non_nullable
as List<MemberView>,membersStatus: null == membersStatus ? _self.membersStatus : membersStatus // ignore: cast_nullable_to_non_nullable
as GenericStatus,membersErrorMessage: freezed == membersErrorMessage ? _self.membersErrorMessage : membersErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,actionStatus: null == actionStatus ? _self.actionStatus : actionStatus // ignore: cast_nullable_to_non_nullable
as GenericStatus,flowStep: null == flowStep ? _self.flowStep : flowStep // ignore: cast_nullable_to_non_nullable
as GenericFlowStep,actionErrorMessage: freezed == actionErrorMessage ? _self.actionErrorMessage : actionErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
