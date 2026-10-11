// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'money_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MoneyEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is MoneyEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'MoneyEvent()';
}


}

/// @nodoc
class $MoneyEventCopyWith<$Res>  {
$MoneyEventCopyWith(MoneyEvent _, $Res Function(MoneyEvent) __);
}


/// Adds pattern-matching-related methods to [MoneyEvent].
extension MoneyEventPatterns on MoneyEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Load value)?  load,TResult Function( _FetchEntries value)?  fetchEntries,TResult Function( _RefreshEntries value)?  refreshEntries,TResult Function( _LiveUpdateReceived value)?  liveUpdateReceived,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Load() when load != null:
return load(_that);case _FetchEntries() when fetchEntries != null:
return fetchEntries(_that);case _RefreshEntries() when refreshEntries != null:
return refreshEntries(_that);case _LiveUpdateReceived() when liveUpdateReceived != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Load value)  load,required TResult Function( _FetchEntries value)  fetchEntries,required TResult Function( _RefreshEntries value)  refreshEntries,required TResult Function( _LiveUpdateReceived value)  liveUpdateReceived,}){
final _that = this;
switch (_that) {
case _Load():
return load(_that);case _FetchEntries():
return fetchEntries(_that);case _RefreshEntries():
return refreshEntries(_that);case _LiveUpdateReceived():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Load value)?  load,TResult? Function( _FetchEntries value)?  fetchEntries,TResult? Function( _RefreshEntries value)?  refreshEntries,TResult? Function( _LiveUpdateReceived value)?  liveUpdateReceived,}){
final _that = this;
switch (_that) {
case _Load() when load != null:
return load(_that);case _FetchEntries() when fetchEntries != null:
return fetchEntries(_that);case _RefreshEntries() when refreshEntries != null:
return refreshEntries(_that);case _LiveUpdateReceived() when liveUpdateReceived != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int projectId)?  load,TResult Function( int projectId,  int pageKey,  LedgerEntryKind? kind,  int? stageId,  int? size)?  fetchEntries,TResult Function()?  refreshEntries,TResult Function( LiveUpdate<ActivityEntry> update)?  liveUpdateReceived,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Load() when load != null:
return load(_that.projectId);case _FetchEntries() when fetchEntries != null:
return fetchEntries(_that.projectId,_that.pageKey,_that.kind,_that.stageId,_that.size);case _RefreshEntries() when refreshEntries != null:
return refreshEntries();case _LiveUpdateReceived() when liveUpdateReceived != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int projectId)  load,required TResult Function( int projectId,  int pageKey,  LedgerEntryKind? kind,  int? stageId,  int? size)  fetchEntries,required TResult Function()  refreshEntries,required TResult Function( LiveUpdate<ActivityEntry> update)  liveUpdateReceived,}) {final _that = this;
switch (_that) {
case _Load():
return load(_that.projectId);case _FetchEntries():
return fetchEntries(_that.projectId,_that.pageKey,_that.kind,_that.stageId,_that.size);case _RefreshEntries():
return refreshEntries();case _LiveUpdateReceived():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int projectId)?  load,TResult? Function( int projectId,  int pageKey,  LedgerEntryKind? kind,  int? stageId,  int? size)?  fetchEntries,TResult? Function()?  refreshEntries,TResult? Function( LiveUpdate<ActivityEntry> update)?  liveUpdateReceived,}) {final _that = this;
switch (_that) {
case _Load() when load != null:
return load(_that.projectId);case _FetchEntries() when fetchEntries != null:
return fetchEntries(_that.projectId,_that.pageKey,_that.kind,_that.stageId,_that.size);case _RefreshEntries() when refreshEntries != null:
return refreshEntries();case _LiveUpdateReceived() when liveUpdateReceived != null:
return liveUpdateReceived(_that.update);case _:
  return null;

}
}

}

/// @nodoc


class _Load implements MoneyEvent {
  const _Load({required this.projectId});
  

 final  int projectId;

/// Create a copy of MoneyEvent
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
    return 'MoneyEvent.load(projectId: $projectId)';
}


}

