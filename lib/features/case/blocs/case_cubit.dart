import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:tatpar_acf/configurations/configurations.dart';
import 'package:tatpar_acf/features/case/data/case_models/case_model.dart';
import 'package:tatpar_acf/features/case/data/repos/case_repo.dart';
import 'package:tatpar_acf/features/case/data/source_models/data_model.dart';
import 'package:tatpar_acf/features/case/data/source_models/diagnosis_data.dart';
import 'package:tatpar_acf/features/conducttbscreening/model/tb_screening_model.dart';
import 'package:tatpar_acf/features/contacttracing/models/contact_tracing_model.dart';
import 'package:tatpar_acf/features/diagnosis/model/diagnosis_model.dart';
import 'package:tatpar_acf/features/faochecklist/models/faq_checklist_model.dart';
import 'package:tatpar_acf/features/mentalhealthscreening/model/mental_health_screening_model.dart';
import 'package:tatpar_acf/features/mentalhealthscreening/model/who_srq_model.dart';
import 'package:tatpar_acf/features/outcome/model/outcome_model.dart';
import 'package:tatpar_acf/features/referral/model/referral_details_model.dart';
import 'package:tatpar_acf/features/treatment/model/treatment_model.dart';

import '../data/case_models/workflow_item.dart';

part 'case_cubit.freezed.dart';
part 'case_cubit.g.dart';

@freezed
class CaseState with _$CaseState {
  const factory CaseState(
      {@Default(false) bool isLoading,
      @Default([]) List<ContactTracingModel> contactTracingList,
      required Case caseWorkedUpon,
      DataModel? dataModel,
      ReferralDetailsModel? referralDetailsModel,
      TBScreeningModel? tbScreeningModel,
      WHOSrqModel? whoSrqModel,
      MentalHealthScreeningModel? mentalHealthScreeningModel,
      String? screeningOutcome,
      int? contactTracingId,
      DiagnosisModel? diagnsosisModel,
      DiagnosisData? diagnosisData,
      TreatmentModel? treatmentModel,
      ContactTracingModel? contactTracingModel,
      OutcomeModel? outcomeModel,
      List<ContactTracingModel>? filteredContacts,
      FaqChecklistModel? faqCheckListModel}) = _CaseState;

  factory CaseState.fromJson(Map<String, dynamic> json) =>
      _$CaseStateFromJson(json);
}

class CaseCubit extends Cubit<CaseState> {
  final CaseRepo caseRepo;

  CaseCubit({
    required this.caseRepo,
    required Case caseModel,
  }) : super(CaseState(caseWorkedUpon: caseModel)) {
    if (caseModel.referralDetails != null) {
      getReferralDetailsData(caseModel.referralDetails);
    }
    if (caseModel.tbScreening != null) {
      getTBScreeningData(caseModel.tbScreening);
    }
    if (caseModel.whoSrq != null) {
      getMentalHealthScreeningData(caseModel.whoSrq);
    }
    if (caseModel.diagnosis != null) {
      getDiagnosisData(caseModel.diagnosis);
    }
    if (caseModel.treatment != null) {
      getTreatmentData(caseModel.treatment);
    }

    if (caseModel.outcomeValue != null) {
      getOutcomeData(caseModel.outcomeValue);
    }
    if (caseModel.faqChecklist != null) {
      getFaqCheckListData(caseModel.faqChecklist);
    }
    if (caseModel.id != null &&
        caseModel.contactTracingList != null &&
        caseModel.contactTracingList!.isNotEmpty) {
      getContactTracingListData();
    }
  }
  Case? _selectedCase;

  Case? get selectedCase => _selectedCase;

  set selectCase(Case? selectedCase) => _selectedCase = selectedCase;

  ///ReferralDetailsPage
  int? _selectedDistrictId;
  int? _selectedBlockId;
  int? _selectedPanchayatCodeId;
  int? _selectedCasteCategory;
  List<int>? _selectedKeyPopulation;
  int? _selectedTrimester;
  int? _selectedReferrerSource;
  int? _selectedReferrerPanchayatCodeId;

  ///TB Screening
  int? _selectedTBTrimester;

