// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quiz_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$QuizState {

 QuizMode get mode; String get stateCode; String? get topic; List<Question> get questions; int get passMark; int get index; Map<int, int> get answers; Set<int> get unlockedExplanations; bool get finished; Duration get elapsedBefore; DateTime? get runningSince;
/// Create a copy of QuizState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuizStateCopyWith<QuizState> get copyWith => _$QuizStateCopyWithImpl<QuizState>(this as QuizState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuizState&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.stateCode, stateCode) || other.stateCode == stateCode)&&(identical(other.topic, topic) || other.topic == topic)&&const DeepCollectionEquality().equals(other.questions, questions)&&(identical(other.passMark, passMark) || other.passMark == passMark)&&(identical(other.index, index) || other.index == index)&&const DeepCollectionEquality().equals(other.answers, answers)&&const DeepCollectionEquality().equals(other.unlockedExplanations, unlockedExplanations)&&(identical(other.finished, finished) || other.finished == finished)&&(identical(other.elapsedBefore, elapsedBefore) || other.elapsedBefore == elapsedBefore)&&(identical(other.runningSince, runningSince) || other.runningSince == runningSince));
}


@override
int get hashCode => Object.hash(runtimeType,mode,stateCode,topic,const DeepCollectionEquality().hash(questions),passMark,index,const DeepCollectionEquality().hash(answers),const DeepCollectionEquality().hash(unlockedExplanations),finished,elapsedBefore,runningSince);

@override
String toString() {
  return 'QuizState(mode: $mode, stateCode: $stateCode, topic: $topic, questions: $questions, passMark: $passMark, index: $index, answers: $answers, unlockedExplanations: $unlockedExplanations, finished: $finished, elapsedBefore: $elapsedBefore, runningSince: $runningSince)';
}


}

/// @nodoc
abstract mixin class $QuizStateCopyWith<$Res>  {
  factory $QuizStateCopyWith(QuizState value, $Res Function(QuizState) _then) = _$QuizStateCopyWithImpl;
@useResult
$Res call({
 QuizMode mode, String stateCode, String? topic, List<Question> questions, int passMark, int index, Map<int, int> answers, Set<int> unlockedExplanations, bool finished, Duration elapsedBefore, DateTime? runningSince
});




}
/// @nodoc
class _$QuizStateCopyWithImpl<$Res>
    implements $QuizStateCopyWith<$Res> {
  _$QuizStateCopyWithImpl(this._self, this._then);

  final QuizState _self;
  final $Res Function(QuizState) _then;

/// Create a copy of QuizState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mode = null,Object? stateCode = null,Object? topic = freezed,Object? questions = null,Object? passMark = null,Object? index = null,Object? answers = null,Object? unlockedExplanations = null,Object? finished = null,Object? elapsedBefore = null,Object? runningSince = freezed,}) {
  return _then(QuizState(
mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as QuizMode,stateCode: null == stateCode ? _self.stateCode : stateCode // ignore: cast_nullable_to_non_nullable
as String,topic: freezed == topic ? _self.topic : topic // ignore: cast_nullable_to_non_nullable
as String?,questions: null == questions ? _self.questions : questions // ignore: cast_nullable_to_non_nullable
as List<Question>,passMark: null == passMark ? _self.passMark : passMark // ignore: cast_nullable_to_non_nullable
as int,index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,answers: null == answers ? _self.answers : answers // ignore: cast_nullable_to_non_nullable
as Map<int, int>,unlockedExplanations: null == unlockedExplanations ? _self.unlockedExplanations : unlockedExplanations // ignore: cast_nullable_to_non_nullable
as Set<int>,finished: null == finished ? _self.finished : finished // ignore: cast_nullable_to_non_nullable
as bool,elapsedBefore: null == elapsedBefore ? _self.elapsedBefore : elapsedBefore // ignore: cast_nullable_to_non_nullable
as Duration,runningSince: freezed == runningSince ? _self.runningSince : runningSince // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [QuizState].
extension QuizStatePatterns on QuizState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuizState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuizState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuizState value)  $default,){
final _that = this;
switch (_that) {
case _QuizState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuizState value)?  $default,){
final _that = this;
switch (_that) {
case _QuizState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( QuizMode mode,  String stateCode,  String? topic,  List<Question> questions,  int passMark,  int index,  Map<int, int> answers,  Set<int> unlockedExplanations,  bool finished,  Duration elapsedBefore,  DateTime? runningSince)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuizState() when $default != null:
return $default(_that.mode,_that.stateCode,_that.topic,_that.questions,_that.passMark,_that.index,_that.answers,_that.unlockedExplanations,_that.finished,_that.elapsedBefore,_that.runningSince);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( QuizMode mode,  String stateCode,  String? topic,  List<Question> questions,  int passMark,  int index,  Map<int, int> answers,  Set<int> unlockedExplanations,  bool finished,  Duration elapsedBefore,  DateTime? runningSince)  $default,) {final _that = this;
switch (_that) {
case _QuizState():
return $default(_that.mode,_that.stateCode,_that.topic,_that.questions,_that.passMark,_that.index,_that.answers,_that.unlockedExplanations,_that.finished,_that.elapsedBefore,_that.runningSince);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( QuizMode mode,  String stateCode,  String? topic,  List<Question> questions,  int passMark,  int index,  Map<int, int> answers,  Set<int> unlockedExplanations,  bool finished,  Duration elapsedBefore,  DateTime? runningSince)?  $default,) {final _that = this;
switch (_that) {
case _QuizState() when $default != null:
return $default(_that.mode,_that.stateCode,_that.topic,_that.questions,_that.passMark,_that.index,_that.answers,_that.unlockedExplanations,_that.finished,_that.elapsedBefore,_that.runningSince);case _:
  return null;

}
}

}

/// @nodoc


class _QuizState extends QuizState {
  const _QuizState({required this.mode, required this.stateCode, this.topic, required  List<Question> questions, required this.passMark, this.index = 0,  Map<int, int> answers = const <int, int>{},  Set<int> unlockedExplanations = const <int>{}, this.finished = false, this.elapsedBefore = Duration.zero, this.runningSince}): _questions = questions,_answers = answers,_unlockedExplanations = unlockedExplanations,super._();
  

@override final  QuizMode mode;
@override final  String stateCode;
@override final  String? topic;
 final  List<Question> _questions;
@override List<Question> get questions {
  if (_questions is EqualUnmodifiableListView) return _questions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_questions);
}

@override final  int passMark;
@override@JsonKey() final  int index;
 final  Map<int, int> _answers;
@override@JsonKey() Map<int, int> get answers {
  if (_answers is EqualUnmodifiableMapView) return _answers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_answers);
}

 final  Set<int> _unlockedExplanations;
@override@JsonKey() Set<int> get unlockedExplanations {
  if (_unlockedExplanations is EqualUnmodifiableSetView) return _unlockedExplanations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_unlockedExplanations);
}

