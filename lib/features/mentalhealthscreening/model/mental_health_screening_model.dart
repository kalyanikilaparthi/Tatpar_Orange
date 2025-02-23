// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tatpar_orange/features/mentalhealthscreening/model/who_srq_model.dart';

part 'mental_health_screening_model.freezed.dart';
part 'mental_health_screening_model.g.dart';

DateTime? fromJsonToDateTime(String? date) {
  if (date == null) {
    return null;
  }
  final dateCleaned = date.split('T')[0];
  final dateParts = dateCleaned.split('-');
  return DateTime(int.parse(dateParts[0]), int.parse(dateParts[1]),
      int.parse(dateParts[2]));
}

String? _dateTimeToJson(DateTime? date) =>
    date?.toIso8601String().substring(0, 10);

@freezed
@HiveType(typeId: 17)
class MentalHealthScreeningModel with _$MentalHealthScreeningModel {
  const factory MentalHealthScreeningModel({
    @HiveField(0) @JsonKey(name: 'id', includeToJson: false) int? id,
    @HiveField(1) @JsonKey(includeToJson: false) String? stage,
    @HiveField(2) @JsonKey(name: 'ip_stage') String? ipStage,
    @HiveField(3) @JsonKey(name: 'ipfu_stage') String? ipfuStage,
    @HiveField(4) @JsonKey(name: 'cp_stage') String? cpStage,
    @HiveField(5)
    @JsonKey(
      name: 'ip_screening_date',
      fromJson: fromJsonToDateTime,
      toJson: _dateTimeToJson,
    )
    DateTime? ipScreeningDate,
    @HiveField(6)
    @JsonKey(
      name: 'ipfu_screening_date',
      fromJson: fromJsonToDateTime,
      toJson: _dateTimeToJson,
    )
    DateTime? ipfuScreeningDate,
    @HiveField(7)
    @JsonKey(
      name: 'cp_screening_date',
      fromJson: fromJsonToDateTime,
      toJson: _dateTimeToJson,
    )
    DateTime? cpScreeningDate,
    @HiveField(8) @JsonKey(name: 'ip_case_status') String? ipScreeningStatus,
    @HiveField(9)
    @JsonKey(name: 'ipfu_case_status')
    String? ipfuScreeningStatus,
    @HiveField(10) @JsonKey(name: 'cp_case_status') String? cpScreeningStatus,
    @HiveField(11) @JsonKey(name: 'ip_score') String? ipScreeningScore,
    @HiveField(12) @JsonKey(name: 'ipfu_score') String? ipfuScreeningScore,
    @HiveField(13) @JsonKey(name: 'cp_score') String? cpScreeningScore,
    @HiveField(14)
    @JsonKey(
      name: 'ip_counselling_linked',
      fromJson: fromJsonToDateTime,
      toJson: _dateTimeToJson,
    )
    DateTime? ipCounsellingLinked,
    @HiveField(15)
    @JsonKey(
      name: 'ipfu_counselling_linked',
      fromJson: fromJsonToDateTime,
      toJson: _dateTimeToJson,
    )
    DateTime? ipfuCounsellingLinked,
    @HiveField(16)
    @JsonKey(
      name: 'cp_counselling_linked',
      fromJson: fromJsonToDateTime,
      toJson: _dateTimeToJson,
    )
    DateTime? cpCounsellingLinked,
    @HiveField(17)
    @JsonKey(
      name: 'ip_psychiatrist_linked',
      fromJson: fromJsonToDateTime,
      toJson: _dateTimeToJson,
    )
    DateTime? ipPsychiatristLinked,
    @HiveField(18)
    @JsonKey(
      name: 'ipfu_psychiatrist_linked',
      fromJson: fromJsonToDateTime,
      toJson: _dateTimeToJson,
    )
    DateTime? ipfuPsychiatristLinked,
    @HiveField(19)
    @JsonKey(
      name: 'cp_psychiatrist_linked',
      fromJson: fromJsonToDateTime,
      toJson: _dateTimeToJson,
    )
    DateTime? cpPsychiatristLinked,
    @HiveField(20)
    @JsonKey(name: 'ip_feeling_better_linkage')
    String? ipFeelingBetter,
    @HiveField(21)
    @JsonKey(name: 'ipfu_feeling_better_linkage')
    String? ipfuFeelingBetter,
    @HiveField(22)
    @JsonKey(name: 'cp_feeling_better_linkage')
    String? cpFeelingBetter,
    @HiveField(23)
    @JsonKey(name: 'ip_talk_helpline_again')
    String? iptalkToHelpline,
    @HiveField(24)
    @JsonKey(name: 'ipfu_talk_helpline_again')
    String? ipfutalkToHelpline,
    @HiveField(25)
    @JsonKey(name: 'cp_talk_helpline_again')
    String? cptalkToHelpline,
    @HiveField(26) @JsonKey(includeToJson: false) WHOSrqModel? whoSrqModel,
    @HiveField(27) @JsonKey(name: 'is_updated') bool? isUpdated,
    @HiveField(28)
    @JsonKey(name: 'is_form_id_assigned', includeToJson: false)
    bool? isFormIDAssigned,
    @HiveField(29) @JsonKey(name: 'case_id', includeToJson: false) int? caseId,
  }) = _MentalHealthScreeningModel;

  factory MentalHealthScreeningModel.fromJson(Map<String, dynamic> json) =>
      _$MentalHealthScreeningModelFromJson(json);
}
