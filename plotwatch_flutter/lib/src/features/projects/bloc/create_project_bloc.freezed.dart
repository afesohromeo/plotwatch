// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_project_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CreateProjectEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateProjectEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'CreateProjectEvent()';
}


}

/// @nodoc
class $CreateProjectEventCopyWith<$Res>  {
$CreateProjectEventCopyWith(CreateProjectEvent _, $Res Function(CreateProjectEvent) __);
}


/// Adds pattern-matching-related methods to [CreateProjectEvent].
extension CreateProjectEventPatterns on CreateProjectEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _DetailsSubmitted value)?  detailsSubmitted,TResult Function( _TemplateChosen value)?  templateChosen,TResult Function( _StagesSubmitted value)?  stagesSubmitted,TResult Function( _StepBack value)?  stepBack,TResult Function( _CreateSubmitted value)?  createSubmitted,TResult Function( _ResetFlowStep value)?  resetFlowStep,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DetailsSubmitted() when detailsSubmitted != null:
return detailsSubmitted(_that);case _TemplateChosen() when templateChosen != null:
return templateChosen(_that);case _StagesSubmitted() when stagesSubmitted != null:
return stagesSubmitted(_that);case _StepBack() when stepBack != null:
return stepBack(_that);case _CreateSubmitted() when createSubmitted != null:
return createSubmitted(_that);case _ResetFlowStep() when resetFlowStep != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _DetailsSubmitted value)  detailsSubmitted,required TResult Function( _TemplateChosen value)  templateChosen,required TResult Function( _StagesSubmitted value)  stagesSubmitted,required TResult Function( _StepBack value)  stepBack,required TResult Function( _CreateSubmitted value)  createSubmitted,required TResult Function( _ResetFlowStep value)  resetFlowStep,}){
final _that = this;
switch (_that) {
case _DetailsSubmitted():
return detailsSubmitted(_that);case _TemplateChosen():
return templateChosen(_that);case _StagesSubmitted():
return stagesSubmitted(_that);case _StepBack():
return stepBack(_that);case _CreateSubmitted():
return createSubmitted(_that);case _ResetFlowStep():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _DetailsSubmitted value)?  detailsSubmitted,TResult? Function( _TemplateChosen value)?  templateChosen,TResult? Function( _StagesSubmitted value)?  stagesSubmitted,TResult? Function( _StepBack value)?  stepBack,TResult? Function( _CreateSubmitted value)?  createSubmitted,TResult? Function( _ResetFlowStep value)?  resetFlowStep,}){
final _that = this;
switch (_that) {
case _DetailsSubmitted() when detailsSubmitted != null:
return detailsSubmitted(_that);case _TemplateChosen() when templateChosen != null:
return templateChosen(_that);case _StagesSubmitted() when stagesSubmitted != null:
return stagesSubmitted(_that);case _StepBack() when stepBack != null:
return stepBack(_that);case _CreateSubmitted() when createSubmitted != null:
return createSubmitted(_that);case _ResetFlowStep() when resetFlowStep != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( ProjectDetails details)?  detailsSubmitted,TResult Function( StageTemplate template)?  templateChosen,TResult Function()?  stagesSubmitted,TResult Function()?  stepBack,TResult Function()?  createSubmitted,TResult Function()?  resetFlowStep,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DetailsSubmitted() when detailsSubmitted != null:
return detailsSubmitted(_that.details);case _TemplateChosen() when templateChosen != null:
return templateChosen(_that.template);case _StagesSubmitted() when stagesSubmitted != null:
return stagesSubmitted();case _StepBack() when stepBack != null:
return stepBack();case _CreateSubmitted() when createSubmitted != null:
return createSubmitted();case _ResetFlowStep() when resetFlowStep != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( ProjectDetails details)  detailsSubmitted,required TResult Function( StageTemplate template)  templateChosen,required TResult Function()  stagesSubmitted,required TResult Function()  stepBack,required TResult Function()  createSubmitted,required TResult Function()  resetFlowStep,}) {final _that = this;
switch (_that) {
case _DetailsSubmitted():
return detailsSubmitted(_that.details);case _TemplateChosen():
return templateChosen(_that.template);case _StagesSubmitted():
return stagesSubmitted();case _StepBack():
return stepBack();case _CreateSubmitted():
return createSubmitted();case _ResetFlowStep():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( ProjectDetails details)?  detailsSubmitted,TResult? Function( StageTemplate template)?  templateChosen,TResult? Function()?  stagesSubmitted,TResult? Function()?  stepBack,TResult? Function()?  createSubmitted,TResult? Function()?  resetFlowStep,}) {final _that = this;
switch (_that) {
case _DetailsSubmitted() when detailsSubmitted != null:
return detailsSubmitted(_that.details);case _TemplateChosen() when templateChosen != null:
return templateChosen(_that.template);case _StagesSubmitted() when stagesSubmitted != null:
return stagesSubmitted();case _StepBack() when stepBack != null:
return stepBack();case _CreateSubmitted() when createSubmitted != null:
return createSubmitted();case _ResetFlowStep() when resetFlowStep != null:
return resetFlowStep();case _:
  return null;

}
}

}

