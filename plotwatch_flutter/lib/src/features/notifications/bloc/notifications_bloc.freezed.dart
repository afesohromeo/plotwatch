// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notifications_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NotificationsEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationsEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'NotificationsEvent()';
}


}

/// @nodoc
class $NotificationsEventCopyWith<$Res>  {
$NotificationsEventCopyWith(NotificationsEvent _, $Res Function(NotificationsEvent) __);
}


/// Adds pattern-matching-related methods to [NotificationsEvent].
extension NotificationsEventPatterns on NotificationsEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _Stopped value)?  stopped,TResult Function( _FetchNotifications value)?  fetchNotifications,TResult Function( _RefreshNotifications value)?  refreshNotifications,TResult Function( _MarkRead value)?  markRead,TResult Function( _MarkAllRead value)?  markAllRead,TResult Function( _LiveUpdateReceived value)?  liveUpdateReceived,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _Stopped() when stopped != null:
return stopped(_that);case _FetchNotifications() when fetchNotifications != null:
return fetchNotifications(_that);case _RefreshNotifications() when refreshNotifications != null:
return refreshNotifications(_that);case _MarkRead() when markRead != null:
return markRead(_that);case _MarkAllRead() when markAllRead != null:
return markAllRead(_that);case _LiveUpdateReceived() when liveUpdateReceived != null:
return liveUpdateReceived(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _Stopped value)  stopped,required TResult Function( _FetchNotifications value)  fetchNotifications,required TResult Function( _RefreshNotifications value)  refreshNotifications,required TResult Function( _MarkRead value)  markRead,required TResult Function( _MarkAllRead value)  markAllRead,required TResult Function( _LiveUpdateReceived value)  liveUpdateReceived,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _Stopped():
return stopped(_that);case _FetchNotifications():
return fetchNotifications(_that);case _RefreshNotifications():
return refreshNotifications(_that);case _MarkRead():
return markRead(_that);case _MarkAllRead():
return markAllRead(_that);case _LiveUpdateReceived():
return liveUpdateReceived(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _Stopped value)?  stopped,TResult? Function( _FetchNotifications value)?  fetchNotifications,TResult? Function( _RefreshNotifications value)?  refreshNotifications,TResult? Function( _MarkRead value)?  markRead,TResult? Function( _MarkAllRead value)?  markAllRead,TResult? Function( _LiveUpdateReceived value)?  liveUpdateReceived,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _Stopped() when stopped != null:
return stopped(_that);case _FetchNotifications() when fetchNotifications != null:
return fetchNotifications(_that);case _RefreshNotifications() when refreshNotifications != null:
return refreshNotifications(_that);case _MarkRead() when markRead != null:
return markRead(_that);case _MarkAllRead() when markAllRead != null:
return markAllRead(_that);case _LiveUpdateReceived() when liveUpdateReceived != null:
return liveUpdateReceived(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function()?  stopped,TResult Function( int pageKey,  int? size)?  fetchNotifications,TResult Function()?  refreshNotifications,TResult Function( int notificationId)?  markRead,TResult Function()?  markAllRead,TResult Function( LiveUpdate<AppNotification> update)?  liveUpdateReceived,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _Stopped() when stopped != null:
return stopped();case _FetchNotifications() when fetchNotifications != null:
return fetchNotifications(_that.pageKey,_that.size);case _RefreshNotifications() when refreshNotifications != null:
return refreshNotifications();case _MarkRead() when markRead != null:
return markRead(_that.notificationId);case _MarkAllRead() when markAllRead != null:
return markAllRead();case _LiveUpdateReceived() when liveUpdateReceived != null:
return liveUpdateReceived(_that.update);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function()  stopped,required TResult Function( int pageKey,  int? size)  fetchNotifications,required TResult Function()  refreshNotifications,required TResult Function( int notificationId)  markRead,required TResult Function()  markAllRead,required TResult Function( LiveUpdate<AppNotification> update)  liveUpdateReceived,}) {final _that = this;
switch (_that) {
case _Started():
return started();case _Stopped():
return stopped();case _FetchNotifications():
return fetchNotifications(_that.pageKey,_that.size);case _RefreshNotifications():
return refreshNotifications();case _MarkRead():
return markRead(_that.notificationId);case _MarkAllRead():
return markAllRead();case _LiveUpdateReceived():
return liveUpdateReceived(_that.update);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function()?  stopped,TResult? Function( int pageKey,  int? size)?  fetchNotifications,TResult? Function()?  refreshNotifications,TResult? Function( int notificationId)?  markRead,TResult? Function()?  markAllRead,TResult? Function( LiveUpdate<AppNotification> update)?  liveUpdateReceived,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _Stopped() when stopped != null:
return stopped();case _FetchNotifications() when fetchNotifications != null:
return fetchNotifications(_that.pageKey,_that.size);case _RefreshNotifications() when refreshNotifications != null:
return refreshNotifications();case _MarkRead() when markRead != null:
return markRead(_that.notificationId);case _MarkAllRead() when markAllRead != null:
return markAllRead();case _LiveUpdateReceived() when liveUpdateReceived != null:
return liveUpdateReceived(_that.update);case _:
  return null;

}
}

}

