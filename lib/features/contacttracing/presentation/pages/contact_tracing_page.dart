import 'package:djangoflow_app/djangoflow_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:tatpar_orange/configurations/configurations.dart';
import 'package:tatpar_orange/features/app/presentation/widgets/chip_radio_buttons.dart';
import 'package:tatpar_orange/features/app/presentation/widgets/date_text_input.dart';
import 'package:tatpar_orange/features/app/presentation/widgets/primary_text_field.dart';
import 'package:tatpar_orange/features/app/presentation/widgets/text_field_with_list.dart';
import 'package:tatpar_orange/features/case/blocs/case_cubit.dart';
import 'package:tatpar_orange/features/case/blocs/source_cubit.dart';
import 'package:tatpar_orange/features/case/data/source_models/diagnosis_data_fields.dart';
import 'package:tatpar_orange/features/contacttracing/data/contact_tracing_cubit.dart';
import 'package:tatpar_orange/features/contacttracing/models/contact_tracing_model.dart';
import 'package:tatpar_orange/features/referral/presentation/widgets/bottom_button_bar.dart';
import 'package:tatpar_orange/features/referral/presentation/widgets/case_app_bar.dart';

@RoutePage()
class ContactTracingPage extends StatelessWidget {
  const ContactTracingPage({super.key});
  FormGroup _contactTracingFormBuilder(
      {required ContactTracingModel? contactTracingModel,
      required SourceCubit cubit}) {
    final tptRegimen = contactTracingModel?.selectedTptRegimen;
    final tptRegimenData = cubit.state.diagnosisData?.tptRegimen?.firstWhere(
      (element) => element.id == tptRegimen,
      orElse: () => const TPTRegimen(name: null),
    );
    final String? tptRegimenName = tptRegimenData?.name;
    return fb.group({
      'contact_tracing_referral_id': FormControl<String?>(
        value: contactTracingModel?.contactTracingReferralId,
      ),
      'tb_contact_name': FormControl<String?>(
        value: contactTracingModel?.tbContactName,
      ),
      'age': FormControl<int>(value: contactTracingModel?.age),
      'screening_outcome': FormControl<String>(
        value: contactTracingModel?.screeningOutcome,
      ),
      'test_conducted': FormControl<String?>(
        value: contactTracingModel?.testConducted,
      ),
      'cxr_date': FormControl<DateTime>(value: contactTracingModel?.cxrDate),
      'cxr_result': FormControl<String>(value: contactTracingModel?.cxrResult),
      'tbi_date': FormControl<DateTime>(value: contactTracingModel?.tbiDate),
      'tbi_result': FormControl<String>(value: contactTracingModel?.tbiResult),
      'nikshay_id': FormControl<String>(value: contactTracingModel?.nikshayID),
      'tpt_eligible':
          FormControl<String?>(value: contactTracingModel?.tptEligible),
      'tpt_regimen': FormControl<String?>(
          value: tptRegimenName ?? contactTracingModel?.tptRegimen),
      'tpt_start_date':
          FormControl<DateTime>(value: contactTracingModel?.tptStartDate),
      'weight': FormControl<int>(value: contactTracingModel?.weight),
      'tpt_side_effects':
          FormControl<String?>(value: contactTracingModel?.tptSideEffects),
      'tpt_outcome_date':
          FormControl<DateTime>(value: contactTracingModel?.tptOutcomeDate),
      'tpt_outcome':
          FormControl<String>(value: contactTracingModel?.tptOutcome),
    });
  }

