// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'project_list_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProjectListEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ProjectListEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'ProjectListEvent()';
}


}

/// @nodoc
class $ProjectListEventCopyWith<$Res>  {
$ProjectListEventCopyWith(ProjectListEvent _, $Res Function(ProjectListEvent) __);
}


/// Adds pattern-matching-related methods to [ProjectListEvent].
extension ProjectListEventPatterns on ProjectListEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _FetchProjects value)?  fetchProjects,TResult Function( _RefreshProjects value)?  refreshProjects,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FetchProjects() when fetchProjects != null:
return fetchProjects(_that);case _RefreshProjects() when refreshProjects != null:
return refreshProjects(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _FetchProjects value)  fetchProjects,required TResult Function( _RefreshProjects value)  refreshProjects,}){
final _that = this;
switch (_that) {
case _FetchProjects():
return fetchProjects(_that);case _RefreshProjects():
return refreshProjects(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _FetchProjects value)?  fetchProjects,TResult? Function( _RefreshProjects value)?  refreshProjects,}){
final _that = this;
switch (_that) {
case _FetchProjects() when fetchProjects != null:
return fetchProjects(_that);case _RefreshProjects() when refreshProjects != null:
return refreshProjects(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int pageKey,  String? searchTerm,  ProjectStatus? statusFilter,  ProjectSort? sort,  int? size)?  fetchProjects,TResult Function()?  refreshProjects,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FetchProjects() when fetchProjects != null:
return fetchProjects(_that.pageKey,_that.searchTerm,_that.statusFilter,_that.sort,_that.size);case _RefreshProjects() when refreshProjects != null:
return refreshProjects();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int pageKey,  String? searchTerm,  ProjectStatus? statusFilter,  ProjectSort? sort,  int? size)  fetchProjects,required TResult Function()  refreshProjects,}) {final _that = this;
switch (_that) {
case _FetchProjects():
return fetchProjects(_that.pageKey,_that.searchTerm,_that.statusFilter,_that.sort,_that.size);case _RefreshProjects():
return refreshProjects();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int pageKey,  String? searchTerm,  ProjectStatus? statusFilter,  ProjectSort? sort,  int? size)?  fetchProjects,TResult? Function()?  refreshProjects,}) {final _that = this;
switch (_that) {
case _FetchProjects() when fetchProjects != null:
return fetchProjects(_that.pageKey,_that.searchTerm,_that.statusFilter,_that.sort,_that.size);case _RefreshProjects() when refreshProjects != null:
return refreshProjects();case _:
  return null;

}
}

}

/// @nodoc


class _FetchProjects implements ProjectListEvent {
  const _FetchProjects({this.pageKey = 0, this.searchTerm, this.statusFilter, this.sort, this.size});
  

@JsonKey() final  int pageKey;
 final  String? searchTerm;
 final  ProjectStatus? statusFilter;
 final  ProjectSort? sort;
 final  int? size;

/// Create a copy of ProjectListEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FetchProjectsCopyWith<_FetchProjects> get copyWith => __$FetchProjectsCopyWithImpl<_FetchProjects>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FetchProjects&&(identical(other.pageKey, pageKey) || other.pageKey == pageKey)&&(identical(other.searchTerm, searchTerm) || other.searchTerm == searchTerm)&&(identical(other.statusFilter, statusFilter) || other.statusFilter == statusFilter)&&(identical(other.sort, sort) || other.sort == sort)&&(identical(other.size, size) || other.size == size));
}


@override
int get hashCode {
    return Object.hash(runtimeType,pageKey,searchTerm,statusFilter,sort,size);
}

@override
String toString() {
    return 'ProjectListEvent.fetchProjects(pageKey: $pageKey, searchTerm: $searchTerm, statusFilter: $statusFilter, sort: $sort, size: $size)';
}


}

