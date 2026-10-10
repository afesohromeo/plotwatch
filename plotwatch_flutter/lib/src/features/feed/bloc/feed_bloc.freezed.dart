// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feed_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FeedEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'FeedEvent()';
}


}

/// @nodoc
class $FeedEventCopyWith<$Res>  {
$FeedEventCopyWith(FeedEvent _, $Res Function(FeedEvent) __);
}


/// Adds pattern-matching-related methods to [FeedEvent].
extension FeedEventPatterns on FeedEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _FetchActivity value)?  fetchActivity,TResult Function( _RefreshActivity value)?  refreshActivity,TResult Function( _LiveUpdateReceived value)?  liveUpdateReceived,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FetchActivity() when fetchActivity != null:
return fetchActivity(_that);case _RefreshActivity() when refreshActivity != null:
return refreshActivity(_that);case _LiveUpdateReceived() when liveUpdateReceived != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _FetchActivity value)  fetchActivity,required TResult Function( _RefreshActivity value)  refreshActivity,required TResult Function( _LiveUpdateReceived value)  liveUpdateReceived,}){
final _that = this;
switch (_that) {
case _FetchActivity():
return fetchActivity(_that);case _RefreshActivity():
return refreshActivity(_that);case _LiveUpdateReceived():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _FetchActivity value)?  fetchActivity,TResult? Function( _RefreshActivity value)?  refreshActivity,TResult? Function( _LiveUpdateReceived value)?  liveUpdateReceived,}){
final _that = this;
switch (_that) {
case _FetchActivity() when fetchActivity != null:
return fetchActivity(_that);case _RefreshActivity() when refreshActivity != null:
return refreshActivity(_that);case _LiveUpdateReceived() when liveUpdateReceived != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int projectId,  int pageKey,  List<ActivityType>? types,  int? stageId,  int? size)?  fetchActivity,TResult Function()?  refreshActivity,TResult Function( LiveUpdate<ActivityEntry> update)?  liveUpdateReceived,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FetchActivity() when fetchActivity != null:
return fetchActivity(_that.projectId,_that.pageKey,_that.types,_that.stageId,_that.size);case _RefreshActivity() when refreshActivity != null:
return refreshActivity();case _LiveUpdateReceived() when liveUpdateReceived != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int projectId,  int pageKey,  List<ActivityType>? types,  int? stageId,  int? size)  fetchActivity,required TResult Function()  refreshActivity,required TResult Function( LiveUpdate<ActivityEntry> update)  liveUpdateReceived,}) {final _that = this;
switch (_that) {
case _FetchActivity():
return fetchActivity(_that.projectId,_that.pageKey,_that.types,_that.stageId,_that.size);case _RefreshActivity():
return refreshActivity();case _LiveUpdateReceived():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int projectId,  int pageKey,  List<ActivityType>? types,  int? stageId,  int? size)?  fetchActivity,TResult? Function()?  refreshActivity,TResult? Function( LiveUpdate<ActivityEntry> update)?  liveUpdateReceived,}) {final _that = this;
switch (_that) {
case _FetchActivity() when fetchActivity != null:
return fetchActivity(_that.projectId,_that.pageKey,_that.types,_that.stageId,_that.size);case _RefreshActivity() when refreshActivity != null:
return refreshActivity();case _LiveUpdateReceived() when liveUpdateReceived != null:
return liveUpdateReceived(_that.update);case _:
  return null;

}
}

}

/// @nodoc


class _FetchActivity implements FeedEvent {
  const _FetchActivity({required this.projectId, this.pageKey = 0,  List<ActivityType>? types, this.stageId, this.size}): _types = types;
  

 final  int projectId;
@JsonKey() final  int pageKey;
 final  List<ActivityType>? _types;
 List<ActivityType>? get types {
  final value = _types;
  if (value == null) return null;
  if (_types is EqualUnmodifiableListView) return _types;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  int? stageId;
 final  int? size;

/// Create a copy of FeedEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FetchActivityCopyWith<_FetchActivity> get copyWith => __$FetchActivityCopyWithImpl<_FetchActivity>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FetchActivity&&(identical(other.projectId, projectId) || other.projectId == projectId)&&(identical(other.pageKey, pageKey) || other.pageKey == pageKey)&&const DeepCollectionEquality().equals(other.types, _types)&&(identical(other.stageId, stageId) || other.stageId == stageId)&&(identical(other.size, size) || other.size == size));
}


@override
int get hashCode {
    return Object.hash(runtimeType,projectId,pageKey,const DeepCollectionEquality().hash(_types),stageId,size);
}

@override
String toString() {
    return 'FeedEvent.fetchActivity(projectId: $projectId, pageKey: $pageKey, types: $types, stageId: $stageId, size: $size)';
}


}

