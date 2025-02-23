// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'treatment_model.freezed.dart';

part 'treatment_model.g.dart';

DateTime? fromJsonToDateTime(String? date) {
  if (date == null) {
    return null;
  }
  final dateCleaned = date.split('T')[0];
  final dateParts = dateCleaned.split('-');
  return DateTime(int.parse(dateParts[0]), int.parse(dateParts[1]),
      int.parse(dateParts[2]));
}

List<bool> ihvChecklistFromJson(List<dynamic>? json) {
  final List<bool> checklist = List.generate(10, (index) => false);
  if(json == null){
    return checklist;
  }
  for (final item in json) {
    if(item.toString().startsWith('Q')){
      final index = int.parse(item.toString().substring(1));
      checklist[index - 1] = true;
    }
  }
  return checklist;
}

List<String> ihvChecklistToJson(List<bool>? checklist) {
  final List<String> json = [];
  if(checklist == null){
    return json;
  }
  for (var i = 0; i < checklist.length; i++) {
    if(checklist[i]){
      json.add('Q${i + 1}');
    }
  }
  return json;
}



String? _dateTimeToJson(DateTime? date) =>
    date?.toIso8601String().substring(0, 10);

@freezed
@HiveType(typeId: 19)
class TreatmentModel with _$TreatmentModel {
  const factory TreatmentModel({
    @HiveField(0) @JsonKey(name: 'id', includeToJson: false) int? id,
    @HiveField(1) @JsonKey(name: 'case_definition') String? caseDefinition,
    @HiveField(2) @JsonKey(name: 'tb_site') String? tbSite,
    @HiveField(4) @JsonKey(name: 'drug_sensitive') String? drugSensitive,
    @HiveField(5) @JsonKey(name: 'diagnosis_status') String? diagnosisStatus,
    @HiveField(6)
    @JsonKey(
      name: 'ihv_date',
      fromJson: fromJsonToDateTime,
      toJson: _dateTimeToJson,
    )
    DateTime? ihvDate,
    @HiveField(7) @JsonKey(name: 'treatment_regimen') String? treatmentRegimen,
    @HiveField(8)
    @JsonKey(name: 'patient_occupation')
    String? patientOccupation,
    @HiveField(9)
    @JsonKey(name: 'treatment_supporter_name')
    String? treatmentSupporterName,
    @HiveField(10)
    @JsonKey(name: 'treatment_supporter_position')
    String? treatmentSupporterPosition,
    @HiveField(11)
    @JsonKey(name: 'treatment_supporter_phone')
    String? treatmentSupporterPhone,
    @HiveField(12)
    @JsonKey(includeToJson: false)
    String? treatmentSupporterPanchayat,
    @HiveField(13)
    @JsonKey(name: 'treatment_supporter_panchayat')
    int? selectedTreatmentSupporterPanchayat,
    @HiveField(14)
    @JsonKey(name: 'treatment_supporter_ward')
    int? treatmentSupporterWard,
    @HiveField(15)
    @JsonKey(
      name: 'ipt_start_date',
      fromJson: fromJsonToDateTime,
      toJson: _dateTimeToJson,
    )
    DateTime? ipStartDate,
    @HiveField(16) @JsonKey(name: 'hiv_done') String? hivDone,
    @HiveField(17) @JsonKey(name: 'hiv_result') String? hivResult,
    @HiveField(18)
    @JsonKey(
      name: 'hiv_date',
      fromJson: fromJsonToDateTime,
      toJson: _dateTimeToJson,
    )
    DateTime? hivDate,
    @HiveField(19) @JsonKey(name: 'hb_done') String? hbDone,
    @HiveField(20) @JsonKey(name: 'hb_result') double? hbResult,
    @HiveField(21)
    @JsonKey(
      name: 'hb_date',
      fromJson: fromJsonToDateTime,
      toJson: _dateTimeToJson,
    )
    DateTime? hbDate,
    @HiveField(22) @JsonKey(name: 'blood_sugar_done') String? bloodSugarDone,
    @HiveField(23)
    @JsonKey(name: 'blood_sugar_result')
    double? bloodSugarResult,
    @HiveField(24)
    @JsonKey(
      name: 'blood_sugar_date',
      fromJson: fromJsonToDateTime,
      toJson: _dateTimeToJson,
    )
    DateTime? bloodSugarDate,
    @HiveField(25) @JsonKey(name: 'alcohol') String? alcohol,
    @HiveField(26) @JsonKey(name: 'tb_consumption') String? tobaccoConsumption,
    @HiveField(27)
    @JsonKey(name: 'nutrition_screening')
    String? nutritionScreening,
    @HiveField(28)
    @JsonKey(name: 'nutrition_eligibility')
    String? nutritionEligibility,
    @HiveField(29)
    @JsonKey(
      name: 'nutrition_screening_date',
      fromJson: fromJsonToDateTime,
      toJson: _dateTimeToJson,
    )
    DateTime? screeningDateNutrition,
    @HiveField(30) @JsonKey(name: 'nutrition_linkage') String? nutritionLinkage,
    @HiveField(31)
    @JsonKey(
      name: 'nutrition_linkage_date',
      fromJson: fromJsonToDateTime,
      toJson: _dateTimeToJson,
    )
    DateTime? nutritionLinkageDate,
    @HiveField(32) @JsonKey(name: 'height') int? height,
    @HiveField(33) @JsonKey(name: 'weight') int? weight,
    @HiveField(34) @JsonKey(name: 'stage') String? stage,
    @HiveField(35)
    @JsonKey(
      name: 'ipfu_date',
      fromJson: fromJsonToDateTime,
      toJson: _dateTimeToJson,
    )
    DateTime? ipfuDate,
    @HiveField(36) @JsonKey(name: 'ipfu_afb_done') String? ipfuAfbDone,
    @HiveField(37)
    @JsonKey(name: 'ip_followup_afb_lab_number')
    String? ipfuAfbLabNo,
    @HiveField(38)
    @JsonKey(
      name: 'ipfu_afb_date',
      fromJson: fromJsonToDateTime,
      toJson: _dateTimeToJson,
    )
    DateTime? ipfuAfbDate,
    @HiveField(39) @JsonKey(includeToJson: false) String? ipfuAfbResult,
    @HiveField(40) @JsonKey(name: 'ipfu_afb_result') int? selectedIpfuAFBResult,
    @HiveField(41) @JsonKey(name: 'ip_followup_nat_test') String? ipfuNaatTest,
    @HiveField(42) @JsonKey(includeToJson: false) String? ipfuNaatResult,
    @HiveField(43)
    @JsonKey(name: 'ip_followup_naat_result')
    int? selectedIpfuNaatResult,
    @HiveField(44) @JsonKey(name: 'ip_followup_lab_number') String? ipfuLabNo,
    @HiveField(45) @JsonKey(name: 'ipfu_chest_xray') String? ipfuChestXray,
    @HiveField(46)
    @JsonKey(name: 'ipfu_nutrition_support')
    String? ipfuNutritionSupport,
    @HiveField(47)
    @JsonKey(
      name: 'cp_date',
      fromJson: fromJsonToDateTime,
      toJson: _dateTimeToJson,
    )
    DateTime? cpDate,
    @HiveField(48) @JsonKey(name: 'cp_afb_done') String? cpAfbDone,
    @HiveField(49) @JsonKey(name: 'cp_afb_lab_number') String? cpAfbLabNo,
    @HiveField(50)
    @JsonKey(
      name: 'cp_afb_date',
      fromJson: fromJsonToDateTime,
      toJson: _dateTimeToJson,
    )
    DateTime? cpAfbDate,
    @HiveField(51) @JsonKey(includeToJson: false) String? cpAfbResult,
    @HiveField(52) @JsonKey(name: 'cp_afb_result') int? selectedCpAFBResult,
    @HiveField(53) @JsonKey(name: 'cp_naat_test') String? cpNaatTest,
    @HiveField(54) @JsonKey(includeToJson: false) String? cpNaatResult,
    @HiveField(55) @JsonKey(name: 'cp_naat_result') int? selectedCpNaatResult,
    @HiveField(56) @JsonKey(name: 'cp_lab_no') String? cpLabNo,
    @HiveField(57) @JsonKey(name: 'cp_chest_xray') String? cpChestXray,
    @HiveField(58)
    @JsonKey(name: 'cp_nutrition_support')
    String? cpNutritionSupport,
    @HiveField(59) @JsonKey(name: 'is_updated') bool? isUpdated,
    @HiveField(60) @JsonKey(name: 'case_id', includeToJson: false) int? caseId,
    @HiveField(61)
    @JsonKey(name: 'is_form_id_assigned', includeToJson: false)
    bool? isFormIDAssigned,
    @HiveField(62) @JsonKey(name: 'nikshay_id') String? nikshayId,
    @HiveField(63)
    @JsonKey(name: 'case_history')
    int? selectedTreatmentHistoryResult,
    @HiveField(64) @JsonKey(includeToJson: false) String? treatmentHistory,
    @HiveField(65)
    @JsonKey(
      name: 'ihv_checklist',
      fromJson: ihvChecklistFromJson,
      toJson: ihvChecklistToJson,
    )
    List<bool>? ihvChecklist,
    @HiveField(66)
    @JsonKey(
      name: 'ipfu_gx_rr',
    )
    String? ipfuGxRr,
    @HiveField(67)
    @JsonKey(
      name: 'cpfu_gx_rr',
    )
    String? cpGxRr,
  }) = _TreatmentModel;

  factory TreatmentModel.fromJson(Map<String, dynamic> json) =>
      _$TreatmentModelFromJson(json);
}