/// @nodoc


class _Started implements NotificationsEvent {
  const _Started();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'NotificationsEvent.started()';
}


}




/// @nodoc


class _Stopped implements NotificationsEvent {
  const _Stopped();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Stopped);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'NotificationsEvent.stopped()';
}


}




/// @nodoc


class _FetchNotifications implements NotificationsEvent {
  const _FetchNotifications({this.pageKey = 0, this.size});
  

@JsonKey() final  int pageKey;
 final  int? size;

/// Create a copy of NotificationsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FetchNotificationsCopyWith<_FetchNotifications> get copyWith => __$FetchNotificationsCopyWithImpl<_FetchNotifications>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FetchNotifications&&(identical(other.pageKey, pageKey) || other.pageKey == pageKey)&&(identical(other.size, size) || other.size == size));
}


@override
int get hashCode {
    return Object.hash(runtimeType,pageKey,size);
}

@override
String toString() {
    return 'NotificationsEvent.fetchNotifications(pageKey: $pageKey, size: $size)';
}


}

/// @nodoc
abstract mixin class _$FetchNotificationsCopyWith<$Res> implements $NotificationsEventCopyWith<$Res> {
  factory _$FetchNotificationsCopyWith(_FetchNotifications value, $Res Function(_FetchNotifications) _then) = __$FetchNotificationsCopyWithImpl;
@useResult
$Res call({
 int pageKey, int? size
});




}
/// @nodoc
class __$FetchNotificationsCopyWithImpl<$Res>
    implements _$FetchNotificationsCopyWith<$Res> {
  __$FetchNotificationsCopyWithImpl(this._self, this._then);

  final _FetchNotifications _self;
  final $Res Function(_FetchNotifications) _then;

/// Create a copy of NotificationsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? pageKey = null,Object? size = freezed,}) {
  return _then(_FetchNotifications(
pageKey: null == pageKey ? _self.pageKey : pageKey // ignore: cast_nullable_to_non_nullable
as int,size: freezed == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc


class _RefreshNotifications implements NotificationsEvent {
  const _RefreshNotifications();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RefreshNotifications);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'NotificationsEvent.refreshNotifications()';
}


}




/// @nodoc


class _MarkRead implements NotificationsEvent {
  const _MarkRead(this.notificationId);
  

 final  int notificationId;

/// Create a copy of NotificationsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MarkReadCopyWith<_MarkRead> get copyWith => __$MarkReadCopyWithImpl<_MarkRead>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MarkRead&&(identical(other.notificationId, notificationId) || other.notificationId == notificationId));
}


@override
int get hashCode {
    return Object.hash(runtimeType,notificationId);
}

@override
String toString() {
    return 'NotificationsEvent.markRead(notificationId: $notificationId)';
}


}