/// @nodoc


class _DetailsSubmitted implements CreateProjectEvent {
  const _DetailsSubmitted({required this.details});
  

 final  ProjectDetails details;

/// Create a copy of CreateProjectEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DetailsSubmittedCopyWith<_DetailsSubmitted> get copyWith => __$DetailsSubmittedCopyWithImpl<_DetailsSubmitted>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DetailsSubmitted&&(identical(other.details, details) || other.details == details));
}


@override
int get hashCode {
    return Object.hash(runtimeType,details);
}

@override
String toString() {
    return 'CreateProjectEvent.detailsSubmitted(details: $details)';
}


}

/// @nodoc
abstract mixin class _$DetailsSubmittedCopyWith<$Res> implements $CreateProjectEventCopyWith<$Res> {
  factory _$DetailsSubmittedCopyWith(_DetailsSubmitted value, $Res Function(_DetailsSubmitted) _then) = __$DetailsSubmittedCopyWithImpl;
@useResult
$Res call({
 ProjectDetails details
});




}
/// @nodoc
class __$DetailsSubmittedCopyWithImpl<$Res>
    implements _$DetailsSubmittedCopyWith<$Res> {
  __$DetailsSubmittedCopyWithImpl(this._self, this._then);

  final _DetailsSubmitted _self;
  final $Res Function(_DetailsSubmitted) _then;

/// Create a copy of CreateProjectEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? details = null,}) {
  return _then(_DetailsSubmitted(
details: null == details ? _self.details : details // ignore: cast_nullable_to_non_nullable
as ProjectDetails,
  ));
}


}

/// @nodoc


class _TemplateChosen implements CreateProjectEvent {
  const _TemplateChosen({required this.template});
  

 final  StageTemplate template;

/// Create a copy of CreateProjectEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TemplateChosenCopyWith<_TemplateChosen> get copyWith => __$TemplateChosenCopyWithImpl<_TemplateChosen>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TemplateChosen&&(identical(other.template, template) || other.template == template));
}


@override
int get hashCode {
    return Object.hash(runtimeType,template);
}

@override
String toString() {
    return 'CreateProjectEvent.templateChosen(template: $template)';
}


}

/// @nodoc
abstract mixin class _$TemplateChosenCopyWith<$Res> implements $CreateProjectEventCopyWith<$Res> {
  factory _$TemplateChosenCopyWith(_TemplateChosen value, $Res Function(_TemplateChosen) _then) = __$TemplateChosenCopyWithImpl;
@useResult
$Res call({
 StageTemplate template
});




}
/// @nodoc
class __$TemplateChosenCopyWithImpl<$Res>
    implements _$TemplateChosenCopyWith<$Res> {
  __$TemplateChosenCopyWithImpl(this._self, this._then);

  final _TemplateChosen _self;
  final $Res Function(_TemplateChosen) _then;

/// Create a copy of CreateProjectEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? template = null,}) {
  return _then(_TemplateChosen(
template: null == template ? _self.template : template // ignore: cast_nullable_to_non_nullable
as StageTemplate,
  ));
}


}

/// @nodoc