/// @nodoc
abstract mixin class _$LoadCopyWith<$Res> implements $MoneyEventCopyWith<$Res> {
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

/// Create a copy of MoneyEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? projectId = null,}) {
  return _then(_Load(
projectId: null == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _FetchEntries implements MoneyEvent {
  const _FetchEntries({required this.projectId, this.pageKey = 0, this.kind, this.stageId, this.size});
  

 final  int projectId;
@JsonKey() final  int pageKey;
 final  LedgerEntryKind? kind;
 final  int? stageId;
 final  int? size;

/// Create a copy of MoneyEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FetchEntriesCopyWith<_FetchEntries> get copyWith => __$FetchEntriesCopyWithImpl<_FetchEntries>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FetchEntries&&(identical(other.projectId, projectId) || other.projectId == projectId)&&(identical(other.pageKey, pageKey) || other.pageKey == pageKey)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.stageId, stageId) || other.stageId == stageId)&&(identical(other.size, size) || other.size == size));
}


@override
int get hashCode {
    return Object.hash(runtimeType,projectId,pageKey,kind,stageId,size);
}

@override
String toString() {
    return 'MoneyEvent.fetchEntries(projectId: $projectId, pageKey: $pageKey, kind: $kind, stageId: $stageId, size: $size)';
}


}

/// @nodoc
abstract mixin class _$FetchEntriesCopyWith<$Res> implements $MoneyEventCopyWith<$Res> {
  factory _$FetchEntriesCopyWith(_FetchEntries value, $Res Function(_FetchEntries) _then) = __$FetchEntriesCopyWithImpl;
@useResult
$Res call({
 int projectId, int pageKey, LedgerEntryKind? kind, int? stageId, int? size
});




}
/// @nodoc
class __$FetchEntriesCopyWithImpl<$Res>
    implements _$FetchEntriesCopyWith<$Res> {
  __$FetchEntriesCopyWithImpl(this._self, this._then);

  final _FetchEntries _self;
  final $Res Function(_FetchEntries) _then;

/// Create a copy of MoneyEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? projectId = null,Object? pageKey = null,Object? kind = freezed,Object? stageId = freezed,Object? size = freezed,}) {
  return _then(_FetchEntries(
projectId: null == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as int,pageKey: null == pageKey ? _self.pageKey : pageKey // ignore: cast_nullable_to_non_nullable
as int,kind: freezed == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as LedgerEntryKind?,stageId: freezed == stageId ? _self.stageId : stageId // ignore: cast_nullable_to_non_nullable
as int?,size: freezed == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc


class _RefreshEntries implements MoneyEvent {
  const _RefreshEntries();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RefreshEntries);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'MoneyEvent.refreshEntries()';
}


}




/// @nodoc


class _LiveUpdateReceived implements MoneyEvent {
  const _LiveUpdateReceived(this.update);
  

 final  LiveUpdate<ActivityEntry> update;

/// Create a copy of MoneyEvent
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
    return 'MoneyEvent.liveUpdateReceived(update: $update)';
}


}

/// @nodoc
abstract mixin class _$LiveUpdateReceivedCopyWith<$Res> implements $MoneyEventCopyWith<$Res> {
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

/// Create a copy of MoneyEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? update = null,}) {
  return _then(_LiveUpdateReceived(
null == update ? _self.update : update // ignore: cast_nullable_to_non_nullable
as LiveUpdate<ActivityEntry>,
  ));
}


}

/// @nodoc
mixin _$MoneyState {

 int? get projectId; LedgerSummary? get summary; GenericStatus get summaryStatus; String? get summaryError; List<LedgerEntry> get entries; List<LedgerEntry> get paginatedEntries; bool get maxEntries; bool get entriesRefreshController;/// The ID of the last entry of the last page: the next page's key.
 int get entriesPageKey; GenericStatus get entriesListStatus; String? get entriesListError; bool get reconnecting;
/// Create a copy of MoneyState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MoneyStateCopyWith<MoneyState> get copyWith => _$MoneyStateCopyWithImpl<MoneyState>(this as MoneyState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as MoneyState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MoneyState&&(identical(other.projectId, _this.projectId) || other.projectId == _this.projectId)&&(identical(other.summary, _this.summary) || other.summary == _this.summary)&&(identical(other.summaryStatus, _this.summaryStatus) || other.summaryStatus == _this.summaryStatus)&&(identical(other.summaryError, _this.summaryError) || other.summaryError == _this.summaryError)&&const DeepCollectionEquality().equals(other.entries, _this.entries)&&const DeepCollectionEquality().equals(other.paginatedEntries, _this.paginatedEntries)&&(identical(other.maxEntries, _this.maxEntries) || other.maxEntries == _this.maxEntries)&&(identical(other.entriesRefreshController, _this.entriesRefreshController) || other.entriesRefreshController == _this.entriesRefreshController)&&(identical(other.entriesPageKey, _this.entriesPageKey) || other.entriesPageKey == _this.entriesPageKey)&&(identical(other.entriesListStatus, _this.entriesListStatus) || other.entriesListStatus == _this.entriesListStatus)&&(identical(other.entriesListError, _this.entriesListError) || other.entriesListError == _this.entriesListError)&&(identical(other.reconnecting, _this.reconnecting) || other.reconnecting == _this.reconnecting));
}


@override
int get hashCode {
  final _this = this as MoneyState;
  return Object.hash(runtimeType,_this.projectId,_this.summary,_this.summaryStatus,_this.summaryError,const DeepCollectionEquality().hash(_this.entries),const DeepCollectionEquality().hash(_this.paginatedEntries),_this.maxEntries,_this.entriesRefreshController,_this.entriesPageKey,_this.entriesListStatus,_this.entriesListError,_this.reconnecting);
}

@override
String toString() {
  final _this = this as MoneyState;
  return 'MoneyState(projectId: ${_this.projectId}, summary: ${_this.summary}, summaryStatus: ${_this.summaryStatus}, summaryError: ${_this.summaryError}, entries: ${_this.entries}, paginatedEntries: ${_this.paginatedEntries}, maxEntries: ${_this.maxEntries}, entriesRefreshController: ${_this.entriesRefreshController}, entriesPageKey: ${_this.entriesPageKey}, entriesListStatus: ${_this.entriesListStatus}, entriesListError: ${_this.entriesListError}, reconnecting: ${_this.reconnecting})';
}


}