/// @nodoc
abstract mixin class _$MarkReadCopyWith<$Res> implements $NotificationsEventCopyWith<$Res> {
  factory _$MarkReadCopyWith(_MarkRead value, $Res Function(_MarkRead) _then) = __$MarkReadCopyWithImpl;
@useResult
$Res call({
 int notificationId
});




}
/// @nodoc
class __$MarkReadCopyWithImpl<$Res>
    implements _$MarkReadCopyWith<$Res> {
  __$MarkReadCopyWithImpl(this._self, this._then);

  final _MarkRead _self;
  final $Res Function(_MarkRead) _then;

/// Create a copy of NotificationsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? notificationId = null,}) {
  return _then(_MarkRead(
null == notificationId ? _self.notificationId : notificationId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _MarkAllRead implements NotificationsEvent {
  const _MarkAllRead();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MarkAllRead);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'NotificationsEvent.markAllRead()';
}


}




/// @nodoc


class _LiveUpdateReceived implements NotificationsEvent {
  const _LiveUpdateReceived(this.update);
  

 final  LiveUpdate<AppNotification> update;

/// Create a copy of NotificationsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LiveUpdateReceivedCopyWith<_LiveUpdateReceived> get copyWith => __$LiveUpdateReceivedCopyWithImpl<_LiveUpdateReceived>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LiveUpdateReceived&&(identical(other.update, update) || other.update == update));
}


@override
int get hashCode {
    return Object.hash(runtimeType,update);
}

@override
String toString() {
    return 'NotificationsEvent.liveUpdateReceived(update: $update)';
}


}

/// @nodoc
abstract mixin class _$LiveUpdateReceivedCopyWith<$Res> implements $NotificationsEventCopyWith<$Res> {
  factory _$LiveUpdateReceivedCopyWith(_LiveUpdateReceived value, $Res Function(_LiveUpdateReceived) _then) = __$LiveUpdateReceivedCopyWithImpl;
@useResult
$Res call({
 LiveUpdate<AppNotification> update
});




}
/// @nodoc
class __$LiveUpdateReceivedCopyWithImpl<$Res>
    implements _$LiveUpdateReceivedCopyWith<$Res> {
  __$LiveUpdateReceivedCopyWithImpl(this._self, this._then);

  final _LiveUpdateReceived _self;
  final $Res Function(_LiveUpdateReceived) _then;

/// Create a copy of NotificationsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? update = null,}) {
  return _then(_LiveUpdateReceived(
null == update ? _self.update : update // ignore: cast_nullable_to_non_nullable
as LiveUpdate<AppNotification>,
  ));
}


}

/// @nodoc
mixin _$NotificationsState {

/// The bell's badge (NOT-01).
 int get unreadCount; bool get watching;/// Everything shown, newest first: live ones on top, then the pages.
 List<AppNotification> get notifications; List<AppNotification> get paginatedNotifications; bool get maxNotifications; bool get notificationsRefreshController;/// The ID of the last notification of the last page: the next page's
/// key.
 int get notificationsPageKey; GenericStatus get notificationsListStatus; String? get notificationsListError;/// Counts the changes made outside a page load (live, mark read), so
/// the page knows to redraw.
 int get revision; bool get reconnecting;
/// Create a copy of NotificationsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationsStateCopyWith<NotificationsState> get copyWith => _$NotificationsStateCopyWithImpl<NotificationsState>(this as NotificationsState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as NotificationsState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationsState&&(identical(other.unreadCount, _this.unreadCount) || other.unreadCount == _this.unreadCount)&&(identical(other.watching, _this.watching) || other.watching == _this.watching)&&const DeepCollectionEquality().equals(other.notifications, _this.notifications)&&const DeepCollectionEquality().equals(other.paginatedNotifications, _this.paginatedNotifications)&&(identical(other.maxNotifications, _this.maxNotifications) || other.maxNotifications == _this.maxNotifications)&&(identical(other.notificationsRefreshController, _this.notificationsRefreshController) || other.notificationsRefreshController == _this.notificationsRefreshController)&&(identical(other.notificationsPageKey, _this.notificationsPageKey) || other.notificationsPageKey == _this.notificationsPageKey)&&(identical(other.notificationsListStatus, _this.notificationsListStatus) || other.notificationsListStatus == _this.notificationsListStatus)&&(identical(other.notificationsListError, _this.notificationsListError) || other.notificationsListError == _this.notificationsListError)&&(identical(other.revision, _this.revision) || other.revision == _this.revision)&&(identical(other.reconnecting, _this.reconnecting) || other.reconnecting == _this.reconnecting));
}


