import 'package:djangoflow_app/djangoflow_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:tatpar_acf/configurations/configurations.dart';
import 'package:tatpar_acf/features/app/presentation/widgets/chip_radio_buttons.dart';
import 'package:tatpar_acf/features/app/presentation/widgets/date_text_input.dart';
import 'package:tatpar_acf/features/app/presentation/widgets/primary_text_field.dart';
import 'package:tatpar_acf/features/case/blocs/case_cubit.dart';
import 'package:tatpar_acf/features/case/blocs/source_cubit.dart';
import 'package:tatpar_acf/features/case/presentation/widgets/bottom_button_bar.dart';
import 'package:tatpar_acf/features/case/data/source_models/diagnosis_data_fields.dart';
import 'package:tatpar_acf/features/outcome/model/outcome_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tatpar_acf/features/referral/presentation/widgets/case_app_bar.dart';

@RoutePage()
class OutcomePage extends StatelessWidget {
  const OutcomePage({super.key});
  FormGroup _outcomeFormBuilder(
      {required OutcomeModel? outcomeModel, required SourceCubit sourceCubit}) {
    final treatmentOutcome = outcomeModel?.selectedtreatmentOutcome;
    final treatmentOutcomeData =
        sourceCubit.state.diagnosisData?.treatmentOutcome?.firstWhere(
      (element) => element.id == treatmentOutcome,
      orElse: () => const TreatmentOutcome(name: null),
    );
    final String? treatmentOutcomeName = treatmentOutcomeData?.name;
    return fb.group({
      'treatment_completion_date': FormControl<DateTime>(
        value: outcomeModel?.treatmentCompletionDate,
      ),
      'nutrition_provided': FormControl<String?>(
        value: outcomeModel?.nutritionProvided,
      ),
      'treatment_outcome': FormControl<String?>(
        value: treatmentOutcomeName ?? outcomeModel?.treatmentOutcome,
      ),
      'treatment_comments': FormControl<String?>(
        value: outcomeModel?.treatmentComments,
      ),
    });
  }

  Future<void> _onSave(BuildContext context, FormGroup formGroup) async {
    if (formGroup.valid) {
      final formData = formGroup.value;
      final cubit = context.read<CaseCubit>();
      final sourceCubit = context.read<SourceCubit>();
      final model = cubit.state.outcomeModel ?? const OutcomeModel();
      context.read<CaseCubit>().selectTreatmentOutcome = sourceCubit
          .state.diagnosisData!.treatmentOutcome!
          .firstWhere(
              (element) =>
                  element.name == formGroup.control('treatment_outcome').value,
              orElse: () => const TreatmentOutcome(id: 0))
          .id;
      final outcomeModel = model.copyWith(
          treatmentCompletionDate:
              formData['treatment_completion_date'] as DateTime?,
          nikshayId: formData['nikshay_id'] as String?,
          nutritionProvided: formData['nutrition_provided'] as String?,
          selectedtreatmentOutcome: cubit.selectedTreatmentOutcome,
          treatmentComments: formData['treatment_comments'] as String?,
          isUpdated: cubit.state.outcomeModel?.isUpdated ?? false);
      await cubit.updateOutcomeData(outcomeModel);
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
              'Outcome',
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
            body: state.isLoading ||
                    (state.caseWorkedUpon.outcomeValue != null &&
                        state.outcomeModel == null)
                ? Center(
                    child: Lottie.asset(
                      'assets/lottie/registration_loading.json', // Path to your Lottie animation
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  )
                : ReactiveFormBuilder(
                    form: () => _outcomeFormBuilder(
                        outcomeModel: state.outcomeModel,
                        sourceCubit: context.read<SourceCubit>()),
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
                                            DateTextInput(
                                              firstDate: DateTime(2002),
                                              controlName:
                                                  'treatment_completion_date',
                                              label:
                                                  AppLocalizations.of(context)!
                                                      .treatmentCompletionDate,
                                            ),
                                            const SizedBox(
                                                height: kPadding * 2),
                                            PrimaryTextField(
                                              formControlName:
                                                  'nutrition_provided',
                                              label:
                                                  AppLocalizations.of(context)!
                                                      .nutritionProvided,
                                              prefixIcon:
                                                  Icons.account_circle_outlined,
                                            ),
                                            const SizedBox(
                                                height: kPadding * 2),
                                            BlocBuilder<SourceCubit,
                                                    SourceState>(
                                                buildWhen: ((previous,
                                                        current) =>
                                                    (previous.isLoading !=
                                                        current.isLoading) ||
                                                    previous.dataModel !=
                                                        current.dataModel),
                                                builder: (context, state) {
                                                  List<String>
                                                      treatmentOutcome =
                                                      (state.diagnosisData !=
                                                              null)
                                                          ? state.diagnosisData!
                                                              .treatmentOutcome!
                                                              .map((e) =>
                                                                  '${e.name}')
                                                              .toList()
                                                          : [];

                                                  if (state.isLoading ??
                                                      false) {
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
                                                    label: AppLocalizations.of(
                                                            context)!
                                                        .treatmentOutcome,
                                                    options: treatmentOutcome,
                                                    crossAxisCount: 2,
                                                    onChanged: (value) {
                                                      formGroup
                                                          .control(
                                                              'treatment_outcome')
                                                          .value = value;
                                                    },
                                                    selected: formGroup
                                                        .control(
                                                            'treatment_outcome')
                                                        .value,
                                                  );
                                                }),
                                            const SizedBox(
                                                height: kPadding * 2),
                                            PrimaryTextField(
                                              formControlName:
                                                  'treatment_comments',
                                              label:
                                                  AppLocalizations.of(context)!
                                                      .treatmentComments,
                                              prefixIcon:
                                                  Icons.account_circle_outlined,
                                            ),
                                            const SizedBox(
                                                height: kPadding * 2),
                                          ])))),
                          BottomButtonBar(
                            onSave: (_) async =>
                                await _onSave(context, formGroup),
                            nextPage: const AppHomeRoute(),
                          ),
                          const SizedBox(height: kPadding * 2),
                        ])))));
  }
}
