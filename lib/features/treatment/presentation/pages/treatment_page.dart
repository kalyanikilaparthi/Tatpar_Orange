import 'package:djangoflow_app/djangoflow_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:tatpar_acf/configurations/configurations.dart';
import 'package:tatpar_acf/features/app/presentation/widgets/chip_radio_buttons.dart';
import 'package:tatpar_acf/features/app/presentation/widgets/date_text_input.dart';
import 'package:tatpar_acf/features/app/presentation/widgets/primary_text_field.dart';
import 'package:tatpar_acf/features/app/presentation/widgets/text_field_with_list.dart';
import 'package:tatpar_acf/features/case/blocs/case_cubit.dart';
import 'package:tatpar_acf/features/case/blocs/source_cubit.dart';
import 'package:tatpar_acf/features/case/data/source_models/diagnosis_data_fields.dart';
import 'package:tatpar_acf/features/case/data/source_models/referral_districts_model.dart';
import 'package:tatpar_acf/features/case/presentation/widgets/bottom_button_bar.dart';
import 'package:tatpar_acf/features/referral/presentation/widgets/case_app_bar.dart';
import 'package:tatpar_acf/features/treatment/model/treatment_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

@RoutePage()
class TreatmentPage extends StatelessWidget {
  const TreatmentPage({super.key});
  FormGroup _treatmentFormBuilder(
      {required TreatmentModel? treatmentModel, required SourceCubit cubit}) {
    final ipfuAfbResult = treatmentModel?.selectedIpfuAFBResult;
    final cpAfbResult = treatmentModel?.selectedCpAFBResult;
    final ipfuNaatResult = treatmentModel?.selectedIpfuNaatResult;
    final cpNaatResult = treatmentModel?.selectedCpNaatResult;

    final panchayat = treatmentModel?.selectedTreatmentSupporterPanchayat;
    String? panchayatName =
        _getPanchayatName(cubit.state.dataModel?.blocks!, panchayat);
    final ipfuAfbResultName = _getAFBResultName(cubit, ipfuAfbResult);
    final cpAfbResultName = _getAFBResultName(cubit, cpAfbResult);
    final ipfuNaatResultName = _getNaatResultName(cubit, ipfuNaatResult);
    final cpNaatResultName = _getNaatResultName(cubit, cpNaatResult);

    return fb.group({
      'case_definition': FormControl<String>(
        value: treatmentModel?.caseDefinition,
      ),
      'tb_site': FormControl<String>(
        value: treatmentModel?.tbSite,
      ),
      'case_history': FormControl<String>(
        value: treatmentModel?.caseHistory,
      ),
      'drug_sensitive': FormControl<String>(
        value: treatmentModel?.drugSensitive,
      ),
      'diagnosis_status': FormControl<String>(
        value: treatmentModel?.diagnosisStatus,
      ),
      'ihv_date': FormControl<DateTime>(
        value: treatmentModel?.ihvDate ?? DateTime.now(),
      ),
      'treatment_regimen': FormControl<String>(
        value: treatmentModel?.treatmentRegimen,
      ),
      'patient_occupation': FormControl<String>(
        value: treatmentModel?.patientOccupation,
      ),
      'treatment_supporter_name': FormControl<String>(
        value: treatmentModel?.treatmentSupporterName,
      ),
      'treatment_supporter_position': FormControl<String>(
        value: treatmentModel?.treatmentSupporterPosition,
      ),
      'treatment_supporter_phone': FormControl<String>(
        value: treatmentModel?.treatmentSupporterPhone,
      ),
      'treatment_supporter_panchayat': FormControl<String>(
        value: panchayatName ?? treatmentModel?.treatmentSupporterPanchayat,
      ),
      'treatment_supporter_ward': FormControl<int>(
        value: treatmentModel?.treatmentSupporterWard,
      ),
      'ip_start_date': FormControl<DateTime>(
        value: treatmentModel?.ipStartDate ?? DateTime.now(),
      ),
      'hiv_done': FormControl<String>(
        value: treatmentModel?.hivDone,
      ),
      'hiv_result': FormControl<String>(
        value: treatmentModel?.hivResult,
      ),
      'hiv_date': FormControl<DateTime>(
        value: treatmentModel?.hivDate ?? DateTime.now(),
      ),
      'hb_done': FormControl<String>(
        value: treatmentModel?.hbDone,
      ),
      'hb_result': FormControl<double>(value: treatmentModel?.hbResult),
      'hb_date': FormControl<DateTime>(
        value: treatmentModel?.hbDate ?? DateTime.now(),
      ),
      'blood_sugar_done': FormControl<String>(
        value: treatmentModel?.bloodSugarDone,
      ),
      'blood_sugar_result':
          FormControl<int>(value: treatmentModel?.bloodSugarResult),
      'blood_sugar_date': FormControl<DateTime>(
        value: treatmentModel?.bloodSugarDate ?? DateTime.now(),
      ),
      'alcohol': FormControl<String>(
        value: treatmentModel?.alcohol,
      ),
      'tobacco_consumption': FormControl<String>(
        value: treatmentModel?.tobaccoConsumption,
      ),
      'nutrition': FormControl<String>(
        value: treatmentModel?.nutritionScreening,
      ),
      'nutrition_eligibility':
          FormControl<String>(value: treatmentModel?.nutritionEligibility),
      'screening_date_nutrition': FormControl<DateTime>(
        value: treatmentModel?.screeningDateNutrition ?? DateTime.now(),
      ),
      'nutrition_linkage': FormControl<String>(
        value: treatmentModel?.nutritionLinkage,
      ),
      'nutrition_linkage_date': FormControl<DateTime>(
        value: treatmentModel?.nutritionLinkageDate ?? DateTime.now(),
      ),
      'height': FormControl<int>(value: treatmentModel?.height),
      'weight': FormControl<int>(value: treatmentModel?.weight),
      'stage': FormControl<String>(value: treatmentModel?.stage),
      'ipfu_date': FormControl<DateTime>(
          value: treatmentModel?.ipfuDate ?? DateTime.now()),
      'ipfu_afb_done': FormControl<String>(value: treatmentModel?.ipfuAfbDone),
      'ipfu_afb_lab_no': FormControl<String>(
        value: treatmentModel?.ipfuAfbLabNo,
      ),
      'ipfu_afb_date': FormControl<DateTime>(
        value: treatmentModel?.ipfuAfbDate ?? DateTime.now(),
      ),
      'ipfu_afb_result': FormControl<String>(
          value: ipfuAfbResultName ?? treatmentModel?.ipfuAfbResult),
      'ipfu_naat_test': FormControl<String>(
        value: treatmentModel?.ipfuNaatTest,
      ),
      'ipfu_naat_result': FormControl<String>(
        value: ipfuNaatResultName ?? treatmentModel?.ipfuNaatResult,
      ),
      'ipfu_lab_no': FormControl<String>(
        value: treatmentModel?.ipfuLabNo,
      ),
      'ipfu_chest_xray': FormControl<String>(
        value: treatmentModel?.ipfuChestXray,
      ),
      'ipfu_nutrition_support': FormControl<String>(
        value: treatmentModel?.ipfuNutritionSupport,
      ),
      'cp_date': FormControl<DateTime>(
          value: treatmentModel?.cpDate ?? DateTime.now()),
      'cp_afb_done': FormControl<String>(value: treatmentModel?.cpAfbDone),
      'cp_afb_lab_no': FormControl<String>(
        value: treatmentModel?.ipfuAfbLabNo,
      ),
      'cp_afb_date': FormControl<DateTime>(
        value: treatmentModel?.cpAfbDate ?? DateTime.now(),
      ),
      'cp_afb_result': FormControl<String>(
          value: cpAfbResultName ?? treatmentModel?.cpAfbResult),
      'cp_naat_test': FormControl<String>(
        value: treatmentModel?.cpNaatTest,
      ),
      'cp_naat_result': FormControl<String>(
        value: cpNaatResultName ?? treatmentModel?.cpNaatResult,
      ),
      'cp_lab_no': FormControl<String>(
        value: treatmentModel?.cpLabNo,
      ),
      'cp_chest_xray': FormControl<String>(
        value: treatmentModel?.cpChestXray,
      ),
      'cp_nutrition_support': FormControl<String>(
        value: treatmentModel?.cpNutritionSupport,
      ),
    });
  }