@override
int get hashCode {
  final _this = this as NotificationsState;
  return Object.hash(runtimeType,_this.unreadCount,_this.watching,const DeepCollectionEquality().hash(_this.notifications),const DeepCollectionEquality().hash(_this.paginatedNotifications),_this.maxNotifications,_this.notificationsRefreshController,_this.notificationsPageKey,_this.notificationsListStatus,_this.notificationsListError,_this.revision,_this.reconnecting);
}

@override
String toString() {
  final _this = this as NotificationsState;
  return 'NotificationsState(unreadCount: ${_this.unreadCount}, watching: ${_this.watching}, notifications: ${_this.notifications}, paginatedNotifications: ${_this.paginatedNotifications}, maxNotifications: ${_this.maxNotifications}, notificationsRefreshController: ${_this.notificationsRefreshController}, notificationsPageKey: ${_this.notificationsPageKey}, notificationsListStatus: ${_this.notificationsListStatus}, notificationsListError: ${_this.notificationsListError}, revision: ${_this.revision}, reconnecting: ${_this.reconnecting})';
}


}

/// @nodoc
abstract mixin class $NotificationsStateCopyWith<$Res>  {
  factory $NotificationsStateCopyWith(NotificationsState value, $Res Function(NotificationsState) _then) = _$NotificationsStateCopyWithImpl;
@useResult
$Res call({
 int unreadCount, bool watching, List<AppNotification> notifications, List<AppNotification> paginatedNotifications, bool maxNotifications, bool notificationsRefreshController, int notificationsPageKey, GenericStatus notificationsListStatus, String? notificationsListError, int revision, bool reconnecting
});




}
/// @nodoc
class _$NotificationsStateCopyWithImpl<$Res>
    implements $NotificationsStateCopyWith<$Res> {
  _$NotificationsStateCopyWithImpl(this._self, this._then);

  final NotificationsState _self;
  final $Res Function(NotificationsState) _then;

/// Create a copy of NotificationsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? unreadCount = null,Object? watching = null,Object? notifications = null,Object? paginatedNotifications = null,Object? maxNotifications = null,Object? notificationsRefreshController = null,Object? notificationsPageKey = null,Object? notificationsListStatus = null,Object? notificationsListError = freezed,Object? revision = null,Object? reconnecting = null,}) {
  return _then(NotificationsState(
unreadCount: null == unreadCount ? _self.unreadCount : unreadCount // ignore: cast_nullable_to_non_nullable
as int,watching: null == watching ? _self.watching : watching // ignore: cast_nullable_to_non_nullable
as bool,notifications: null == notifications ? _self.notifications : notifications // ignore: cast_nullable_to_non_nullable
as List<AppNotification>,paginatedNotifications: null == paginatedNotifications ? _self.paginatedNotifications : paginatedNotifications // ignore: cast_nullable_to_non_nullable
as List<AppNotification>,maxNotifications: null == maxNotifications ? _self.maxNotifications : maxNotifications // ignore: cast_nullable_to_non_nullable
as bool,notificationsRefreshController: null == notificationsRefreshController ? _self.notificationsRefreshController : notificationsRefreshController // ignore: cast_nullable_to_non_nullable
as bool,notificationsPageKey: null == notificationsPageKey ? _self.notificationsPageKey : notificationsPageKey // ignore: cast_nullable_to_non_nullable
as int,notificationsListStatus: null == notificationsListStatus ? _self.notificationsListStatus : notificationsListStatus // ignore: cast_nullable_to_non_nullable
as GenericStatus,notificationsListError: freezed == notificationsListError ? _self.notificationsListError : notificationsListError // ignore: cast_nullable_to_non_nullable
as String?,revision: null == revision ? _self.revision : revision // ignore: cast_nullable_to_non_nullable
as int,reconnecting: null == reconnecting ? _self.reconnecting : reconnecting // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationsState].
extension NotificationsStatePatterns on NotificationsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationsState value)  $default,){
final _that = this;
switch (_that) {
case _NotificationsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationsState value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int unreadCount,  bool watching,  List<AppNotification> notifications,  List<AppNotification> paginatedNotifications,  bool maxNotifications,  bool notificationsRefreshController,  int notificationsPageKey,  GenericStatus notificationsListStatus,  String? notificationsListError,  int revision,  bool reconnecting)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationsState() when $default != null:
return $default(_that.unreadCount,_that.watching,_that.notifications,_that.paginatedNotifications,_that.maxNotifications,_that.notificationsRefreshController,_that.notificationsPageKey,_that.notificationsListStatus,_that.notificationsListError,_that.revision,_that.reconnecting);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int unreadCount,  bool watching,  List<AppNotification> notifications,  List<AppNotification> paginatedNotifications,  bool maxNotifications,  bool notificationsRefreshController,  int notificationsPageKey,  GenericStatus notificationsListStatus,  String? notificationsListError,  int revision,  bool reconnecting)  $default,) {final _that = this;
switch (_that) {
case _NotificationsState():
return $default(_that.unreadCount,_that.watching,_that.notifications,_that.paginatedNotifications,_that.maxNotifications,_that.notificationsRefreshController,_that.notificationsPageKey,_that.notificationsListStatus,_that.notificationsListError,_that.revision,_that.reconnecting);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int unreadCount,  bool watching,  List<AppNotification> notifications,  List<AppNotification> paginatedNotifications,  bool maxNotifications,  bool notificationsRefreshController,  int notificationsPageKey,  GenericStatus notificationsListStatus,  String? notificationsListError,  int revision,  bool reconnecting)?  $default,) {final _that = this;
switch (_that) {
case _NotificationsState() when $default != null:
return $default(_that.unreadCount,_that.watching,_that.notifications,_that.paginatedNotifications,_that.maxNotifications,_that.notificationsRefreshController,_that.notificationsPageKey,_that.notificationsListStatus,_that.notificationsListError,_that.revision,_that.reconnecting);case _:
  return null;

}
}

}