class _StagesSubmitted implements CreateProjectEvent {
  const _StagesSubmitted();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _StagesSubmitted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'CreateProjectEvent.stagesSubmitted()';
}


}




/// @nodoc


class _StepBack implements CreateProjectEvent {
  const _StepBack();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _StepBack);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'CreateProjectEvent.stepBack()';
}


}




/// @nodoc


class _CreateSubmitted implements CreateProjectEvent {
  const _CreateSubmitted();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateSubmitted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'CreateProjectEvent.createSubmitted()';
}


}




/// @nodoc


class _ResetFlowStep implements CreateProjectEvent {
  const _ResetFlowStep();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResetFlowStep);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'CreateProjectEvent.resetFlowStep()';
}


}




/// @nodoc
mixin _$CreateProjectState {

 CreateProjectStep get step; ProjectDetails? get details;/// The stage plan to start from; editable after creation.
 StageTemplate get template; GenericStatus get createStatus; String? get createErrorMessage;/// The new project, once created; the page then opens it.
 ProjectOverview? get created;
/// Create a copy of CreateProjectState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateProjectStateCopyWith<CreateProjectState> get copyWith => _$CreateProjectStateCopyWithImpl<CreateProjectState>(this as CreateProjectState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as CreateProjectState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateProjectState&&(identical(other.step, _this.step) || other.step == _this.step)&&(identical(other.details, _this.details) || other.details == _this.details)&&(identical(other.template, _this.template) || other.template == _this.template)&&(identical(other.createStatus, _this.createStatus) || other.createStatus == _this.createStatus)&&(identical(other.createErrorMessage, _this.createErrorMessage) || other.createErrorMessage == _this.createErrorMessage)&&(identical(other.created, _this.created) || other.created == _this.created));
}


@override
int get hashCode {
  final _this = this as CreateProjectState;
  return Object.hash(runtimeType,_this.step,_this.details,_this.template,_this.createStatus,_this.createErrorMessage,_this.created);
}

@override
String toString() {
  final _this = this as CreateProjectState;
  return 'CreateProjectState(step: ${_this.step}, details: ${_this.details}, template: ${_this.template}, createStatus: ${_this.createStatus}, createErrorMessage: ${_this.createErrorMessage}, created: ${_this.created})';
}


}

/// @nodoc
abstract mixin class $CreateProjectStateCopyWith<$Res>  {
  factory $CreateProjectStateCopyWith(CreateProjectState value, $Res Function(CreateProjectState) _then) = _$CreateProjectStateCopyWithImpl;
@useResult
$Res call({
 CreateProjectStep step, ProjectDetails? details, StageTemplate template, GenericStatus createStatus, String? createErrorMessage, ProjectOverview? created
});




}
/// @nodoc
class _$CreateProjectStateCopyWithImpl<$Res>
    implements $CreateProjectStateCopyWith<$Res> {
  _$CreateProjectStateCopyWithImpl(this._self, this._then);

  final CreateProjectState _self;
  final $Res Function(CreateProjectState) _then;

/// Create a copy of CreateProjectState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? step = null,Object? details = freezed,Object? template = null,Object? createStatus = null,Object? createErrorMessage = freezed,Object? created = freezed,}) {
  return _then(CreateProjectState(
step: null == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as CreateProjectStep,details: freezed == details ? _self.details : details // ignore: cast_nullable_to_non_nullable
as ProjectDetails?,template: null == template ? _self.template : template // ignore: cast_nullable_to_non_nullable
as StageTemplate,createStatus: null == createStatus ? _self.createStatus : createStatus // ignore: cast_nullable_to_non_nullable
as GenericStatus,createErrorMessage: freezed == createErrorMessage ? _self.createErrorMessage : createErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,created: freezed == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as ProjectOverview?,
  ));
}

}