/// @nodoc
abstract mixin class _$FetchProjectsCopyWith<$Res> implements $ProjectListEventCopyWith<$Res> {
  factory _$FetchProjectsCopyWith(_FetchProjects value, $Res Function(_FetchProjects) _then) = __$FetchProjectsCopyWithImpl;
@useResult
$Res call({
 int pageKey, String? searchTerm, ProjectStatus? statusFilter, ProjectSort? sort, int? size
});




}
/// @nodoc
class __$FetchProjectsCopyWithImpl<$Res>
    implements _$FetchProjectsCopyWith<$Res> {
  __$FetchProjectsCopyWithImpl(this._self, this._then);

  final _FetchProjects _self;
  final $Res Function(_FetchProjects) _then;

/// Create a copy of ProjectListEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? pageKey = null,Object? searchTerm = freezed,Object? statusFilter = freezed,Object? sort = freezed,Object? size = freezed,}) {
  return _then(_FetchProjects(
pageKey: null == pageKey ? _self.pageKey : pageKey // ignore: cast_nullable_to_non_nullable
as int,searchTerm: freezed == searchTerm ? _self.searchTerm : searchTerm // ignore: cast_nullable_to_non_nullable
as String?,statusFilter: freezed == statusFilter ? _self.statusFilter : statusFilter // ignore: cast_nullable_to_non_nullable
as ProjectStatus?,sort: freezed == sort ? _self.sort : sort // ignore: cast_nullable_to_non_nullable
as ProjectSort?,size: freezed == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc


class _RefreshProjects implements ProjectListEvent {
  const _RefreshProjects();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RefreshProjects);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'ProjectListEvent.refreshProjects()';
}


}




/// @nodoc
mixin _$ProjectListState {

 List<ProjectSummary> get projects; List<ProjectSummary> get paginatedProjects; bool get maxProjects; bool get projectsRefreshController; int get projectsPageKey; GenericStatus get projectsListStatus; String? get projectsListError;
/// Create a copy of ProjectListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProjectListStateCopyWith<ProjectListState> get copyWith => _$ProjectListStateCopyWithImpl<ProjectListState>(this as ProjectListState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ProjectListState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProjectListState&&const DeepCollectionEquality().equals(other.projects, _this.projects)&&const DeepCollectionEquality().equals(other.paginatedProjects, _this.paginatedProjects)&&(identical(other.maxProjects, _this.maxProjects) || other.maxProjects == _this.maxProjects)&&(identical(other.projectsRefreshController, _this.projectsRefreshController) || other.projectsRefreshController == _this.projectsRefreshController)&&(identical(other.projectsPageKey, _this.projectsPageKey) || other.projectsPageKey == _this.projectsPageKey)&&(identical(other.projectsListStatus, _this.projectsListStatus) || other.projectsListStatus == _this.projectsListStatus)&&(identical(other.projectsListError, _this.projectsListError) || other.projectsListError == _this.projectsListError));
}


@override
int get hashCode {
  final _this = this as ProjectListState;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.projects),const DeepCollectionEquality().hash(_this.paginatedProjects),_this.maxProjects,_this.projectsRefreshController,_this.projectsPageKey,_this.projectsListStatus,_this.projectsListError);
}

@override
String toString() {
  final _this = this as ProjectListState;
  return 'ProjectListState(projects: ${_this.projects}, paginatedProjects: ${_this.paginatedProjects}, maxProjects: ${_this.maxProjects}, projectsRefreshController: ${_this.projectsRefreshController}, projectsPageKey: ${_this.projectsPageKey}, projectsListStatus: ${_this.projectsListStatus}, projectsListError: ${_this.projectsListError})';
}


}