@override@JsonKey() final  bool finished;
@override@JsonKey() final  Duration elapsedBefore;
@override final  DateTime? runningSince;

/// Create a copy of QuizState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuizStateCopyWith<_QuizState> get copyWith => __$QuizStateCopyWithImpl<_QuizState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuizState&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.stateCode, stateCode) || other.stateCode == stateCode)&&(identical(other.topic, topic) || other.topic == topic)&&const DeepCollectionEquality().equals(other._questions, _questions)&&(identical(other.passMark, passMark) || other.passMark == passMark)&&(identical(other.index, index) || other.index == index)&&const DeepCollectionEquality().equals(other._answers, _answers)&&const DeepCollectionEquality().equals(other._unlockedExplanations, _unlockedExplanations)&&(identical(other.finished, finished) || other.finished == finished)&&(identical(other.elapsedBefore, elapsedBefore) || other.elapsedBefore == elapsedBefore)&&(identical(other.runningSince, runningSince) || other.runningSince == runningSince));
}


@override
int get hashCode => Object.hash(runtimeType,mode,stateCode,topic,const DeepCollectionEquality().hash(_questions),passMark,index,const DeepCollectionEquality().hash(_answers),const DeepCollectionEquality().hash(_unlockedExplanations),finished,elapsedBefore,runningSince);

@override
String toString() {
  return 'QuizState(mode: $mode, stateCode: $stateCode, topic: $topic, questions: $questions, passMark: $passMark, index: $index, answers: $answers, unlockedExplanations: $unlockedExplanations, finished: $finished, elapsedBefore: $elapsedBefore, runningSince: $runningSince)';
}


}

/// @nodoc
abstract mixin class _$QuizStateCopyWith<$Res> implements $QuizStateCopyWith<$Res> {
  factory _$QuizStateCopyWith(_QuizState value, $Res Function(_QuizState) _then) = __$QuizStateCopyWithImpl;
@override @useResult
$Res call({
 QuizMode mode, String stateCode, String? topic, List<Question> questions, int passMark, int index, Map<int, int> answers, Set<int> unlockedExplanations, bool finished, Duration elapsedBefore, DateTime? runningSince
});




}
/// @nodoc
class __$QuizStateCopyWithImpl<$Res>
    implements _$QuizStateCopyWith<$Res> {
  __$QuizStateCopyWithImpl(this._self, this._then);

  final _QuizState _self;
  final $Res Function(_QuizState) _then;

/// Create a copy of QuizState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mode = null,Object? stateCode = null,Object? topic = freezed,Object? questions = null,Object? passMark = null,Object? index = null,Object? answers = null,Object? unlockedExplanations = null,Object? finished = null,Object? elapsedBefore = null,Object? runningSince = freezed,}) {
  return _then(_QuizState(
mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as QuizMode,stateCode: null == stateCode ? _self.stateCode : stateCode // ignore: cast_nullable_to_non_nullable
as String,topic: freezed == topic ? _self.topic : topic // ignore: cast_nullable_to_non_nullable
as String?,questions: null == questions ? _self._questions : questions // ignore: cast_nullable_to_non_nullable
as List<Question>,passMark: null == passMark ? _self.passMark : passMark // ignore: cast_nullable_to_non_nullable
as int,index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,answers: null == answers ? _self._answers : answers // ignore: cast_nullable_to_non_nullable
as Map<int, int>,unlockedExplanations: null == unlockedExplanations ? _self._unlockedExplanations : unlockedExplanations // ignore: cast_nullable_to_non_nullable
as Set<int>,finished: null == finished ? _self.finished : finished // ignore: cast_nullable_to_non_nullable
as bool,elapsedBefore: null == elapsedBefore ? _self.elapsedBefore : elapsedBefore // ignore: cast_nullable_to_non_nullable
as Duration,runningSince: freezed == runningSince ? _self.runningSince : runningSince // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
