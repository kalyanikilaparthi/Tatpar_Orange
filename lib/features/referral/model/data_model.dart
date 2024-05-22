// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tatpar_acf/features/referral/model/caste_category_model.dart';
import 'package:tatpar_acf/features/referral/model/key_population_model.dart';
import 'package:tatpar_acf/features/referral/model/referral_districts_model.dart';
import 'package:tatpar_acf/features/referral/model/referrer_source_model.dart';
import 'package:tatpar_acf/features/referral/model/trimester_model.dart';

part 'data_model.freezed.dart';
part 'data_model.g.dart';

@freezed
@HiveType(typeId: 0)
class DataModel with _$DataModel {
  const factory DataModel({
    @HiveField(0)
    @JsonKey(name: 'caste_category')
    List<CasteCategory>? casteCategory,
    @HiveField(1)
    @JsonKey(name: 'key_population')
    List<KeyPopulation>? keyPopulation,
    @HiveField(2)
    @JsonKey(name: 'referrer_source')
    List<ReferrerSource>? referrerSource,
    @HiveField(3) @JsonKey(name: 'trimester_of_pw') List<Trimester>? trimester,
    @HiveField(4) @JsonKey(name: 'districts') List<District>? districts,
    @HiveField(5) @JsonKey(name: 'blocks') List<Block>? blocks,
  }) = _DataModel;

  factory DataModel.fromJson(Map<String, dynamic> json) =>
      _$DataModelFromJson(json);
}