  ///DiagnosisPage
  int? _selectedAFB1Result;
  int? _selectedAFB2Result;
  int? _selectedNAATMachine;
  int? _selectedMTBResult;
  int? _selectedXDRResult;

  ///TreatmentPage
  int? _selectedTreatmentPanchayatCodeId;
  int? _selectedIPFUAFBResult;
  int? _selectedCPAFBResult;
  int? _selectedTreatmentIPFUNaatResult;
  int? _selectedTreatmentCPFUNaatResult;
  int? _selectedTreatmentHistoryResult;

  ///ContactTracingPage
  int? _selectedTPTRegimen;

  ///OutcomePage
  int? _selectedTreatmentOutcome;

  set selectDistrictId(int? selectedDistrictId) =>
      _selectedDistrictId = selectedDistrictId;
  set selectBlockId(int? selectedBlockId) => _selectedBlockId = selectedBlockId;
  set selectPanchayatCodeId(int? selectedPanchayatCodeId) =>
      _selectedPanchayatCodeId = selectedPanchayatCodeId;
  set selectReferrerPanchayatCodeId(int? selectedReferrerPanchayatCodeId) =>
      _selectedReferrerPanchayatCodeId = selectedReferrerPanchayatCodeId;
  set selectCasteCategory(int? selectedCasteCategory) =>
      _selectedCasteCategory = selectedCasteCategory;
  set selectKeyPopulation(List<int>? selectedKeyPopulation) =>
      _selectedKeyPopulation = selectedKeyPopulation;
  set selectTrimester(int? selectedTrimester) =>
      _selectedTrimester = selectedTrimester;
  set selectReferrerSource(int? selectedReferrerSource) =>
      _selectedReferrerSource = selectedReferrerSource;

  set selectTBTrimester(int? selectedTBTrimester) =>
      _selectedTBTrimester = selectedTBTrimester;

  set selectAFB1Result(int? selectedAFB1Result) =>
      _selectedAFB1Result = selectedAFB1Result;
  set selectAFB2Result(int? selectedAFB2Result) =>
      _selectedAFB2Result = selectedAFB2Result;
  set selectNAATMachine(int? selectedNAATMachine) =>
      _selectedNAATMachine = selectedNAATMachine;
  set selectMTBResult(int? selectedMTBResult) =>
      _selectedMTBResult = selectedMTBResult;
  set selectXDRResult(int? selectedXDRResult) =>
      _selectedXDRResult = selectedXDRResult;

  set selectTreatmentPanchayatCodeId(int? selectedTreatmentPanchayatCodeId) =>
      _selectedTreatmentPanchayatCodeId = selectedTreatmentPanchayatCodeId;
  set selectIPFUAFBResult(int? selectedIPFUAFBResult) =>
      _selectedIPFUAFBResult = selectedIPFUAFBResult;
  set selectCPAFBResult(int? selectedCPAFBResult) =>
      _selectedCPAFBResult = selectedCPAFBResult;
  set selectTreatmentIPFUNaatResult(int? selectedTreatmentIPFUNaatResult) =>
      _selectedTreatmentIPFUNaatResult = selectedTreatmentIPFUNaatResult;
  set selectTreatmentCPFUNaatResult(int? selectedTreatmentCPFUNaatResult) =>
      _selectedTreatmentCPFUNaatResult = selectedTreatmentCPFUNaatResult;
  set selectTreatmentHistoryResult(int? selectedTreatmentHistoryResult) =>
      _selectedTreatmentHistoryResult = selectedTreatmentHistoryResult;

  set selectTPTRegimen(int? selectedTPTRegimen) =>
      _selectedTPTRegimen = selectedTPTRegimen;

  set selectTreatmentOutcome(int? selectedTreatmentOutcome) =>
      _selectedTreatmentOutcome = selectedTreatmentOutcome;

  int? get selectedBlockId => _selectedBlockId;
  int? get selectedDistrictId => _selectedDistrictId;
  int? get selectedPanchayatCodeId => _selectedPanchayatCodeId;
  int? get selectedReferrerPanchayatCodeId => _selectedReferrerPanchayatCodeId;
  int? get selectedCasteCategory => _selectedCasteCategory;
  List<int>? get selectedKeyPopulation => _selectedKeyPopulation;
  int? get selectedTrimester => _selectedTrimester;
  int? get selectedReferrerSource => _selectedReferrerSource;