/// @nodoc


class _NotificationsState implements NotificationsState {
  const _NotificationsState({this.unreadCount = 0, this.watching = false,  List<AppNotification> notifications = const [],  List<AppNotification> paginatedNotifications = const [], this.maxNotifications = false, this.notificationsRefreshController = false, this.notificationsPageKey = 0, this.notificationsListStatus = GenericStatus.initial, this.notificationsListError, this.revision = 0, this.reconnecting = false}): _notifications = notifications,_paginatedNotifications = paginatedNotifications;
  

/// The bell's badge (NOT-01).
@override@JsonKey() final  int unreadCount;
@override@JsonKey() final  bool watching;
/// Everything shown, newest first: live ones on top, then the pages.
 final  List<AppNotification> _notifications;
/// Everything shown, newest first: live ones on top, then the pages.
@override@JsonKey() List<AppNotification> get notifications {
  if (_notifications is EqualUnmodifiableListView) return _notifications;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_notifications);
}

 final  List<AppNotification> _paginatedNotifications;
@override@JsonKey() List<AppNotification> get paginatedNotifications {
  if (_paginatedNotifications is EqualUnmodifiableListView) return _paginatedNotifications;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_paginatedNotifications);
}

@override@JsonKey() final  bool maxNotifications;
@override@JsonKey() final  bool notificationsRefreshController;
/// The ID of the last notification of the last page: the next page's
/// key.
@override@JsonKey() final  int notificationsPageKey;
@override@JsonKey() final  GenericStatus notificationsListStatus;
@override final  String? notificationsListError;
/// Counts the changes made outside a page load (live, mark read), so
/// the page knows to redraw.
@override@JsonKey() final  int revision;
@override@JsonKey() final  bool reconnecting;

/// Create a copy of NotificationsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationsStateCopyWith<_NotificationsState> get copyWith => __$NotificationsStateCopyWithImpl<_NotificationsState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationsState&&(identical(other.unreadCount, unreadCount) || other.unreadCount == unreadCount)&&(identical(other.watching, watching) || other.watching == watching)&&const DeepCollectionEquality().equals(other.notifications, _notifications)&&const DeepCollectionEquality().equals(other.paginatedNotifications, _paginatedNotifications)&&(identical(other.maxNotifications, maxNotifications) || other.maxNotifications == maxNotifications)&&(identical(other.notificationsRefreshController, notificationsRefreshController) || other.notificationsRefreshController == notificationsRefreshController)&&(identical(other.notificationsPageKey, notificationsPageKey) || other.notificationsPageKey == notificationsPageKey)&&(identical(other.notificationsListStatus, notificationsListStatus) || other.notificationsListStatus == notificationsListStatus)&&(identical(other.notificationsListError, notificationsListError) || other.notificationsListError == notificationsListError)&&(identical(other.revision, revision) || other.revision == revision)&&(identical(other.reconnecting, reconnecting) || other.reconnecting == reconnecting));
}


