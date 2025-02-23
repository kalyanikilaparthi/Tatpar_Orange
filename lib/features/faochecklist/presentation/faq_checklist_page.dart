import 'package:djangoflow_app/djangoflow_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:tatpar_orange/configurations/configurations.dart';
import 'package:tatpar_orange/features/app/presentation/widgets/chip_radio_buttons.dart';
import 'package:tatpar_orange/features/app/presentation/widgets/date_text_input.dart';

import 'package:tatpar_orange/features/case/blocs/case_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tatpar_orange/features/case/presentation/widgets/bottom_button_bar.dart';
import 'package:tatpar_orange/features/faochecklist/models/faq_checklist_model.dart';

import 'package:tatpar_orange/features/referral/presentation/widgets/case_app_bar.dart';

@RoutePage()
class FaqChecklistPage extends StatelessWidget {
  const FaqChecklistPage({super.key});

  FormGroup _faqChecklistFormBuilder(
      {required FaqChecklistModel? faqChecklistModel}) {
    return fb.group({
      'worried_enough':
          FormControl<String?>(value: faqChecklistModel?.worriedEnough),
      'unable_to_eat':
          FormControl<String>(value: faqChecklistModel?.unableToEat),
      'few_foods': FormControl<String>(value: faqChecklistModel?.fewFoods),
      'skip_meal': FormControl<String>(value: faqChecklistModel?.skipMeal),
      'ate_less': FormControl<String>(value: faqChecklistModel?.ateLess),
      'household_food':
          FormControl<String>(value: faqChecklistModel?.householdFood),
      'hungry_but_did_not_eat':
          FormControl<String>(value: faqChecklistModel?.hungryButDidNotEat),
      'went_without_eating':
          FormControl<String>(value: faqChecklistModel?.wentWithoutEating),
      'nutrition_linked':
          FormControl<String>(value: faqChecklistModel?.nutritionLinked),
      'score_result':
          FormControl<String>(value: faqChecklistModel?.scoreResult),
      'linkage_date':
          FormControl<DateTime>(value: faqChecklistModel?.linkageDate),
      'yes_field': FormControl<bool>(value: faqChecklistModel?.yesField),
    });
  }