  int? get selectedTBTrimester => _selectedTBTrimester;

  int? get selectedAFB1Result => _selectedAFB1Result;
  int? get selectedAFB2Result => _selectedAFB2Result;
  int? get selectedNAATMachine => _selectedNAATMachine;
  int? get selectedMTBResult => _selectedMTBResult;
  int? get selectedXDRResult => _selectedXDRResult;

  int? get selectedTreatmentPanchayatCodeId =>
      _selectedTreatmentPanchayatCodeId;

  int? get selectedTPTRegimen => _selectedTPTRegimen;

  int? get selectedTreatmentOutcome => _selectedTreatmentOutcome;
  int? get selectedIPFUAFBResult => _selectedIPFUAFBResult;
  int? get selectedCPAFBResult => _selectedCPAFBResult;
  int? get selectedTreatmentIPFUNaatResult => _selectedTreatmentIPFUNaatResult;
  int? get selectedTreatmentCPFUNaatResult => _selectedTreatmentCPFUNaatResult;
  int? get selectedTreatmentHistoryResult => _selectedTreatmentHistoryResult;

  String? updateScreeningOutcome(FormGroup formGroup) {
    final cough = formGroup.control('cough').value;
    final sputum = formGroup.control('sputum').value;
    final hemoptysis = formGroup.control('hemoptysis').value;
    final fever = formGroup.control('fever').value;
    final nightSweats = formGroup.control('night_sweats').value;
    final chestPain = formGroup.control('chest_pain').value;
    final weightLoss = formGroup.control('weight_loss').value;
    final swollenGland = formGroup.control('swollen_gland').value;
    final tbMedicine = formGroup.control('tb_medicine').value;
    if (cough == 'No' &&
        sputum == 'No' &&
        hemoptysis == 'No' &&
        fever == 'No' &&
        nightSweats == 'No' &&
        chestPain == 'No' &&
        weightLoss == 'No' &&
        swollenGland == 'No') {
      emit(state.copyWith(screeningOutcome: 'No Symptom'));
      return 'No Symptom';
    } else if (swollenGland == 'Yes') {
      emit(state.copyWith(screeningOutcome: 'Presumptive EPTB'));
      return 'EPTB';
    } else if ((cough == 'Yes' ||
            sputum == 'Yes' ||
            hemoptysis == 'Yes' ||
            fever == 'Yes' ||
            chestPain == 'Yes' ||
            weightLoss == 'Yes' ||
            swollenGland == 'Yes') &&
        tbMedicine == 'Yes') {
      emit(state.copyWith(screeningOutcome: 'Presumptive DRTB'));
      return 'DRTB';
    } else if ((cough == 'Yes' ||
            sputum == 'Yes' ||
            hemoptysis == 'Yes' ||
            fever == 'Yes' ||
            chestPain == 'Yes' ||
            weightLoss == 'Yes') &&
        swollenGland == 'No' &&
        tbMedicine == 'No') {
      emit(state.copyWith(screeningOutcome: 'Presumptive DSTB'));
      return 'DSTB';
    } else {
      emit(state.copyWith(screeningOutcome: 'No Symptom'));
      return 'No Symptom';
    }
  }

  Map<String, dynamic> calculateYesCounter(
      FormGroup formGroup, WHOSrqModel whoSrqModel) {
    int numberOfYes = 0;
    String screeningStatus;
    formGroup.controls.forEach((key, control) {
      if (control.value?.toString() == 'Yes') {
        numberOfYes++;
      }
    });
    if (numberOfYes > 14 ||
        (formGroup.control('ending_your_life').value == 'Yes' &&
            numberOfYes < 15)) {
      screeningStatus = 'Positive';
    } else {
      screeningStatus = 'Negative';
    }
    String yesCounter = '$numberOfYes/20'.toString();
    return {
      'yesCounter': yesCounter,
      'screeningStatus': screeningStatus,
      'whoSrqModel': whoSrqModel
    };
  }

