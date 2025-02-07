// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tb_screening_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TBScreeningModel _$TBScreeningModelFromJson(Map<String, dynamic> json) {
  return _TBScreeningModel.fromJson(json);
}

/// @nodoc
mixin _$TBScreeningModel {
  @HiveField(0)
  @JsonKey(name: 'id', includeToJson: false)
  int? get id => throw _privateConstructorUsedError;
  @HiveField(1)
  @JsonKey(
      name: 'screening_date',
      fromJson: fromJsonToDateTime,
      toJson: _dateTimeToJson)
  DateTime? get screeningDate => throw _privateConstructorUsedError;
  @HiveField(2)
  @JsonKey(name: 'screened_by')
  String? get screenedBy => throw _privateConstructorUsedError;
  @HiveField(3)
  @JsonKey(includeToJson: false)
  String? get pregnant => throw _privateConstructorUsedError;
  @HiveField(4)
  @JsonKey(name: 'trimester_of_pw')
  int? get selectedTrimester => throw _privateConstructorUsedError;
  @HiveField(5)
  @JsonKey(includeIfNull: false)
  String? get trimester => throw _privateConstructorUsedError;
  @HiveField(6)
  @JsonKey(name: 'cough_2_weeks')
  String? get cough => throw _privateConstructorUsedError;
  @HiveField(7)
  @JsonKey(name: 'sputum_2_weeks')
  String? get sputum => throw _privateConstructorUsedError;
  @HiveField(8)
  @JsonKey(name: 'hemoptysis')
  String? get hemoptysis => throw _privateConstructorUsedError;
  @HiveField(9)
  @JsonKey(name: 'fever_2_weeks')
  String? get fever => throw _privateConstructorUsedError;
  @HiveField(10)
  @JsonKey(name: 'night_sweats_2_weeks')
  String? get nightSweats => throw _privateConstructorUsedError;
  @HiveField(11)
  @JsonKey(name: 'chest_pain_2_months')
  String? get chestPain => throw _privateConstructorUsedError;
  @HiveField(12)
  @JsonKey(name: 'weight_loss_3_months')
  String? get weightLoss => throw _privateConstructorUsedError;
  @HiveField(13)
  @JsonKey(name: 'swollen_gland')
  String? get swollenGland => throw _privateConstructorUsedError;
  @HiveField(14)
  @JsonKey(name: 'tb_medicine_before')
  String? get tbMedicine => throw _privateConstructorUsedError;
  @HiveField(15)
  @JsonKey(name: 'screening_outcome')
  String? get screeningOutcome => throw _privateConstructorUsedError;
  @HiveField(16)
  @JsonKey(name: 'comments')
  String? get comments => throw _privateConstructorUsedError;
  @HiveField(17)
  @JsonKey(name: 'is_updated')
  bool? get isUpdated => throw _privateConstructorUsedError;
  @HiveField(18)
  @JsonKey(name: 'case_id', includeToJson: false)
  int? get caseId => throw _privateConstructorUsedError;
  @HiveField(19)
  @JsonKey(name: 'is_form_id_assigned', includeToJson: false)
  bool? get isFormIDAssigned => throw _privateConstructorUsedError;
  @HiveField(20)
  @JsonKey(name: 'wheezing')
  String? get wheezing => throw _privateConstructorUsedError;
  @HiveField(21)
  @JsonKey(name: 'shortness_breath')
  String? get shortnessBreath => throw _privateConstructorUsedError;
  @HiveField(22)
  @JsonKey(name: 'tightness_chest')
  String? get tightnessChest => throw _privateConstructorUsedError;
  @HiveField(23)
  @JsonKey(name: 'screened_with_swasa')
  String? get swasaScreening => throw _privateConstructorUsedError;
  @HiveField(24)
  @JsonKey(
      name: 'swasa_screening_date',
      fromJson: fromJsonToDateTime,
      toJson: _dateTimeToJson)
  DateTime? get swasaScreeningDate => throw _privateConstructorUsedError;
  @HiveField(25)
  @JsonKey(name: 'swasa_screening_result')
  String? get swasaScreeningResult => throw _privateConstructorUsedError;
  @HiveField(26)
  @JsonKey(name: 'screening_cxr_ai')
  String? get cxrScreening => throw _privateConstructorUsedError;
  @HiveField(27)
  @JsonKey(
      name: 'cxr_screening_date',
      fromJson: fromJsonToDateTime,
      toJson: _dateTimeToJson)
  DateTime? get cxrScreeningDate => throw _privateConstructorUsedError;
  @HiveField(28)
  @JsonKey(name: 'cxr_screening_result')
  String? get cxrScreeningResult => throw _privateConstructorUsedError;

  /// Serializes this TBScreeningModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TBScreeningModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TBScreeningModelCopyWith<TBScreeningModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TBScreeningModelCopyWith<$Res> {
  factory $TBScreeningModelCopyWith(
          TBScreeningModel value, $Res Function(TBScreeningModel) then) =
      _$TBScreeningModelCopyWithImpl<$Res, TBScreeningModel>;
  @useResult
  $Res call(
      {@HiveField(0) @JsonKey(name: 'id', includeToJson: false) int? id,
      @HiveField(1)
      @JsonKey(
          name: 'screening_date',
          fromJson: fromJsonToDateTime,
          toJson: _dateTimeToJson)
      DateTime? screeningDate,
      @HiveField(2) @JsonKey(name: 'screened_by') String? screenedBy,
      @HiveField(3) @JsonKey(includeToJson: false) String? pregnant,
      @HiveField(4) @JsonKey(name: 'trimester_of_pw') int? selectedTrimester,
      @HiveField(5) @JsonKey(includeIfNull: false) String? trimester,
      @HiveField(6) @JsonKey(name: 'cough_2_weeks') String? cough,
      @HiveField(7) @JsonKey(name: 'sputum_2_weeks') String? sputum,
      @HiveField(8) @JsonKey(name: 'hemoptysis') String? hemoptysis,
      @HiveField(9) @JsonKey(name: 'fever_2_weeks') String? fever,
      @HiveField(10) @JsonKey(name: 'night_sweats_2_weeks') String? nightSweats,
      @HiveField(11) @JsonKey(name: 'chest_pain_2_months') String? chestPain,
      @HiveField(12) @JsonKey(name: 'weight_loss_3_months') String? weightLoss,
      @HiveField(13) @JsonKey(name: 'swollen_gland') String? swollenGland,
      @HiveField(14) @JsonKey(name: 'tb_medicine_before') String? tbMedicine,
      @HiveField(15)
      @JsonKey(name: 'screening_outcome')
      String? screeningOutcome,
      @HiveField(16) @JsonKey(name: 'comments') String? comments,
      @HiveField(17) @JsonKey(name: 'is_updated') bool? isUpdated,
      @HiveField(18)
      @JsonKey(name: 'case_id', includeToJson: false)
      int? caseId,
      @HiveField(19)
      @JsonKey(name: 'is_form_id_assigned', includeToJson: false)
      bool? isFormIDAssigned,
      @HiveField(20) @JsonKey(name: 'wheezing') String? wheezing,
      @HiveField(21) @JsonKey(name: 'shortness_breath') String? shortnessBreath,
      @HiveField(22) @JsonKey(name: 'tightness_chest') String? tightnessChest,
      @HiveField(23)
      @JsonKey(name: 'screened_with_swasa')
      String? swasaScreening,
      @HiveField(24)
      @JsonKey(
          name: 'swasa_screening_date',
          fromJson: fromJsonToDateTime,
          toJson: _dateTimeToJson)
      DateTime? swasaScreeningDate,
      @HiveField(25)
      @JsonKey(name: 'swasa_screening_result')
      String? swasaScreeningResult,
      @HiveField(26) @JsonKey(name: 'screening_cxr_ai') String? cxrScreening,
      @HiveField(27)
      @JsonKey(
          name: 'cxr_screening_date',
          fromJson: fromJsonToDateTime,
          toJson: _dateTimeToJson)
      DateTime? cxrScreeningDate,
      @HiveField(28)
      @JsonKey(name: 'cxr_screening_result')
      String? cxrScreeningResult});
}