/// @nodoc
abstract mixin class _$FetchActivityCopyWith<$Res> implements $FeedEventCopyWith<$Res> {
  factory _$FetchActivityCopyWith(_FetchActivity value, $Res Function(_FetchActivity) _then) = __$FetchActivityCopyWithImpl;
@useResult
$Res call({
 int projectId, int pageKey, List<ActivityType>? types, int? stageId, int? size
});




}
/// @nodoc
class __$FetchActivityCopyWithImpl<$Res>
    implements _$FetchActivityCopyWith<$Res> {
  __$FetchActivityCopyWithImpl(this._self, this._then);

  final _FetchActivity _self;
  final $Res Function(_FetchActivity) _then;

/// Create a copy of FeedEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? projectId = null,Object? pageKey = null,Object? types = freezed,Object? stageId = freezed,Object? size = freezed,}) {
  return _then(_FetchActivity(
projectId: null == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as int,pageKey: null == pageKey ? _self.pageKey : pageKey // ignore: cast_nullable_to_non_nullable
as int,types: freezed == types ? _self._types : types // ignore: cast_nullable_to_non_nullable
as List<ActivityType>?,stageId: freezed == stageId ? _self.stageId : stageId // ignore: cast_nullable_to_non_nullable
as int?,size: freezed == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc


class _RefreshActivity implements FeedEvent {
  const _RefreshActivity();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RefreshActivity);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'FeedEvent.refreshActivity()';
}


}




/// @nodoc


class _LiveUpdateReceived implements FeedEvent {
  const _LiveUpdateReceived(this.update);
  

 final  LiveUpdate<ActivityEntry> update;

/// Create a copy of FeedEvent
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
    return 'FeedEvent.liveUpdateReceived(update: $update)';
}


}

/// @nodoc
abstract mixin class _$LiveUpdateReceivedCopyWith<$Res> implements $FeedEventCopyWith<$Res> {
  factory _$LiveUpdateReceivedCopyWith(_LiveUpdateReceived value, $Res Function(_LiveUpdateReceived) _then) = __$LiveUpdateReceivedCopyWithImpl;
@useResult
$Res call({
 LiveUpdate<ActivityEntry> update
});




}
/// @nodoc
class __$LiveUpdateReceivedCopyWithImpl<$Res>
    implements _$LiveUpdateReceivedCopyWith<$Res> {
  __$LiveUpdateReceivedCopyWithImpl(this._self, this._then);

  final _LiveUpdateReceived _self;
  final $Res Function(_LiveUpdateReceived) _then;

/// Create a copy of FeedEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? update = null,}) {
  return _then(_LiveUpdateReceived(
null == update ? _self.update : update // ignore: cast_nullable_to_non_nullable
as LiveUpdate<ActivityEntry>,
  ));
}


}

/// @nodoc
mixin _$FeedState {

 int? get projectId;/// Everything shown, newest first: live events on top, then the pages.
 List<ActivityEntry> get activity; List<ActivityEntry> get paginatedActivity; bool get maxActivity; bool get activityRefreshController;/// The ID of the last event of the last page: the next page's key.
 int get activityPageKey; GenericStatus get activityListStatus; String? get activityListError; List<ActivityType>? get filterTypes; int? get filterStageId;/// Counts the live events added on top, so the page knows to redraw.
 int get liveCount; bool get reconnecting;
/// Create a copy of FeedState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedStateCopyWith<FeedState> get copyWith => _$FeedStateCopyWithImpl<FeedState>(this as FeedState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as FeedState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedState&&(identical(other.projectId, _this.projectId) || other.projectId == _this.projectId)&&const DeepCollectionEquality().equals(other.activity, _this.activity)&&const DeepCollectionEquality().equals(other.paginatedActivity, _this.paginatedActivity)&&(identical(other.maxActivity, _this.maxActivity) || other.maxActivity == _this.maxActivity)&&(identical(other.activityRefreshController, _this.activityRefreshController) || other.activityRefreshController == _this.activityRefreshController)&&(identical(other.activityPageKey, _this.activityPageKey) || other.activityPageKey == _this.activityPageKey)&&(identical(other.activityListStatus, _this.activityListStatus) || other.activityListStatus == _this.activityListStatus)&&(identical(other.activityListError, _this.activityListError) || other.activityListError == _this.activityListError)&&const DeepCollectionEquality().equals(other.filterTypes, _this.filterTypes)&&(identical(other.filterStageId, _this.filterStageId) || other.filterStageId == _this.filterStageId)&&(identical(other.liveCount, _this.liveCount) || other.liveCount == _this.liveCount)&&(identical(other.reconnecting, _this.reconnecting) || other.reconnecting == _this.reconnecting));
}