  Future<Case?> getCaseModel(int? caseId) async {
    final response = await caseRepo.getCaseModel(caseId: caseId);
    return response;
  }

  Future<void> getReferralDetailsData(int? formId) async {
    emit(state.copyWith(isLoading: true));

    if (state.caseWorkedUpon.referralDetails == null) return;
    final response = await caseRepo.getReferralDetails(id: formId);
    log(response.toString());
    emit(
      state.copyWith(
        isLoading: false,
        caseWorkedUpon: state.caseWorkedUpon.copyWith(referralDetails: formId),
        referralDetailsModel: response,
      ),
    );
  }

  Future<void> getTBScreeningData(int? formId) async {
    if (state.caseWorkedUpon.tbScreening == null) return;
    caseRepo.getTBScreening(id: formId).then((value) {
      emit(state.copyWith(isLoading: true));
      emit(
        state.copyWith(
          isLoading: false,
          tbScreeningModel: value,
        ),
      );
    });
  }

  Future<void> getMentalHealthScreeningData(int? formId) async {
    if (state.caseWorkedUpon.whoSrq == null) return;
    emit(state.copyWith(isLoading: true));

    final response = await caseRepo.getWhoSrq(id: formId);
    emit(
      state.copyWith(
        isLoading: false,
        mentalHealthScreeningModel: response,
      ),
    );
  }

  Future<void> getDiagnosisData(int? formId) async {
    if (state.caseWorkedUpon.diagnosis == null) return;
    emit(state.copyWith(isLoading: true));

    final response = await caseRepo.getDiagnosis(id: formId);
    emit(
      state.copyWith(
        isLoading: false,
        diagnsosisModel: response,
      ),
    );
  }

  Future<void> getTreatmentData(int? formId) async {
    if (state.caseWorkedUpon.treatment == null) return;
    emit(state.copyWith(isLoading: true));

    final response = await caseRepo.getTreatment(id: formId);
    emit(
      state.copyWith(
        isLoading: false,
        treatmentModel: response,
      ),
    );
  }

  Future<void> getOutcomeData(int? formId) async {
    if (state.caseWorkedUpon.outcomeValue == null) return;
    emit(state.copyWith(isLoading: true));

    final response = await caseRepo.getOutcome(id: formId);
    emit(
      state.copyWith(
        isLoading: false,
        outcomeModel: response,
      ),
    );
  }

  Future<void> getFaqCheckListData(int? formId) async {
    if (state.caseWorkedUpon.faqChecklist == null) return;
    emit(state.copyWith(isLoading: true));

    final response = await caseRepo.getFaqChecklist(id: formId);
    emit(
      state.copyWith(
        isLoading: false,
        faqCheckListModel: response,
      ),
    );
  }

  Future<void> getContactTracingListData() async {
    final response =
        await caseRepo.getContactTracingList(caseId: state.caseWorkedUpon.id);
    emit(
      state.copyWith(
        contactTracingList: response,
      ),
    );
  }

  Future<void> getContactTracingData(int? formId) async {
    if (state.caseWorkedUpon.contactTracingList == null) return;
    emit(state.copyWith(isLoading: true));

    final response = await caseRepo.getContactTracing(id: formId);
    emit(
      state.copyWith(
        isLoading: false,
        contactTracingModel: response,
      ),
    );
  }

  void resetSelectedCase() {
    selectCase = null;
    emit(state.copyWith(caseWorkedUpon: const Case()));
  }

  Future<int?> updateReferralDetailsData(
      ReferralDetailsModel referralDetailsModel) async {
    final response = await caseRepo.saveReferralDetails(
        referralDetailsModel: referralDetailsModel,
        id: state.caseWorkedUpon.referralDetails,
        referralId: state.caseWorkedUpon.referralId ?? '');
    selectCase = await getCaseModel(response.caseId);

    emit(
      state.copyWith(
        caseWorkedUpon: (selectedCase ?? state.caseWorkedUpon)
            .copyWith(referralDetails: response.id),
        referralDetailsModel: response,
      ),
    );
    //  log('Response.caseID================${response.caseId.toString()}');

    getReferralDetailsData(state.caseWorkedUpon.referralDetails);
    return response.caseId;
  }

