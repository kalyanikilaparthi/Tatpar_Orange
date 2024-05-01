// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mental_health_screening_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MentalHealthScreeningModel _$MentalHealthScreeningModelFromJson(
    Map<String, dynamic> json) {
  return _MentalHealthScreeningModel.fromJson(json);
}

/// @nodoc
mixin _$MentalHealthScreeningModel {
  @JsonKey(name: 'stage')
  String? get stage => throw _privateConstructorUsedError;
  @JsonKey(name: 'screening_date')
  DateTime? get screeningDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'Scr_date')
  String? get screeningStatus => throw _privateConstructorUsedError;
  @JsonKey(name: 'Scr_score')
  int? get screeningScore => throw _privateConstructorUsedError;
  @JsonKey(name: 'counselling_linked')
  DateTime? get counsellingLinked => throw _privateConstructorUsedError;
  @JsonKey(name: 'psychiatrist_linked')
  DateTime? get psychiatristLinked => throw _privateConstructorUsedError;
  @JsonKey(name: 'feeling_better_linkage')
  String? get feelingBetter => throw _privateConstructorUsedError;
  @JsonKey(name: 'talk_helpline_again')
  String? get talkToHelpline => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MentalHealthScreeningModelCopyWith<MentalHealthScreeningModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MentalHealthScreeningModelCopyWith<$Res> {
  factory $MentalHealthScreeningModelCopyWith(MentalHealthScreeningModel value,
          $Res Function(MentalHealthScreeningModel) then) =
      _$MentalHealthScreeningModelCopyWithImpl<$Res,
          MentalHealthScreeningModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'stage') String? stage,
      @JsonKey(name: 'screening_date') DateTime? screeningDate,
      @JsonKey(name: 'Scr_date') String? screeningStatus,
      @JsonKey(name: 'Scr_score') int? screeningScore,
      @JsonKey(name: 'counselling_linked') DateTime? counsellingLinked,
      @JsonKey(name: 'psychiatrist_linked') DateTime? psychiatristLinked,
      @JsonKey(name: 'feeling_better_linkage') String? feelingBetter,
      @JsonKey(name: 'talk_helpline_again') String? talkToHelpline});
}

/// @nodoc
class _$MentalHealthScreeningModelCopyWithImpl<$Res,
        $Val extends MentalHealthScreeningModel>
    implements $MentalHealthScreeningModelCopyWith<$Res> {
  _$MentalHealthScreeningModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stage = freezed,
    Object? screeningDate = freezed,
    Object? screeningStatus = freezed,
    Object? screeningScore = freezed,
    Object? counsellingLinked = freezed,
    Object? psychiatristLinked = freezed,
    Object? feelingBetter = freezed,
    Object? talkToHelpline = freezed,
  }) {
    return _then(_value.copyWith(
      stage: freezed == stage
          ? _value.stage
          : stage // ignore: cast_nullable_to_non_nullable
              as String?,
      screeningDate: freezed == screeningDate
          ? _value.screeningDate
          : screeningDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      screeningStatus: freezed == screeningStatus
          ? _value.screeningStatus
          : screeningStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      screeningScore: freezed == screeningScore
          ? _value.screeningScore
          : screeningScore // ignore: cast_nullable_to_non_nullable
              as int?,
      counsellingLinked: freezed == counsellingLinked
          ? _value.counsellingLinked
          : counsellingLinked // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      psychiatristLinked: freezed == psychiatristLinked
          ? _value.psychiatristLinked
          : psychiatristLinked // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      feelingBetter: freezed == feelingBetter
          ? _value.feelingBetter
          : feelingBetter // ignore: cast_nullable_to_non_nullable
              as String?,
      talkToHelpline: freezed == talkToHelpline
          ? _value.talkToHelpline
          : talkToHelpline // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MentalHealthScreeningModelImplCopyWith<$Res>
    implements $MentalHealthScreeningModelCopyWith<$Res> {
  factory _$$MentalHealthScreeningModelImplCopyWith(
          _$MentalHealthScreeningModelImpl value,
          $Res Function(_$MentalHealthScreeningModelImpl) then) =
      __$$MentalHealthScreeningModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'stage') String? stage,
      @JsonKey(name: 'screening_date') DateTime? screeningDate,
      @JsonKey(name: 'Scr_date') String? screeningStatus,
      @JsonKey(name: 'Scr_score') int? screeningScore,
      @JsonKey(name: 'counselling_linked') DateTime? counsellingLinked,
      @JsonKey(name: 'psychiatrist_linked') DateTime? psychiatristLinked,
      @JsonKey(name: 'feeling_better_linkage') String? feelingBetter,
      @JsonKey(name: 'talk_helpline_again') String? talkToHelpline});
}