@override
int get hashCode {
  final _this = this as FeedState;
  return Object.hash(runtimeType,_this.projectId,const DeepCollectionEquality().hash(_this.activity),const DeepCollectionEquality().hash(_this.paginatedActivity),_this.maxActivity,_this.activityRefreshController,_this.activityPageKey,_this.activityListStatus,_this.activityListError,const DeepCollectionEquality().hash(_this.filterTypes),_this.filterStageId,_this.liveCount,_this.reconnecting);
}

@override
String toString() {
  final _this = this as FeedState;
  return 'FeedState(projectId: ${_this.projectId}, activity: ${_this.activity}, paginatedActivity: ${_this.paginatedActivity}, maxActivity: ${_this.maxActivity}, activityRefreshController: ${_this.activityRefreshController}, activityPageKey: ${_this.activityPageKey}, activityListStatus: ${_this.activityListStatus}, activityListError: ${_this.activityListError}, filterTypes: ${_this.filterTypes}, filterStageId: ${_this.filterStageId}, liveCount: ${_this.liveCount}, reconnecting: ${_this.reconnecting})';
}


}

/// @nodoc
abstract mixin class $FeedStateCopyWith<$Res>  {
  factory $FeedStateCopyWith(FeedState value, $Res Function(FeedState) _then) = _$FeedStateCopyWithImpl;
@useResult
$Res call({
 int? projectId, List<ActivityEntry> activity, List<ActivityEntry> paginatedActivity, bool maxActivity, bool activityRefreshController, int activityPageKey, GenericStatus activityListStatus, String? activityListError, List<ActivityType>? filterTypes, int? filterStageId, int liveCount, bool reconnecting
});




}
/// @nodoc
class _$FeedStateCopyWithImpl<$Res>
    implements $FeedStateCopyWith<$Res> {
  _$FeedStateCopyWithImpl(this._self, this._then);

  final FeedState _self;
  final $Res Function(FeedState) _then;

/// Create a copy of FeedState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? projectId = freezed,Object? activity = null,Object? paginatedActivity = null,Object? maxActivity = null,Object? activityRefreshController = null,Object? activityPageKey = null,Object? activityListStatus = null,Object? activityListError = freezed,Object? filterTypes = freezed,Object? filterStageId = freezed,Object? liveCount = null,Object? reconnecting = null,}) {
  return _then(FeedState(
projectId: freezed == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as int?,activity: null == activity ? _self.activity : activity // ignore: cast_nullable_to_non_nullable
as List<ActivityEntry>,paginatedActivity: null == paginatedActivity ? _self.paginatedActivity : paginatedActivity // ignore: cast_nullable_to_non_nullable
as List<ActivityEntry>,maxActivity: null == maxActivity ? _self.maxActivity : maxActivity // ignore: cast_nullable_to_non_nullable
as bool,activityRefreshController: null == activityRefreshController ? _self.activityRefreshController : activityRefreshController // ignore: cast_nullable_to_non_nullable
as bool,activityPageKey: null == activityPageKey ? _self.activityPageKey : activityPageKey // ignore: cast_nullable_to_non_nullable
as int,activityListStatus: null == activityListStatus ? _self.activityListStatus : activityListStatus // ignore: cast_nullable_to_non_nullable
as GenericStatus,activityListError: freezed == activityListError ? _self.activityListError : activityListError // ignore: cast_nullable_to_non_nullable
as String?,filterTypes: freezed == filterTypes ? _self.filterTypes : filterTypes // ignore: cast_nullable_to_non_nullable
as List<ActivityType>?,filterStageId: freezed == filterStageId ? _self.filterStageId : filterStageId // ignore: cast_nullable_to_non_nullable
as int?,liveCount: null == liveCount ? _self.liveCount : liveCount // ignore: cast_nullable_to_non_nullable
as int,reconnecting: null == reconnecting ? _self.reconnecting : reconnecting // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [FeedState].
extension FeedStatePatterns on FeedState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FeedState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FeedState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FeedState value)  $default,){
final _that = this;
switch (_that) {
case _FeedState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FeedState value)?  $default,){
final _that = this;
switch (_that) {
case _FeedState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? projectId,  List<ActivityEntry> activity,  List<ActivityEntry> paginatedActivity,  bool maxActivity,  bool activityRefreshController,  int activityPageKey,  GenericStatus activityListStatus,  String? activityListError,  List<ActivityType>? filterTypes,  int? filterStageId,  int liveCount,  bool reconnecting)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FeedState() when $default != null:
return $default(_that.projectId,_that.activity,_that.paginatedActivity,_that.maxActivity,_that.activityRefreshController,_that.activityPageKey,_that.activityListStatus,_that.activityListError,_that.filterTypes,_that.filterStageId,_that.liveCount,_that.reconnecting);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? projectId,  List<ActivityEntry> activity,  List<ActivityEntry> paginatedActivity,  bool maxActivity,  bool activityRefreshController,  int activityPageKey,  GenericStatus activityListStatus,  String? activityListError,  List<ActivityType>? filterTypes,  int? filterStageId,  int liveCount,  bool reconnecting)  $default,) {final _that = this;
switch (_that) {
case _FeedState():
return $default(_that.projectId,_that.activity,_that.paginatedActivity,_that.maxActivity,_that.activityRefreshController,_that.activityPageKey,_that.activityListStatus,_that.activityListError,_that.filterTypes,_that.filterStageId,_that.liveCount,_that.reconnecting);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? projectId,  List<ActivityEntry> activity,  List<ActivityEntry> paginatedActivity,  bool maxActivity,  bool activityRefreshController,  int activityPageKey,  GenericStatus activityListStatus,  String? activityListError,  List<ActivityType>? filterTypes,  int? filterStageId,  int liveCount,  bool reconnecting)?  $default,) {final _that = this;
switch (_that) {
case _FeedState() when $default != null:
return $default(_that.projectId,_that.activity,_that.paginatedActivity,_that.maxActivity,_that.activityRefreshController,_that.activityPageKey,_that.activityListStatus,_that.activityListError,_that.filterTypes,_that.filterStageId,_that.liveCount,_that.reconnecting);case _:
  return null;

}
}

}