/// Adds pattern-matching-related methods to [CreateProjectState].
extension CreateProjectStatePatterns on CreateProjectState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateProjectState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateProjectState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateProjectState value)  $default,){
final _that = this;
switch (_that) {
case _CreateProjectState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateProjectState value)?  $default,){
final _that = this;
switch (_that) {
case _CreateProjectState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CreateProjectStep step,  ProjectDetails? details,  StageTemplate template,  GenericStatus createStatus,  String? createErrorMessage,  ProjectOverview? created)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateProjectState() when $default != null:
return $default(_that.step,_that.details,_that.template,_that.createStatus,_that.createErrorMessage,_that.created);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CreateProjectStep step,  ProjectDetails? details,  StageTemplate template,  GenericStatus createStatus,  String? createErrorMessage,  ProjectOverview? created)  $default,) {final _that = this;
switch (_that) {
case _CreateProjectState():
return $default(_that.step,_that.details,_that.template,_that.createStatus,_that.createErrorMessage,_that.created);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CreateProjectStep step,  ProjectDetails? details,  StageTemplate template,  GenericStatus createStatus,  String? createErrorMessage,  ProjectOverview? created)?  $default,) {final _that = this;
switch (_that) {
case _CreateProjectState() when $default != null:
return $default(_that.step,_that.details,_that.template,_that.createStatus,_that.createErrorMessage,_that.created);case _:
  return null;

}
}

}

/// @nodoc


class _CreateProjectState implements CreateProjectState {
  const _CreateProjectState({this.step = CreateProjectStep.details, this.details, this.template = StageTemplate.singleStoreyHouse, this.createStatus = GenericStatus.initial, this.createErrorMessage, this.created});
  

@override@JsonKey() final  CreateProjectStep step;
@override final  ProjectDetails? details;
/// The stage plan to start from; editable after creation.
@override@JsonKey() final  StageTemplate template;
@override@JsonKey() final  GenericStatus createStatus;
@override final  String? createErrorMessage;
/// The new project, once created; the page then opens it.
@override final  ProjectOverview? created;

/// Create a copy of CreateProjectState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateProjectStateCopyWith<_CreateProjectState> get copyWith => __$CreateProjectStateCopyWithImpl<_CreateProjectState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateProjectState&&(identical(other.step, step) || other.step == step)&&(identical(other.details, details) || other.details == details)&&(identical(other.template, template) || other.template == template)&&(identical(other.createStatus, createStatus) || other.createStatus == createStatus)&&(identical(other.createErrorMessage, createErrorMessage) || other.createErrorMessage == createErrorMessage)&&(identical(other.created, created) || other.created == created));
}


@override
int get hashCode {
    return Object.hash(runtimeType,step,details,template,createStatus,createErrorMessage,created);
}

@override
String toString() {
    return 'CreateProjectState(step: $step, details: $details, template: $template, createStatus: $createStatus, createErrorMessage: $createErrorMessage, created: $created)';
}


}

/// @nodoc
abstract mixin class _$CreateProjectStateCopyWith<$Res> implements $CreateProjectStateCopyWith<$Res> {
  factory _$CreateProjectStateCopyWith(_CreateProjectState value, $Res Function(_CreateProjectState) _then) = __$CreateProjectStateCopyWithImpl;
@override @useResult
$Res call({
 CreateProjectStep step, ProjectDetails? details, StageTemplate template, GenericStatus createStatus, String? createErrorMessage, ProjectOverview? created
});




}
/// @nodoc
class __$CreateProjectStateCopyWithImpl<$Res>
    implements _$CreateProjectStateCopyWith<$Res> {
  __$CreateProjectStateCopyWithImpl(this._self, this._then);

  final _CreateProjectState _self;
  final $Res Function(_CreateProjectState) _then;

/// Create a copy of CreateProjectState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? step = null,Object? details = freezed,Object? template = null,Object? createStatus = null,Object? createErrorMessage = freezed,Object? created = freezed,}) {
  return _then(_CreateProjectState(
step: null == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as CreateProjectStep,details: freezed == details ? _self.details : details // ignore: cast_nullable_to_non_nullable
as ProjectDetails?,template: null == template ? _self.template : template // ignore: cast_nullable_to_non_nullable
as StageTemplate,createStatus: null == createStatus ? _self.createStatus : createStatus // ignore: cast_nullable_to_non_nullable
as GenericStatus,createErrorMessage: freezed == createErrorMessage ? _self.createErrorMessage : createErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,created: freezed == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as ProjectOverview?,
  ));
}


}

// dart format on
