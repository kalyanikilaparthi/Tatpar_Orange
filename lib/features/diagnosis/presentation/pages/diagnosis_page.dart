import 'package:djangoflow_app/djangoflow_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lottie/lottie.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:tatpar_orange/configurations/configurations.dart';
import 'package:tatpar_orange/features/app/presentation/widgets/date_text_input.dart';
import 'package:tatpar_orange/features/app/presentation/widgets/primary_text_field.dart';
import 'package:tatpar_orange/features/app/presentation/widgets/text_field_with_list.dart';
import 'package:tatpar_orange/features/case/blocs/case_cubit.dart';
import 'package:tatpar_orange/features/case/blocs/source_cubit.dart';
import 'package:tatpar_orange/features/case/data/source_models/diagnosis_data_fields.dart';
import 'package:tatpar_orange/features/case/presentation/widgets/bottom_button_bar.dart';
import 'package:tatpar_orange/features/case/presentation/widgets/secondary_text_field.dart';
import 'package:tatpar_orange/features/diagnosis/model/diagnosis_model.dart';
import 'package:tatpar_orange/features/referral/presentation/widgets/case_app_bar.dart';

import '../../../app/presentation/widgets/chip_radio_buttons.dart';

@RoutePage()
class DiagnosisPage extends StatelessWidget {
  const DiagnosisPage({super.key});
  FormGroup _diagnosisFormBuilder(
      {required DiagnosisModel? diagnosisModel, required SourceCubit cubit}) {
    final afb1Result = diagnosisModel?.selectedAfb1Result;
    final afb2Result = diagnosisModel?.selectedAfb2Result;
    final naatResult = diagnosisModel?.selectedNaatMachine;
    final mtbResult = diagnosisModel?.selectedMtbResult;
    final afb1ResultName = _getAFBResultName(cubit, afb1Result);
    final afb2ResultName = _getAFBResultName(cubit, afb2Result);
    final naatResultData = cubit.state.diagnosisData?.naatMachine?.firstWhere(
        (element) => element.id == naatResult,
        orElse: () => const NaatMachine(name: null));
    final naatResultName = naatResultData?.name;
    final mtbResultData = cubit.state.diagnosisData?.mtbResult?.firstWhere(
        (element) => element.id == mtbResult,
        orElse: () => const MTBResult(name: null));
    final mtbResultName = mtbResultData?.name;

    return fb.group({
      'diagnosis_initiated':
          FormControl<String>(value: diagnosisModel?.diagnosisInitiated),
      'first_consultation':
          FormControl<String>(value: diagnosisModel?.firstConsultation),
      'first_consultation_date':
          FormControl<DateTime>(value: diagnosisModel?.firstConsultationDate),
      'chest_xray': FormControl<String>(value: diagnosisModel?.chestXray),
      'chest_xray_date':
          FormControl<DateTime>(value: diagnosisModel?.chestXrayDate),
      'chest_xray_result':
          FormControl<String>(value: diagnosisModel?.chestXrayResult),
      'afb_done': FormControl<String>(value: diagnosisModel?.afbDone),
      'afb_lab_number':
          FormControl<String>(value: diagnosisModel?.afbLabNumber),
      'afb1_result': FormControl<String>(
          value: afb1ResultName ?? diagnosisModel?.afb1Result),
      'afb1_result_date':
          FormControl<DateTime>(value: diagnosisModel?.afb1ResultDate),
      'afb2_result': FormControl<String>(
          value: afb2ResultName ?? diagnosisModel?.afb2Result),
      'afb2_result_date':
          FormControl<DateTime>(value: diagnosisModel?.afb2ResultDate),
      'naat_test': FormControl<String>(value: diagnosisModel?.naatTest),
      'naat_machine': FormControl<String>(
          value: naatResultName ?? diagnosisModel?.naatMachine),
      'naat_site': FormControl<String>(value: diagnosisModel?.naatSite),
      'naat_lab_number':
          FormControl<String>(value: diagnosisModel?.naatLabNumber),
      'sample_collection_date':
          FormControl<DateTime>(value: diagnosisModel?.sampleCollectionDate),
      'naat_result_date':
          FormControl<DateTime>(value: diagnosisModel?.naatResultDate),
      'mtb_result': FormControl<String>(
          value: mtbResultName ?? diagnosisModel?.mtbResult),
      'rif_resistance':
          FormControl<String>(value: diagnosisModel?.rifResistance),
      'xdr_done': FormControl<String>(value: diagnosisModel?.xdrDone),
      'xdr_result': FormControl<String>(value: diagnosisModel?.xdrResult),
      'xdr_result_date':
          FormControl<DateTime>(value: diagnosisModel?.xdrResultDate),
      'xdr_lab_number':
          FormControl<String>(value: diagnosisModel?.xdrLabNumber),
      'xdr_site': FormControl<String>(value: diagnosisModel?.xdrSite),
      'inh_resistance':
          FormControl<String>(value: diagnosisModel?.inhResistance),
      'flq_resistance':
          FormControl<String>(value: diagnosisModel?.flqResistance),
      'amk_resistance':
          FormControl<String>(value: diagnosisModel?.amkResistance),
      'kan_resistance':
          FormControl<String>(value: diagnosisModel?.kanResistance),
      'cap_resistance':
          FormControl<String>(value: diagnosisModel?.capResistance),
      'eth_resistance':
          FormControl<String>(value: diagnosisModel?.ethResistance),
      'fnac': FormControl<String>(value: diagnosisModel?.fnac),
      'fnac_date': FormControl<DateTime>(value: diagnosisModel?.fnacDate),
      'fnac_result': FormControl<String>(value: diagnosisModel?.fnacResult),
      'fnac_comments': FormControl<String>(value: diagnosisModel?.fnacComments),
      'usg': FormControl<String>(value: diagnosisModel?.usg),
      'usg_date': FormControl<DateTime>(value: diagnosisModel?.usgDate),
      'usg_result': FormControl<String>(value: diagnosisModel?.usgResult),
      'usg_comments': FormControl<String>(value: diagnosisModel?.usgComments),
      'other_test': FormControl<String>(value: diagnosisModel?.otherTest),
      'other_test_date':
          FormControl<DateTime>(value: diagnosisModel?.otherTestDate),
      'test_name': FormControl<String>(value: diagnosisModel?.testName),
      'other_test_result':
          FormControl<String>(value: diagnosisModel?.otherTestResult),
      'diagnosis': FormControl<String>(value: diagnosisModel?.diagnosis),
      'diagnosis_date':
          FormControl<DateTime>(value: diagnosisModel?.diagnosisDate),
      'diagnosis_comments':
          FormControl<String>(value: diagnosisModel?.diagnosisComments),
      'spirometry': FormControl<String>(value: diagnosisModel?.spirometry),
      'fev': FormControl<double>(value: diagnosisModel?.fev),
      'fec': FormControl<double>(value: diagnosisModel?.fec),
      'ratio': FormControl<double>(value: diagnosisModel?.ratio),
    });
  }