/// @nodoc
abstract mixin class $MoneyStateCopyWith<$Res>  {
  factory $MoneyStateCopyWith(MoneyState value, $Res Function(MoneyState) _then) = _$MoneyStateCopyWithImpl;
@useResult
$Res call({
 int? projectId, LedgerSummary? summary, GenericStatus summaryStatus, String? summaryError, List<LedgerEntry> entries, List<LedgerEntry> paginatedEntries, bool maxEntries, bool entriesRefreshController, int entriesPageKey, GenericStatus entriesListStatus, String? entriesListError, bool reconnecting
});




}
/// @nodoc
class _$MoneyStateCopyWithImpl<$Res>
    implements $MoneyStateCopyWith<$Res> {
  _$MoneyStateCopyWithImpl(this._self, this._then);

  final MoneyState _self;
  final $Res Function(MoneyState) _then;

/// Create a copy of MoneyState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? projectId = freezed,Object? summary = freezed,Object? summaryStatus = null,Object? summaryError = freezed,Object? entries = null,Object? paginatedEntries = null,Object? maxEntries = null,Object? entriesRefreshController = null,Object? entriesPageKey = null,Object? entriesListStatus = null,Object? entriesListError = freezed,Object? reconnecting = null,}) {
  return _then(MoneyState(
projectId: freezed == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as int?,summary: freezed == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as LedgerSummary?,summaryStatus: null == summaryStatus ? _self.summaryStatus : summaryStatus // ignore: cast_nullable_to_non_nullable
as GenericStatus,summaryError: freezed == summaryError ? _self.summaryError : summaryError // ignore: cast_nullable_to_non_nullable
as String?,entries: null == entries ? _self.entries : entries // ignore: cast_nullable_to_non_nullable
as List<LedgerEntry>,paginatedEntries: null == paginatedEntries ? _self.paginatedEntries : paginatedEntries // ignore: cast_nullable_to_non_nullable
as List<LedgerEntry>,maxEntries: null == maxEntries ? _self.maxEntries : maxEntries // ignore: cast_nullable_to_non_nullable
as bool,entriesRefreshController: null == entriesRefreshController ? _self.entriesRefreshController : entriesRefreshController // ignore: cast_nullable_to_non_nullable
as bool,entriesPageKey: null == entriesPageKey ? _self.entriesPageKey : entriesPageKey // ignore: cast_nullable_to_non_nullable
as int,entriesListStatus: null == entriesListStatus ? _self.entriesListStatus : entriesListStatus // ignore: cast_nullable_to_non_nullable
as GenericStatus,entriesListError: freezed == entriesListError ? _self.entriesListError : entriesListError // ignore: cast_nullable_to_non_nullable
as String?,reconnecting: null == reconnecting ? _self.reconnecting : reconnecting // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [MoneyState].
extension MoneyStatePatterns on MoneyState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MoneyState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MoneyState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MoneyState value)  $default,){
final _that = this;
switch (_that) {
case _MoneyState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MoneyState value)?  $default,){
final _that = this;
switch (_that) {
case _MoneyState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? projectId,  LedgerSummary? summary,  GenericStatus summaryStatus,  String? summaryError,  List<LedgerEntry> entries,  List<LedgerEntry> paginatedEntries,  bool maxEntries,  bool entriesRefreshController,  int entriesPageKey,  GenericStatus entriesListStatus,  String? entriesListError,  bool reconnecting)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MoneyState() when $default != null:
return $default(_that.projectId,_that.summary,_that.summaryStatus,_that.summaryError,_that.entries,_that.paginatedEntries,_that.maxEntries,_that.entriesRefreshController,_that.entriesPageKey,_that.entriesListStatus,_that.entriesListError,_that.reconnecting);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? projectId,  LedgerSummary? summary,  GenericStatus summaryStatus,  String? summaryError,  List<LedgerEntry> entries,  List<LedgerEntry> paginatedEntries,  bool maxEntries,  bool entriesRefreshController,  int entriesPageKey,  GenericStatus entriesListStatus,  String? entriesListError,  bool reconnecting)  $default,) {final _that = this;
switch (_that) {
case _MoneyState():
return $default(_that.projectId,_that.summary,_that.summaryStatus,_that.summaryError,_that.entries,_that.paginatedEntries,_that.maxEntries,_that.entriesRefreshController,_that.entriesPageKey,_that.entriesListStatus,_that.entriesListError,_that.reconnecting);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? projectId,  LedgerSummary? summary,  GenericStatus summaryStatus,  String? summaryError,  List<LedgerEntry> entries,  List<LedgerEntry> paginatedEntries,  bool maxEntries,  bool entriesRefreshController,  int entriesPageKey,  GenericStatus entriesListStatus,  String? entriesListError,  bool reconnecting)?  $default,) {final _that = this;
switch (_that) {
case _MoneyState() when $default != null:
return $default(_that.projectId,_that.summary,_that.summaryStatus,_that.summaryError,_that.entries,_that.paginatedEntries,_that.maxEntries,_that.entriesRefreshController,_that.entriesPageKey,_that.entriesListStatus,_that.entriesListError,_that.reconnecting);case _:
  return null;

}
}

}