/// @nodoc
abstract mixin class $ProjectListStateCopyWith<$Res>  {
  factory $ProjectListStateCopyWith(ProjectListState value, $Res Function(ProjectListState) _then) = _$ProjectListStateCopyWithImpl;
@useResult
$Res call({
 List<ProjectSummary> projects, List<ProjectSummary> paginatedProjects, bool maxProjects, bool projectsRefreshController, int projectsPageKey, GenericStatus projectsListStatus, String? projectsListError
});




}
/// @nodoc
class _$ProjectListStateCopyWithImpl<$Res>
    implements $ProjectListStateCopyWith<$Res> {
  _$ProjectListStateCopyWithImpl(this._self, this._then);

  final ProjectListState _self;
  final $Res Function(ProjectListState) _then;

/// Create a copy of ProjectListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? projects = null,Object? paginatedProjects = null,Object? maxProjects = null,Object? projectsRefreshController = null,Object? projectsPageKey = null,Object? projectsListStatus = null,Object? projectsListError = freezed,}) {
  return _then(ProjectListState(
projects: null == projects ? _self.projects : projects // ignore: cast_nullable_to_non_nullable
as List<ProjectSummary>,paginatedProjects: null == paginatedProjects ? _self.paginatedProjects : paginatedProjects // ignore: cast_nullable_to_non_nullable
as List<ProjectSummary>,maxProjects: null == maxProjects ? _self.maxProjects : maxProjects // ignore: cast_nullable_to_non_nullable
as bool,projectsRefreshController: null == projectsRefreshController ? _self.projectsRefreshController : projectsRefreshController // ignore: cast_nullable_to_non_nullable
as bool,projectsPageKey: null == projectsPageKey ? _self.projectsPageKey : projectsPageKey // ignore: cast_nullable_to_non_nullable
as int,projectsListStatus: null == projectsListStatus ? _self.projectsListStatus : projectsListStatus // ignore: cast_nullable_to_non_nullable
as GenericStatus,projectsListError: freezed == projectsListError ? _self.projectsListError : projectsListError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProjectListState].
extension ProjectListStatePatterns on ProjectListState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProjectListState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProjectListState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProjectListState value)  $default,){
final _that = this;
switch (_that) {
case _ProjectListState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProjectListState value)?  $default,){
final _that = this;
switch (_that) {
case _ProjectListState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<ProjectSummary> projects,  List<ProjectSummary> paginatedProjects,  bool maxProjects,  bool projectsRefreshController,  int projectsPageKey,  GenericStatus projectsListStatus,  String? projectsListError)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProjectListState() when $default != null:
return $default(_that.projects,_that.paginatedProjects,_that.maxProjects,_that.projectsRefreshController,_that.projectsPageKey,_that.projectsListStatus,_that.projectsListError);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<ProjectSummary> projects,  List<ProjectSummary> paginatedProjects,  bool maxProjects,  bool projectsRefreshController,  int projectsPageKey,  GenericStatus projectsListStatus,  String? projectsListError)  $default,) {final _that = this;
switch (_that) {
case _ProjectListState():
return $default(_that.projects,_that.paginatedProjects,_that.maxProjects,_that.projectsRefreshController,_that.projectsPageKey,_that.projectsListStatus,_that.projectsListError);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<ProjectSummary> projects,  List<ProjectSummary> paginatedProjects,  bool maxProjects,  bool projectsRefreshController,  int projectsPageKey,  GenericStatus projectsListStatus,  String? projectsListError)?  $default,) {final _that = this;
switch (_that) {
case _ProjectListState() when $default != null:
return $default(_that.projects,_that.paginatedProjects,_that.maxProjects,_that.projectsRefreshController,_that.projectsPageKey,_that.projectsListStatus,_that.projectsListError);case _:
  return null;

}
}

}

/// @nodoc


class _ProjectListState implements ProjectListState {
  const _ProjectListState({ List<ProjectSummary> projects = const [],  List<ProjectSummary> paginatedProjects = const [], this.maxProjects = false, this.projectsRefreshController = false, this.projectsPageKey = 0, this.projectsListStatus = GenericStatus.initial, this.projectsListError}): _projects = projects,_paginatedProjects = paginatedProjects;
  

 final  List<ProjectSummary> _projects;
@override@JsonKey() List<ProjectSummary> get projects {
  if (_projects is EqualUnmodifiableListView) return _projects;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_projects);
}

 final  List<ProjectSummary> _paginatedProjects;