/// @nodoc
class _$TBScreeningModelCopyWithImpl<$Res, $Val extends TBScreeningModel>
    implements $TBScreeningModelCopyWith<$Res> {
  _$TBScreeningModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TBScreeningModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? screeningDate = freezed,
    Object? screenedBy = freezed,
    Object? pregnant = freezed,
    Object? selectedTrimester = freezed,
    Object? trimester = freezed,
    Object? cough = freezed,
    Object? sputum = freezed,
    Object? hemoptysis = freezed,
    Object? fever = freezed,
    Object? nightSweats = freezed,
    Object? chestPain = freezed,
    Object? weightLoss = freezed,
    Object? swollenGland = freezed,
    Object? tbMedicine = freezed,
    Object? screeningOutcome = freezed,
    Object? comments = freezed,
    Object? isUpdated = freezed,
    Object? caseId = freezed,
    Object? isFormIDAssigned = freezed,
    Object? wheezing = freezed,
    Object? shortnessBreath = freezed,
    Object? tightnessChest = freezed,
    Object? swasaScreening = freezed,
    Object? swasaScreeningDate = freezed,
    Object? swasaScreeningResult = freezed,
    Object? cxrScreening = freezed,
    Object? cxrScreeningDate = freezed,
    Object? cxrScreeningResult = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      screeningDate: freezed == screeningDate
          ? _value.screeningDate
          : screeningDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      screenedBy: freezed == screenedBy
          ? _value.screenedBy
          : screenedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      pregnant: freezed == pregnant
          ? _value.pregnant
          : pregnant // ignore: cast_nullable_to_non_nullable
              as String?,
      selectedTrimester: freezed == selectedTrimester
          ? _value.selectedTrimester
          : selectedTrimester // ignore: cast_nullable_to_non_nullable
              as int?,
      trimester: freezed == trimester
          ? _value.trimester
          : trimester // ignore: cast_nullable_to_non_nullable
              as String?,
      cough: freezed == cough
          ? _value.cough
          : cough // ignore: cast_nullable_to_non_nullable
              as String?,
      sputum: freezed == sputum
          ? _value.sputum
          : sputum // ignore: cast_nullable_to_non_nullable
              as String?,
      hemoptysis: freezed == hemoptysis
          ? _value.hemoptysis
          : hemoptysis // ignore: cast_nullable_to_non_nullable
              as String?,
      fever: freezed == fever
          ? _value.fever
          : fever // ignore: cast_nullable_to_non_nullable
              as String?,
      nightSweats: freezed == nightSweats
          ? _value.nightSweats
          : nightSweats // ignore: cast_nullable_to_non_nullable
              as String?,
      chestPain: freezed == chestPain
          ? _value.chestPain
          : chestPain // ignore: cast_nullable_to_non_nullable
              as String?,
      weightLoss: freezed == weightLoss
          ? _value.weightLoss
          : weightLoss // ignore: cast_nullable_to_non_nullable
              as String?,
      swollenGland: freezed == swollenGland
          ? _value.swollenGland
          : swollenGland // ignore: cast_nullable_to_non_nullable
              as String?,
      tbMedicine: freezed == tbMedicine
          ? _value.tbMedicine
          : tbMedicine // ignore: cast_nullable_to_non_nullable
              as String?,
      screeningOutcome: freezed == screeningOutcome
          ? _value.screeningOutcome
          : screeningOutcome // ignore: cast_nullable_to_non_nullable
              as String?,
      comments: freezed == comments
          ? _value.comments
          : comments // ignore: cast_nullable_to_non_nullable
              as String?,
      isUpdated: freezed == isUpdated
          ? _value.isUpdated
          : isUpdated // ignore: cast_nullable_to_non_nullable
              as bool?,
      caseId: freezed == caseId
          ? _value.caseId
          : caseId // ignore: cast_nullable_to_non_nullable
              as int?,
      isFormIDAssigned: freezed == isFormIDAssigned
          ? _value.isFormIDAssigned
          : isFormIDAssigned // ignore: cast_nullable_to_non_nullable
              as bool?,
      wheezing: freezed == wheezing
          ? _value.wheezing
          : wheezing // ignore: cast_nullable_to_non_nullable
              as String?,
      shortnessBreath: freezed == shortnessBreath
          ? _value.shortnessBreath
          : shortnessBreath // ignore: cast_nullable_to_non_nullable
              as String?,
      tightnessChest: freezed == tightnessChest
          ? _value.tightnessChest
          : tightnessChest // ignore: cast_nullable_to_non_nullable
              as String?,
      swasaScreening: freezed == swasaScreening
          ? _value.swasaScreening
          : swasaScreening // ignore: cast_nullable_to_non_nullable
              as String?,
      swasaScreeningDate: freezed == swasaScreeningDate
          ? _value.swasaScreeningDate
          : swasaScreeningDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      swasaScreeningResult: freezed == swasaScreeningResult
          ? _value.swasaScreeningResult
          : swasaScreeningResult // ignore: cast_nullable_to_non_nullable
              as String?,
      cxrScreening: freezed == cxrScreening
          ? _value.cxrScreening
          : cxrScreening // ignore: cast_nullable_to_non_nullable
              as String?,
      cxrScreeningDate: freezed == cxrScreeningDate
          ? _value.cxrScreeningDate
          : cxrScreeningDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      cxrScreeningResult: freezed == cxrScreeningResult
          ? _value.cxrScreeningResult
          : cxrScreeningResult // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TBScreeningModelImplCopyWith<$Res>
    implements $TBScreeningModelCopyWith<$Res> {
  factory _$$TBScreeningModelImplCopyWith(_$TBScreeningModelImpl value,
          $Res Function(_$TBScreeningModelImpl) then) =
      __$$TBScreeningModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) @JsonKey(name: 'id', includeToJson: false) int? id,
      @HiveField(1)
      @JsonKey(
          name: 'screening_date',
          fromJson: fromJsonToDateTime,
          toJson: _dateTimeToJson)
      DateTime? screeningDate,
      @HiveField(2) @JsonKey(name: 'screened_by') String? screenedBy,
      @HiveField(3) @JsonKey(includeToJson: false) String? pregnant,
      @HiveField(4) @JsonKey(name: 'trimester_of_pw') int? selectedTrimester,
      @HiveField(5) @JsonKey(includeIfNull: false) String? trimester,
      @HiveField(6) @JsonKey(name: 'cough_2_weeks') String? cough,
      @HiveField(7) @JsonKey(name: 'sputum_2_weeks') String? sputum,
      @HiveField(8) @JsonKey(name: 'hemoptysis') String? hemoptysis,
      @HiveField(9) @JsonKey(name: 'fever_2_weeks') String? fever,
      @HiveField(10) @JsonKey(name: 'night_sweats_2_weeks') String? nightSweats,
      @HiveField(11) @JsonKey(name: 'chest_pain_2_months') String? chestPain,
      @HiveField(12) @JsonKey(name: 'weight_loss_3_months') String? weightLoss,
      @HiveField(13) @JsonKey(name: 'swollen_gland') String? swollenGland,
      @HiveField(14) @JsonKey(name: 'tb_medicine_before') String? tbMedicine,
      @HiveField(15)
      @JsonKey(name: 'screening_outcome')
      String? screeningOutcome,
      @HiveField(16) @JsonKey(name: 'comments') String? comments,
      @HiveField(17) @JsonKey(name: 'is_updated') bool? isUpdated,
      @HiveField(18)
      @JsonKey(name: 'case_id', includeToJson: false)
      int? caseId,
      @HiveField(19)
      @JsonKey(name: 'is_form_id_assigned', includeToJson: false)
      bool? isFormIDAssigned,
      @HiveField(20) @JsonKey(name: 'wheezing') String? wheezing,
      @HiveField(21) @JsonKey(name: 'shortness_breath') String? shortnessBreath,
      @HiveField(22) @JsonKey(name: 'tightness_chest') String? tightnessChest,
      @HiveField(23)
      @JsonKey(name: 'screened_with_swasa')
      String? swasaScreening,
      @HiveField(24)
      @JsonKey(
          name: 'swasa_screening_date',
          fromJson: fromJsonToDateTime,
          toJson: _dateTimeToJson)
      DateTime? swasaScreeningDate,
      @HiveField(25)
      @JsonKey(name: 'swasa_screening_result')
      String? swasaScreeningResult,
      @HiveField(26) @JsonKey(name: 'screening_cxr_ai') String? cxrScreening,
      @HiveField(27)
      @JsonKey(
          name: 'cxr_screening_date',
          fromJson: fromJsonToDateTime,
          toJson: _dateTimeToJson)
      DateTime? cxrScreeningDate,
      @HiveField(28)
      @JsonKey(name: 'cxr_screening_result')
      String? cxrScreeningResult});
}