/// @nodoc


class _MoneyState implements MoneyState {
  const _MoneyState({this.projectId, this.summary, this.summaryStatus = GenericStatus.initial, this.summaryError,  List<LedgerEntry> entries = const [],  List<LedgerEntry> paginatedEntries = const [], this.maxEntries = false, this.entriesRefreshController = false, this.entriesPageKey = 0, this.entriesListStatus = GenericStatus.initial, this.entriesListError, this.reconnecting = false}): _entries = entries,_paginatedEntries = paginatedEntries;
  

@override final  int? projectId;
@override final  LedgerSummary? summary;
@override@JsonKey() final  GenericStatus summaryStatus;
@override final  String? summaryError;
 final  List<LedgerEntry> _entries;
@override@JsonKey() List<LedgerEntry> get entries {
  if (_entries is EqualUnmodifiableListView) return _entries;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_entries);
}

 final  List<LedgerEntry> _paginatedEntries;
@override@JsonKey() List<LedgerEntry> get paginatedEntries {
  if (_paginatedEntries is EqualUnmodifiableListView) return _paginatedEntries;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_paginatedEntries);
}

@override@JsonKey() final  bool maxEntries;
@override@JsonKey() final  bool entriesRefreshController;
/// The ID of the last entry of the last page: the next page's key.
@override@JsonKey() final  int entriesPageKey;
@override@JsonKey() final  GenericStatus entriesListStatus;
@override final  String? entriesListError;
@override@JsonKey() final  bool reconnecting;

