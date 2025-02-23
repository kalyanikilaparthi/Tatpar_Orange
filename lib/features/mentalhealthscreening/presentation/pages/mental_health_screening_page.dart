import 'dart:developer';

import 'package:djangoflow_app/djangoflow_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:tatpar_orange/configurations/configurations.dart';
import 'package:tatpar_orange/features/app/presentation/widgets/chip_radio_buttons.dart';
import 'package:tatpar_orange/features/case/blocs/case_cubit.dart';
import 'package:tatpar_orange/features/case/presentation/widgets/secondary_text_field.dart';
import 'package:tatpar_orange/features/mentalhealthscreening/model/mental_health_screening_model.dart';
import 'package:tatpar_orange/features/mentalhealthscreening/model/who_srq_model.dart';
import 'package:tatpar_orange/features/referral/presentation/widgets/bottom_button_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../app/presentation/widgets/date_text_input.dart';
import '../../../referral/presentation/widgets/case_app_bar.dart';

@RoutePage()
class MentalHealthScreeningPage extends StatelessWidget {
  const MentalHealthScreeningPage({super.key});

  FormGroup _mentalHealthScreeningFormBuilder(
      {required MentalHealthScreeningModel? mentalHealthScreeningModel}) {
    return fb.group({
      'stage': FormControl<String>(value: mentalHealthScreeningModel?.ipStage),
      'ip_stage':
          FormControl<String>(value: mentalHealthScreeningModel?.ipStage),
      'ipfu_stage':
          FormControl<String>(value: mentalHealthScreeningModel?.ipfuStage),
      'cp_stage':
          FormControl<String>(value: mentalHealthScreeningModel?.cpStage),
      'screening_date': FormControl<DateTime>(
          value: (mentalHealthScreeningModel?.ipScreeningDate)),
      'screening_status': FormControl<String>(
          value: mentalHealthScreeningModel?.ipScreeningStatus),
      'screening_score': FormControl<String>(
          value: mentalHealthScreeningModel?.ipScreeningScore),
      'counselling_linked': FormControl<DateTime>(
          value: mentalHealthScreeningModel?.ipCounsellingLinked),
      'psychiatrist_linked': FormControl<DateTime>(
          value: mentalHealthScreeningModel?.ipPsychiatristLinked),
      'feeling_better_after_linkage': FormControl<String>(
          value: mentalHealthScreeningModel?.ipfuFeelingBetter),
      'talk_to_helpline': FormControl<String>(
          value: mentalHealthScreeningModel?.ipfutalkToHelpline),
      'ipfu_screening_date': FormControl<DateTime>(
          value: (mentalHealthScreeningModel?.ipfuScreeningDate)),
      'ipfu_screening_status': FormControl<String>(
          value: mentalHealthScreeningModel?.ipfuScreeningStatus),
      'ipfu_screening_score': FormControl<String>(
          value: mentalHealthScreeningModel?.ipfuScreeningScore),
      'ipfu_counselling_linked': FormControl<DateTime>(
          value: mentalHealthScreeningModel?.ipfuCounsellingLinked),
      'ipfu_psychiatrist_linked': FormControl<DateTime>(
          value: mentalHealthScreeningModel?.ipfuPsychiatristLinked),
      'ipfu_feeling_better_after_linkage': FormControl<String>(
          value: mentalHealthScreeningModel?.ipfuFeelingBetter),
      'ipfu_talk_to_helpline': FormControl<String>(
          value: mentalHealthScreeningModel?.ipfutalkToHelpline),
      'cp_screening_date': FormControl<DateTime>(
          value: (mentalHealthScreeningModel?.cpScreeningDate)),
      'cp_screening_status': FormControl<String>(
          value: mentalHealthScreeningModel?.cpScreeningStatus),
      'cp_screening_score': FormControl<String>(
          value: mentalHealthScreeningModel?.cpScreeningScore),
      'cp_counselling_linked': FormControl<DateTime>(
          value: mentalHealthScreeningModel?.cpCounsellingLinked),
      'cp_psychiatrist_linked': FormControl<DateTime>(
          value: mentalHealthScreeningModel?.cpPsychiatristLinked),
      'cp_feeling_better_after_linkage': FormControl<String>(
          value: mentalHealthScreeningModel?.cpFeelingBetter),
      'cp_talk_to_helpline': FormControl<String>(
          value: mentalHealthScreeningModel?.cptalkToHelpline),
    });
  }