  Future<void> _onSave(BuildContext context, FormGroup formGroup) async {
    if (formGroup.valid) {
      final formData = formGroup.value;
      final cubit = context.read<CaseCubit>();
      final contactTracingCubit = context.read<ContactTracingCubit>();
      final sourceCubit = context.read<SourceCubit>();
      context.read<CaseCubit>().selectTPTRegimen = sourceCubit
          .state.diagnosisData?.tptRegimen!
          .firstWhere(
              (element) =>
                  element.name == formGroup.control('tpt_regimen').value,
              orElse: () => const TPTRegimen(id: null))
          .id;
      final model =
          cubit.state.contactTracingModel ?? const ContactTracingModel();
      final contactTracingModel = model.copyWith(
          contactTracingReferralId:
              formData['contact_tracing_referral_id'] as String?,
          tbContactName: formData['tb_contact_name'] as String?,
          age: formData['age'] as int?,
          screeningOutcome: formData['screening_outcome'] as String?,
          testConducted: formData['test_conducted'] as String?,
          cxrDate: formData['cxr_date'] as DateTime?,
          cxrResult: formData['cxr_result'] as String?,
          tbiDate: formData['tbi_date'] as DateTime?,
          tbiResult: formData['tbi_result'] as String?,
          nikshayID: formData['nikshay_id'] as String?,
          tptEligible: formData['tpt_eligible'] as String?,
          selectedTptRegimen: cubit.selectedTPTRegimen,
          tptStartDate: formData['tpt_start_date'] as DateTime?,
          weight: formData['weight'] as int?,
          tptSideEffects: formData['tpt_side_effects'] as String?,
          tptOutcomeDate: formData['tpt_outcome_date'] as DateTime?,
          tptOutcome: formData['tpt_outcome'] as String?,
          isUpdated: cubit.state.contactTracingModel?.isUpdated ?? false);

      await cubit.updateContactTracingData(contactTracingModel,
          contactTracingCubit.state.contactTracingModel.id);
      contactTracingCubit.updateContact(cubit.state.contactTracingModel);
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
    return BlocBuilder<ContactTracingCubit, ContactTracingState>(
        builder: (context, state) {
      return Scaffold(
          appBar: CaseAppBar(
            'Contact Tracing',
            onClick: () {
              context.router.pushAndPopUntil(const ContactTracingListRoute(),
                  predicate: (Route<dynamic> route) => false);
            },
          ),
          body: ReactiveFormBuilder(
              form: () => _contactTracingFormBuilder(
                    contactTracingModel: state.contactTracingModel,
                    cubit: context.read<SourceCubit>(),
                  ),
              builder: (BuildContext context, FormGroup formGroup,
                      Widget? child) =>
                  AutofillGroup(
                      child: Column(children: [
                    const SizedBox(height: kPadding * 2),
                    Expanded(
                        child: SingleChildScrollView(
                            child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: kPadding * 2),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const PrimaryTextField(
                                        formControlName:
                                            'contact_tracing_referral_id',
                                        label: 'Contact Tracing Referral ID',
                                        prefixIcon:
                                            Icons.account_circle_outlined,
                                      ),
                                      const SizedBox(height: kPadding * 2),
                                      PrimaryTextField(
                                        formControlName: 'tb_contact_name',
                                        label: AppLocalizations.of(context)!
                                            .tbContactName,
                                        prefixIcon:
                                            Icons.account_circle_outlined,
                                      ),
                                      const SizedBox(height: kPadding * 2),
                                      PrimaryTextField<int>(
                                        formControlName: 'age',
                                        label:
                                            AppLocalizations.of(context)!.age,
                                        prefixIcon:
                                            Icons.account_circle_outlined,
                                        keyboardType: TextInputType.number,
                                        inputFormatter: [
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                          LengthLimitingTextInputFormatter(2)
                                        ],
                                      ),
                                      const SizedBox(height: kPadding * 2),
                                      TextFieldWithList(
                                        controlName: 'screening_outcome',
                                        label: AppLocalizations.of(context)!
                                            .screeningOutcome,
                                        padding: EdgeInsets.zero,
                                        prefixIcon:
                                            Icons.account_circle_outlined,
                                        listData: const [
                                          'No Symptom',
                                          'Presumptive DSTB',
                                          'Presumptive DRTB',
                                          'Presumptive EPTB'
                                        ],
                                        allowMultiSelection: false,
                                        onSelected: (value) {
                                          formGroup
                                              .control('screening_outcome')
                                              .value = value[0];
                                        },
                                        emptyString: '',
                                      ),
                                      const SizedBox(height: kPadding * 2),
                                      PrimaryTextField(
                                        formControlName: 'nikshay_id',
                                        label: AppLocalizations.of(context)!
                                            .nikshay_id,
                                        prefixIcon:
                                            Icons.account_circle_outlined,
                                      ),
                                      const SizedBox(height: kPadding * 2),
                                      ChipRadioButtons(
                                        label: AppLocalizations.of(context)!
                                            .testConducted,
                                        options: const ['Yes', 'No'],
                                        crossAxisCount: 2,
                                        onChanged: (value) {
                                          formGroup
                                              .control('test_conducted')
                                              .value = value;
                                        },
                                        selected: formGroup
                                            .control('test_conducted')
                                            .value,
                                      ),
                                      const SizedBox(height: kPadding * 2),
                                      ReactiveValueListenableBuilder<String?>(
                                          formControlName: 'test_conducted',
                                          builder: (context, control, child) =>
                                              Visibility(
                                                  visible:
                                                      (control.value == 'Yes'),
                                                  child: Column(children: [
                                                    DateTextInput(
                                                      firstDate: DateTime(2002),
                                                      controlName: 'cxr_date',
                                                      label:
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .cxr_date,
                                                    ),
                                                    const SizedBox(
                                                        height: kPadding * 2),
                                                    ChipRadioButtons(
                                                      label:
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .cxr_result,
                                                      options: const [
                                                        'Normal',
                                                        'Abnormal'
                                                      ],
                                                      crossAxisCount: 2,
                                                      onChanged: (value) {
                                                        formGroup
                                                            .control(
                                                                'cxr_result')
                                                            .value = value;
                                                      },
                                                      selected: formGroup
                                                          .control('cxr_result')
                                                          .value,
                                                    ),
                                                    const SizedBox(
                                                        height: kPadding * 2),
                                                    DateTextInput(
                                                      firstDate: DateTime(2002),
                                                      controlName: 'tbi_date',
                                                      label:
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .tbi_date,
                                                    ),
                                                    const SizedBox(
                                                        height: kPadding * 2),
                                                    ChipRadioButtons(
                                                      label:
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .tbi_result,
                                                      options: const [
                                                        'Negative',
                                                        'Positive'
                                                      ],
                                                      crossAxisCount: 2,
                                                      onChanged: (value) {
                                                        formGroup
                                                            .control(
                                                                'tbi_result')
                                                            .value = value;
                                                      },
                                                      selected: formGroup
                                                          .control('tbi_result')
                                                          .value,
                                                    ),
                                                    const SizedBox(
                                                        height: kPadding * 2),
                                                  ]))),
                                      ChipRadioButtons(
                                        label: AppLocalizations.of(context)!
                                            .tpt_eligible,
                                        options: const ['Yes', 'No'],
                                        crossAxisCount: 2,
                                        onChanged: (value) {
                                          formGroup
                                              .control('tpt_eligible')
                                              .value = value;
                                        },
                                        selected: formGroup
                                            .control('tpt_eligible')
                                            .value,
                                      ),
                                      const SizedBox(height: kPadding * 2),
                                      BlocBuilder<SourceCubit, SourceState>(
                                          buildWhen: ((previous, current) =>
                                              (previous.isLoading !=
                                                  current.isLoading) ||
                                              previous.dataModel !=
                                                  current.dataModel),
                                          builder: (context, state) {
                                            List<String> tptRegimen =
                                                (state.diagnosisData != null)
                                                    ? state.diagnosisData!
                                                        .tptRegimen!
                                                        .map((e) => '${e.name}')
                                                        .toList()
                                                    : [];

                                            if (state.isLoading ?? false) {
                                              return const SizedBox(
                                                height: 15,
                                                width: 15,
                                                child: Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                              );
                                            }

                                            return ChipRadioButtons(
                                              label:
                                                  AppLocalizations.of(context)!
                                                      .tpt_regimen,
                                              options: tptRegimen,
                                              crossAxisCount: 2,
                                              onChanged: (value) {
                                                formGroup
                                                    .control('tpt_regimen')
                                                    .value = value;
                                              },
                                              selected: formGroup
                                                  .control('tpt_regimen')
                                                  .value,
                                            );
                                          }),
                                      const SizedBox(height: kPadding * 2),
                                      DateTextInput(
                                        firstDate: DateTime(2002),
                                        controlName: 'tpt_start_date',
                                        label: AppLocalizations.of(context)!
                                            .tpt_start_date,
                                      ),
                                      const SizedBox(height: kPadding * 2),
                                      PrimaryTextField<int>(
                                        formControlName: 'weight',
                                        label: AppLocalizations.of(context)!
                                            .weight,
                                        prefixIcon: Icons.monitor_weight,
                                        keyboardType: TextInputType.number,
                                        inputFormatter: [
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                          LengthLimitingTextInputFormatter(3)
                                        ],
                                      ),
                                      const SizedBox(height: kPadding * 2),
                                      PrimaryTextField(
                                        formControlName: 'tpt_side_effects',
                                        label: AppLocalizations.of(context)!
                                            .tpt_side_effects,
                                        prefixIcon:
                                            Icons.account_circle_outlined,
                                      ),
                                      const SizedBox(height: kPadding * 2),
                                      DateTextInput(
                                        firstDate: DateTime(2002),
                                        controlName: 'tpt_outcome_date',
                                        label: AppLocalizations.of(context)!
                                            .tpt_outcome_date,
                                      ),
                                      const SizedBox(height: kPadding * 2),
                                      TextFieldWithList(
                                        controlName: 'tpt_outcome',
                                        label: AppLocalizations.of(context)!
                                            .tpt_outcome,
                                        padding: EdgeInsets.zero,
                                        prefixIcon:
                                            Icons.account_circle_outlined,
                                        listData: const [
                                          'TPT Complete',
                                          'Died',
                                          'Non responder',
                                          'LTFU',
                                          'TPT discontinue due to toxicity',
                                          'Not evaluated'
                                        ],
                                        allowMultiSelection: false,
                                        onSelected: (value) {
                                          formGroup
                                              .control('tpt_outcome')
                                              .value = value[0];
                                        },
                                        emptyString: '',
                                      ),
                                    ])))),
                    BottomButtonBar(
                      onSave: (_) async => await _onSave(context, formGroup),
                      nextPage: const ContactTracingListRoute(),
                    ),
                    const SizedBox(height: kPadding * 2),
                  ]))));
    });
  }
}