  String? _getAFBResultName(SourceCubit cubit, int? afb) {
    final afbResultData = cubit.state.diagnosisData?.afbResult?.firstWhere(
        (element) => element.id == afb,
        orElse: () => const AFBResult(name: null));
    return afbResultData?.name;
  }

  String? _getNaatResultName(SourceCubit cubit, int? mtb) {
    final mtbResultData = cubit.state.diagnosisData?.mtbResult?.firstWhere(
        (element) => element.id == mtb,
        orElse: () => const MTBResult(name: null));
    return mtbResultData?.name;
  }

  String? _getPanchayatName(List<Block>? blocks, int? panchayat) {
    String? panchayatName;
    if (blocks != null) {
      for (var block in blocks) {
        var panchayatData = block.panchayat?.firstWhere(
            (p) => p.id == panchayat,
            orElse: () => const Panchayat(id: 0));
        if (panchayatData?.id != 0) {
          panchayatName = panchayatData?.panchayat;
          break;
        }
      }
      return panchayatName;
    } else {
      return null;
    }
  }

  Future<void> _onSave(BuildContext context, FormGroup formGroup) async {
    if (formGroup.valid) {
      final formData = formGroup.value;
      final cubit = context.read<CaseCubit>();
      final sourceCubit = context.read<SourceCubit>();

      for (var block in sourceCubit.state.dataModel!.blocks!) {
        var panchayat = block.panchayat!.firstWhere(
            (p) =>
                p.panchayat ==
                formGroup.control('treatment_supporter_panchayat').value,
            orElse: () => const Panchayat(id: 0));
        if (panchayat.id != 0) {
          context.read<CaseCubit>().selectTreatmentPanchayatCodeId =
              panchayat.id;
          break;
        }
      }
      context.read<CaseCubit>().selectIPFUAFBResult = sourceCubit
          .state.diagnosisData!.afbResult!
          .firstWhere(
              (element) =>
                  element.name == formGroup.control('ipfu_afb_result').value,
              orElse: () => const AFBResult(id: null))
          .id;
      context.read<CaseCubit>().selectCPAFBResult = sourceCubit
          .state.diagnosisData!.afbResult!
          .firstWhere(
              (element) =>
                  element.name == formGroup.control('cp_afb_result').value,
              orElse: () => const AFBResult(id: null))
          .id;
      context.read<CaseCubit>().selectTreatmentIPFUNaatResult = sourceCubit
          .state.diagnosisData!.mtbResult!
          .firstWhere(
              (element) =>
                  element.name == formGroup.control('ipfu_naat_result').value,
              orElse: () => const MTBResult(id: null))
          .id;
      context.read<CaseCubit>().selectTreatmentCPFUNaatResult = sourceCubit
          .state.diagnosisData!.mtbResult!
          .firstWhere(
              (element) =>
                  element.name == formGroup.control('cp_naat_result').value,
              orElse: () => const MTBResult(id: null))
          .id;

      final model = cubit.state.treatmentModel ?? const TreatmentModel();
      final treatmentModel = model.copyWith(
          caseDefinition: formData['case_definition'] as String?,
          tbSite: formData['tb_site'] as String?,
          caseHistory: formData['case_history'] as String?,
          drugSensitive: formData['drug_sensitive'] as String?,
          diagnosisStatus: formData['diagnosis_status'] as String?,
          ihvDate: formData['ihv_date'] as DateTime?,
          treatmentRegimen: formData['treatment_regimen'] as String?,
          patientOccupation: formData['patient_occupation'] as String?,
          treatmentSupporterName:
              formData['treatment_supporter_name'] as String?,
          treatmentSupporterPosition:
              formData['treatment_supporter_position'] as String?,
          treatmentSupporterPhone:
              formData['treatment_supporter_phone'] as String?,
          selectedTreatmentSupporterPanchayat:
              cubit.selectedTreatmentPanchayatCodeId,
          treatmentSupporterWard: formData['treatment_supporter_ward'] as int?,
          height: formData['height'] as int?,
          weight: formData['weight'] as int?,
          stage: formData['stage'] as String?,
          ipStartDate: formData['ip_start_date'] as DateTime?,
          hivDone: formData['hiv_done'] as String?,
          hivResult: formData['hiv_result'] as String?,
          hivDate: formData['hiv_date'] as DateTime?,
          hbDone: formData['hb_done'] as String?,
          hbResult: formData['hb_result'] as double?,
          hbDate: formData['hb_date'] as DateTime?,
          bloodSugarDone: formData['blood_sugar_done'] as String?,
          bloodSugarResult: formData['blood_sugar_result'] as int?,
          bloodSugarDate: formData['blood_sugar_date'] as DateTime?,
          alcohol: formData['alcohol'] as String?,
          tobaccoConsumption: formData['tobacco_consumption'] as String?,
          nutritionScreening: formData['nutrition'] as String?,
          screeningDateNutrition:
              formData['screening_date_nutrition'] as DateTime?,
          nutritionEligibility: formData['nutrition_eligibility'] as String?,
          nutritionLinkage: formData['nutrition_linkage'] as String?,
          nutritionLinkageDate: formData['nutrition_linkage_date'] as DateTime?,
          ipfuDate: formData['ipfu_date'] as DateTime?,
          ipfuAfbDone: formData['ipfu_afb_done'] as String?,
          ipfuAfbDate: formData['ipfu_afb_date'] as DateTime?,
          ipfuAfbLabNo: formData['ipfu_afb_lab_no'] as String?,
          selectedIpfuAFBResult: cubit.selectedIPFUAFBResult,
          ipfuNaatTest: formData['ipfu_naat_test'] as String?,
          selectedIpfuNaatResult: cubit.selectedTreatmentIPFUNaatResult,
          ipfuLabNo: formData['ipfu_lab_no'] as String?,
          ipfuChestXray: formData['ipfu_chest_xray'] as String?,
          ipfuNutritionSupport: formData['ipfu_nutrition_support'] as String?,
          cpDate: formData['cp_date'] as DateTime?,
          cpAfbDone: formData['cp_afb_done'] as String?,
          cpAfbDate: formData['cp_afb_date'] as DateTime?,
          cpAfbLabNo: formData['cp_afb_lab_no'] as String?,
          selectedCpAFBResult: cubit.selectedIPFUAFBResult,
          cpNaatTest: formData['cp_naat_test'] as String?,
          selectedCpNaatResult: cubit.selectedTreatmentCPFUNaatResult,
          cpLabNo: formData['cp_lab_no'] as String?,
          cpChestXray: formData['cp_chest_xray'] as String?,
          cpNutritionSupport: formData['cp_nutrition_support'] as String?,
          isUpdated: false);
      await cubit.updateTreatmentData(treatmentModel);
    } else {
      formGroup.markAllAsTouched();
      // DjangoflowAppSnackbar.showError('Something went wrong.Please try again.');
      final fields = [];
      formGroup.controls.forEach((key, value) {
        if (value.invalid) {
          fields.add(key.replaceFirst('patient_', ''));
        }
      });
      DjangoflowAppSnackbar.showError(
          'please enter the fields: ${fields.join(', ')}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CaseCubit, CaseState>(
        builder: (context, state) => Scaffold(
            appBar: CaseAppBar(
              'Treatment',
              onClick: () {
                // Navigate after the current frame
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  context.router.pushAndPopUntil(
                    const AppHomeRoute(children: [CasesRoute()]),
                    predicate: (Route<dynamic> route) => false,
                  );
                });
                context.read<CaseCubit>().close();
              },
            ),
            body:
                state.isLoading ||
                        state.caseWorkedUpon.treatment != null &&
                            state.treatmentModel == null
                    ? Center(
                        child: Lottie.asset(
                          'assets/lottie/registration_loading.json', // Path to your Lottie animation
                          width: 200,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      )
                    : ReactiveFormBuilder(
                        form: () => _treatmentFormBuilder(
                            treatmentModel: state.treatmentModel,
                            cubit: context.read<SourceCubit>()),
                        builder:
                            (BuildContext context, FormGroup formGroup,
                                    Widget? child) =>
                                AutofillGroup(
                                  child: Column(children: [
                                    const SizedBox(height: kPadding * 2),
                                    Expanded(
                                        child: SingleChildScrollView(
                                            child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal:
                                                            kPadding * 2),
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      ChipRadioButtons(
                                                        label:
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .caseDefinition,
                                                        options: const [
                                                          'MCB',
                                                          'CD'
                                                        ],
                                                        crossAxisCount: 2,
                                                        onChanged: (value) {
                                                          formGroup
                                                              .control(
                                                                  'case_definition')
                                                              .value = value;
                                                        },
                                                        selected: formGroup
                                                            .control(
                                                                'case_definition')
                                                            .value,
                                                      ),
                                                      const SizedBox(
                                                          height: kPadding * 2),
                                                      ChipRadioButtons(
                                                        label:
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .tbSite,
                                                        options: const [
                                                          'PTB',
                                                          'EPTB'
                                                        ],
                                                        crossAxisCount: 2,
                                                        onChanged: (value) {
                                                          formGroup
                                                              .control(
                                                                  'tb_site')
                                                              .value = value;
                                                        },
                                                        selected: formGroup
                                                            .control('tb_site')
                                                            .value,
                                                      ),
                                                      const SizedBox(
                                                          height: kPadding * 2),
                                                      ChipRadioButtons(
                                                        label:
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .caseHistory,
                                                        options: const [
                                                          'New',
                                                          'Recurrent'
                                                        ],
                                                        crossAxisCount: 2,
                                                        onChanged: (value) {
                                                          formGroup
                                                              .control(
                                                                  'case_history')
                                                              .value = value;
                                                        },
                                                        selected: formGroup
                                                            .control(
                                                                'case_history')
                                                            .value,
                                                      ),
                                                      const SizedBox(
                                                          height: kPadding * 2),
                                                      ChipRadioButtons(
                                                        label:
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .drugSensitive,
                                                        options: const [
                                                          'Sensitive',
                                                          'Resistant'
                                                        ],
                                                        crossAxisCount: 2,
                                                        onChanged: (value) {
                                                          formGroup
                                                              .control(
                                                                  'drug_sensitive')
                                                              .value = value;
                                                        },
                                                        selected: formGroup
                                                            .control(
                                                                'drug_sensitive')
                                                            .value,
                                                      ),
                                                      const SizedBox(
                                                          height: kPadding * 2),
                                                      ChipRadioButtons(
                                                        label: AppLocalizations
                                                                .of(context)!
                                                            .diagnosisStatus,
                                                        options: const [
                                                          'PTLFU',
                                                          'On Treatment'
                                                        ],
                                                        crossAxisCount: 2,
                                                        onChanged: (value) {
                                                          formGroup
                                                              .control(
                                                                  'diagnosis_status')
                                                              .value = value;
                                                        },
                                                        selected: formGroup
                                                            .control(
                                                                'diagnosis_status')
                                                            .value,
                                                      ),
                                                      const SizedBox(
                                                          height: kPadding * 2),
                                                      ReactiveValueListenableBuilder<
                                                              String>(
                                                          formControlName:
                                                              'diagnosis_status',
                                                          builder: (context,
                                                                  control,
                                                                  child) =>
                                                              Visibility(
                                                                  visible: (formGroup
                                                                          .control(
                                                                              'diagnosis_status')
                                                                          .value) ==
                                                                      'On Treatment',
                                                                  child: Column(
                                                                      children: [
                                                                        DateTextInput(
                                                                          firstDate:
                                                                              DateTime(2002),
                                                                          controlName:
                                                                              'ihv_date',
                                                                          label:
                                                                              AppLocalizations.of(context)!.ihvDate,
                                                                        ),
                                                                        const SizedBox(
                                                                            height:
                                                                                kPadding * 2),
                                                                        ChipRadioButtons(
                                                                          label:
                                                                              AppLocalizations.of(context)!.treatmentRegimen,
                                                                          options: const [
                                                                            'New',
                                                                            'Previous'
                                                                          ],
                                                                          crossAxisCount:
                                                                              2,
                                                                          onChanged:
                                                                              (value) {
                                                                            formGroup.control('treatment_regimen').value =
                                                                                value;
                                                                          },
                                                                          selected: formGroup
                                                                              .control('treatment_regimen')
                                                                              .value,
                                                                        ),
                                                                        const SizedBox(
                                                                            height:
                                                                                kPadding * 2),
                                                                        PrimaryTextField(
                                                                          formControlName:
                                                                              'patient_occupation',
                                                                          label:
                                                                              AppLocalizations.of(context)!.patientOccupation,
                                                                          prefixIcon:
                                                                              Icons.account_circle_outlined,
                                                                        ),
                                                                        const SizedBox(
                                                                            height:
                                                                                kPadding * 2),
                                                                        PrimaryTextField(
                                                                          formControlName:
                                                                              'treatment_supporter_name',
                                                                          label:
                                                                              AppLocalizations.of(context)!.treatmentSupporterName,
                                                                          prefixIcon:
                                                                              Icons.account_circle_outlined,
                                                                        ),
                                                                        const SizedBox(
                                                                            height:
                                                                                kPadding * 2),
                                                                        TextFieldWithList(
                                                                          controlName:
                                                                              'treatment_supporter_position',
                                                                          label:
                                                                              AppLocalizations.of(context)!.treatmentSupporterPosition,
                                                                          padding:
                                                                              EdgeInsets.zero,
                                                                          prefixIcon:
                                                                              Icons.account_circle_outlined,
                                                                          listData: const [
                                                                            'ASHA',
                                                                            'Family DOTS',
                                                                          ],
                                                                          allowMultiSelection:
                                                                              false,
                                                                          onSelected:
                                                                              (value) {
                                                                            formGroup.control('treatment_supporter_position').value =
                                                                                value[0];
                                                                          },
                                                                          emptyString:
                                                                              '',
                                                                        ),
                                                                        const SizedBox(
                                                                            height:
                                                                                kPadding * 2),
                                                                        PrimaryTextField(
                                                                          formControlName:
                                                                              'treatment_supporter_phone',
                                                                          label:
                                                                              AppLocalizations.of(context)!.treatmentSupporterPhone,
                                                                          keyboardType:
                                                                              TextInputType.number,
                                                                          maxLength:
                                                                              10,
                                                                          prefixIcon:
                                                                              Icons.phone_outlined,
                                                                          inputFormatter: [
                                                                            FilteringTextInputFormatter.digitsOnly,
                                                                            LengthLimitingTextInputFormatter(10)
                                                                          ],
                                                                        ),
                                                                        const SizedBox(
                                                                            height:
                                                                                kPadding * 2),
                                                                        BlocBuilder<SourceCubit,
                                                                                SourceState>(
                                                                            buildWhen: ((previous, current) =>
                                                                                (previous.isLoading != current.isLoading) ||
                                                                                previous.dataModel != current.dataModel),
                                                                            builder: (context, state) {
                                                                              final cubit = context.read<CaseCubit>();
                                                                              var block = (cubit.state.caseWorkedUpon.referralBlock);
                                                                              List<String> panchayats = (state.dataModel!.blocks!.where((element) => element.block == block).expand((e) => e.panchayat!.map((e) => '${e.panchayat}')).toList());

                                                                              if (state.isLoading ?? false) {
                                                                                return const SizedBox(
                                                                                  height: 15,
                                                                                  width: 15,
                                                                                  child: Center(
                                                                                    child: CircularProgressIndicator(),
                                                                                  ),
                                                                                );
                                                                              }
                                                                              return TextFieldWithList(
                                                                                controlName: 'treatment_supporter_panchayat',
                                                                                label: AppLocalizations.of(context)!.treatmentSupporterPanchayat,
                                                                                padding: EdgeInsets.zero,
                                                                                prefixIcon: Icons.account_circle_outlined,
                                                                                listData: panchayats,
                                                                                allowMultiSelection: false,
                                                                                onSelected: (value) {
                                                                                  formGroup.control('treatment_supporter_panchayat').value = value[0];
                                                                                },
                                                                                emptyString: 'No Panchayats available',
                                                                              );
                                                                            }),
                                                                        const SizedBox(
                                                                            height:
                                                                                kPadding * 2),
                                                                        PrimaryTextField<
                                                                            int>(
                                                                          formControlName:
                                                                              'treatment_supporter_ward',
                                                                          label:
                                                                              AppLocalizations.of(context)!.treatmentSupporterWard,
                                                                          prefixIcon:
                                                                              Icons.account_circle_outlined,
                                                                        ),
                                                                        const SizedBox(
                                                                            height:
                                                                                kPadding * 2),
                                                                        PrimaryTextField(
                                                                          formControlName:
                                                                              'height',
                                                                          label:
                                                                              AppLocalizations.of(context)!.height,
                                                                          prefixIcon:
                                                                              Icons.account_circle_outlined,
                                                                          keyboardType:
                                                                              TextInputType.number,
                                                                          inputFormatter: [
                                                                            FilteringTextInputFormatter.digitsOnly,
                                                                            LengthLimitingTextInputFormatter(3)
                                                                          ],
                                                                        ),
                                                                        const SizedBox(
                                                                            height:
                                                                                kPadding * 2),
                                                                        PrimaryTextField(
                                                                          formControlName:
                                                                              'weight',
                                                                          label:
                                                                              AppLocalizations.of(context)!.weight,
                                                                          prefixIcon:
                                                                              Icons.account_circle_outlined,
                                                                          keyboardType:
                                                                              TextInputType.number,
                                                                          inputFormatter: [
                                                                            FilteringTextInputFormatter.digitsOnly,
                                                                            LengthLimitingTextInputFormatter(3)
                                                                          ],
                                                                        ),
                                                                        const SizedBox(
                                                                            height:
                                                                                kPadding * 2),
                                                                        ChipRadioButtons(
                                                                          label:
                                                                              AppLocalizations.of(context)!.stage,
                                                                          options: const [
                                                                            'IP',
                                                                            'IPFU',
                                                                            'CP'
                                                                          ],
                                                                          crossAxisCount:
                                                                              3,
                                                                          onChanged:
                                                                              (value) {
                                                                            formGroup.control('stage').value =
                                                                                value;
                                                                          },
                                                                          selected: formGroup
                                                                              .control('stage')
                                                                              .value,
                                                                        ),
                                                                        const SizedBox(
                                                                            height:
                                                                                kPadding * 2),
                                                                        ReactiveValueListenableBuilder<
                                                                                String>(
                                                                            formControlName:
                                                                                'stage',
                                                                            builder: (context, control, child) => Visibility(
                                                                                visible: (control.value == 'IP'),
                                                                                child: Column(children: [
                                                                                  DateTextInput(
                                                                                    firstDate: DateTime(2002),
                                                                                    controlName: 'ip_start_date',
                                                                                    label: AppLocalizations.of(context)!.ipStartDate,
                                                                                  ),
                                                                                  const SizedBox(height: kPadding * 2),
                                                                                  ChipRadioButtons(
                                                                                    label: AppLocalizations.of(context)!.hivDone,
                                                                                    options: const [
                                                                                      'Yes',
                                                                                      'No'
                                                                                    ],
                                                                                    crossAxisCount: 2,
                                                                                    onChanged: (value) {
                                                                                      formGroup.control('hiv_done').value = value;
                                                                                    },
                                                                                    selected: formGroup.control('hiv_done').value,
                                                                                  ),
                                                                                  const SizedBox(height: kPadding * 2),
                                                                                  ReactiveValueListenableBuilder<String>(
                                                                                    formControlName: 'hiv_done',
                                                                                    builder: (context, control, child) => Visibility(
                                                                                      visible: (control.value == 'Yes'),
                                                                                      child: Column(
                                                                                        children: [
                                                                                          ChipRadioButtons(
                                                                                            label: AppLocalizations.of(context)!.hivResult,
                                                                                            options: const [
                                                                                              'Reactive',
                                                                                              'Non Reactive'
                                                                                            ],
                                                                                            crossAxisCount: 2,
                                                                                            onChanged: (value) {
                                                                                              formGroup.control('hiv_result').value = value;
                                                                                            },
                                                                                            selected: formGroup.control('hiv_result').value,
                                                                                          ),
                                                                                          const SizedBox(height: kPadding * 2),
                                                                                          DateTextInput(
                                                                                            firstDate: DateTime(2002),
                                                                                            controlName: 'hiv_date',
                                                                                            label: AppLocalizations.of(context)!.hivDate,
                                                                                          ),
                                                                                          const SizedBox(height: kPadding * 2),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  ChipRadioButtons(
                                                                                    label: AppLocalizations.of(context)!.hbDone,
                                                                                    options: const [
                                                                                      'Yes',
                                                                                      'No'
                                                                                    ],
                                                                                    crossAxisCount: 2,
                                                                                    onChanged: (value) {
                                                                                      formGroup.control('hb_done').value = value;
                                                                                    },
                                                                                    selected: formGroup.control('hb_done').value,
                                                                                  ),
                                                                                  const SizedBox(height: kPadding * 2),
                                                                                  ReactiveValueListenableBuilder<String>(
                                                                                    formControlName: 'hb_done',
                                                                                    builder: (context, control, child) => Visibility(
                                                                                      visible: (control.value == 'Yes'),
                                                                                      child: Column(
                                                                                        children: [
                                                                                          PrimaryTextField<double>(
                                                                                            formControlName: 'hb_result',
                                                                                            label: AppLocalizations.of(context)!.hbResult,
                                                                                            prefixIcon: Icons.account_circle_outlined,
                                                                                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                                                                            inputFormatter: [
                                                                                              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
                                                                                            ],
                                                                                          ),
                                                                                          const SizedBox(height: kPadding * 2),
                                                                                          DateTextInput(
                                                                                            firstDate: DateTime(2002),
                                                                                            controlName: 'hb_date',
                                                                                            label: AppLocalizations.of(context)!.hbDate,
                                                                                          ),
                                                                                          const SizedBox(height: kPadding * 2),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  ChipRadioButtons(
                                                                                    label: AppLocalizations.of(context)!.bloodSugarDone,
                                                                                    options: const [
                                                                                      'Yes',
                                                                                      'No'
                                                                                    ],
                                                                                    crossAxisCount: 2,
                                                                                    onChanged: (value) {
                                                                                      formGroup.control('blood_sugar_done').value = value;
                                                                                    },
                                                                                    selected: formGroup.control('blood_sugar_done').value,
                                                                                  ),
                                                                                  const SizedBox(height: kPadding * 2),
                                                                                  ReactiveValueListenableBuilder<String>(
                                                                                    formControlName: 'blood_sugar_done',
                                                                                    builder: (context, control, child) => Visibility(
                                                                                      visible: (control.value == 'Yes'),
                                                                                      child: Column(
                                                                                        children: [
                                                                                          PrimaryTextField(
                                                                                            formControlName: 'blood_sugar_result',
                                                                                            label: AppLocalizations.of(context)!.bloodSugarResult,
                                                                                            prefixIcon: Icons.account_circle_outlined,
                                                                                            keyboardType: TextInputType.number,
                                                                                            inputFormatter: [
                                                                                              FilteringTextInputFormatter.digitsOnly,
                                                                                              LengthLimitingTextInputFormatter(3)
                                                                                            ],
                                                                                          ),
                                                                                          const SizedBox(height: kPadding * 2),
                                                                                          DateTextInput(
                                                                                            firstDate: DateTime(2002),
                                                                                            controlName: 'blood_sugar_date',
                                                                                            label: AppLocalizations.of(context)!.bloodSugarDate,
                                                                                          ),
                                                                                          const SizedBox(height: kPadding * 2),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  ChipRadioButtons(
                                                                                    label: AppLocalizations.of(context)!.alcohol,
                                                                                    options: const [
                                                                                      'Yes',
                                                                                      'No'
                                                                                    ],
                                                                                    crossAxisCount: 2,
                                                                                    onChanged: (value) {
                                                                                      formGroup.control('alcohol').value = value;
                                                                                    },
                                                                                    selected: formGroup.control('alcohol').value,
                                                                                  ),
                                                                                  const SizedBox(height: kPadding * 2),
                                                                                  ChipRadioButtons(
                                                                                    label: AppLocalizations.of(context)!.tobaccoConsumption,
                                                                                    options: const [
                                                                                      'Yes',
                                                                                      'No'
                                                                                    ],
                                                                                    crossAxisCount: 2,
                                                                                    onChanged: (value) {
                                                                                      formGroup.control('tobacco_consumption').value = value;
                                                                                    },
                                                                                    selected: formGroup.control('tobacco_consumption').value,
                                                                                  ),
                                                                                  const SizedBox(height: kPadding * 2),
                                                                                  ChipRadioButtons(
                                                                                    label: AppLocalizations.of(context)!.screeningForNutrition,
                                                                                    options: const [
                                                                                      'Yes',
                                                                                      'No'
                                                                                    ],
                                                                                    crossAxisCount: 2,
                                                                                    onChanged: (value) {
                                                                                      formGroup.control('nutrition').value = value;
                                                                                    },
                                                                                    selected: formGroup.control('nutrition').value,
                                                                                  ),
                                                                                  const SizedBox(height: kPadding * 2),
                                                                                  ReactiveValueListenableBuilder<String>(
                                                                                      formControlName: 'nutrition',
                                                                                      builder: (context, control, child) => Visibility(
                                                                                          visible: (control.value == 'Yes'),
                                                                                          child: Column(children: [
                                                                                            DateTextInput(
                                                                                              firstDate: DateTime(2002),
                                                                                              controlName: 'screening_date_nutrition',
                                                                                              label: AppLocalizations.of(context)!.nutritionScreeningDate,
                                                                                            ),
                                                                                            const SizedBox(height: kPadding * 2),
                                                                                            ChipRadioButtons(
                                                                                              label: AppLocalizations.of(context)!.nutritionEligibility,
                                                                                              options: const ['Yes', 'No'],
                                                                                              crossAxisCount: 2,
                                                                                              onChanged: (value) {
                                                                                                formGroup.control('nutrition_eligibility').value = value;
                                                                                              },
                                                                                              selected: formGroup.control('nutrition_eligibility').value,
                                                                                            ),
                                                                                            const SizedBox(height: kPadding * 2),
                                                                                          ]))),
                                                                                  ChipRadioButtons(
                                                                                    label: AppLocalizations.of(context)!.nutritionLinkage,
                                                                                    options: const [
                                                                                      'Yes',
                                                                                      'No'
                                                                                    ],
                                                                                    crossAxisCount: 2,
                                                                                    onChanged: (value) {
                                                                                      formGroup.control('nutrition_linkage').value = value;
                                                                                    },
                                                                                    selected: formGroup.control('nutrition_linkage').value,
                                                                                  ),
                                                                                  const SizedBox(height: kPadding * 2),
                                                                                  ReactiveValueListenableBuilder<String>(
                                                                                      formControlName: 'nutrition_linkage',
                                                                                      builder: (context, control, child) => Visibility(
                                                                                          visible: (control.value == 'Yes'),
                                                                                          child: Column(children: [
                                                                                            DateTextInput(
                                                                                              firstDate: DateTime(2002),
                                                                                              controlName: 'nutrition_linkage_date',
                                                                                              label: AppLocalizations.of(context)!.nutritionLinkageDate,
                                                                                            ),
                                                                                            const SizedBox(height: kPadding * 2),
                                                                                          ]))),
                                                                                ]))),
                                                                        ReactiveValueListenableBuilder<
                                                                                String>(
                                                                            formControlName:
                                                                                'stage',
                                                                            builder: (context, control, child) => Visibility(
                                                                                visible: (control.value == 'IPFU'),
                                                                                child: Column(children: [
                                                                                  DateTextInput(
                                                                                    firstDate: DateTime(2002),
                                                                                    controlName: 'ipfu_date',
                                                                                    label: AppLocalizations.of(context)!.ipfuDate,
                                                                                  ),
                                                                                  const SizedBox(height: kPadding * 2),
                                                                                  ChipRadioButtons(
                                                                                    label: AppLocalizations.of(context)!.ipfuAfbDone,
                                                                                    options: const [
                                                                                      'Yes',
                                                                                      'No'
                                                                                    ],
                                                                                    crossAxisCount: 2,
                                                                                    onChanged: (value) {
                                                                                      formGroup.control('ipfu_afb_done').value = value;
                                                                                    },
                                                                                    selected: formGroup.control('ipfu_afb_done').value,
                                                                                  ),
                                                                                  const SizedBox(height: kPadding * 2),
                                                                                  ReactiveValueListenableBuilder<String>(
                                                                                      formControlName: 'ipfu_afb_done',
                                                                                      builder: (context, control, child) => Visibility(
                                                                                          visible: (formGroup.control('ipfu_afb_done').value) == 'Yes',
                                                                                          child: Column(children: [
                                                                                            DateTextInput(
                                                                                              firstDate: DateTime(2002),
                                                                                              controlName: 'ipfu_afb_date',
                                                                                              label: AppLocalizations.of(context)!.ipfuAfbDate,
                                                                                            ),
                                                                                            const SizedBox(height: kPadding * 2),
                                                                                            PrimaryTextField(
                                                                                              formControlName: 'ipfu_afb_lab_no',
                                                                                              label: AppLocalizations.of(context)!.ipfuAfbLabNo,
                                                                                              prefixIcon: Icons.account_circle_outlined,
                                                                                            ),
                                                                                            const SizedBox(height: kPadding * 2),
                                                                                            BlocBuilder<SourceCubit, SourceState>(
                                                                                                buildWhen: ((previous, current) => (previous.isLoading != current.isLoading) || previous.diagnosisData != current.diagnosisData),
                                                                                                builder: (context, state) {
                                                                                                  List<String> list = (state.diagnosisData != null) ? state.diagnosisData!.afbResult!.map((e) => '${e.name}').toList() : [];
                                                                                                  if (state.isLoading ?? false) {
                                                                                                    return const SizedBox(
                                                                                                      height: 15,
                                                                                                      width: 15,
                                                                                                      child: Center(
                                                                                                        child: CircularProgressIndicator(),
                                                                                                      ),
                                                                                                    );
                                                                                                  }
                                                                                                  return TextFieldWithList(
                                                                                                    controlName: 'ipfu_afb_result',
                                                                                                    label: AppLocalizations.of(context)!.ipfuAFBResult,
                                                                                                    padding: EdgeInsets.zero,
                                                                                                    prefixIcon: Icons.account_circle_outlined,
                                                                                                    listData: list,
                                                                                                    allowMultiSelection: false,
                                                                                                    onSelected: (value) {
                                                                                                      formGroup.control('ipfu_afb_result').value = value[0];
                                                                                                    },
                                                                                                    emptyString: '',
                                                                                                  );
                                                                                                }),
                                                                                            const SizedBox(height: kPadding * 2),
                                                                                          ]))),
                                                                                  ChipRadioButtons(
                                                                                    label: AppLocalizations.of(context)!.ipfuNaatTest,
                                                                                    options: const [
                                                                                      'Yes',
                                                                                      'No'
                                                                                    ],
                                                                                    crossAxisCount: 2,
                                                                                    onChanged: (value) {
                                                                                      formGroup.control('ipfu_naat_test').value = value;
                                                                                    },
                                                                                    selected: formGroup.control('ipfu_naat_test').value,
                                                                                  ),
                                                                                  const SizedBox(height: kPadding * 2),
                                                                                  BlocBuilder<SourceCubit, SourceState>(
                                                                                      buildWhen: ((previous, current) => (previous.isLoading != current.isLoading) || previous.diagnosisData != current.diagnosisData),
                                                                                      builder: (context, state) {
                                                                                        List<String> list = (state.diagnosisData != null) ? state.diagnosisData!.mtbResult!.map((e) => '${e.name}').toList() : [];
                                                                                        if (state.isLoading ?? false) {
                                                                                          return const SizedBox(
                                                                                            height: 15,
                                                                                            width: 15,
                                                                                            child: Center(
                                                                                              child: CircularProgressIndicator(),
                                                                                            ),
                                                                                          );
                                                                                        }
                                                                                        return TextFieldWithList(
                                                                                          controlName: 'ipfu_naat_result',
                                                                                          label: AppLocalizations.of(context)!.ipfuNaatResult,
                                                                                          padding: EdgeInsets.zero,
                                                                                          prefixIcon: Icons.account_circle_outlined,
                                                                                          listData: list,
                                                                                          allowMultiSelection: false,
                                                                                          onSelected: (value) {
                                                                                            formGroup.control('ipfu_naat_result').value = value[0];
                                                                                          },
                                                                                          emptyString: '',
                                                                                        );
                                                                                      }),
                                                                                  const SizedBox(height: kPadding * 2),
                                                                                  PrimaryTextField(
                                                                                    formControlName: 'ipfu_lab_no',
                                                                                    label: AppLocalizations.of(context)!.ipfuLabNo,
                                                                                    prefixIcon: Icons.account_circle_outlined,
                                                                                  ),
                                                                                  const SizedBox(height: kPadding * 2),
                                                                                  ChipRadioButtons(
                                                                                    label: AppLocalizations.of(context)!.ipfuChestXray,
                                                                                    options: const [
                                                                                      'Yes',
                                                                                      'No'
                                                                                    ],
                                                                                    crossAxisCount: 2,
                                                                                    onChanged: (value) {
                                                                                      formGroup.control('ipfu_chest_xray').value = value;
                                                                                    },
                                                                                    selected: formGroup.control('ipfu_chest_xray').value,
                                                                                  ),
                                                                                  const SizedBox(height: kPadding * 2),
                                                                                  ChipRadioButtons(
                                                                                    label: AppLocalizations.of(context)!.ipfuNutritionSupport,
                                                                                    options: const [
                                                                                      'Yes',
                                                                                      'No'
                                                                                    ],
                                                                                    crossAxisCount: 2,
                                                                                    onChanged: (value) {
                                                                                      formGroup.control('ipfu_nutrition_support').value = value;
                                                                                    },
                                                                                    selected: formGroup.control('ipfu_nutrition_support').value,
                                                                                  ),
                                                                                ]))),
                                                                        ReactiveValueListenableBuilder<
                                                                                String>(
                                                                            formControlName:
                                                                                'stage',
                                                                            builder: (context, control, child) => Visibility(
                                                                                visible: (control.value == 'CP'),
                                                                                child: Column(children: [
                                                                                  DateTextInput(
                                                                                    firstDate: DateTime(2002),
                                                                                    controlName: 'cp_date',
                                                                                    label: AppLocalizations.of(context)!.cpDate,
                                                                                  ),
                                                                                  const SizedBox(height: kPadding * 2),
                                                                                  ChipRadioButtons(
                                                                                    label: AppLocalizations.of(context)!.cpAfbDone,
                                                                                    options: const [
                                                                                      'Yes',
                                                                                      'No'
                                                                                    ],
                                                                                    crossAxisCount: 2,
                                                                                    onChanged: (value) {
                                                                                      formGroup.control('cp_afb_done').value = value;
                                                                                    },
                                                                                    selected: formGroup.control('cp_afb_done').value,
                                                                                  ),
                                                                                  const SizedBox(height: kPadding * 2),
                                                                                  ReactiveValueListenableBuilder<String>(
                                                                                      formControlName: 'cp_afb_done',
                                                                                      builder: (context, control, child) => Visibility(
                                                                                          visible: (formGroup.control('cp_afb_done').value) == 'Yes',
                                                                                          child: Column(children: [
                                                                                            DateTextInput(
                                                                                              firstDate: DateTime(2002),
                                                                                              controlName: 'cp_afb_date',
                                                                                              label: AppLocalizations.of(context)!.cpAfbDate,
                                                                                            ),
                                                                                            const SizedBox(height: kPadding * 2),
                                                                                            PrimaryTextField(
                                                                                              formControlName: 'cp_afb_lab_no',
                                                                                              label: AppLocalizations.of(context)!.cpAfbLabNo,
                                                                                              prefixIcon: Icons.account_circle_outlined,
                                                                                            ),
                                                                                            const SizedBox(height: kPadding * 2),
                                                                                            BlocBuilder<SourceCubit, SourceState>(
                                                                                                buildWhen: ((previous, current) => (previous.isLoading != current.isLoading) || previous.diagnosisData != current.diagnosisData),
                                                                                                builder: (context, state) {
                                                                                                  List<String> list = (state.diagnosisData != null) ? state.diagnosisData!.afbResult!.map((e) => '${e.name}').toList() : [];
                                                                                                  if (state.isLoading ?? false) {
                                                                                                    return const SizedBox(
                                                                                                      height: 15,
                                                                                                      width: 15,
                                                                                                      child: Center(
                                                                                                        child: CircularProgressIndicator(),
                                                                                                      ),
                                                                                                    );
                                                                                                  }
                                                                                                  return TextFieldWithList(
                                                                                                    controlName: 'cp_afb_result',
                                                                                                    label: AppLocalizations.of(context)!.cpAFBResult,
                                                                                                    padding: EdgeInsets.zero,
                                                                                                    prefixIcon: Icons.account_circle_outlined,
                                                                                                    listData: list,
                                                                                                    allowMultiSelection: false,
                                                                                                    onSelected: (value) {
                                                                                                      formGroup.control('cp_afb_result').value = value[0];
                                                                                                    },
                                                                                                    emptyString: '',
                                                                                                  );
                                                                                                }),
                                                                                            const SizedBox(height: kPadding * 2),
                                                                                          ]))),
                                                                                  ChipRadioButtons(
                                                                                    label: AppLocalizations.of(context)!.cpNaatTest,
                                                                                    options: const [
                                                                                      'Yes',
                                                                                      'No'
                                                                                    ],
                                                                                    crossAxisCount: 2,
                                                                                    onChanged: (value) {
                                                                                      formGroup.control('cp_naat_test').value = value;
                                                                                    },
                                                                                    selected: formGroup.control('cp_naat_test').value,
                                                                                  ),
                                                                                  const SizedBox(height: kPadding * 2),
                                                                                  BlocBuilder<SourceCubit, SourceState>(
                                                                                      buildWhen: ((previous, current) => (previous.isLoading != current.isLoading) || previous.diagnosisData != current.diagnosisData),
                                                                                      builder: (context, state) {
                                                                                        List<String> list = (state.diagnosisData != null) ? state.diagnosisData!.mtbResult!.map((e) => '${e.name}').toList() : [];
                                                                                        if (state.isLoading ?? false) {
                                                                                          return const SizedBox(
                                                                                            height: 15,
                                                                                            width: 15,
                                                                                            child: Center(
                                                                                              child: CircularProgressIndicator(),
                                                                                            ),
                                                                                          );
                                                                                        }
                                                                                        return TextFieldWithList(
                                                                                          controlName: 'cp_naat_result',
                                                                                          label: AppLocalizations.of(context)!.cpNaatResult,
                                                                                          padding: EdgeInsets.zero,
                                                                                          prefixIcon: Icons.account_circle_outlined,
                                                                                          listData: list,
                                                                                          allowMultiSelection: false,
                                                                                          onSelected: (value) {
                                                                                            formGroup.control('cp_naat_result').value = value[0];
                                                                                          },
                                                                                          emptyString: '',
                                                                                        );
                                                                                      }),
                                                                                  const SizedBox(height: kPadding * 2),
                                                                                  PrimaryTextField(
                                                                                    formControlName: 'cp_lab_no',
                                                                                    label: AppLocalizations.of(context)!.cpLabNo,
                                                                                    prefixIcon: Icons.account_circle_outlined,
                                                                                  ),
                                                                                  const SizedBox(height: kPadding * 2),
                                                                                  ChipRadioButtons(
                                                                                    label: AppLocalizations.of(context)!.cpChestXray,
                                                                                    options: const [
                                                                                      'Yes',
                                                                                      'No'
                                                                                    ],
                                                                                    crossAxisCount: 2,
                                                                                    onChanged: (value) {
                                                                                      formGroup.control('cp_chest_xray').value = value;
                                                                                    },
                                                                                    selected: formGroup.control('cp_chest_xray').value,
                                                                                  ),
                                                                                  const SizedBox(height: kPadding * 2),
                                                                                  ChipRadioButtons(
                                                                                    label: AppLocalizations.of(context)!.cpNutritionSupport,
                                                                                    options: const [
                                                                                      'Yes',
                                                                                      'No'
                                                                                    ],
                                                                                    crossAxisCount: 2,
                                                                                    onChanged: (value) {
                                                                                      formGroup.control('cp_nutrition_support').value = value;
                                                                                    },
                                                                                    selected: formGroup.control('cp_nutrition_support').value,
                                                                                  ),
                                                                                ]))),
                                                                      ]))),
                                                    ])))),
                                    BottomButtonBar(
                                      onSave: (_) async =>
                                          await _onSave(context, formGroup),
                                      nextPage: const ContactTracingListRoute(),
                                    ),
                                    const SizedBox(height: kPadding * 2),
                                  ]),
                                ))));
  }
}