@override@JsonKey() List<ProjectSummary> get paginatedProjects {
  if (_paginatedProjects is EqualUnmodifiableListView) return _paginatedProjects;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_paginatedProjects);
}

@override@JsonKey() final  bool maxProjects;
@override@JsonKey() final  bool projectsRefreshController;
@override@JsonKey() final  int projectsPageKey;
@override@JsonKey() final  GenericStatus projectsListStatus;
@override final  String? projectsListError;

/// Create a copy of ProjectListState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProjectListStateCopyWith<_ProjectListState> get copyWith => __$ProjectListStateCopyWithImpl<_ProjectListState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProjectListState&&const DeepCollectionEquality().equals(other.projects, _projects)&&const DeepCollectionEquality().equals(other.paginatedProjects, _paginatedProjects)&&(identical(other.maxProjects, maxProjects) || other.maxProjects == maxProjects)&&(identical(other.projectsRefreshController, projectsRefreshController) || other.projectsRefreshController == projectsRefreshController)&&(identical(other.projectsPageKey, projectsPageKey) || other.projectsPageKey == projectsPageKey)&&(identical(other.projectsListStatus, projectsListStatus) || other.projectsListStatus == projectsListStatus)&&(identical(other.projectsListError, projectsListError) || other.projectsListError == projectsListError));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_projects),const DeepCollectionEquality().hash(_paginatedProjects),maxProjects,projectsRefreshController,projectsPageKey,projectsListStatus,projectsListError);
}

@override
String toString() {
    return 'ProjectListState(projects: $projects, paginatedProjects: $paginatedProjects, maxProjects: $maxProjects, projectsRefreshController: $projectsRefreshController, projectsPageKey: $projectsPageKey, projectsListStatus: $projectsListStatus, projectsListError: $projectsListError)';
}


}

/// @nodoc
abstract mixin class _$ProjectListStateCopyWith<$Res> implements $ProjectListStateCopyWith<$Res> {
  factory _$ProjectListStateCopyWith(_ProjectListState value, $Res Function(_ProjectListState) _then) = __$ProjectListStateCopyWithImpl;
@override @useResult
$Res call({
 List<ProjectSummary> projects, List<ProjectSummary> paginatedProjects, bool maxProjects, bool projectsRefreshController, int projectsPageKey, GenericStatus projectsListStatus, String? projectsListError
});




}
/// @nodoc
class __$ProjectListStateCopyWithImpl<$Res>
    implements _$ProjectListStateCopyWith<$Res> {
  __$ProjectListStateCopyWithImpl(this._self, this._then);

  final _ProjectListState _self;
  final $Res Function(_ProjectListState) _then;

/// Create a copy of ProjectListState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? projects = null,Object? paginatedProjects = null,Object? maxProjects = null,Object? projectsRefreshController = null,Object? projectsPageKey = null,Object? projectsListStatus = null,Object? projectsListError = freezed,}) {
  return _then(_ProjectListState(
projects: null == projects ? _self._projects : projects // ignore: cast_nullable_to_non_nullable
as List<ProjectSummary>,paginatedProjects: null == paginatedProjects ? _self._paginatedProjects : paginatedProjects // ignore: cast_nullable_to_non_nullable
as List<ProjectSummary>,maxProjects: null == maxProjects ? _self.maxProjects : maxProjects // ignore: cast_nullable_to_non_nullable
as bool,projectsRefreshController: null == projectsRefreshController ? _self.projectsRefreshController : projectsRefreshController // ignore: cast_nullable_to_non_nullable
as bool,projectsPageKey: null == projectsPageKey ? _self.projectsPageKey : projectsPageKey // ignore: cast_nullable_to_non_nullable
as int,projectsListStatus: null == projectsListStatus ? _self.projectsListStatus : projectsListStatus // ignore: cast_nullable_to_non_nullable
as GenericStatus,projectsListError: freezed == projectsListError ? _self.projectsListError : projectsListError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