/// @nodoc
class __$$TBScreeningModelImplCopyWithImpl<$Res>
    extends _$TBScreeningModelCopyWithImpl<$Res, _$TBScreeningModelImpl>
    implements _$$TBScreeningModelImplCopyWith<$Res> {
  __$$TBScreeningModelImplCopyWithImpl(_$TBScreeningModelImpl _value,
      $Res Function(_$TBScreeningModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of TBScreeningModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? screeningDate = freezed,
    Object? screenedBy = freezed,
    Object? pregnant = freezed,
    Object? selectedTrimester = freezed,
    Object? trimester = freezed,
    Object? cough = freezed,
    Object? sputum = freezed,
    Object? hemoptysis = freezed,
    Object? fever = freezed,
    Object? nightSweats = freezed,
    Object? chestPain = freezed,
    Object? weightLoss = freezed,
    Object? swollenGland = freezed,
    Object? tbMedicine = freezed,
    Object? screeningOutcome = freezed,
    Object? comments = freezed,
    Object? isUpdated = freezed,
    Object? caseId = freezed,
    Object? isFormIDAssigned = freezed,
    Object? wheezing = freezed,
    Object? shortnessBreath = freezed,
    Object? tightnessChest = freezed,
    Object? swasaScreening = freezed,
    Object? swasaScreeningDate = freezed,
    Object? swasaScreeningResult = freezed,
    Object? cxrScreening = freezed,
    Object? cxrScreeningDate = freezed,
    Object? cxrScreeningResult = freezed,
  }) {
    return _then(_$TBScreeningModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      screeningDate: freezed == screeningDate
          ? _value.screeningDate
          : screeningDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      screenedBy: freezed == screenedBy
          ? _value.screenedBy
          : screenedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      pregnant: freezed == pregnant
          ? _value.pregnant
          : pregnant // ignore: cast_nullable_to_non_nullable
              as String?,
      selectedTrimester: freezed == selectedTrimester
          ? _value.selectedTrimester
          : selectedTrimester // ignore: cast_nullable_to_non_nullable
              as int?,
      trimester: freezed == trimester
          ? _value.trimester
          : trimester // ignore: cast_nullable_to_non_nullable
              as String?,
      cough: freezed == cough
          ? _value.cough
          : cough // ignore: cast_nullable_to_non_nullable
              as String?,
      sputum: freezed == sputum
          ? _value.sputum
          : sputum // ignore: cast_nullable_to_non_nullable
              as String?,
      hemoptysis: freezed == hemoptysis
          ? _value.hemoptysis
          : hemoptysis // ignore: cast_nullable_to_non_nullable
              as String?,
      fever: freezed == fever
          ? _value.fever
          : fever // ignore: cast_nullable_to_non_nullable
              as String?,
      nightSweats: freezed == nightSweats
          ? _value.nightSweats
          : nightSweats // ignore: cast_nullable_to_non_nullable
              as String?,
      chestPain: freezed == chestPain
          ? _value.chestPain
          : chestPain // ignore: cast_nullable_to_non_nullable
              as String?,
      weightLoss: freezed == weightLoss
          ? _value.weightLoss
          : weightLoss // ignore: cast_nullable_to_non_nullable
              as String?,
      swollenGland: freezed == swollenGland
          ? _value.swollenGland
          : swollenGland // ignore: cast_nullable_to_non_nullable
              as String?,
      tbMedicine: freezed == tbMedicine
          ? _value.tbMedicine
          : tbMedicine // ignore: cast_nullable_to_non_nullable
              as String?,
      screeningOutcome: freezed == screeningOutcome
          ? _value.screeningOutcome
          : screeningOutcome // ignore: cast_nullable_to_non_nullable
              as String?,
      comments: freezed == comments
          ? _value.comments
          : comments // ignore: cast_nullable_to_non_nullable
              as String?,
      isUpdated: freezed == isUpdated
          ? _value.isUpdated
          : isUpdated // ignore: cast_nullable_to_non_nullable
              as bool?,
      caseId: freezed == caseId
          ? _value.caseId
          : caseId // ignore: cast_nullable_to_non_nullable
              as int?,
      isFormIDAssigned: freezed == isFormIDAssigned
          ? _value.isFormIDAssigned
          : isFormIDAssigned // ignore: cast_nullable_to_non_nullable
              as bool?,
      wheezing: freezed == wheezing
          ? _value.wheezing
          : wheezing // ignore: cast_nullable_to_non_nullable
              as String?,
      shortnessBreath: freezed == shortnessBreath
          ? _value.shortnessBreath
          : shortnessBreath // ignore: cast_nullable_to_non_nullable
              as String?,
      tightnessChest: freezed == tightnessChest
          ? _value.tightnessChest
          : tightnessChest // ignore: cast_nullable_to_non_nullable
              as String?,
      swasaScreening: freezed == swasaScreening
          ? _value.swasaScreening
          : swasaScreening // ignore: cast_nullable_to_non_nullable
              as String?,
      swasaScreeningDate: freezed == swasaScreeningDate
          ? _value.swasaScreeningDate
          : swasaScreeningDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      swasaScreeningResult: freezed == swasaScreeningResult
          ? _value.swasaScreeningResult
          : swasaScreeningResult // ignore: cast_nullable_to_non_nullable
              as String?,
      cxrScreening: freezed == cxrScreening
          ? _value.cxrScreening
          : cxrScreening // ignore: cast_nullable_to_non_nullable
              as String?,
      cxrScreeningDate: freezed == cxrScreeningDate
          ? _value.cxrScreeningDate
          : cxrScreeningDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      cxrScreeningResult: freezed == cxrScreeningResult
          ? _value.cxrScreeningResult
          : cxrScreeningResult // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TBScreeningModelImpl implements _TBScreeningModel {
  const _$TBScreeningModelImpl(
      {@HiveField(0) @JsonKey(name: 'id', includeToJson: false) this.id,
      @HiveField(1)
      @JsonKey(
          name: 'screening_date',
          fromJson: fromJsonToDateTime,
          toJson: _dateTimeToJson)
      this.screeningDate,
      @HiveField(2) @JsonKey(name: 'screened_by') this.screenedBy,
      @HiveField(3) @JsonKey(includeToJson: false) this.pregnant,
      @HiveField(4) @JsonKey(name: 'trimester_of_pw') this.selectedTrimester,
      @HiveField(5) @JsonKey(includeIfNull: false) this.trimester,
      @HiveField(6) @JsonKey(name: 'cough_2_weeks') this.cough,
      @HiveField(7) @JsonKey(name: 'sputum_2_weeks') this.sputum,
      @HiveField(8) @JsonKey(name: 'hemoptysis') this.hemoptysis,
      @HiveField(9) @JsonKey(name: 'fever_2_weeks') this.fever,
      @HiveField(10) @JsonKey(name: 'night_sweats_2_weeks') this.nightSweats,
      @HiveField(11) @JsonKey(name: 'chest_pain_2_months') this.chestPain,
      @HiveField(12) @JsonKey(name: 'weight_loss_3_months') this.weightLoss,
      @HiveField(13) @JsonKey(name: 'swollen_gland') this.swollenGland,
      @HiveField(14) @JsonKey(name: 'tb_medicine_before') this.tbMedicine,
      @HiveField(15) @JsonKey(name: 'screening_outcome') this.screeningOutcome,
      @HiveField(16) @JsonKey(name: 'comments') this.comments,
      @HiveField(17) @JsonKey(name: 'is_updated') this.isUpdated,
      @HiveField(18)
      @JsonKey(name: 'case_id', includeToJson: false)
      this.caseId,
      @HiveField(19)
      @JsonKey(name: 'is_form_id_assigned', includeToJson: false)
      this.isFormIDAssigned,
      @HiveField(20) @JsonKey(name: 'wheezing') this.wheezing,
      @HiveField(21) @JsonKey(name: 'shortness_breath') this.shortnessBreath,
      @HiveField(22) @JsonKey(name: 'tightness_chest') this.tightnessChest,
      @HiveField(23) @JsonKey(name: 'screened_with_swasa') this.swasaScreening,
      @HiveField(24)
      @JsonKey(
          name: 'swasa_screening_date',
          fromJson: fromJsonToDateTime,
          toJson: _dateTimeToJson)
      this.swasaScreeningDate,
      @HiveField(25)
      @JsonKey(name: 'swasa_screening_result')
      this.swasaScreeningResult,
      @HiveField(26) @JsonKey(name: 'screening_cxr_ai') this.cxrScreening,
      @HiveField(27)
      @JsonKey(
          name: 'cxr_screening_date',
          fromJson: fromJsonToDateTime,
          toJson: _dateTimeToJson)
      this.cxrScreeningDate,
      @HiveField(28)
      @JsonKey(name: 'cxr_screening_result')
      this.cxrScreeningResult});

  factory _$TBScreeningModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TBScreeningModelImplFromJson(json);

  @override
  @HiveField(0)
  @JsonKey(name: 'id', includeToJson: false)
  final int? id;
  @override
  @HiveField(1)
  @JsonKey(
      name: 'screening_date',
      fromJson: fromJsonToDateTime,
      toJson: _dateTimeToJson)
  final DateTime? screeningDate;
  @override
  @HiveField(2)
  @JsonKey(name: 'screened_by')
  final String? screenedBy;
  @override
  @HiveField(3)
  @JsonKey(includeToJson: false)
  final String? pregnant;
  @override
  @HiveField(4)
  @JsonKey(name: 'trimester_of_pw')
  final int? selectedTrimester;
  @override
  @HiveField(5)
  @JsonKey(includeIfNull: false)
  final String? trimester;
  @override
  @HiveField(6)
  @JsonKey(name: 'cough_2_weeks')
  final String? cough;
  @override
  @HiveField(7)
  @JsonKey(name: 'sputum_2_weeks')
  final String? sputum;
  @override
  @HiveField(8)
  @JsonKey(name: 'hemoptysis')
  final String? hemoptysis;
  @override
  @HiveField(9)
  @JsonKey(name: 'fever_2_weeks')
  final String? fever;
  @override
  @HiveField(10)
  @JsonKey(name: 'night_sweats_2_weeks')
  final String? nightSweats;
  @override
  @HiveField(11)
  @JsonKey(name: 'chest_pain_2_months')
  final String? chestPain;
  @override
  @HiveField(12)
  @JsonKey(name: 'weight_loss_3_months')
  final String? weightLoss;
  @override
  @HiveField(13)
  @JsonKey(name: 'swollen_gland')
  final String? swollenGland;
  @override
  @HiveField(14)
  @JsonKey(name: 'tb_medicine_before')
  final String? tbMedicine;
  @override
  @HiveField(15)
  @JsonKey(name: 'screening_outcome')
  final String? screeningOutcome;
  @override
  @HiveField(16)
  @JsonKey(name: 'comments')
  final String? comments;
  @override
  @HiveField(17)
  @JsonKey(name: 'is_updated')
  final bool? isUpdated;
  @override
  @HiveField(18)
  @JsonKey(name: 'case_id', includeToJson: false)
  final int? caseId;
  @override
  @HiveField(19)
  @JsonKey(name: 'is_form_id_assigned', includeToJson: false)
  final bool? isFormIDAssigned;
  @override
  @HiveField(20)
  @JsonKey(name: 'wheezing')
  final String? wheezing;
  @override
  @HiveField(21)
  @JsonKey(name: 'shortness_breath')
  final String? shortnessBreath;
  @override
  @HiveField(22)
  @JsonKey(name: 'tightness_chest')
  final String? tightnessChest;
  @override
  @HiveField(23)
  @JsonKey(name: 'screened_with_swasa')
  final String? swasaScreening;
  @override
  @HiveField(24)
  @JsonKey(
      name: 'swasa_screening_date',
      fromJson: fromJsonToDateTime,
      toJson: _dateTimeToJson)
  final DateTime? swasaScreeningDate;
  @override
  @HiveField(25)
  @JsonKey(name: 'swasa_screening_result')
  final String? swasaScreeningResult;
  @override
  @HiveField(26)
  @JsonKey(name: 'screening_cxr_ai')
  final String? cxrScreening;
  @override
  @HiveField(27)
  @JsonKey(
      name: 'cxr_screening_date',
      fromJson: fromJsonToDateTime,
      toJson: _dateTimeToJson)
  final DateTime? cxrScreeningDate;
  @override
  @HiveField(28)
  @JsonKey(name: 'cxr_screening_result')
  final String? cxrScreeningResult;

  @override
  String toString() {
    return 'TBScreeningModel(id: $id, screeningDate: $screeningDate, screenedBy: $screenedBy, pregnant: $pregnant, selectedTrimester: $selectedTrimester, trimester: $trimester, cough: $cough, sputum: $sputum, hemoptysis: $hemoptysis, fever: $fever, nightSweats: $nightSweats, chestPain: $chestPain, weightLoss: $weightLoss, swollenGland: $swollenGland, tbMedicine: $tbMedicine, screeningOutcome: $screeningOutcome, comments: $comments, isUpdated: $isUpdated, caseId: $caseId, isFormIDAssigned: $isFormIDAssigned, wheezing: $wheezing, shortnessBreath: $shortnessBreath, tightnessChest: $tightnessChest, swasaScreening: $swasaScreening, swasaScreeningDate: $swasaScreeningDate, swasaScreeningResult: $swasaScreeningResult, cxrScreening: $cxrScreening, cxrScreeningDate: $cxrScreeningDate, cxrScreeningResult: $cxrScreeningResult)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TBScreeningModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.screeningDate, screeningDate) ||
                other.screeningDate == screeningDate) &&
            (identical(other.screenedBy, screenedBy) ||
                other.screenedBy == screenedBy) &&
            (identical(other.pregnant, pregnant) ||
                other.pregnant == pregnant) &&
            (identical(other.selectedTrimester, selectedTrimester) ||
                other.selectedTrimester == selectedTrimester) &&
            (identical(other.trimester, trimester) ||
                other.trimester == trimester) &&
            (identical(other.cough, cough) || other.cough == cough) &&
            (identical(other.sputum, sputum) || other.sputum == sputum) &&
            (identical(other.hemoptysis, hemoptysis) ||
                other.hemoptysis == hemoptysis) &&
            (identical(other.fever, fever) || other.fever == fever) &&
            (identical(other.nightSweats, nightSweats) ||
                other.nightSweats == nightSweats) &&
            (identical(other.chestPain, chestPain) ||
                other.chestPain == chestPain) &&
            (identical(other.weightLoss, weightLoss) ||
                other.weightLoss == weightLoss) &&
            (identical(other.swollenGland, swollenGland) ||
                other.swollenGland == swollenGland) &&
            (identical(other.tbMedicine, tbMedicine) ||
                other.tbMedicine == tbMedicine) &&
            (identical(other.screeningOutcome, screeningOutcome) ||
                other.screeningOutcome == screeningOutcome) &&
            (identical(other.comments, comments) ||
                other.comments == comments) &&
            (identical(other.isUpdated, isUpdated) ||
                other.isUpdated == isUpdated) &&
            (identical(other.caseId, caseId) || other.caseId == caseId) &&
            (identical(other.isFormIDAssigned, isFormIDAssigned) ||
                other.isFormIDAssigned == isFormIDAssigned) &&
            (identical(other.wheezing, wheezing) ||
                other.wheezing == wheezing) &&
            (identical(other.shortnessBreath, shortnessBreath) ||
                other.shortnessBreath == shortnessBreath) &&
            (identical(other.tightnessChest, tightnessChest) ||
                other.tightnessChest == tightnessChest) &&
            (identical(other.swasaScreening, swasaScreening) ||
                other.swasaScreening == swasaScreening) &&
            (identical(other.swasaScreeningDate, swasaScreeningDate) ||
                other.swasaScreeningDate == swasaScreeningDate) &&
            (identical(other.swasaScreeningResult, swasaScreeningResult) ||
                other.swasaScreeningResult == swasaScreeningResult) &&
            (identical(other.cxrScreening, cxrScreening) ||
                other.cxrScreening == cxrScreening) &&
            (identical(other.cxrScreeningDate, cxrScreeningDate) ||
                other.cxrScreeningDate == cxrScreeningDate) &&
            (identical(other.cxrScreeningResult, cxrScreeningResult) ||
                other.cxrScreeningResult == cxrScreeningResult));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        screeningDate,
        screenedBy,
        pregnant,
        selectedTrimester,
        trimester,
        cough,
        sputum,
        hemoptysis,
        fever,
        nightSweats,
        chestPain,
        weightLoss,
        swollenGland,
        tbMedicine,
        screeningOutcome,
        comments,
        isUpdated,
        caseId,
        isFormIDAssigned,
        wheezing,
        shortnessBreath,
        tightnessChest,
        swasaScreening,
        swasaScreeningDate,
        swasaScreeningResult,
        cxrScreening,
        cxrScreeningDate,
        cxrScreeningResult
      ]);

  /// Create a copy of TBScreeningModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TBScreeningModelImplCopyWith<_$TBScreeningModelImpl> get copyWith =>
      __$$TBScreeningModelImplCopyWithImpl<_$TBScreeningModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TBScreeningModelImplToJson(
      this,
    );
  }
}