  Future<void> updateTbScreeningData(TBScreeningModel tbScreeningModel) async {
    final response = await caseRepo.saveTbScreeningData(
        tbScreeningModel: tbScreeningModel,
        id: state.caseWorkedUpon.tbScreening,
        caseId: state.caseWorkedUpon.id);

    emit(
      state.copyWith(
        caseWorkedUpon: state.caseWorkedUpon.copyWith(tbScreening: response.id),
        tbScreeningModel: response,
      ),
    );

    getTBScreeningData(state.caseWorkedUpon.tbScreening);
    getCaseModel(state.caseWorkedUpon.id);
  }

  Future<void> updateWHOSRQData(
      MentalHealthScreeningModel mentalHealthScreeningModel,
      WHOSrqModel? whoSrqModel,
      WHOSrqModel? ipfuWhoSrqModel,
      WHOSrqModel? cpWhoSrqModel) async {
    final response = await caseRepo.saveWHOSRQData(
        mentalHealthScreeningModel: mentalHealthScreeningModel,
        whoSrqModel: whoSrqModel,
        id: state.caseWorkedUpon.whoSrq,
        caseId: state.caseWorkedUpon.id,
        ipfuWhoSrqModel: ipfuWhoSrqModel,
        cpWhoSrqModel: cpWhoSrqModel);
    emit(
      state.copyWith(
        caseWorkedUpon: state.caseWorkedUpon.copyWith(whoSrq: response.id),
        mentalHealthScreeningModel: response,
      ),
    );
    getMentalHealthScreeningData(state.caseWorkedUpon.whoSrq);
  }

  Future<void> updateDiagnosisData(DiagnosisModel diagnosisModel) async {
    final response = await caseRepo.saveDiagnosisData(
        diagnosisModel: diagnosisModel,
        id: state.caseWorkedUpon.diagnosis,
        caseId: state.caseWorkedUpon.id);
    emit(
      state.copyWith(
        caseWorkedUpon: state.caseWorkedUpon.copyWith(diagnosis: response.id),
        diagnsosisModel: response,
      ),
    );
    getDiagnosisData(state.caseWorkedUpon.diagnosis);
  }

  Future<void> updateTreatmentData(TreatmentModel treatmentModel) async {
    final response = await caseRepo.saveTreatmentData(
        treatmentModel: treatmentModel,
        id: state.caseWorkedUpon.treatment,
        caseId: state.caseWorkedUpon.id);
    emit(
      state.copyWith(
        caseWorkedUpon: state.caseWorkedUpon.copyWith(treatment: response.id),
        treatmentModel: response,
      ),
    );
    getTreatmentData(state.caseWorkedUpon.treatment);
  }

  Future<void> updateContactTracingData(
      ContactTracingModel contactTracingModel, int? id) async {
    final response = await caseRepo.saveContactTracingData(
        contactTracingModel: contactTracingModel,
        id: id,
        caseId: state.caseWorkedUpon.id);
    emit(
      state.copyWith(
        caseWorkedUpon: state.caseWorkedUpon.copyWith(
          contactTracing: response.id,
        ),
        contactTracingModel: response,
      ),
    );
    getContactTracingData(response.id);
    getContactTracingListData();
  }

  Future<void> updateOutcomeData(OutcomeModel outcomeModel) async {
    final response = await caseRepo.saveOutcomeData(
        outcomeModel: outcomeModel,
        id: state.caseWorkedUpon.outcomeValue,
        caseId: state.caseWorkedUpon.id);
    emit(
      state.copyWith(
        caseWorkedUpon:
            state.caseWorkedUpon.copyWith(outcomeValue: response.id),
        outcomeModel: response,
      ),
    );
    getOutcomeData(state.caseWorkedUpon.outcomeValue);
  }

  Future<void> updateFaqChecklistData(
      FaqChecklistModel faqChecklistModel) async {
    final response = await caseRepo.saveFaqChecklistData(
        model: faqChecklistModel,
        id: state.caseWorkedUpon.faqChecklist,
        caseId: state.caseWorkedUpon.id);
    emit(
      state.copyWith(
        caseWorkedUpon:
            state.caseWorkedUpon.copyWith(faqChecklist: response.id),
        faqCheckListModel: response,
      ),
    );
    getFaqCheckListData(state.caseWorkedUpon.faqChecklist);
  }