/// @nodoc
class __$$MentalHealthScreeningModelImplCopyWithImpl<$Res>
    extends _$MentalHealthScreeningModelCopyWithImpl<$Res,
        _$MentalHealthScreeningModelImpl>
    implements _$$MentalHealthScreeningModelImplCopyWith<$Res> {
  __$$MentalHealthScreeningModelImplCopyWithImpl(
      _$MentalHealthScreeningModelImpl _value,
      $Res Function(_$MentalHealthScreeningModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stage = freezed,
    Object? screeningDate = freezed,
    Object? screeningStatus = freezed,
    Object? screeningScore = freezed,
    Object? counsellingLinked = freezed,
    Object? psychiatristLinked = freezed,
    Object? feelingBetter = freezed,
    Object? talkToHelpline = freezed,
  }) {
    return _then(_$MentalHealthScreeningModelImpl(
      stage: freezed == stage
          ? _value.stage
          : stage // ignore: cast_nullable_to_non_nullable
              as String?,
      screeningDate: freezed == screeningDate
          ? _value.screeningDate
          : screeningDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      screeningStatus: freezed == screeningStatus
          ? _value.screeningStatus
          : screeningStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      screeningScore: freezed == screeningScore
          ? _value.screeningScore
          : screeningScore // ignore: cast_nullable_to_non_nullable
              as int?,
      counsellingLinked: freezed == counsellingLinked
          ? _value.counsellingLinked
          : counsellingLinked // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      psychiatristLinked: freezed == psychiatristLinked
          ? _value.psychiatristLinked
          : psychiatristLinked // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      feelingBetter: freezed == feelingBetter
          ? _value.feelingBetter
          : feelingBetter // ignore: cast_nullable_to_non_nullable
              as String?,
      talkToHelpline: freezed == talkToHelpline
          ? _value.talkToHelpline
          : talkToHelpline // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MentalHealthScreeningModelImpl implements _MentalHealthScreeningModel {
  const _$MentalHealthScreeningModelImpl(
      {@JsonKey(name: 'stage') this.stage,
      @JsonKey(name: 'screening_date') this.screeningDate,
      @JsonKey(name: 'Scr_date') this.screeningStatus,
      @JsonKey(name: 'Scr_score') this.screeningScore,
      @JsonKey(name: 'counselling_linked') this.counsellingLinked,
      @JsonKey(name: 'psychiatrist_linked') this.psychiatristLinked,
      @JsonKey(name: 'feeling_better_linkage') this.feelingBetter,
      @JsonKey(name: 'talk_helpline_again') this.talkToHelpline});

  factory _$MentalHealthScreeningModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$MentalHealthScreeningModelImplFromJson(json);

  @override
  @JsonKey(name: 'stage')
  final String? stage;
  @override
  @JsonKey(name: 'screening_date')
  final DateTime? screeningDate;
  @override
  @JsonKey(name: 'Scr_date')
  final String? screeningStatus;
  @override
  @JsonKey(name: 'Scr_score')
  final int? screeningScore;
  @override
  @JsonKey(name: 'counselling_linked')
  final DateTime? counsellingLinked;
  @override
  @JsonKey(name: 'psychiatrist_linked')
  final DateTime? psychiatristLinked;
  @override
  @JsonKey(name: 'feeling_better_linkage')
  final String? feelingBetter;
  @override
  @JsonKey(name: 'talk_helpline_again')
  final String? talkToHelpline;

  @override
  String toString() {
    return 'MentalHealthScreeningModel(stage: $stage, screeningDate: $screeningDate, screeningStatus: $screeningStatus, screeningScore: $screeningScore, counsellingLinked: $counsellingLinked, psychiatristLinked: $psychiatristLinked, feelingBetter: $feelingBetter, talkToHelpline: $talkToHelpline)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MentalHealthScreeningModelImpl &&
            (identical(other.stage, stage) || other.stage == stage) &&
            (identical(other.screeningDate, screeningDate) ||
                other.screeningDate == screeningDate) &&
            (identical(other.screeningStatus, screeningStatus) ||
                other.screeningStatus == screeningStatus) &&
            (identical(other.screeningScore, screeningScore) ||
                other.screeningScore == screeningScore) &&
            (identical(other.counsellingLinked, counsellingLinked) ||
                other.counsellingLinked == counsellingLinked) &&
            (identical(other.psychiatristLinked, psychiatristLinked) ||
                other.psychiatristLinked == psychiatristLinked) &&
            (identical(other.feelingBetter, feelingBetter) ||
                other.feelingBetter == feelingBetter) &&
            (identical(other.talkToHelpline, talkToHelpline) ||
                other.talkToHelpline == talkToHelpline));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      stage,
      screeningDate,
      screeningStatus,
      screeningScore,
      counsellingLinked,
      psychiatristLinked,
      feelingBetter,
      talkToHelpline);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MentalHealthScreeningModelImplCopyWith<_$MentalHealthScreeningModelImpl>
      get copyWith => __$$MentalHealthScreeningModelImplCopyWithImpl<
          _$MentalHealthScreeningModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MentalHealthScreeningModelImplToJson(
      this,
    );
  }
}

abstract class _MentalHealthScreeningModel
    implements MentalHealthScreeningModel {
  const factory _MentalHealthScreeningModel(
      {@JsonKey(name: 'stage') final String? stage,
      @JsonKey(name: 'screening_date') final DateTime? screeningDate,
      @JsonKey(name: 'Scr_date') final String? screeningStatus,
      @JsonKey(name: 'Scr_score') final int? screeningScore,
      @JsonKey(name: 'counselling_linked') final DateTime? counsellingLinked,
      @JsonKey(name: 'psychiatrist_linked') final DateTime? psychiatristLinked,
      @JsonKey(name: 'feeling_better_linkage') final String? feelingBetter,
      @JsonKey(name: 'talk_helpline_again')
      final String? talkToHelpline}) = _$MentalHealthScreeningModelImpl;

  factory _MentalHealthScreeningModel.fromJson(Map<String, dynamic> json) =
      _$MentalHealthScreeningModelImpl.fromJson;

  @override
  @JsonKey(name: 'stage')
  String? get stage;
  @override
  @JsonKey(name: 'screening_date')
  DateTime? get screeningDate;
  @override
  @JsonKey(name: 'Scr_date')
  String? get screeningStatus;
  @override
  @JsonKey(name: 'Scr_score')
  int? get screeningScore;
  @override
  @JsonKey(name: 'counselling_linked')
  DateTime? get counsellingLinked;
  @override
  @JsonKey(name: 'psychiatrist_linked')
  DateTime? get psychiatristLinked;
  @override
  @JsonKey(name: 'feeling_better_linkage')
  String? get feelingBetter;
  @override
  @JsonKey(name: 'talk_helpline_again')
  String? get talkToHelpline;
  @override
  @JsonKey(ignore: true)
  _$$MentalHealthScreeningModelImplCopyWith<_$MentalHealthScreeningModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
