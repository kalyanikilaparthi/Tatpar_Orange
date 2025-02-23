// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tatpar_orange/features/case/data/source_models/diagnosis_data_fields.dart';
part 'diagnosis_data.freezed.dart';
part 'diagnosis_data.g.dart';

@freezed
@HiveType(typeId: 8)
class DiagnosisData with _$DiagnosisData {
  const factory DiagnosisData({
    @HiveField(9) @JsonKey(name: 'afb_result') List<AFBResult>? afbResult,
    @HiveField(10)
    @JsonKey(name: 'naat_machine')
    List<NaatMachine>? naatMachine,
    @HiveField(11) @JsonKey(name: 'mtb_result') List<MTBResult>? mtbResult,
    @HiveField(12) @JsonKey(name: 'tpt_regimen') List<TPTRegimen>? tptRegimen,
    @HiveField(13)
    @JsonKey(name: 'treatment_outcome')
    List<TreatmentOutcome>? treatmentOutcome,
    @HiveField(14)
    @JsonKey(name: 'treatment_history')
    List<TreatmentHistory>? treatmentHistory,
  }) = _DiagnosisData;

  factory DiagnosisData.fromJson(Map<String, dynamic> json) =>
      _$DiagnosisDataFromJson(json);
}