/// @nodoc


class _FeedState implements FeedState {
  const _FeedState({this.projectId,  List<ActivityEntry> activity = const [],  List<ActivityEntry> paginatedActivity = const [], this.maxActivity = false, this.activityRefreshController = false, this.activityPageKey = 0, this.activityListStatus = GenericStatus.initial, this.activityListError,  List<ActivityType>? filterTypes, this.filterStageId, this.liveCount = 0, this.reconnecting = false}): _activity = activity,_paginatedActivity = paginatedActivity,_filterTypes = filterTypes;
  

@override final  int? projectId;
/// Everything shown, newest first: live events on top, then the pages.
 final  List<ActivityEntry> _activity;
/// Everything shown, newest first: live events on top, then the pages.
@override@JsonKey() List<ActivityEntry> get activity {
  if (_activity is EqualUnmodifiableListView) return _activity;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_activity);
}

 final  List<ActivityEntry> _paginatedActivity;
@override@JsonKey() List<ActivityEntry> get paginatedActivity {
  if (_paginatedActivity is EqualUnmodifiableListView) return _paginatedActivity;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_paginatedActivity);
}

@override@JsonKey() final  bool maxActivity;
@override@JsonKey() final  bool activityRefreshController;
/// The ID of the last event of the last page: the next page's key.
@override@JsonKey() final  int activityPageKey;
@override@JsonKey() final  GenericStatus activityListStatus;
@override final  String? activityListError;
 final  List<ActivityType>? _filterTypes;