abstract class _TBScreeningModel implements TBScreeningModel {
  const factory _TBScreeningModel(
      {@HiveField(0) @JsonKey(name: 'id', includeToJson: false) final int? id,
      @HiveField(1)
      @JsonKey(
          name: 'screening_date',
          fromJson: fromJsonToDateTime,
          toJson: _dateTimeToJson)
      final DateTime? screeningDate,
      @HiveField(2) @JsonKey(name: 'screened_by') final String? screenedBy,
      @HiveField(3) @JsonKey(includeToJson: false) final String? pregnant,
      @HiveField(4)
      @JsonKey(name: 'trimester_of_pw')
      final int? selectedTrimester,
      @HiveField(5) @JsonKey(includeIfNull: false) final String? trimester,
      @HiveField(6) @JsonKey(name: 'cough_2_weeks') final String? cough,
      @HiveField(7) @JsonKey(name: 'sputum_2_weeks') final String? sputum,
      @HiveField(8) @JsonKey(name: 'hemoptysis') final String? hemoptysis,
      @HiveField(9) @JsonKey(name: 'fever_2_weeks') final String? fever,
      @HiveField(10)
      @JsonKey(name: 'night_sweats_2_weeks')
      final String? nightSweats,
      @HiveField(11)
      @JsonKey(name: 'chest_pain_2_months')
      final String? chestPain,
      @HiveField(12)
      @JsonKey(name: 'weight_loss_3_months')
      final String? weightLoss,
      @HiveField(13) @JsonKey(name: 'swollen_gland') final String? swollenGland,
      @HiveField(14)
      @JsonKey(name: 'tb_medicine_before')
      final String? tbMedicine,
      @HiveField(15)
      @JsonKey(name: 'screening_outcome')
      final String? screeningOutcome,
      @HiveField(16) @JsonKey(name: 'comments') final String? comments,
      @HiveField(17) @JsonKey(name: 'is_updated') final bool? isUpdated,
      @HiveField(18)
      @JsonKey(name: 'case_id', includeToJson: false)
      final int? caseId,
      @HiveField(19)
      @JsonKey(name: 'is_form_id_assigned', includeToJson: false)
      final bool? isFormIDAssigned,
      @HiveField(20) @JsonKey(name: 'wheezing') final String? wheezing,
      @HiveField(21)
      @JsonKey(name: 'shortness_breath')
      final String? shortnessBreath,
      @HiveField(22)
      @JsonKey(name: 'tightness_chest')
      final String? tightnessChest,
      @HiveField(23)
      @JsonKey(name: 'screened_with_swasa')
      final String? swasaScreening,
      @HiveField(24)
      @JsonKey(
          name: 'swasa_screening_date',
          fromJson: fromJsonToDateTime,
          toJson: _dateTimeToJson)
      final DateTime? swasaScreeningDate,
      @HiveField(25)
      @JsonKey(name: 'swasa_screening_result')
      final String? swasaScreeningResult,
      @HiveField(26)
      @JsonKey(name: 'screening_cxr_ai')
      final String? cxrScreening,
      @HiveField(27)
      @JsonKey(
          name: 'cxr_screening_date',
          fromJson: fromJsonToDateTime,
          toJson: _dateTimeToJson)
      final DateTime? cxrScreeningDate,
      @HiveField(28)
      @JsonKey(name: 'cxr_screening_result')
      final String? cxrScreeningResult}) = _$TBScreeningModelImpl;