@override
int get hashCode {
    return Object.hash(runtimeType,unreadCount,watching,const DeepCollectionEquality().hash(_notifications),const DeepCollectionEquality().hash(_paginatedNotifications),maxNotifications,notificationsRefreshController,notificationsPageKey,notificationsListStatus,notificationsListError,revision,reconnecting);
}

@override
String toString() {
    return 'NotificationsState(unreadCount: $unreadCount, watching: $watching, notifications: $notifications, paginatedNotifications: $paginatedNotifications, maxNotifications: $maxNotifications, notificationsRefreshController: $notificationsRefreshController, notificationsPageKey: $notificationsPageKey, notificationsListStatus: $notificationsListStatus, notificationsListError: $notificationsListError, revision: $revision, reconnecting: $reconnecting)';
}


}

/// @nodoc
abstract mixin class _$NotificationsStateCopyWith<$Res> implements $NotificationsStateCopyWith<$Res> {
  factory _$NotificationsStateCopyWith(_NotificationsState value, $Res Function(_NotificationsState) _then) = __$NotificationsStateCopyWithImpl;
@override @useResult
$Res call({
 int unreadCount, bool watching, List<AppNotification> notifications, List<AppNotification> paginatedNotifications, bool maxNotifications, bool notificationsRefreshController, int notificationsPageKey, GenericStatus notificationsListStatus, String? notificationsListError, int revision, bool reconnecting
});




}
/// @nodoc
class __$NotificationsStateCopyWithImpl<$Res>
    implements _$NotificationsStateCopyWith<$Res> {
  __$NotificationsStateCopyWithImpl(this._self, this._then);

  final _NotificationsState _self;
  final $Res Function(_NotificationsState) _then;

/// Create a copy of NotificationsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? unreadCount = null,Object? watching = null,Object? notifications = null,Object? paginatedNotifications = null,Object? maxNotifications = null,Object? notificationsRefreshController = null,Object? notificationsPageKey = null,Object? notificationsListStatus = null,Object? notificationsListError = freezed,Object? revision = null,Object? reconnecting = null,}) {
  return _then(_NotificationsState(
unreadCount: null == unreadCount ? _self.unreadCount : unreadCount // ignore: cast_nullable_to_non_nullable
as int,watching: null == watching ? _self.watching : watching // ignore: cast_nullable_to_non_nullable
as bool,notifications: null == notifications ? _self._notifications : notifications // ignore: cast_nullable_to_non_nullable
as List<AppNotification>,paginatedNotifications: null == paginatedNotifications ? _self._paginatedNotifications : paginatedNotifications // ignore: cast_nullable_to_non_nullable
as List<AppNotification>,maxNotifications: null == maxNotifications ? _self.maxNotifications : maxNotifications // ignore: cast_nullable_to_non_nullable
as bool,notificationsRefreshController: null == notificationsRefreshController ? _self.notificationsRefreshController : notificationsRefreshController // ignore: cast_nullable_to_non_nullable
as bool,notificationsPageKey: null == notificationsPageKey ? _self.notificationsPageKey : notificationsPageKey // ignore: cast_nullable_to_non_nullable
as int,notificationsListStatus: null == notificationsListStatus ? _self.notificationsListStatus : notificationsListStatus // ignore: cast_nullable_to_non_nullable
as GenericStatus,notificationsListError: freezed == notificationsListError ? _self.notificationsListError : notificationsListError // ignore: cast_nullable_to_non_nullable
as String?,revision: null == revision ? _self.revision : revision // ignore: cast_nullable_to_non_nullable
as int,reconnecting: null == reconnecting ? _self.reconnecting : reconnecting // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