  Future<void> _onSave(
      BuildContext context,
      FormGroup formGroup,
      WHOSrqModel? whoSrqModel,
      WHOSrqModel? ipfuWhoSrqModel,
      WHOSrqModel? cpWhoSrqModel) async {
    if (formGroup.valid) {
      final formData = formGroup.value;
      final caseCubit = context.read<CaseCubit>();
      final model = caseCubit.state.mentalHealthScreeningModel ??
          const MentalHealthScreeningModel();
      //final whoSrqJson = whoSrqModel?.toJson() ?? <String, dynamic>{};

      final updatedModel = model.copyWith(
          ipStage: formData['stage'] as String?,
          ipScreeningDate: formData['screening_date'] as DateTime?,
          ipScreeningStatus: formData['screening_status'] as String?,
          ipScreeningScore: formData['screening_score'] as String?,
          ipCounsellingLinked: formData['counselling_linked'] as DateTime?,
          ipPsychiatristLinked: formData['psychiatrist_linked'] as DateTime?,
          ipfuScreeningDate: formData['ipfu_screening_date'] as DateTime?,
          ipfuScreeningStatus: formData['ipfu_screening_status'] as String?,
          ipfuScreeningScore: formData['ipfu_screening_score'] as String?,
          ipfuCounsellingLinked:
              formData['ipfu_counselling_linked'] as DateTime?,
          ipfuPsychiatristLinked:
              formData['ipfu_psychiatrist_linked'] as DateTime?,
          ipfuFeelingBetter:
              formData['ipfu_feeling_better_after_linkage'] as String?,
          ipfutalkToHelpline: formData['ipfu_talk_to_helpline'] as String?,
          cpScreeningDate: formData['cp_screening_date'] as DateTime?,
          cpScreeningStatus: formData['cp_screening_status'] as String?,
          cpScreeningScore: formData['cp_screening_score'] as String?,
          cpCounsellingLinked: formData['cp_counselling_linked'] as DateTime?,
          cpPsychiatristLinked: formData['cp_psychiatrist_linked'] as DateTime?,
          cpFeelingBetter:
              formData['cp_feeling_better_after_linkage'] as String?,
          cptalkToHelpline: formData['cp_talk_to_helpline'] as String?,
          isUpdated:
              caseCubit.state.mentalHealthScreeningModel?.isUpdated ?? false);
      await caseCubit.updateWHOSRQData(
          updatedModel, whoSrqModel, ipfuWhoSrqModel, cpWhoSrqModel);
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
    WHOSrqModel? whoSrqModel, ipfuWhoSrqModel, cpWhoSrqModel;
    String yesCounter, ipfuYesCounter, cpYesCounter;
    String screeningStatus, ipfuScreeningStatus, cpScreeningStatus;

    return Scaffold(
        appBar: CaseAppBar(
          AppLocalizations.of(context)!.mentalHealthScreening,
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
                (previous.mentalHealthScreeningModel !=
                    current.mentalHealthScreeningModel),
            builder: (context, state) {
              return (state.isLoading) ||
                      (state.caseWorkedUpon.whoSrq != null &&
                          state.mentalHealthScreeningModel == null)
                  ? Center(
                      child: Lottie.asset(
                        'assets/lottie/registration_loading.json',
                        // Path to your Lottie animation
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    )
                  : ReactiveFormBuilder(
                      form: () => _mentalHealthScreeningFormBuilder(
                          mentalHealthScreeningModel:
                              state.mentalHealthScreeningModel),
                      builder: (BuildContext context, FormGroup formGroup,
                          Widget? child) {
                        return AutofillGroup(
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
                                            ChipRadioButtons(
                                              allowMultiSelect: false,
                                              label:
                                                  AppLocalizations.of(context)!
                                                      .stage,
                                              options: const [
                                                'IHV',
                                                'IPFU',
                                                'CP'
                                              ],
                                              crossAxisCount: 3,
                                              onChanged: (value) {
                                                formGroup
                                                    .control('stage')
                                                    .value = value;
                                              },
                                              selected: formGroup
                                                  .control('stage')
                                                  .value,
                                            ),
                                            const SizedBox(
                                                height: kPadding * 2),
                                            ReactiveValueListenableBuilder<
                                                String>(
                                              formControlName: 'stage',
                                              builder:
                                                  (context, control, child) =>
                                                      Visibility(
                                                          visible: formGroup
                                                                  .control(
                                                                      'stage')
                                                                  .value
                                                                  .toString() ==
                                                              'IHV',
                                                          child: Column(
                                                            children: [
                                                              DateTextInput(
                                                                firstDate:
                                                                    DateTime(
                                                                        2002),
                                                                controlName:
                                                                    'screening_date',
                                                                label: AppLocalizations.of(
                                                                        context)!
                                                                    .screeningDate,
                                                              ),
                                                              const SizedBox(
                                                                  height:
                                                                      kPadding *
                                                                          2),
                                                              ReactiveValueListenableBuilder<
                                                                      DateTime>(
                                                                  formControlName:
                                                                      'screening_date',
                                                                  builder: (context,
                                                                          control,
                                                                          child) =>
                                                                      Visibility(
                                                                        visible:
                                                                            (control.valid),
                                                                        child:
                                                                            ElevatedButton(
                                                                          onPressed:
                                                                              () {
                                                                            (context.router.push(const WHOSRQRoute())).then((value) {
                                                                              if (value != null && value is Map<String, dynamic>) {
                                                                                whoSrqModel = value['whoSrqModel'] as WHOSrqModel;
                                                                                yesCounter = value['yesCounter'] as String;

                                                                                screeningStatus = value['screeningStatus'] as String;

                                                                                formGroup.control('screening_score').value = yesCounter;
                                                                                formGroup.control('screening_status').value = screeningStatus;
                                                                              }
                                                                            });
                                                                          },
                                                                          child:
                                                                              const Text('Take WHO SRQ'),
                                                                        ),
                                                                      )),
                                                              const SizedBox(
                                                                  height:
                                                                      kPadding *
                                                                          2),
                                                              ReactiveValueListenableBuilder<
                                                                      String>(
                                                                  formControlName:
                                                                      'screening_status',
                                                                  builder: (context,
                                                                          control,
                                                                          child) =>
                                                                      Visibility(
                                                                          visible: (formGroup.control('screening_status').value) !=
                                                                              null,
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              Row(
                                                                                children: [
                                                                                  ReactiveValueListenableBuilder<String>(
                                                                                      formControlName: 'screening_score',
                                                                                      builder: (context, control, child) {
                                                                                        return Expanded(
                                                                                          child: SecondaryTextField(
                                                                                            text: formGroup.control('screening_score').value ?? '',
                                                                                            label: AppLocalizations.of(context)!.screeningScore,
                                                                                          ),
                                                                                        );
                                                                                      }),
                                                                                  const SizedBox(width: kPadding * 1.25),
                                                                                  ReactiveValueListenableBuilder<String>(
                                                                                      formControlName: 'screening_status',
                                                                                      builder: (context, control, child) {
                                                                                        return Expanded(
                                                                                          child: SecondaryTextField(
                                                                                            text: formGroup.control('screening_status').value ?? '',
                                                                                            label: AppLocalizations.of(context)!.screeningStatus,
                                                                                          ),
                                                                                        );
                                                                                      }),
                                                                                  const SizedBox(height: kPadding * 2),
                                                                                ],
                                                                              ),
                                                                              const SizedBox(height: kPadding * 2),
                                                                              Row(
                                                                                children: [
                                                                                  Expanded(
                                                                                    child: DateTextInput(
                                                                                      firstDate: DateTime(2000),
                                                                                      controlName: 'counselling_linked',
                                                                                      label: AppLocalizations.of(context)!.counsellingLinked,
                                                                                    ),
                                                                                  ),
                                                                                  const SizedBox(width: kPadding * 1.25),
                                                                                  Expanded(
                                                                                    child: DateTextInput(
                                                                                      firstDate: DateTime(2002),
                                                                                      controlName: 'psychiatrist_linked',
                                                                                      label: AppLocalizations.of(context)!.psychiatristLinked,
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              const SizedBox(height: kPadding * 2),
                                                                            ],
                                                                          ))),
                                                            ],
                                                          )),
                                            ),
                                            ReactiveValueListenableBuilder<
                                                String>(
                                              formControlName: 'stage',
                                              builder:
                                                  (context, control, child) =>
                                                      Visibility(
                                                visible: formGroup
                                                        .control('stage')
                                                        .value
                                                        .toString() ==
                                                    'IPFU',
                                                child: Column(
                                                  children: [
                                                    // const SizedBox(
                                                    //     height: kPadding * 2),
                                                    // Text(
                                                    //   'IPFU',
                                                    //   textAlign:
                                                    //       TextAlign.left,
                                                    //   style: Theme.of(context)
                                                    //       .textTheme
                                                    //       .labelLarge
                                                    //       ?.copyWith(
                                                    //           fontWeight:
                                                    //               FontWeight
                                                    //                   .w600,
                                                    //           fontSize: 20,
                                                    //           height: 1.2,
                                                    //           letterSpacing:
                                                    //               0.5),
                                                    // ),
                                                    // const SizedBox(
                                                    //     height: kPadding * 2),
                                                    DateTextInput(
                                                      firstDate: DateTime(2002),
                                                      controlName:
                                                          'ipfu_screening_date',
                                                      label:
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .screeningDate,
                                                    ),
                                                    const SizedBox(
                                                        height: kPadding * 2),
                                                    ReactiveValueListenableBuilder<
                                                            DateTime>(
                                                        formControlName:
                                                            'ipfu_screening_date',
                                                        builder:
                                                            (context, control,
                                                                    child) =>
                                                                Visibility(
                                                                  visible:
                                                                      (control
                                                                          .valid),
                                                                  child:
                                                                      ElevatedButton(
                                                                    onPressed:
                                                                        () {
                                                                      (context.router.push(
                                                                              const WHOSRQRoute()))
                                                                          .then(
                                                                              (value) {
                                                                        if (value !=
                                                                                null &&
                                                                            value
                                                                                is Map<String, dynamic>) {
                                                                          ipfuWhoSrqModel =
                                                                              value['whoSrqModel'] as WHOSrqModel;

                                                                          ipfuYesCounter =
                                                                              value['yesCounter'] as String;

                                                                          ipfuScreeningStatus =
                                                                              value['screeningStatus'] as String;

                                                                          formGroup
                                                                              .control('ipfu_screening_score')
                                                                              .value = ipfuYesCounter;
                                                                          formGroup
                                                                              .control('ipfu_screening_status')
                                                                              .value = ipfuScreeningStatus;
                                                                        }
                                                                      });
                                                                    },
                                                                    child: const Text(
                                                                        'Take WHO SRQ'),
                                                                  ),
                                                                )),
                                                    const SizedBox(
                                                        height: kPadding * 2),
                                                    ReactiveValueListenableBuilder<
                                                            String>(
                                                        formControlName:
                                                            'ipfu_screening_status',
                                                        builder: (context,
                                                                control,
                                                                child) =>
                                                            Visibility(
                                                                visible: (formGroup
                                                                        .control(
                                                                            'ipfu_screening_status')
                                                                        .value) !=
                                                                    null,
                                                                child: Column(
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        ReactiveValueListenableBuilder<
                                                                                String>(
                                                                            formControlName:
                                                                                'ipfu_screening_score',
                                                                            builder: (context,
                                                                                control,
                                                                                child) {
                                                                              return Expanded(
                                                                                child: SecondaryTextField(
                                                                                  text: formGroup.control('ipfu_screening_score').value ?? '',
                                                                                  label: AppLocalizations.of(context)!.screeningScore,
                                                                                ),
                                                                              );
                                                                            }),
                                                                        const SizedBox(
                                                                            width:
                                                                                kPadding * 1.25),
                                                                        ReactiveValueListenableBuilder<
                                                                                String>(
                                                                            formControlName:
                                                                                'ipfu_screening_status',
                                                                            builder: (context,
                                                                                control,
                                                                                child) {
                                                                              return Expanded(
                                                                                child: SecondaryTextField(
                                                                                  text: formGroup.control('ipfu_screening_status').value ?? '',
                                                                                  label: AppLocalizations.of(context)!.screeningStatus,
                                                                                ),
                                                                              );
                                                                            }),
                                                                        const SizedBox(
                                                                            height:
                                                                                kPadding * 2),
                                                                      ],
                                                                    ),
                                                                    const SizedBox(
                                                                        height:
                                                                            kPadding *
                                                                                2),
                                                                    Row(
                                                                      children: [
                                                                        Expanded(
                                                                          child:
                                                                              DateTextInput(
                                                                            firstDate:
                                                                                DateTime(2000),
                                                                            controlName:
                                                                                'ipfu_counselling_linked',
                                                                            label:
                                                                                AppLocalizations.of(context)!.counsellingLinked,
                                                                          ),
                                                                        ),
                                                                        const SizedBox(
                                                                            width:
                                                                                kPadding * 1.25),
                                                                        Expanded(
                                                                          child:
                                                                              DateTextInput(
                                                                            firstDate:
                                                                                DateTime(2002),
                                                                            controlName:
                                                                                'ipfu_psychiatrist_linked',
                                                                            label:
                                                                                AppLocalizations.of(context)!.psychiatristLinked,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    ReactiveValueListenableBuilder<
                                                                            String>(
                                                                        formControlName:
                                                                            'screening_status',
                                                                        builder: (context, control, child) => Visibility(
                                                                            visible: (formGroup.control('screening_status').value) == 'Positive',
                                                                            child: Column(children: [
                                                                              const SizedBox(height: kPadding * 2),
                                                                              ChipRadioButtons(
                                                                                label: 'Feeling better after linkage',
                                                                                options: const [
                                                                                  'Yes',
                                                                                  'No'
                                                                                ],
                                                                                crossAxisCount: 2,
                                                                                onChanged: (value) {
                                                                                  formGroup.control('ipfu_feeling_better_after_linkage').value = value;
                                                                                },
                                                                                selected: formGroup.control('ipfu_feeling_better_after_linkage').value,
                                                                              ),
                                                                              const SizedBox(height: kPadding * 2),
                                                                              ChipRadioButtons(
                                                                                label: 'Talk to helpline again',
                                                                                options: const [
                                                                                  'Yes',
                                                                                  'No'
                                                                                ],
                                                                                crossAxisCount: 2,
                                                                                onChanged: (value) {
                                                                                  formGroup.control('ipfu_talk_to_helpline').value = value;
                                                                                },
                                                                                selected: formGroup.control('ipfu_talk_to_helpline').value,
                                                                              ),
                                                                            ]))),
                                                                  ],
                                                                ))),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            ReactiveValueListenableBuilder<
                                                    String>(
                                                formControlName: 'stage',
                                                builder: (context, control,
                                                        child) =>
                                                    Visibility(
                                                        visible: formGroup
                                                                .control(
                                                                    'stage')
                                                                .value
                                                                .toString() ==
                                                            'CP',
                                                        child: Column(
                                                          children: [
                                                            // const SizedBox(
                                                            //     height:
                                                            //         kPadding *
                                                            //             2),
                                                            // Text(
                                                            //   'CP',
                                                            //   textAlign:
                                                            //       TextAlign
                                                            //           .left,
                                                            //   style: Theme
                                                            //           .of(
                                                            //               context)
                                                            //       .textTheme
                                                            //       .labelLarge
                                                            //       ?.copyWith(
                                                            //           fontWeight:
                                                            //               FontWeight
                                                            //                   .w600,
                                                            //           fontSize:
                                                            //               20,
                                                            //           height:
                                                            //               1.2,
                                                            //           letterSpacing:
                                                            //               0.5),
                                                            // ),
                                                            // const SizedBox(
                                                            //     height:
                                                            //         kPadding *
                                                            //             2),
                                                            DateTextInput(
                                                              firstDate:
                                                                  DateTime(
                                                                      2002),
                                                              controlName:
                                                                  'cp_screening_date',
                                                              label: AppLocalizations
                                                                      .of(context)!
                                                                  .screeningDate,
                                                            ),
                                                            const SizedBox(
                                                                height:
                                                                    kPadding *
                                                                        2),
                                                            ReactiveValueListenableBuilder<
                                                                    DateTime>(
                                                                formControlName:
                                                                    'cp_screening_date',
                                                                builder: (context,
                                                                        control,
                                                                        child) =>
                                                                    Visibility(
                                                                      visible:
                                                                          (control
                                                                              .valid),
                                                                      child:
                                                                          ElevatedButton(
                                                                        onPressed:
                                                                            () {
                                                                          (context.router.push(const WHOSRQRoute()))
                                                                              .then((value) {
                                                                            if (value != null &&
                                                                                value is Map<String, dynamic>) {
                                                                              cpWhoSrqModel = value['whoSrqModel'] as WHOSrqModel;
                                                                              cpYesCounter = value['yesCounter'] as String;
                                                                              cpScreeningStatus = value['screeningStatus'] as String;
                                                                              log(cpYesCounter);
                                                                              log(cpWhoSrqModel.toString());

                                                                              log(cpScreeningStatus);
                                                                              formGroup.control('cp_screening_score').value = cpYesCounter;
                                                                              formGroup.control('cp_screening_status').value = cpScreeningStatus;
                                                                            }
                                                                          });
                                                                        },
                                                                        child: const Text(
                                                                            'Take WHO SRQ'),
                                                                      ),
                                                                    )),
                                                            const SizedBox(
                                                                height:
                                                                    kPadding *
                                                                        2),
                                                            ReactiveValueListenableBuilder<
                                                                String>(
                                                              formControlName:
                                                                  'cp_screening_status',
                                                              builder: (context,
                                                                      control,
                                                                      child) =>
                                                                  Visibility(
                                                                visible: (formGroup
                                                                        .control(
                                                                            'cp_screening_status')
                                                                        .value) !=
                                                                    null,
                                                                child: Column(
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        ReactiveValueListenableBuilder<
                                                                                String>(
                                                                            formControlName:
                                                                                'cp_screening_score',
                                                                            builder: (context,
                                                                                control,
                                                                                child) {
                                                                              return Expanded(
                                                                                child: SecondaryTextField(
                                                                                  text: formGroup.control('cp_screening_score').value ?? '',
                                                                                  label: AppLocalizations.of(context)!.screeningScore,
                                                                                ),
                                                                              );
                                                                            }),
                                                                        const SizedBox(
                                                                            width:
                                                                                kPadding * 1.25),
                                                                        ReactiveValueListenableBuilder<
                                                                                String>(
                                                                            formControlName:
                                                                                'cp_screening_status',
                                                                            builder: (context,
                                                                                control,
                                                                                child) {
                                                                              return Expanded(
                                                                                child: SecondaryTextField(
                                                                                  text: formGroup.control('cp_screening_status').value ?? '',
                                                                                  label: AppLocalizations.of(context)!.screeningStatus,
                                                                                ),
                                                                              );
                                                                            }),
                                                                      ],
                                                                    ),
                                                                    const SizedBox(
                                                                        height:
                                                                            kPadding *
                                                                                2),
                                                                    Row(
                                                                      children: [
                                                                        Expanded(
                                                                          child:
                                                                              DateTextInput(
                                                                            firstDate:
                                                                                DateTime(2000),
                                                                            controlName:
                                                                                'cp_counselling_linked',
                                                                            label:
                                                                                AppLocalizations.of(context)!.counsellingLinked,
                                                                          ),
                                                                        ),
                                                                        const SizedBox(
                                                                            width:
                                                                                kPadding * 1.25),
                                                                        Expanded(
                                                                          child:
                                                                              DateTextInput(
                                                                            firstDate:
                                                                                DateTime(2002),
                                                                            controlName:
                                                                                'cp_psychiatrist_linked',
                                                                            label:
                                                                                AppLocalizations.of(context)!.psychiatristLinked,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    const SizedBox(
                                                                        height:
                                                                            kPadding *
                                                                                2),
                                                                    ReactiveValueListenableBuilder<
                                                                        String>(
                                                                      formControlName:
                                                                          'screening_status',
                                                                      builder: (context,
                                                                              control,
                                                                              child) =>
                                                                          Visibility(
                                                                        visible:
                                                                            (formGroup.control('screening_status').value) ==
                                                                                'Positive',
                                                                        child:
                                                                            Column(
                                                                          children: [
                                                                            ChipRadioButtons(
                                                                              label: 'Feeling better after linkage',
                                                                              options: const [
                                                                                'Yes',
                                                                                'No'
                                                                              ],
                                                                              crossAxisCount: 2,
                                                                              onChanged: (value) {
                                                                                formGroup.control('cp_feeling_better_after_linkage').value = value;
                                                                              },
                                                                              selected: formGroup.control('cp_feeling_better_after_linkage').value,
                                                                            ),
                                                                            const SizedBox(height: kPadding * 2),
                                                                            ChipRadioButtons(
                                                                              label: 'Talk to helpline again',
                                                                              options: const [
                                                                                'Yes',
                                                                                'No'
                                                                              ],
                                                                              crossAxisCount: 2,
                                                                              onChanged: (value) {
                                                                                formGroup.control('cp_talk_to_helpline').value = value;
                                                                              },
                                                                              selected: formGroup.control('cp_talk_to_helpline').value,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        )))
                                          ])))),
                          BottomButtonBar(
                            onSave: (_) async => await _onSave(
                                context,
                                formGroup,
                                whoSrqModel,
                                ipfuWhoSrqModel,
                                cpWhoSrqModel),
                            nextPage: const DiagnosisRoute(),
                          ),
                          const SizedBox(height: kPadding * 2),
                        ]));
                      });
            }));
  }
}
