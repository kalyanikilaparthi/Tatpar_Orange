import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tatpar_orange/features/case/data/source_models/diagnosis_data.dart';
import 'package:tatpar_orange/features/case/data/source_models/data_model.dart';

import '../data/repos/source_repo.dart';
part 'source_cubit.freezed.dart';
part 'source_cubit.g.dart';

@freezed
class SourceState with _$SourceState {
  const factory SourceState(
      {bool? isLoading,
      DataModel? dataModel,
      DiagnosisData? diagnosisData,
      List<String>? panchayatList,
      List<String>? blockList}) = _SourceState;

  factory SourceState.fromJson(Map<String, dynamic> json) =>
      _$SourceStateFromJson(json);
}

class SourceCubit extends Cubit<SourceState> {
  final SourceRepo repo;
  String? _selectedDistrict;
  String? _selectedBlock;
  String? _selectedPanchayatCode;

  set selectDistrict(String? selectedDistrict) =>
      _selectedDistrict = selectedDistrict;
  set selectBlock(String? selectedBlock) => _selectedBlock = selectedBlock;
  set selectPanchayatCode(String? selectedPanchayatCode) =>
      _selectedPanchayatCode = selectedPanchayatCode;

  String? get selectedBlock => _selectedBlock;
  String? get selectedDistrict => _selectedDistrict;
  String? get selectedPanchayatCode => _selectedPanchayatCode;

  SourceCubit(this.repo) : super(const SourceState());
  Future<void> loadDistricts() async {
    emit(state.copyWith(isLoading: true));
    try {
      final model = await repo.buildDataFields();
      emit(state.copyWith(isLoading: false, dataModel: model));
    } on Exception {
      emit(
        state.copyWith(
          isLoading: true,
        ),
      );
    }
  }

  Future<void> loadDiagnosisData() async {
    emit(state.copyWith(isLoading: true));
    try {
      final model = await repo.getDiagnosisData();
      emit(state.copyWith(isLoading: false, diagnosisData: model));
    } on Exception {
      emit(
        state.copyWith(
          isLoading: true,
        ),
      );
    }
  }

  Future<void> fetchDataForBlock(String value) async {
    emit(state.copyWith(isLoading: true, blockList: [], panchayatList: []));
    List<String> blockList = (state.dataModel!.districts!
        .where((element) => element.district == value)
        .expand((e) => e.block!.map((e) => '${e.block}'))
        .toList());
    emit(state.copyWith(isLoading: false, blockList: blockList));
  }

  Future<void> fetchDataForPanchayat(String value) async {
    emit(state.copyWith(isLoading: true, panchayatList: []));
    List<String> panchayatList = (state.dataModel!.blocks!
        .where((element) => element.block == value)
        .expand((e) => e.panchayat!.map((e) => '${e.panchayat}'))
        .toList());
    emit(state.copyWith(isLoading: false, panchayatList: panchayatList));
  }
}
