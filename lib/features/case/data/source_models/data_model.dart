// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tatpar_orange/features/case/data/source_models/caste_category_model.dart';
import 'package:tatpar_orange/features/case/data/source_models/key_population_model.dart';
import 'package:tatpar_orange/features/case/data/source_models/referral_districts_model.dart';
import 'package:tatpar_orange/features/case/data/source_models/referrer_source_model.dart';
import 'package:tatpar_orange/features/case/data/source_models/trimester_model.dart';

part 'data_model.freezed.dart';
part 'data_model.g.dart';

@freezed
class DataModel with _$DataModel {
  @HiveType(typeId: 0, adapterName: 'DataModelAdapter')
  const factory DataModel({
    @HiveField(6)
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
