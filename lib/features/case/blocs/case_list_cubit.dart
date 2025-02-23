import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tatpar_orange/features/case/data/case_models/case_model.dart';
import 'package:tatpar_orange/features/case/data/repos/case_repo.dart';

import '../data/case_models/cases_filter_model.dart';

part 'case_list_cubit.freezed.dart';
part 'case_list_cubit.g.dart';

@freezed
class CaseListState with _$CaseListState {
  const factory CaseListState({
    @Default(false) bool isLoading,
    @Default([]) List<Case> cases,
    List<Case>? filteredCases,
    required CasesFilterModel casesFilter,
    @Default(false) bool showAssignedToMeOnly,
  }) = _CaseListState;

  factory CaseListState.fromJson(Map<String, dynamic> json) => _$CaseListStateFromJson(json);
}

class CaseListCubit extends Cubit<CaseListState> {
  final CaseRepo caseRepo;

  CaseListCubit({required this.caseRepo}) : super(const CaseListState(casesFilter: CasesFilterModel()));

  void searchCases(String query) {
    applyFilters(
      caseFilter: state.casesFilter.copyWith(searchWord: query.isEmpty ? null : query),
    );
  }

  void applyFilters({CasesFilterModel? caseFilter}) {
    final filters = caseFilter ?? state.casesFilter;
    final cases = state.cases;
    List<Case> filteredCases = cases;
    if (filters.isEmpty) {
      return emit(state.copyWith(filteredCases: null, casesFilter: filters));
    }
    if (filters.searchWord != null) {
      filteredCases = filteredCases.where((element) {
        final queryLower = filters.searchWord!.toLowerCase();
        final patientName = element.referralName;
        final patientNumber = element.referralMobileNumber;
        final referralId = (element.referralId ?? '').toString();
        return patientName!.toLowerCase().contains(queryLower) ||
            patientNumber!.contains(queryLower) ||
            referralId.contains(queryLower);
      }).toList();
    }
    // if (filters.assignedTo.isNotEmpty) {
    //   filteredCases = filteredCases
    //       .where((element) => filters.assignedTo
    //           .any((assigned) => assigned == element.assignedTo?.id))
    //       .toList();
    // }
    // if (filters.selectedShortCut != null) {
    //   //  this is for completed cases
    //   // TODOTfilteredCases = filteredCases.where((element) => element.isCaseFormCompeted(filters.pendingStage!)).toList();
    //   // TODOT this is for pending cases
    //   filteredCases = filteredCases
    //       .where((element) =>
    //           element.isCaseNeedToCompete(filters.selectedShortCut!))
    //       .toList();
    // }
    emit(state.copyWith(filteredCases: filteredCases, casesFilter: filters));
  }

  // void applyPendingStageFilter(FilterShortCut? pendingStage) {
  //   if (state.casesFilter.selectedShortCut == pendingStage) {
  //     return applyFilters(
  //         caseFilter: state.casesFilter.copyWith(selectedShortCut: null));
  //   }
  //   return applyFilters(
  //       caseFilter: state.casesFilter.copyWith(selectedShortCut: pendingStage));
  // }

  Future<void> getCasesForHealthWorker() async {
    emit(state.copyWith(isLoading: true));
    final cases = await caseRepo.getCasesForHealthWorker();
    cases.sort((a, b) => b.createdOn!.compareTo(a.createdOn!));
    log(cases.toString());
    emit(
      state.copyWith(
        isLoading: false,
        cases: cases,
      ),
    );
  }

  // Future<void> assignCase(
  //     int caseId, SubordinatesModel subordinatesModel) async {
  //   final response = await caseRepo.assignSubordinate(caseId,
  //       subordinatesModel: subordinatesModel);
  //   if (response.status == Status.failed) {
  //     return;
  //   }
  //   final cases = state.cases;
  //   final index = cases.indexWhere((element) => element.id == caseId);
  //   if (index == -1) return;
  //   List<Case> copyCases = List.from(cases);
  //   copyCases[index] = copyCases[index].copyWith(
  //     assignedTo: HealthWorkerInfoModel(
  //       id: subordinatesModel.id,
  //       fullName:
  //           '${subordinatesModel.firstName ?? ''} ${subordinatesModel.lastName ?? ''}',
  //     ),
  //   );
  //   emit(
  //     state.copyWith(
  //       cases: copyCases,
  //     ),
  //   );
  // }

  // void toggleShowAssignedToMeOnly() {
  //   final showAssignedToMeOnly = !state.showAssignedToMeOnly;
  //   final assignedToList = state.casesFilter.assignedTo.toList();
  //   if (showAssignedToMeOnly) {
  //     assignedToList.add(AuthCubit.instance.state.user!.id);
  //   } else {
  //     assignedToList.removeWhere(
  //         (element) => element == AuthCubit.instance.state.user!.id);
  //   }
  //   emit(state.copyWith(
  //       showAssignedToMeOnly: showAssignedToMeOnly,
  //       casesFilter: state.casesFilter.copyWith(assignedTo: assignedToList)));
  //   applyFilters();
  // }

  void updateSingleCase(Case updatedCase) {
    final cases = state.cases;
    final index = cases.indexWhere((element) => element.id == updatedCase.id);

    if (index == -1) return;
    List<Case> copyCases = List.from(cases);
    copyCases[index] = updatedCase;

    emit(
      state.copyWith(cases: copyCases),
    );
  }

  Future<void> deleteCase(int caseId) async {
    await caseRepo.deleteCaseLocal(caseId);
    await caseRepo.deleteCaseRemote(caseId);
    final cases = state.cases;
    final index = cases.indexWhere((element) => element.id == caseId);
    if (index == -1) return;
    List<Case> copyCases = List.from(cases);
    copyCases.removeAt(index);
    emit(
      state.copyWith(
        cases: copyCases,
      ),
    );
  }
}