  factory _TBScreeningModel.fromJson(Map<String, dynamic> json) =
      _$TBScreeningModelImpl.fromJson;

  @override
  @HiveField(0)
  @JsonKey(name: 'id', includeToJson: false)
  int? get id;
  @override
  @HiveField(1)
  @JsonKey(
      name: 'screening_date',
      fromJson: fromJsonToDateTime,
      toJson: _dateTimeToJson)
  DateTime? get screeningDate;
  @override
  @HiveField(2)
  @JsonKey(name: 'screened_by')
  String? get screenedBy;
  @override
  @HiveField(3)
  @JsonKey(includeToJson: false)
  String? get pregnant;
  @override
  @HiveField(4)
  @JsonKey(name: 'trimester_of_pw')
  int? get selectedTrimester;
  @override
  @HiveField(5)
  @JsonKey(includeIfNull: false)
  String? get trimester;
  @override
  @HiveField(6)
  @JsonKey(name: 'cough_2_weeks')
  String? get cough;
  @override
  @HiveField(7)
  @JsonKey(name: 'sputum_2_weeks')
  String? get sputum;
  @override
  @HiveField(8)
  @JsonKey(name: 'hemoptysis')
  String? get hemoptysis;
  @override
  @HiveField(9)
  @JsonKey(name: 'fever_2_weeks')
  String? get fever;
  @override
  @HiveField(10)
  @JsonKey(name: 'night_sweats_2_weeks')
  String? get nightSweats;
  @override
  @HiveField(11)
  @JsonKey(name: 'chest_pain_2_months')
  String? get chestPain;
  @override
  @HiveField(12)
  @JsonKey(name: 'weight_loss_3_months')
  String? get weightLoss;
  @override
  @HiveField(13)
  @JsonKey(name: 'swollen_gland')
  String? get swollenGland;
  @override
  @HiveField(14)
  @JsonKey(name: 'tb_medicine_before')
  String? get tbMedicine;
  @override
  @HiveField(15)
  @JsonKey(name: 'screening_outcome')
  String? get screeningOutcome;
  @override
  @HiveField(16)
  @JsonKey(name: 'comments')
  String? get comments;
  @override
  @HiveField(17)
  @JsonKey(name: 'is_updated')
  bool? get isUpdated;
  @override
  @HiveField(18)
  @JsonKey(name: 'case_id', includeToJson: false)
  int? get caseId;
  @override
  @HiveField(19)
  @JsonKey(name: 'is_form_id_assigned', includeToJson: false)
  bool? get isFormIDAssigned;
  @override
  @HiveField(20)
  @JsonKey(name: 'wheezing')
  String? get wheezing;
  @override
  @HiveField(21)
  @JsonKey(name: 'shortness_breath')
  String? get shortnessBreath;
  @override
  @HiveField(22)
  @JsonKey(name: 'tightness_chest')
  String? get tightnessChest;
  @override
  @HiveField(23)
  @JsonKey(name: 'screened_with_swasa')
  String? get swasaScreening;
  @override
  @HiveField(24)
  @JsonKey(
      name: 'swasa_screening_date',
      fromJson: fromJsonToDateTime,
      toJson: _dateTimeToJson)
  DateTime? get swasaScreeningDate;
  @override
  @HiveField(25)
  @JsonKey(name: 'swasa_screening_result')
  String? get swasaScreeningResult;
  @override
  @HiveField(26)
  @JsonKey(name: 'screening_cxr_ai')
  String? get cxrScreening;
  @override
  @HiveField(27)
  @JsonKey(
      name: 'cxr_screening_date',
      fromJson: fromJsonToDateTime,
      toJson: _dateTimeToJson)
  DateTime? get cxrScreeningDate;
  @override
  @HiveField(28)
  @JsonKey(name: 'cxr_screening_result')
  String? get cxrScreeningResult;

  /// Create a copy of TBScreeningModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TBScreeningModelImplCopyWith<_$TBScreeningModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