  List<WorkflowItem> workflows(Case workingCase) {
    final workflows = [
      WorkflowItem(
        route: const ReferralDetailsRoute(),
        title: 'Referral Details',
        description: 'Add a new case',
        backendKey: 'patient_details_status',
        status: false,
      ),
      WorkflowItem(
          route: const TBScreeningRoute(),
          title: 'TB Screening',
          description: 'Steps of TB Screening',
          backendKey: 'xray_status',
          status: false),
      WorkflowItem(
        route: const MentalHealthRouterRoute(),
        title: 'Mental Health Screening',
        description: 'WHO Questionairre',
        backendKey: 'udst_status',
        status: false,
      ),
      WorkflowItem(
        route: const DiagnosisRoute(),
        title: 'Diagnosis',
        description: 'Steps of diagnosis',
        backendKey: 'nikshay_status',
        status: false,
      ),
      WorkflowItem(
        route: const FaqChecklistRoute(),
        title: 'Faq Checklist',
        description: 'Faq Checklist',
        backendKey: 'faq_checklist',
        status: false,
      ),
      WorkflowItem(
        route: const TreatmentRoute(),
        title: 'Treatment',
        description: 'Steps of treatment',
        backendKey: 'comorbidity_status',
        status: false,
      ),
      WorkflowItem(
        route: const ContactTracingListRoute(),
        title: 'Contact Tracing',
        description: 'Contact Tracing Status',
        backendKey: 'contract_casing_status',
        status: false,
      ),
      WorkflowItem(
        route: const OutcomeRoute(),
        title: 'Outcome',
        description: 'Steps of Outcome',
        backendKey: 'dbt_status',
        status: false,
      )
    ];

    return workflows;
  }

  // Future<void> closeCase(String value) async {
  //   final response = await caseRepo.closeCase(
  //     caseId: state.caseWorkedUpon.id!,
  //     outcome: value,
  //   );

  //   if (response.status == Status.ok) {
  //     // emit(
  //     //   state.copyWith(
  //     //     caseWorkedUpon: state.caseWorkedUpon.copyWith(
  //     //       outcome: value,
  //     //     ),
  //     //   ),
  //     // );
  //   }
  // }

  // Future<void> updateComorbidity(ComorbidityModel model) async {
  //   final newComorbidity = await caseRepo.saveComorbidity(
  //     caseId: state.caseWorkedUpon.id!,
  //     comorbidityId: state.caseWorkedUpon.comorbidity,
  //     comorbidity: model,
  //   );
  //   emit(
  //     state.copyWith(
  //       caseWorkedUpon: state.caseWorkedUpon.copyWith(comorbidity: newComorbidity.id),
  //       comorbidityFormData: newComorbidity,
  //     ),
  //   );
  // }
  void updateSingleCase(ContactTracingModel updatedContact) {
    final contactList = state.contactTracingList;
    final index =
        contactList.indexWhere((element) => element.id == updatedContact.id);

    if (index == -1) return;
    List<ContactTracingModel> contactCopy = List.from(contactList);
    contactCopy[index] = updatedContact;
    emit(
      state.copyWith(contactTracingList: contactCopy),
    );
  }

  void searchCases(String? query) {
    applyFilters(caseFilter: query);
  }

  void applyFilters({String? caseFilter}) {
    final cases = state.contactTracingList;
    List<ContactTracingModel> filteredContacts = cases;
    if (caseFilter == null) {
      return emit(state.copyWith(filteredContacts: null));
    } else {
      filteredContacts = filteredContacts.where((element) {
        final queryLower = caseFilter.toLowerCase();
        final patientName = element.tbContactName;
        return patientName!.toLowerCase().contains(queryLower);
      }).toList();
      return emit(state.copyWith(filteredContacts: filteredContacts));
    }
  }

  Future<bool> pushLocalData() async {
    return await caseRepo.pushPendingReferralDetails();
  }
}