  String? _getAFBResultName(SourceCubit cubit, int? afb) {
    final afbResultData = cubit.state.diagnosisData?.afbResult?.firstWhere(
        (element) => element.id == afb,
        orElse: () => const AFBResult(name: null));
    return afbResultData?.name;
  }

  Future<void> _onSave(BuildContext context, FormGroup formGroup) async {
    if (formGroup.valid) {
      final formData = formGroup.value;
      final cubit = context.read<CaseCubit>();
      final sourceCubit = context.read<SourceCubit>();

      context.read<CaseCubit>().selectAFB1Result = sourceCubit
          .state.diagnosisData!.afbResult!
          .firstWhere(
              (element) =>
                  element.name == formGroup.control('afb1_result').value,
              orElse: () => const AFBResult(id: null))
          .id;
      context.read<CaseCubit>().selectAFB2Result = sourceCubit
          .state.diagnosisData!.afbResult!
          .firstWhere(
              (element) =>
                  element.name == formGroup.control('afb2_result').value,
              orElse: () => const AFBResult(id: null))
          .id;
      context.read<CaseCubit>().selectNAATMachine = sourceCubit
          .state.diagnosisData!.naatMachine!
          .firstWhere(
              (element) =>
                  element.name == formGroup.control('naat_machine').value,
              orElse: () => const NaatMachine(id: null))
          .id;

      context.read<CaseCubit>().selectMTBResult = sourceCubit
          .state.diagnosisData!.mtbResult!
          .firstWhere(
              (element) =>
                  element.name == formGroup.control('mtb_result').value,
              orElse: () => const MTBResult(id: null))
          .id;
      context.read<CaseCubit>().selectXDRResult = sourceCubit
          .state.diagnosisData!.mtbResult!
          .firstWhere(
              (element) =>
                  element.name == formGroup.control('xdr_result').value,
              orElse: () => const MTBResult(id: null))
          .id;

      final model = cubit.state.diagnsosisModel ?? const DiagnosisModel();
      final diagnosisModel = model.copyWith(
          diagnosisInitiated: formData['diagnosis_initiated'] as String?,
          firstConsultation: formData['first_consultation'] as String?,
          firstConsultationDate:
              formData['first_consultation_date'] as DateTime?,
          chestXray: formData['chest_xray'] as String?,
          chestXrayDate: formData['chest_xray_date'] as DateTime?,
          chestXrayResult: formData['chest_xray_result'] as String?,
          afbDone: formData['afb_done'] as String?,
          afbLabNumber: formData['afb_lab_number'] as String?,
          selectedAfb1Result: cubit.selectedAFB1Result,
          afb1ResultDate: formData['afb1_result_date'] as DateTime?,
          selectedAfb2Result: cubit.selectedAFB2Result,
          afb2ResultDate: formData['afb2_result_date'] as DateTime?,
          naatTest: formData['naat_test'] as String?,
          selectedNaatMachine: cubit.selectedNAATMachine,
          naatSite: formData['naat_site'] as String?,
          naatLabNumber: formData['naat_lab_number'] as String?,
          sampleCollectionDate: formData['sample_collection_date'] as DateTime?,
          naatResultDate: formData['naat_result_date'] as DateTime?,
          selectedMtbResult: cubit.selectedMTBResult,
          rifResistance: formData['rif_resistance'] as String?,
          xdrDone: formData['xdr_done'] as String?,
          selectedXdrResult: cubit.selectedXDRResult,
          xdrResultDate: formData['xdr_result_date'] as DateTime?,
          xdrLabNumber: formData['xdr_lab_number'] as String?,
          xdrSite: formData['xdr_site'] as String?,
          inhResistance: formData['inh_resistance'] as String?,
          flqResistance: formData['flq_resistance'] as String?,
          amkResistance: formData['amk_resistance'] as String?,
          kanResistance: formData['kan_resistance'] as String?,
          capResistance: formData['cap_resistance'] as String?,
          ethResistance: formData['eth_resistance'] as String?,
          fnac: formData['fnac'] as String?,
          fnacDate: formData['fnac_date'] as DateTime?,
          fnacResult: formData['fnac_result'] as String?,
          fnacComments: formData['fnac_comments'] as String?,
          usg: formData['usg'] as String?,
          usgDate: formData['usg_date'] as DateTime?,
          usgResult: formData['usg_result'] as String?,
          usgComments: formData['usg_comments'] as String?,
          otherTest: formData['other_test'] as String?,
          otherTestDate: formData['other_test_date'] as DateTime?,
          testName: formData['test_name'] as String?,
          otherTestResult: formData['other_test_result'] as String?,
          diagnosis: formData['diagnosis'] as String?,
          diagnosisDate: formData['diagnosis_date'] as DateTime?,
          diagnosisComments: formData['diagnosis_comments'] as String?,
          spirometry: formData['spirometry'] as String?,
          fec: formData['fec'] as double?,
          fev: formData['fev'] as double?,
          ratio: formData['ratio'] as double?,
          isUpdated: cubit.state.diagnsosisModel?.isUpdated ?? false);

      await cubit.updateDiagnosisData(diagnosisModel);
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
              'Diagnosis',
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
            body: (state.isLoading) ||
                    (state.caseWorkedUpon.diagnosis != null &&
                        state.diagnsosisModel == null)
                ? Center(
                    child: Lottie.asset(
                      'assets/lottie/registration_loading.json', // Path to your Lottie animation
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  )
                : ReactiveFormBuilder(
                    form: () => _diagnosisFormBuilder(
                        diagnosisModel: state.diagnsosisModel,
                        cubit: context.read<SourceCubit>()),
                    builder: (BuildContext context, FormGroup formGroup,
                        Widget? child) {
                      formGroup.control('fev').valueChanges.listen((fevValue) {
                        if (formGroup.control('fev').value != null &&
                            formGroup.control('fec').value != null &&
                            formGroup.control('fec').value != 0) {
                          formGroup.control('ratio').value =
                              formGroup.control('fev').value /
                                  formGroup.control('fec').value;
                        } else {
                          formGroup.control('ratio').value = null;
                        }
                      });

                      formGroup.control('fec').valueChanges.listen((fecValue) {
                        if (formGroup.control('fev').value != null &&
                            formGroup.control('fec').value != null &&
                            formGroup.control('fec').value != 0) {
                          formGroup.control('ratio').value =
                              formGroup.control('fev').value /
                                  formGroup.control('fec').value;
                        } else {
                          formGroup.control('ratio').value = null;
                        }
                      });
                      return AutofillGroup(
                          child: Column(children: [
                        const SizedBox(height: kPadding * 2),
                        Expanded(
                            child: SingleChildScrollView(
                                child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: kPadding * 2),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ChipRadioButtons(
                                label: AppLocalizations.of(context)!
                                    .diagnosisInitiated,
                                options: const ['Yes', 'No'],
                                crossAxisCount: 2,
                                onChanged: (value) {
                                  formGroup
                                      .control('diagnosis_initiated')
                                      .value = value;
                                },
                                selected: formGroup
                                    .control('diagnosis_initiated')
                                    .value,
                              ),
                              const SizedBox(height: kPadding * 2),
                              ChipRadioButtons(
                                label: AppLocalizations.of(context)!
                                    .firstConsultation,
                                options: const ['Yes', 'No'],
                                crossAxisCount: 2,
                                onChanged: (value) {
                                  formGroup
                                      .control('first_consultation')
                                      .value = value;
                                },
                                selected: formGroup
                                    .control('first_consultation')
                                    .value,
                              ),
                              const SizedBox(height: kPadding * 2),
                              ReactiveValueListenableBuilder<String>(
                                  formControlName: 'first_consultation',
                                  builder: (context, control, child) =>
                                      Visibility(
                                          visible: (control.value == 'Yes'),
                                          child: Column(children: [
                                            DateTextInput(
                                              firstDate: DateTime(2002),
                                              controlName:
                                                  'first_consultation_date',
                                              label:
                                                  AppLocalizations.of(context)!
                                                      .firstConsultationDate,
                                            ),
                                            // const SizedBox(height: kPadding * 2),
                                          ]))),
                              ReactiveValueListenableBuilder<String>(
                                  formControlName: 'diagnosis_initiated',
                                  builder: (context, control, child) =>
                                      Visibility(
                                          visible: (formGroup
                                                  .control(
                                                      'diagnosis_initiated')
                                                  .value) ==
                                              'Yes',
                                          child: Column(children: [
                                            const SizedBox(
                                                height: kPadding * 2),
                                            ChipRadioButtons(
                                              label:
                                                  AppLocalizations.of(context)!
                                                      .chestXray,
                                              options: const ['Yes', 'No'],
                                              crossAxisCount: 2,
                                              onChanged: (value) {
                                                formGroup
                                                    .control('chest_xray')
                                                    .value = value;
                                              },
                                              selected: formGroup
                                                  .control('chest_xray')
                                                  .value,
                                            ),
                                            ReactiveValueListenableBuilder<
                                                    String>(
                                                formControlName: 'chest_xray',
                                                builder: (context, control,
                                                        child) =>
                                                    Visibility(
                                                        visible: (formGroup
                                                                .control(
                                                                    'chest_xray')
                                                                .value) ==
                                                            'Yes',
                                                        child:
                                                            Column(children: [
                                                          const SizedBox(
                                                              height:
                                                                  kPadding * 2),
                                                          DateTextInput(
                                                            firstDate:
                                                                DateTime(2002),
                                                            controlName:
                                                                'chest_xray_date',
                                                            label: AppLocalizations
                                                                    .of(context)!
                                                                .chestXrayDate,
                                                          ),
                                                          const SizedBox(
                                                              height:
                                                                  kPadding * 2),
                                                          ChipRadioButtons(
                                                            label: AppLocalizations
                                                                    .of(context)!
                                                                .chestXrayResult,
                                                            options: const [
                                                              'Normal',
                                                              'Abnormal'
                                                            ],
                                                            crossAxisCount: 2,
                                                            onChanged: (value) {
                                                              formGroup
                                                                  .control(
                                                                      'chest_xray_result')
                                                                  .value = value;
                                                            },
                                                            selected: formGroup
                                                                .control(
                                                                    'chest_xray_result')
                                                                .value,
                                                          ),
                                                        ]))),
                                            const SizedBox(
                                                height: kPadding * 2),
                                            ChipRadioButtons(
                                              label:
                                                  AppLocalizations.of(context)!
                                                      .afbDone,
                                              options: const ['Yes', 'No'],
                                              crossAxisCount: 2,
                                              onChanged: (value) {
                                                formGroup
                                                    .control('afb_done')
                                                    .value = value;
                                              },
                                              selected: formGroup
                                                  .control('afb_done')
                                                  .value,
                                            ),
                                            const SizedBox(
                                                height: kPadding * 2),
                                            ReactiveValueListenableBuilder<
                                                    String>(
                                                formControlName: 'afb_done',
                                                builder: (context, control,
                                                        child) =>
                                                    Visibility(
                                                        visible: (formGroup
                                                                .control(
                                                                    'afb_done')
                                                                .value) ==
                                                            'Yes',
                                                        child:
                                                            Column(children: [
                                                          PrimaryTextField(
                                                            formControlName:
                                                                'afb_lab_number',
                                                            label: AppLocalizations
                                                                    .of(context)!
                                                                .afbLabNumber,
                                                            prefixIcon: Icons
                                                                .account_circle_outlined,
                                                          ),
                                                          const SizedBox(
                                                              height:
                                                                  kPadding * 2),
                                                          BlocBuilder<
                                                                  SourceCubit,
                                                                  SourceState>(
                                                              buildWhen: ((previous,
                                                                      current) =>
                                                                  (previous
                                                                          .isLoading !=
                                                                      current
                                                                          .isLoading) ||
                                                                  previous.diagnosisData !=
                                                                      current
                                                                          .diagnosisData),
                                                              builder: (context,
                                                                  state) {
                                                                List<
                                                                    String> list = (state
                                                                            .diagnosisData !=
                                                                        null)
                                                                    ? state
                                                                        .diagnosisData!
                                                                        .afbResult!
                                                                        .map((e) =>
                                                                            '${e.name}')
                                                                        .toList()
                                                                    : [];
                                                                if (state
                                                                        .isLoading ??
                                                                    false) {
                                                                  return const SizedBox(
                                                                    height: 15,
                                                                    width: 15,
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          CircularProgressIndicator(),
                                                                    ),
                                                                  );
                                                                }
                                                                return TextFieldWithList(
                                                                  controlName:
                                                                      'afb1_result',
                                                                  label: AppLocalizations.of(
                                                                          context)!
                                                                      .afb1Result,
                                                                  padding:
                                                                      EdgeInsets
                                                                          .zero,
                                                                  prefixIcon: Icons
                                                                      .account_circle_outlined,
                                                                  listData:
                                                                      list,
                                                                  allowMultiSelection:
                                                                      false,
                                                                  onSelected:
                                                                      (value) {
                                                                    formGroup
                                                                        .control(
                                                                            'afb1_result')
                                                                        .value = value[0];
                                                                  },
                                                                  emptyString:
                                                                      '',
                                                                );
                                                              }),
                                                          const SizedBox(
                                                              height:
                                                                  kPadding * 2),
                                                          DateTextInput(
                                                            firstDate:
                                                                DateTime(2002),
                                                            controlName:
                                                                'afb1_result_date',
                                                            label: AppLocalizations
                                                                    .of(context)!
                                                                .afb1ResultDate,
                                                          ),
                                                          const SizedBox(
                                                              height:
                                                                  kPadding * 2),
                                                          BlocBuilder<
                                                                  SourceCubit,
                                                                  SourceState>(
                                                              buildWhen: ((previous,
                                                                      current) =>
                                                                  (previous
                                                                          .isLoading !=
                                                                      current
                                                                          .isLoading) ||
                                                                  previous.diagnosisData !=
                                                                      current
                                                                          .diagnosisData),
                                                              builder: (context,
                                                                  state) {
                                                                List<
                                                                    String> list = (state
                                                                            .diagnosisData !=
                                                                        null)
                                                                    ? state
                                                                        .diagnosisData!
                                                                        .afbResult!
                                                                        .map((e) =>
                                                                            '${e.name}')
                                                                        .toList()
                                                                    : [];
                                                                if (state
                                                                        .isLoading ??
                                                                    false) {
                                                                  return const SizedBox(
                                                                    height: 15,
                                                                    width: 15,
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          CircularProgressIndicator(),
                                                                    ),
                                                                  );
                                                                }
                                                                return TextFieldWithList(
                                                                  controlName:
                                                                      'afb2_result',
                                                                  label: AppLocalizations.of(
                                                                          context)!
                                                                      .afb2Result,
                                                                  padding:
                                                                      EdgeInsets
                                                                          .zero,
                                                                  prefixIcon: Icons
                                                                      .account_circle_outlined,
                                                                  listData:
                                                                      list,
                                                                  allowMultiSelection:
                                                                      false,
                                                                  onSelected:
                                                                      (value) {
                                                                    formGroup
                                                                        .control(
                                                                            'afb2_result')
                                                                        .value = value[0];
                                                                  },
                                                                  emptyString:
                                                                      '',
                                                                );
                                                              }),
                                                          const SizedBox(
                                                              height:
                                                                  kPadding * 2),
                                                          DateTextInput(
                                                            firstDate:
                                                                DateTime(2002),
                                                            controlName:
                                                                'afb2_result_date',
                                                            label: AppLocalizations
                                                                    .of(context)!
                                                                .afb2ResultDate,
                                                          ),
                                                          const SizedBox(
                                                              height:
                                                                  kPadding * 2),
                                                        ]))),
                                            ChipRadioButtons(
                                              label:
                                                  AppLocalizations.of(context)!
                                                      .spirometry,
                                              options: const ['Yes', 'No'],
                                              crossAxisCount: 2,
                                              onChanged: (value) {
                                                formGroup
                                                    .control('spirometry')
                                                    .value = value;
                                              },
                                              selected: formGroup
                                                  .control('spirometry')
                                                  .value,
                                            ),
                                            const SizedBox(
                                                height: kPadding * 2),
                                            ReactiveValueListenableBuilder<
                                                    String?>(
                                                formControlName: 'spirometry',
                                                builder: (context, control,
                                                        child) =>
                                                    Visibility(
                                                        visible:
                                                            (control.value ==
                                                                'Yes'),
                                                        child:
                                                            Column(children: [
                                                          PrimaryTextField(
                                                            formControlName:
                                                                'fec',
                                                            label: AppLocalizations
                                                                    .of(context)!
                                                                .fec,
                                                            prefixIcon: Icons
                                                                .account_circle_outlined,
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            inputFormatter: [
                                                              //Decimal
                                                              FilteringTextInputFormatter
                                                                  .allow(
                                                                RegExp(
                                                                    r'^\d*\.?\d*$'),
                                                              ),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                              height:
                                                                  kPadding * 2),
                                                          PrimaryTextField(
                                                            formControlName:
                                                                'fev',
                                                            label: AppLocalizations
                                                                    .of(context)!
                                                                .fev,
                                                            prefixIcon: Icons
                                                                .account_circle_outlined,
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            inputFormatter: [
                                                              //Decimal
                                                              FilteringTextInputFormatter
                                                                  .allow(
                                                                RegExp(
                                                                    r'^\d*\.?\d*$'),
                                                              ),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                              height:
                                                                  kPadding * 2),
                                                          ReactiveValueListenableBuilder<
                                                              double>(
                                                            formControlName:
                                                                'ratio',
                                                            builder: (context,
                                                                    control,
                                                                    child) =>
                                                                Visibility(
                                                              visible: true,
                                                              child:
                                                                  SecondaryTextField<
                                                                      double?>(
                                                                label: AppLocalizations.of(
                                                                        context)!
                                                                    .ratio,
                                                                text: formGroup
                                                                    .control(
                                                                        'ratio')
                                                                    .value,
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              height:
                                                                  kPadding * 2),
                                                        ]))),
                                            ChipRadioButtons(
                                              label:
                                                  AppLocalizations.of(context)!
                                                      .naatTest,
                                              options: const ['Yes', 'No'],
                                              crossAxisCount: 2,
                                              onChanged: (value) {
                                                formGroup
                                                    .control('naat_test')
                                                    .value = value;
                                              },
                                              selected: formGroup
                                                  .control('naat_test')
                                                  .value,
                                            ),
                                            const SizedBox(
                                                height: kPadding * 2),
                                            ReactiveValueListenableBuilder<
                                                    String>(
                                                formControlName: 'naat_test',
                                                builder: (context, control,
                                                        child) =>
                                                    Visibility(
                                                        visible:
                                                            (control.value ==
                                                                'Yes'),
                                                        child:
                                                            Column(children: [
                                                          BlocBuilder<
                                                                  SourceCubit,
                                                                  SourceState>(
                                                              buildWhen: ((previous,
                                                                      current) =>
                                                                  (previous
                                                                          .isLoading !=
                                                                      current
                                                                          .isLoading) ||
                                                                  previous.diagnosisData !=
                                                                      current
                                                                          .diagnosisData),
                                                              builder: (context,
                                                                  state) {
                                                                List<
                                                                    String> list = (state
                                                                            .diagnosisData !=
                                                                        null)
                                                                    ? state
                                                                        .diagnosisData!
                                                                        .naatMachine!
                                                                        .map((e) =>
                                                                            '${e.name}')
                                                                        .toList()
                                                                    : [];
                                                                if (state
                                                                        .isLoading ??
                                                                    false) {
                                                                  return const SizedBox(
                                                                    height: 15,
                                                                    width: 15,
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          CircularProgressIndicator(),
                                                                    ),
                                                                  );
                                                                }
                                                                return TextFieldWithList(
                                                                  controlName:
                                                                      'naat_machine',
                                                                  label: AppLocalizations.of(
                                                                          context)!
                                                                      .naatMachine,
                                                                  padding:
                                                                      EdgeInsets
                                                                          .zero,
                                                                  prefixIcon: Icons
                                                                      .account_circle_outlined,
                                                                  listData:
                                                                      list,
                                                                  allowMultiSelection:
                                                                      false,
                                                                  onSelected:
                                                                      (value) {
                                                                    formGroup
                                                                        .control(
                                                                            'naat_machine')
                                                                        .value = value[0];
                                                                  },
                                                                  emptyString:
                                                                      '',
                                                                );
                                                              }),
                                                          const SizedBox(
                                                              height:
                                                                  kPadding * 2),
                                                          ChipRadioButtons(
                                                            label: AppLocalizations
                                                                    .of(context)!
                                                                .naatSite,
                                                            options: const [
                                                              'Internal',
                                                              'GOV',
                                                              'Others'
                                                            ],
                                                            crossAxisCount: 2,
                                                            onChanged: (value) {
                                                              formGroup
                                                                  .control(
                                                                      'naat_site')
                                                                  .value = value;
                                                            },
                                                            selected: formGroup
                                                                .control(
                                                                    'naat_site')
                                                                .value,
                                                          ),
                                                          // TextFieldWithList(
                                                          //   controlName:
                                                          //       'naat_site',
                                                          //   label: ' NAAT Site',
                                                          //   padding:
                                                          //       EdgeInsets.zero,
                                                          //   prefixIcon: Icons
                                                          //       .account_circle_outlined,
                                                          //   listData: const [
                                                          //     'Government',
                                                          //     'Internal',
                                                          //   ],
                                                          //   allowMultiSelection:
                                                          //       false,
                                                          //   onSelected: (value) {
                                                          //     formGroup
                                                          //         .control(
                                                          //             'naat_site')
                                                          //         .value = value[0];
                                                          //   },
                                                          //   emptyString: '',
                                                          // ),
                                                          const SizedBox(
                                                              height:
                                                                  kPadding * 2),
                                                          PrimaryTextField(
                                                            formControlName:
                                                                'naat_lab_number',
                                                            label: AppLocalizations
                                                                    .of(context)!
                                                                .naatLabNumber,
                                                            prefixIcon: Icons
                                                                .account_circle_outlined,
                                                          ),
                                                          const SizedBox(
                                                              height:
                                                                  kPadding * 2),
                                                          DateTextInput(
                                                            firstDate:
                                                                DateTime(2002),
                                                            controlName:
                                                                'sample_collection_date',
                                                            label: AppLocalizations
                                                                    .of(context)!
                                                                .sampleCollectionDate,
                                                          ),
                                                          const SizedBox(
                                                              height:
                                                                  kPadding * 2),
                                                          DateTextInput(
                                                            firstDate:
                                                                DateTime(2002),
                                                            controlName:
                                                                'naat_result_date',
                                                            label: AppLocalizations
                                                                    .of(context)!
                                                                .naatResultDate,
                                                          ),
                                                          const SizedBox(
                                                              height:
                                                                  kPadding * 2),
                                                          BlocBuilder<
                                                                  SourceCubit,
                                                                  SourceState>(
                                                              buildWhen: ((previous,
                                                                      current) =>
                                                                  (previous
                                                                          .isLoading !=
                                                                      current
                                                                          .isLoading) ||
                                                                  previous.diagnosisData !=
                                                                      current
                                                                          .diagnosisData),
                                                              builder: (context,
                                                                  state) {
                                                                List<
                                                                    String> list = (state
                                                                            .diagnosisData !=
                                                                        null)
                                                                    ? state
                                                                        .diagnosisData!
                                                                        .mtbResult!
                                                                        .map((e) =>
                                                                            '${e.name}')
                                                                        .toList()
                                                                    : [];
                                                                if (state
                                                                        .isLoading ??
                                                                    false) {
                                                                  return const SizedBox(
                                                                    height: 15,
                                                                    width: 15,
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          CircularProgressIndicator(),
                                                                    ),
                                                                  );
                                                                }
                                                                return TextFieldWithList(
                                                                  controlName:
                                                                      'mtb_result',
                                                                  label: AppLocalizations.of(
                                                                          context)!
                                                                      .mtbResult,
                                                                  padding:
                                                                      EdgeInsets
                                                                          .zero,
                                                                  prefixIcon: Icons
                                                                      .account_circle_outlined,
                                                                  listData:
                                                                      list,
                                                                  allowMultiSelection:
                                                                      false,
                                                                  onSelected:
                                                                      (value) {
                                                                    formGroup
                                                                        .control(
                                                                            'mtb_result')
                                                                        .value = value[0];
                                                                  },
                                                                  emptyString:
                                                                      '',
                                                                );
                                                              }),
                                                          const SizedBox(
                                                              height:
                                                                  kPadding * 2),
                                                          TextFieldWithList(
                                                            controlName:
                                                                'rif_resistance',
                                                            label: AppLocalizations
                                                                    .of(context)!
                                                                .rifResistance,
                                                            padding:
                                                                EdgeInsets.zero,
                                                            prefixIcon: Icons
                                                                .account_circle_outlined,
                                                            listData: const [
                                                              'Detected',
                                                              'Indeterminate',
                                                              'Not Detected'
                                                            ],
                                                            allowMultiSelection:
                                                                false,
                                                            onSelected:
                                                                (value) {
                                                              formGroup
                                                                  .control(
                                                                      'rif_resistance')
                                                                  .value = value[0];
                                                            },
                                                            emptyString: '',
                                                          ),
                                                          const SizedBox(
                                                              height:
                                                                  kPadding * 2),
                                                          // ChipRadioButtons(
                                                          //   label:
                                                          //       'Drug Resistance',
                                                          //   options: const [
                                                          //     'Sensitive',
                                                          //     'Resistant'
                                                          //   ],
                                                          //   crossAxisCount: 2,
                                                          //   onChanged: (value) {
                                                          //     formGroup
                                                          //         .control(
                                                          //             'drug_resistance')
                                                          //         .value = value;
                                                          //   },
                                                          //   selected: formGroup
                                                          //       .control(
                                                          //           'drug_resistance')
                                                          //       .value,
                                                          // ),
                                                          // const SizedBox(
                                                          //     height:
                                                          //         kPadding * 2),
                                                          ChipRadioButtons(
                                                            label: AppLocalizations
                                                                    .of(context)!
                                                                .xdrDone,
                                                            options: const [
                                                              'Yes',
                                                              'No'
                                                            ],
                                                            crossAxisCount: 2,
                                                            onChanged: (value) {
                                                              formGroup
                                                                  .control(
                                                                      'xdr_done')
                                                                  .value = value;
                                                            },
                                                            selected: formGroup
                                                                .control(
                                                                    'xdr_done')
                                                                .value,
                                                          ),
                                                          const SizedBox(
                                                              height:
                                                                  kPadding * 2),
                                                        ]))),
                                            ReactiveValueListenableBuilder<
                                                    String>(
                                                formControlName: 'xdr_done',
                                                builder: (context, control,
                                                        child) =>
                                                    Visibility(
                                                        visible:
                                                            (control.value ==
                                                                'Yes'),
                                                        child:
                                                            Column(children: [
                                                          DateTextInput(
                                                            firstDate:
                                                                DateTime(2002),
                                                            controlName:
                                                                'xdr_result_date',
                                                            label: AppLocalizations
                                                                    .of(context)!
                                                                .xdrResultDate,
                                                          ),
                                                          const SizedBox(
                                                              height:
                                                                  kPadding * 2),
                                                          PrimaryTextField(
                                                            formControlName:
                                                                'xdr_lab_number',
                                                            label: AppLocalizations
                                                                    .of(context)!
                                                                .xdrLabNumber,
                                                            prefixIcon: Icons
                                                                .account_circle_outlined,
                                                          ),
                                                          const SizedBox(
                                                              height:
                                                                  kPadding * 2),
                                                          ChipRadioButtons(
                                                            label: AppLocalizations
                                                                    .of(context)!
                                                                .xdrSite,
                                                            options: const [
                                                              'Internal',
                                                              'GOV'
                                                            ],
                                                            crossAxisCount: 2,
                                                            onChanged: (value) {
                                                              formGroup
                                                                  .control(
                                                                      'xdr_site')
                                                                  .value = value;
                                                            },
                                                            selected: formGroup
                                                                .control(
                                                                    'xdr_site')
                                                                .value,
                                                          ),
                                                          const SizedBox(
                                                              height:
                                                                  kPadding * 2),
                                                          BlocBuilder<
                                                                  SourceCubit,
                                                                  SourceState>(
                                                              buildWhen: ((previous,
                                                                      current) =>
                                                                  (previous
                                                                          .isLoading !=
                                                                      current
                                                                          .isLoading) ||
                                                                  previous.diagnosisData !=
                                                                      current
                                                                          .diagnosisData),
                                                              builder: (context,
                                                                  state) {
                                                                List<
                                                                    String> list = (state
                                                                            .diagnosisData !=
                                                                        null)
                                                                    ? state
                                                                        .diagnosisData!
                                                                        .mtbResult!
                                                                        .map((e) =>
                                                                            '${e.name}')
                                                                        .toList()
                                                                    : [];
                                                                if (state
                                                                        .isLoading ??
                                                                    false) {
                                                                  return const SizedBox(
                                                                    height: 15,
                                                                    width: 15,
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          CircularProgressIndicator(),
                                                                    ),
                                                                  );
                                                                }
                                                                return TextFieldWithList(
                                                                  controlName:
                                                                      'xdr_result',
                                                                  label: AppLocalizations.of(
                                                                          context)!
                                                                      .xdrResult,
                                                                  padding:
                                                                      EdgeInsets
                                                                          .zero,
                                                                  prefixIcon: Icons
                                                                      .account_circle_outlined,
                                                                  listData:
                                                                      list,
                                                                  allowMultiSelection:
                                                                      false,
                                                                  onSelected:
                                                                      (value) {
                                                                    formGroup
                                                                        .control(
                                                                            'xdr_result')
                                                                        .value = value[0];
                                                                  },
                                                                  emptyString:
                                                                      '',
                                                                );
                                                              }),
                                                          const SizedBox(
                                                              height:
                                                                  kPadding * 2),
                                                          ChipRadioButtons(
                                                            label: AppLocalizations
                                                                    .of(context)!
                                                                .inhResistance,
                                                            options: const [
                                                              'Sensitive',
                                                              'Resistant'
                                                            ],
                                                            crossAxisCount: 2,
                                                            onChanged: (value) {
                                                              formGroup
                                                                  .control(
                                                                      'inh_resistance')
                                                                  .value = value;
                                                            },
                                                            selected: formGroup
                                                                .control(
                                                                    'inh_resistance')
                                                                .value,
                                                          ),
                                                          const SizedBox(
                                                              height:
                                                                  kPadding * 2),
                                                          ChipRadioButtons(
                                                            label: AppLocalizations
                                                                    .of(context)!
                                                                .flqResistance,
                                                            options: const [
                                                              'Sensitive',
                                                              'Resistant'
                                                            ],
                                                            crossAxisCount: 2,
                                                            onChanged: (value) {
                                                              formGroup
                                                                  .control(
                                                                      'flq_resistance')
                                                                  .value = value;
                                                            },
                                                            selected: formGroup
                                                                .control(
                                                                    'flq_resistance')
                                                                .value,
                                                          ),
                                                          const SizedBox(
                                                              height:
                                                                  kPadding * 2),
                                                          ChipRadioButtons(
                                                            label: AppLocalizations
                                                                    .of(context)!
                                                                .amkResistance,
                                                            options: const [
                                                              'Sensitive',
                                                              'Resistant'
                                                            ],
                                                            crossAxisCount: 2,
                                                            onChanged: (value) {
                                                              formGroup
                                                                  .control(
                                                                      'amk_resistance')
                                                                  .value = value;
                                                            },
                                                            selected: formGroup
                                                                .control(
                                                                    'amk_resistance')
                                                                .value,
                                                          ),
                                                          const SizedBox(
                                                              height:
                                                                  kPadding * 2),
                                                          ChipRadioButtons(
                                                            label: AppLocalizations
                                                                    .of(context)!
                                                                .kanResistance,
                                                            options: const [
                                                              'Sensitive',
                                                              'Resistant'
                                                            ],
                                                            crossAxisCount: 2,
                                                            onChanged: (value) {
                                                              formGroup
                                                                  .control(
                                                                      'kan_resistance')
                                                                  .value = value;
                                                            },
                                                            selected: formGroup
                                                                .control(
                                                                    'kan_resistance')
                                                                .value,
                                                          ),
                                                          const SizedBox(
                                                              height:
                                                                  kPadding * 2),
                                                          ChipRadioButtons(
                                                            label: AppLocalizations
                                                                    .of(context)!
                                                                .capResistance,
                                                            options: const [
                                                              'Sensitive',
                                                              'Resistant'
                                                            ],
                                                            crossAxisCount: 2,
                                                            onChanged: (value) {
                                                              formGroup
                                                                  .control(
                                                                      'cap_resistance')
                                                                  .value = value;
                                                            },
                                                            selected: formGroup
                                                                .control(
                                                                    'cap_resistance')
                                                                .value,
                                                          ),
                                                          const SizedBox(
                                                              height:
                                                                  kPadding * 2),
                                                          ChipRadioButtons(
                                                            label: AppLocalizations
                                                                    .of(context)!
                                                                .ethResistance,
                                                            options: const [
                                                              'Sensitive',
                                                              'Resistant'
                                                            ],
                                                            crossAxisCount: 2,
                                                            onChanged: (value) {
                                                              formGroup
                                                                  .control(
                                                                      'eth_resistance')
                                                                  .value = value;
                                                            },
                                                            selected: formGroup
                                                                .control(
                                                                    'eth_resistance')
                                                                .value,
                                                          ),
                                                          const SizedBox(
                                                              height:
                                                                  kPadding * 2),
                                                        ]))),
                                            ChipRadioButtons(
                                              label:
                                                  AppLocalizations.of(context)!
                                                      .fnac,
                                              options: const ['Yes', 'No'],
                                              crossAxisCount: 2,
                                              onChanged: (value) {
                                                formGroup
                                                    .control('fnac')
                                                    .value = value;
                                              },
                                              selected: formGroup
                                                  .control('fnac')
                                                  .value,
                                            ),
                                            const SizedBox(
                                                height: kPadding * 2),
                                            ReactiveValueListenableBuilder<
                                                String>(
                                              formControlName: 'fnac',
                                              builder:
                                                  (context, control, child) =>
                                                      Visibility(
                                                visible:
                                                    (control.value == 'Yes'),
                                                child: Column(
                                                  children: [
                                                    DateTextInput(
                                                      firstDate: DateTime(2002),
                                                      controlName: 'fnac_date',
                                                      label:
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .fnacDate,
                                                    ),
                                                    const SizedBox(
                                                        height: kPadding * 2),
                                                    ChipRadioButtons(
                                                      label:
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .fnacResult,
                                                      options: const [
                                                        'Normal',
                                                        'Abnormal'
                                                      ],
                                                      crossAxisCount: 2,
                                                      onChanged: (value) {
                                                        formGroup
                                                            .control(
                                                                'fnac_result')
                                                            .value = value;
                                                      },
                                                      selected: formGroup
                                                          .control(
                                                              'fnac_result')
                                                          .value,
                                                    ),
                                                    const SizedBox(
                                                        height: kPadding * 2),
                                                    PrimaryTextField(
                                                      formControlName:
                                                          'fnac_comments',
                                                      label:
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .fnacComments,
                                                      prefixIcon: Icons
                                                          .account_circle_outlined,
                                                    ),
                                                    const SizedBox(
                                                        height: kPadding * 2),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            ChipRadioButtons(
                                              label:
                                                  AppLocalizations.of(context)!
                                                      .usg,
                                              options: const ['Yes', 'No'],
                                              crossAxisCount: 2,
                                              onChanged: (value) {
                                                formGroup.control('usg').value =
                                                    value;
                                              },
                                              selected: formGroup
                                                  .control('usg')
                                                  .value,
                                            ),
                                            const SizedBox(
                                                height: kPadding * 2),
                                            ReactiveValueListenableBuilder<
                                                String>(
                                              formControlName: 'usg',
                                              builder:
                                                  (context, control, child) =>
                                                      Visibility(
                                                visible:
                                                    (control.value == 'Yes'),
                                                child: Column(
                                                  children: [
                                                    DateTextInput(
                                                      firstDate: DateTime(2002),
                                                      controlName: 'usg_date',
                                                      label:
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .usgDate,
                                                    ),
                                                    const SizedBox(
                                                        height: kPadding * 2),
                                                    ChipRadioButtons(
                                                      label:
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .usgResult,
                                                      options: const [
                                                        'Normal',
                                                        'Abnormal'
                                                      ],
                                                      crossAxisCount: 2,
                                                      onChanged: (value) {
                                                        formGroup
                                                            .control(
                                                                'usg_result')
                                                            .value = value;
                                                      },
                                                      selected: formGroup
                                                          .control('usg_result')
                                                          .value,
                                                    ),
                                                    const SizedBox(
                                                        height: kPadding * 2),
                                                    PrimaryTextField(
                                                      formControlName:
                                                          'usg_comments',
                                                      label:
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .usgComments,
                                                      prefixIcon: Icons
                                                          .account_circle_outlined,
                                                    ),
                                                    const SizedBox(
                                                        height: kPadding * 2),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            ChipRadioButtons(
                                              label:
                                                  AppLocalizations.of(context)!
                                                      .otherTest,
                                              options: const ['Yes', 'No'],
                                              crossAxisCount: 2,
                                              onChanged: (value) {
                                                formGroup
                                                    .control('other_test')
                                                    .value = value;
                                              },
                                              selected: formGroup
                                                  .control('other_test')
                                                  .value,
                                            ),
                                            const SizedBox(
                                                height: kPadding * 2),
                                            ReactiveValueListenableBuilder<
                                                    String>(
                                                formControlName: 'other_test',
                                                builder: (context, control,
                                                        child) =>
                                                    Visibility(
                                                        visible:
                                                            (control.value ==
                                                                'Yes'),
                                                        child:
                                                            Column(children: [
                                                          DateTextInput(
                                                            firstDate:
                                                                DateTime(2002),
                                                            controlName:
                                                                'other_test_date',
                                                            label: AppLocalizations
                                                                    .of(context)!
                                                                .otherTestDate,
                                                          ),
                                                          const SizedBox(
                                                              height:
                                                                  kPadding * 2),
                                                          PrimaryTextField(
                                                            formControlName:
                                                                'test_name',
                                                            label: AppLocalizations
                                                                    .of(context)!
                                                                .testName,
                                                            prefixIcon: Icons
                                                                .account_circle_outlined,
                                                          ),
                                                          const SizedBox(
                                                              height:
                                                                  kPadding * 2),
                                                          ChipRadioButtons(
                                                            label: AppLocalizations
                                                                    .of(context)!
                                                                .otherTestResult,
                                                            options: const [
                                                              'Normal',
                                                              'Abnormal'
                                                            ],
                                                            crossAxisCount: 2,
                                                            onChanged: (value) {
                                                              formGroup
                                                                  .control(
                                                                      'other_test_result')
                                                                  .value = value;
                                                            },
                                                            selected: formGroup
                                                                .control(
                                                                    'other_test_result')
                                                                .value,
                                                          ),
                                                          const SizedBox(
                                                              height:
                                                                  kPadding * 2),
                                                        ]))),
                                            TextFieldWithList(
                                              controlName: 'diagnosis',
                                              label:
                                                  AppLocalizations.of(context)!
                                                      .diagnosis,
                                              padding: EdgeInsets.zero,
                                              prefixIcon:
                                                  Icons.account_circle_outlined,
                                              listData: const [
                                                'TB',
                                                'Bronchial Asthma',
                                                'Other CRD',
                                                'Case Closed'
                                              ],
                                              allowMultiSelection: false,
                                              onSelected: (value) {
                                                formGroup
                                                    .control('diagnosis')
                                                    .value = value[0];
                                              },
                                              emptyString: '',
                                            ),
                                            const SizedBox(
                                                height: kPadding * 2),
                                            DateTextInput(
                                              firstDate: DateTime(2002),
                                              controlName: 'diagnosis_date',
                                              label:
                                                  AppLocalizations.of(context)!
                                                      .diagnosisDate,
                                            ),
                                            const SizedBox(
                                                height: kPadding * 2),
                                            PrimaryTextField(
                                              formControlName:
                                                  'diagnosis_comments',
                                              label:
                                                  AppLocalizations.of(context)!
                                                      .diagnosisComments,
                                              prefixIcon:
                                                  Icons.account_circle_outlined,
                                            ),
                                            const SizedBox(
                                                height: kPadding * 2),
                                          ]))),
                            ],
                          ),
                        ))),
                        BottomButtonBar(
                          onSave: (_) async =>
                              await _onSave(context, formGroup),
                          nextPage: formGroup.control('diagnosis').value ==
                                  'Case Closed TB'
                              ? const AppHomeRoute()
                              : const FaqChecklistRoute(),
                        ),
                        const SizedBox(height: kPadding * 2),
                      ]));
                    })));
  }
}