  Future<void> _onSave(BuildContext context, FormGroup formGroup) async {
    final caseCubit = context.read<CaseCubit>();
    if (formGroup.valid) {
      final model =
          caseCubit.state.faqCheckListModel ?? const FaqChecklistModel();
      final updatedModel = model.copyWith(
        worriedEnough: formGroup.control('worried_enough').value as String?,
        unableToEat: formGroup.control('unable_to_eat').value as String?,
        fewFoods: formGroup.control('few_foods').value as String?,
        skipMeal: formGroup.control('skip_meal').value as String?,
        ateLess: formGroup.control('ate_less').value as String?,
        householdFood: formGroup.control('household_food').value as String?,
        hungryButDidNotEat:
            formGroup.control('hungry_but_did_not_eat').value as String?,
        wentWithoutEating:
            formGroup.control('went_without_eating').value as String?,
        nutritionLinked: formGroup.control('nutrition_linked').value as String?,
        scoreResult: formGroup.control('score_result').value as String?,
        linkageDate: formGroup.control('linkage_date').value as DateTime?,
        isUpdated: caseCubit.state.faqCheckListModel?.isUpdated ?? false,
      );
      await caseCubit.updateFaqChecklistData(updatedModel);
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
    return Scaffold(
      appBar: CaseAppBar(
        AppLocalizations.of(context)!.faqChecklist,
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
      body: BlocBuilder<CaseCubit, CaseState>(
        buildWhen: (previous, current) =>
            (previous.isLoading != current.isLoading) ||
            (previous.faqCheckListModel != current.faqCheckListModel),
        builder: (context, state) {
          return (state.isLoading) ||
                  (state.caseWorkedUpon.faqChecklist != null &&
                      state.faqCheckListModel == null)
              ? Center(
                  child: Lottie.asset(
                    'assets/lottie/registration_loading.json',
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                )
              : ReactiveFormBuilder(
                  form: () => _faqChecklistFormBuilder(
                      faqChecklistModel: state.faqCheckListModel),
                  builder: (BuildContext context, FormGroup formGroup,
                      Widget? child) {
                    formGroup.valueChanges.listen((_) {
                      formGroup.control('yes_field').value = (formGroup
                                  .control('worried_enough')
                                  .value ==
                              'Yes' ||
                          formGroup.control('unable_to_eat').value == 'Yes' ||
                          formGroup.control('few_foods').value == 'Yes' ||
                          formGroup.control('skip_meal').value == 'Yes' ||
                          formGroup.control('ate_less').value == 'Yes' ||
                          formGroup.control('household_food').value == 'Yes' ||
                          formGroup.control('hungry_but_did_not_eat').value ==
                              'Yes' ||
                          formGroup.control('went_without_eating').value ==
                              'Yes');
                    });

                    return AutofillGroup(
                      child: Column(children: [
                        const SizedBox(height: kPadding * 2),
                        Expanded(
                          child: SingleChildScrollView(
                              child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: kPadding * 2),
                                  child: Column(children: [
                                    ChipRadioButtons(
                                      label: AppLocalizations.of(context)!
                                          .worriedEnough,
                                      options: const ['Yes', 'No'],
                                      crossAxisCount: 2,
                                      onChanged: (value) {
                                        formGroup
                                            .control('worried_enough')
                                            .value = value;
                                      },
                                      selected: formGroup
                                          .control('worried_enough')
                                          .value,
                                    ),
                                    const SizedBox(height: kPadding * 2),
                                    ChipRadioButtons(
                                      label: AppLocalizations.of(context)!
                                          .unableToEat,
                                      options: const ['Yes', 'No'],
                                      crossAxisCount: 2,
                                      onChanged: (value) {
                                        formGroup
                                            .control('unable_to_eat')
                                            .value = value;
                                      },
                                      selected: formGroup
                                          .control('unable_to_eat')
                                          .value,
                                    ),
                                    const SizedBox(height: kPadding * 2),
                                    ChipRadioButtons(
                                      label: AppLocalizations.of(context)!
                                          .fewFoods,
                                      options: const ['Yes', 'No'],
                                      crossAxisCount: 2,
                                      onChanged: (value) {
                                        formGroup.control('few_foods').value =
                                            value;
                                      },
                                      selected:
                                          formGroup.control('few_foods').value,
                                    ),
                                    const SizedBox(height: kPadding * 2),
                                    ChipRadioButtons(
                                      label: AppLocalizations.of(context)!
                                          .skipMeal,
                                      options: const ['Yes', 'No'],
                                      crossAxisCount: 2,
                                      onChanged: (value) {
                                        formGroup.control('skip_meal').value =
                                            value;
                                      },
                                      selected:
                                          formGroup.control('skip_meal').value,
                                    ),
                                    const SizedBox(height: kPadding * 2),
                                    ChipRadioButtons(
                                      label:
                                          AppLocalizations.of(context)!.ateLess,
                                      options: const ['Yes', 'No'],
                                      crossAxisCount: 2,
                                      onChanged: (value) {
                                        formGroup.control('ate_less').value =
                                            value;
                                      },
                                      selected:
                                          formGroup.control('ate_less').value,
                                    ),
                                    const SizedBox(height: kPadding * 2),
                                    ChipRadioButtons(
                                      label: AppLocalizations.of(context)!
                                          .householdFood,
                                      options: const ['Yes', 'No'],
                                      crossAxisCount: 2,
                                      onChanged: (value) {
                                        formGroup
                                            .control('household_food')
                                            .value = value;
                                      },
                                      selected: formGroup
                                          .control('household_food')
                                          .value,
                                    ),
                                    const SizedBox(height: kPadding * 2),
                                    ChipRadioButtons(
                                      label: AppLocalizations.of(context)!
                                          .hungryButDidNotEat,
                                      options: const ['Yes', 'No'],
                                      crossAxisCount: 2,
                                      onChanged: (value) {
                                        formGroup
                                            .control('hungry_but_did_not_eat')
                                            .value = value;
                                      },
                                      selected: formGroup
                                          .control('hungry_but_did_not_eat')
                                          .value,
                                    ),
                                    const SizedBox(height: kPadding * 2),
                                    ChipRadioButtons(
                                      label: AppLocalizations.of(context)!
                                          .wentWithoutEating,
                                      options: const ['Yes', 'No'],
                                      crossAxisCount: 2,
                                      onChanged: (value) {
                                        formGroup
                                            .control('went_without_eating')
                                            .value = value;
                                      },
                                      selected: formGroup
                                          .control('went_without_eating')
                                          .value,
                                    ),
                                    const SizedBox(height: kPadding * 2),
                                    ReactiveValueListenableBuilder<bool?>(
                                        formControlName: 'yes_field',
                                        builder: (context, control, child) {
                                          return Visibility(
                                            visible: formGroup
                                                    .control('yes_field')
                                                    .value ??
                                                false,
                                            child: Column(
                                              children: [
                                                ChipRadioButtons(
                                                  label: AppLocalizations.of(
                                                          context)!
                                                      .nutritionLinkage,
                                                  options: const ['Yes', 'No'],
                                                  crossAxisCount: 2,
                                                  onChanged: (value) {
                                                    formGroup
                                                        .control('score_result')
                                                        .value = value;
                                                  },
                                                  selected: formGroup
                                                      .control('score_result')
                                                      .value,
                                                ),
                                                const SizedBox(
                                                    height: kPadding * 2),
                                                DateTextInput(
                                                  label: AppLocalizations.of(
                                                          context)!
                                                      .linkageDate,
                                                  firstDate: DateTime(2002),
                                                  controlName: 'linkage_date',
                                                ),
                                                const SizedBox(
                                                    height: kPadding * 2),
                                              ],
                                            ),
                                          );
                                        }),
                                  ]))),
                        ),
                        BottomButtonBar(
                          onSave: (_) async => await _onSave(
                            context,
                            formGroup,
                          ),
                          nextPage: const TreatmentRoute(),
                        ),
                        const SizedBox(height: kPadding * 2),
                      ]),
                    );
                  },
                );
        },
      ),
    );
  }
}