/// Create a copy of MoneyState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MoneyStateCopyWith<_MoneyState> get copyWith => __$MoneyStateCopyWithImpl<_MoneyState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MoneyState&&(identical(other.projectId, projectId) || other.projectId == projectId)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.summaryStatus, summaryStatus) || other.summaryStatus == summaryStatus)&&(identical(other.summaryError, summaryError) || other.summaryError == summaryError)&&const DeepCollectionEquality().equals(other.entries, _entries)&&const DeepCollectionEquality().equals(other.paginatedEntries, _paginatedEntries)&&(identical(other.maxEntries, maxEntries) || other.maxEntries == maxEntries)&&(identical(other.entriesRefreshController, entriesRefreshController) || other.entriesRefreshController == entriesRefreshController)&&(identical(other.entriesPageKey, entriesPageKey) || other.entriesPageKey == entriesPageKey)&&(identical(other.entriesListStatus, entriesListStatus) || other.entriesListStatus == entriesListStatus)&&(identical(other.entriesListError, entriesListError) || other.entriesListError == entriesListError)&&(identical(other.reconnecting, reconnecting) || other.reconnecting == reconnecting));
}


@override
int get hashCode {
    return Object.hash(runtimeType,projectId,summary,summaryStatus,summaryError,const DeepCollectionEquality().hash(_entries),const DeepCollectionEquality().hash(_paginatedEntries),maxEntries,entriesRefreshController,entriesPageKey,entriesListStatus,entriesListError,reconnecting);
}

@override
String toString() {
    return 'MoneyState(projectId: $projectId, summary: $summary, summaryStatus: $summaryStatus, summaryError: $summaryError, entries: $entries, paginatedEntries: $paginatedEntries, maxEntries: $maxEntries, entriesRefreshController: $entriesRefreshController, entriesPageKey: $entriesPageKey, entriesListStatus: $entriesListStatus, entriesListError: $entriesListError, reconnecting: $reconnecting)';
}


}

/// @nodoc
abstract mixin class _$MoneyStateCopyWith<$Res> implements $MoneyStateCopyWith<$Res> {
  factory _$MoneyStateCopyWith(_MoneyState value, $Res Function(_MoneyState) _then) = __$MoneyStateCopyWithImpl;
@override @useResult
$Res call({
 int? projectId, LedgerSummary? summary, GenericStatus summaryStatus, String? summaryError, List<LedgerEntry> entries, List<LedgerEntry> paginatedEntries, bool maxEntries, bool entriesRefreshController, int entriesPageKey, GenericStatus entriesListStatus, String? entriesListError, bool reconnecting
});




}
/// @nodoc
class __$MoneyStateCopyWithImpl<$Res>
    implements _$MoneyStateCopyWith<$Res> {
  __$MoneyStateCopyWithImpl(this._self, this._then);

  final _MoneyState _self;
  final $Res Function(_MoneyState) _then;

/// Create a copy of MoneyState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? projectId = freezed,Object? summary = freezed,Object? summaryStatus = null,Object? summaryError = freezed,Object? entries = null,Object? paginatedEntries = null,Object? maxEntries = null,Object? entriesRefreshController = null,Object? entriesPageKey = null,Object? entriesListStatus = null,Object? entriesListError = freezed,Object? reconnecting = null,}) {
  return _then(_MoneyState(
projectId: freezed == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as int?,summary: freezed == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as LedgerSummary?,summaryStatus: null == summaryStatus ? _self.summaryStatus : summaryStatus // ignore: cast_nullable_to_non_nullable
as GenericStatus,summaryError: freezed == summaryError ? _self.summaryError : summaryError // ignore: cast_nullable_to_non_nullable
as String?,entries: null == entries ? _self._entries : entries // ignore: cast_nullable_to_non_nullable
as List<LedgerEntry>,paginatedEntries: null == paginatedEntries ? _self._paginatedEntries : paginatedEntries // ignore: cast_nullable_to_non_nullable
as List<LedgerEntry>,maxEntries: null == maxEntries ? _self.maxEntries : maxEntries // ignore: cast_nullable_to_non_nullable
as bool,entriesRefreshController: null == entriesRefreshController ? _self.entriesRefreshController : entriesRefreshController // ignore: cast_nullable_to_non_nullable
as bool,entriesPageKey: null == entriesPageKey ? _self.entriesPageKey : entriesPageKey // ignore: cast_nullable_to_non_nullable
as int,entriesListStatus: null == entriesListStatus ? _self.entriesListStatus : entriesListStatus // ignore: cast_nullable_to_non_nullable
as GenericStatus,entriesListError: freezed == entriesListError ? _self.entriesListError : entriesListError // ignore: cast_nullable_to_non_nullable
as String?,reconnecting: null == reconnecting ? _self.reconnecting : reconnecting // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