@override List<ActivityType>? get filterTypes {
  final value = _filterTypes;
  if (value == null) return null;
  if (_filterTypes is EqualUnmodifiableListView) return _filterTypes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  int? filterStageId;
/// Counts the live events added on top, so the page knows to redraw.
@override@JsonKey() final  int liveCount;
@override@JsonKey() final  bool reconnecting;

/// Create a copy of FeedState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeedStateCopyWith<_FeedState> get copyWith => __$FeedStateCopyWithImpl<_FeedState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeedState&&(identical(other.projectId, projectId) || other.projectId == projectId)&&const DeepCollectionEquality().equals(other.activity, _activity)&&const DeepCollectionEquality().equals(other.paginatedActivity, _paginatedActivity)&&(identical(other.maxActivity, maxActivity) || other.maxActivity == maxActivity)&&(identical(other.activityRefreshController, activityRefreshController) || other.activityRefreshController == activityRefreshController)&&(identical(other.activityPageKey, activityPageKey) || other.activityPageKey == activityPageKey)&&(identical(other.activityListStatus, activityListStatus) || other.activityListStatus == activityListStatus)&&(identical(other.activityListError, activityListError) || other.activityListError == activityListError)&&const DeepCollectionEquality().equals(other.filterTypes, _filterTypes)&&(identical(other.filterStageId, filterStageId) || other.filterStageId == filterStageId)&&(identical(other.liveCount, liveCount) || other.liveCount == liveCount)&&(identical(other.reconnecting, reconnecting) || other.reconnecting == reconnecting));
}


@override
int get hashCode {
    return Object.hash(runtimeType,projectId,const DeepCollectionEquality().hash(_activity),const DeepCollectionEquality().hash(_paginatedActivity),maxActivity,activityRefreshController,activityPageKey,activityListStatus,activityListError,const DeepCollectionEquality().hash(_filterTypes),filterStageId,liveCount,reconnecting);
}

@override
String toString() {
    return 'FeedState(projectId: $projectId, activity: $activity, paginatedActivity: $paginatedActivity, maxActivity: $maxActivity, activityRefreshController: $activityRefreshController, activityPageKey: $activityPageKey, activityListStatus: $activityListStatus, activityListError: $activityListError, filterTypes: $filterTypes, filterStageId: $filterStageId, liveCount: $liveCount, reconnecting: $reconnecting)';
}


}

/// @nodoc
abstract mixin class _$FeedStateCopyWith<$Res> implements $FeedStateCopyWith<$Res> {
  factory _$FeedStateCopyWith(_FeedState value, $Res Function(_FeedState) _then) = __$FeedStateCopyWithImpl;
@override @useResult
$Res call({
 int? projectId, List<ActivityEntry> activity, List<ActivityEntry> paginatedActivity, bool maxActivity, bool activityRefreshController, int activityPageKey, GenericStatus activityListStatus, String? activityListError, List<ActivityType>? filterTypes, int? filterStageId, int liveCount, bool reconnecting
});




}
/// @nodoc
class __$FeedStateCopyWithImpl<$Res>
    implements _$FeedStateCopyWith<$Res> {
  __$FeedStateCopyWithImpl(this._self, this._then);

  final _FeedState _self;
  final $Res Function(_FeedState) _then;

/// Create a copy of FeedState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? projectId = freezed,Object? activity = null,Object? paginatedActivity = null,Object? maxActivity = null,Object? activityRefreshController = null,Object? activityPageKey = null,Object? activityListStatus = null,Object? activityListError = freezed,Object? filterTypes = freezed,Object? filterStageId = freezed,Object? liveCount = null,Object? reconnecting = null,}) {
  return _then(_FeedState(
projectId: freezed == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as int?,activity: null == activity ? _self._activity : activity // ignore: cast_nullable_to_non_nullable
as List<ActivityEntry>,paginatedActivity: null == paginatedActivity ? _self._paginatedActivity : paginatedActivity // ignore: cast_nullable_to_non_nullable
as List<ActivityEntry>,maxActivity: null == maxActivity ? _self.maxActivity : maxActivity // ignore: cast_nullable_to_non_nullable
as bool,activityRefreshController: null == activityRefreshController ? _self.activityRefreshController : activityRefreshController // ignore: cast_nullable_to_non_nullable
as bool,activityPageKey: null == activityPageKey ? _self.activityPageKey : activityPageKey // ignore: cast_nullable_to_non_nullable
as int,activityListStatus: null == activityListStatus ? _self.activityListStatus : activityListStatus // ignore: cast_nullable_to_non_nullable
as GenericStatus,activityListError: freezed == activityListError ? _self.activityListError : activityListError // ignore: cast_nullable_to_non_nullable
as String?,filterTypes: freezed == filterTypes ? _self._filterTypes : filterTypes // ignore: cast_nullable_to_non_nullable
as List<ActivityType>?,filterStageId: freezed == filterStageId ? _self.filterStageId : filterStageId // ignore: cast_nullable_to_non_nullable
as int?,liveCount: null == liveCount ? _self.liveCount : liveCount // ignore: cast_nullable_to_non_nullable
as int,reconnecting: null == reconnecting ? _self.reconnecting : reconnecting // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
