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
import 'package:tatpar_orange/features/case/data/case_models/case_model.dart';
import 'package:tatpar_orange/features/case/data/source_models/referral_districts_model.dart';
import 'package:tatpar_orange/features/referral/model/referral_details_model.dart';
import 'package:tatpar_orange/features/referral/presentation/widgets/bottom_button_bar.dart';
import 'package:tatpar_orange/features/referral/presentation/widgets/case_app_bar.dart';

@RoutePage()
class BasicDetails extends StatelessWidget {
  const BasicDetails({super.key});
  FormGroup _basicDetailsFormBuilder({
    required ReferralDetailsModel? referralDetailsModel,
  }) {
    return fb.group({
      'referral_id': FormControl<String>(validators: [Validators.required]),
      'referral_date': FormControl<DateTime>(validators: [Validators.required]),
      'referral_name': FormControl<String>(validators: [Validators.required]),
      'age': FormControl<int>(),
      'gender': FormControl<String>(),
      'district': FormControl<String>(validators: [Validators.required]),
      'referral_block': FormControl<String>(validators: [Validators.required]),
      'panchayat_code': FormControl<String>(),
      'ward': FormControl<int>(
        validators: [
          Validators.min(1),
          Validators.max(40),
        ],
      ),
      'guardian_name': FormControl<String>(),
      'guardian_phone_number':
          FormControl<String?>(validators: [Validators.required]),
      'caste_category': FormControl<String?>(),
      'key_population': FormControl<List<String>>(),
      'trimester': FormControl<String?>(),
      'referred_by': FormControl<String?>(),
      'referrer_source': FormControl<String?>(),
      'referred_ward': FormControl<int>(
        validators: [
          Validators.min(1),
          Validators.max(40),
        ],
      ),
      'referrer_panchayat_code': FormControl<String>(),
      'source': FormControl<String?>(),
    });
  }

  Future<void> _onSave(BuildContext context, FormGroup formGroup) async {
    if (formGroup.valid) {
      final formData = formGroup.value;
      final caseCubit = context.read<CaseCubit>();
      final sourceCubit = context.read<SourceCubit>();
      context.read<CaseCubit>().selectCasteCategory =
          formGroup.control('caste_category').value != null
              ? int.tryParse(
                  formGroup.control('caste_category').value.split(':')[0])
              : null;

      context.read<CaseCubit>().selectTrimester =
          (formGroup.control('trimester').value) != null
              ? int.tryParse(formGroup.control('trimester').value.split(':')[0])
              : null;
      context.read<CaseCubit>().selectReferrerSource =
          formGroup.control('referrer_source').value != null
              ? int.tryParse(
                  formGroup.control('referrer_source').value.split(':')[0])
              : null;
      for (var block in sourceCubit.state.dataModel!.blocks!) {
        var panchayat = block.panchayat!.firstWhere(
            (p) =>
                p.panchayat ==
                formGroup.control('referrer_panchayat_code').value,
            orElse: () => const Panchayat(id: 0));
        if (panchayat.id != 0) {
          context.read<CaseCubit>().selectReferrerPanchayatCodeId =
              panchayat.id;
          break;
        }
      }
      context.read<CaseCubit>().selectDistrictId = sourceCubit
          .state.dataModel!.districts!
          .firstWhere(
              (element) =>
                  element.district == formGroup.control('district').value,
              orElse: () => const District(id: null))
          .id;
      context.read<CaseCubit>().selectBlockId = sourceCubit
          .state.dataModel!.blocks!
          .firstWhere(
              (element) =>
                  element.block == formGroup.control('referral_block').value,
              orElse: () => const Block(id: null))
          .id;
      for (var block in sourceCubit.state.dataModel!.blocks!) {
        var panchayat = block.panchayat!.firstWhere(
            (p) => p.panchayat == formGroup.control('panchayat_code').value,
            orElse: () => const Panchayat(id: 0));
        if (panchayat.id != 0) {
          context.read<CaseCubit>().selectPanchayatCodeId = panchayat.id;
          break;
        }
      }
      final List<String>? value = formGroup.control('key_population').value;

      context.read<CaseCubit>().selectKeyPopulation = (value) != null
          ? value
              .join(',')
              .split(',')
              .map((e) => RegExp(r'\d+').firstMatch(e))
              .where((match) => match != null)
              .map((match) => int.parse(match!.group(0)!))
              .toList()
          : [];

      final model =
          caseCubit.state.referralDetailsModel ?? const ReferralDetailsModel();

      final referralDetailsData = model.copyWith(
          referralID: formData['referral_id'] as String?,
          referralDate: formData['referral_date'] as DateTime,
          referralName: formData['referral_name'] as String?,
          age: formData['age'] as int?,
          gender: formData['gender'] as String?,
          selectedDistrict: caseCubit.selectedDistrictId,
          selectedBlock: caseCubit.selectedBlockId,
          selectedPanchayatCode: caseCubit.selectedPanchayatCodeId,
          ward: formData['ward'] as int?,
          guardianName: formData['guardian_name'] as String?,
          guardianPhoneNumber: formData['guardian_phone_number'] as String?,
          selectedCasteCategory: caseCubit.selectedCasteCategory,
          selectedKeyPopulation: caseCubit.selectedKeyPopulation,
          selectedTrimester: caseCubit.selectedTrimester,
          referredBy: formData['referred_by'] as String?,
          selectedrReferrerSource: caseCubit.selectedReferrerSource,
          referredWard: formData['referred_ward'] as int?,
          selectedReferrerPanchayatCode:
              caseCubit.selectedReferrerPanchayatCodeId,
          source: formData['source'] as String?,
          isUpdated: caseCubit.state.referralDetailsModel?.isUpdated ?? false);

      await caseCubit.updateReferralDetailsData(referralDetailsData);
    } else {
      formGroup.markAllAsTouched();
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
              AppLocalizations.of(context)!.addReferral,
              onClick: () {
                context.read<CaseCubit>().resetSelectedCase();

                context.router.pushAndPopUntil(const AppHomeRoute(),
                    predicate: (Route<dynamic> route) => false);
              },
            ),
            body: ReactiveFormBuilder(form: () {
              return _basicDetailsFormBuilder(
                referralDetailsModel: state.referralDetailsModel,
              );
            }, builder:
                (BuildContext context, FormGroup formGroup, Widget? child) {
              (formGroup.control('district').valueChanges).listen(
                (value) {
                  if (value != null) {
                    formGroup.control('referral_block').reset();
                    formGroup.control('panchayat_code').reset();
                    formGroup.control('referrer_panchayat_code').reset();

                    context.read<SourceCubit>().fetchDataForBlock(value);
                  }
                },
              );
              (formGroup.control('referral_block').valueChanges)
                  .listen((value) {
                if (value != null) {
                  formGroup.control('panchayat_code').reset();

                  formGroup.control('referrer_panchayat_code').reset();
                  context.read<SourceCubit>().fetchDataForPanchayat(value);
                }
              });
              return AutofillGroup(
                  child: GestureDetector(
                      onTap: () =>
                          FocusScope.of(context).unfocus(), // Unfocus on tap
                      child: Column(
                        // padding:
                        //     const EdgeInsets.symmetric(vertical: kPadding * 2),
                        children: [
                          const SizedBox(height: kPadding * 2),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: kPadding * 2),
                                child: Column(
                                  children: [
                                    PrimaryTextField(
                                      formControlName: 'referral_id',
                                      label: AppLocalizations.of(context)!
                                          .referralID,
                                      prefixIcon: Icons.account_circle_outlined,
                                    ),
                                    const SizedBox(height: kPadding * 2),
                                    _loadDistricts(formGroup, context),
                                    PrimaryTextField<int?>(
                                      formControlName: 'ward',
                                      label: AppLocalizations.of(context)!.ward,
                                      prefixIcon: Icons.account_circle_outlined,
                                      keyboardType: TextInputType.number,
                                      inputFormatter: [
                                        FilteringTextInputFormatter.digitsOnly,
                                        LengthLimitingTextInputFormatter(2),
                                      ],
                                    ),
                                    const SizedBox(height: kPadding * 2),
                                    DateTextInput(
                                      firstDate: DateTime(2002),
                                      controlName: 'referral_date',
                                      label: AppLocalizations.of(context)!
                                          .referralDate,
                                    ),
                                    const SizedBox(height: kPadding * 2),
                                    PrimaryTextField(
                                      formControlName: 'referral_name',
                                      label: AppLocalizations.of(context)!
                                          .referralName,
                                      prefixIcon: Icons.account_circle_outlined,
                                    ),
                                    const SizedBox(height: kPadding * 2),
                                    PrimaryTextField<int?>(
                                      formControlName: 'age',
                                      label: AppLocalizations.of(context)!.age,
                                      prefixIcon: Icons.account_circle_outlined,
                                      keyboardType: TextInputType.number,
                                      inputFormatter: [
                                        FilteringTextInputFormatter.digitsOnly,
                                        LengthLimitingTextInputFormatter(2)
                                      ],
                                    ),
                                    const SizedBox(height: kPadding * 2),
                                    ChipRadioButtons(
                                      label:
                                          AppLocalizations.of(context)!.gender,
                                      options: const [
                                        'Male',
                                        'Female',
                                        'Other'
                                      ],
                                      selected:
                                          formGroup.control('gender').value,
                                      onChanged: (value) {
                                        formGroup.control('gender').value =
                                            value;
                                      },
                                    ),
                                    const SizedBox(height: kPadding * 2),
                                    PrimaryTextField(
                                      formControlName: 'guardian_name',
                                      label: AppLocalizations.of(context)!
                                          .guardianName,
                                      prefixIcon: Icons.account_circle_outlined,
                                    ),
                                    const SizedBox(height: kPadding * 2),
                                    PrimaryTextField(
                                      formControlName: 'guardian_phone_number',
                                      label: AppLocalizations.of(context)!
                                          .guardianPhoneNumber,
                                      maxLength: 10,
                                      prefixIcon: Icons.phone_outlined,
                                      keyboardType: TextInputType.number,
                                      inputFormatter: [
                                        FilteringTextInputFormatter.digitsOnly,
                                        LengthLimitingTextInputFormatter(10)
                                      ],
                                    ),
                                    BlocBuilder<SourceCubit, SourceState>(
                                        buildWhen: ((previous, current) =>
                                            (previous.isLoading !=
                                                current.isLoading) ||
                                            previous.dataModel !=
                                                current.dataModel),
                                        builder: (context, state) {
                                          List<String> list =
                                              (state.dataModel != null)
                                                  ? state
                                                      .dataModel!.casteCategory!
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
                                            crossAxisCount: 2,
                                            label: AppLocalizations.of(context)!
                                                .casteCategory,
                                            options: list,
                                            selected: formGroup
                                                .control('caste_category')
                                                .value,
                                            onChanged: (value) {
                                              formGroup
                                                  .control('caste_category')
                                                  .value = value;
                                            },
                                          );
                                        }),
                                    const SizedBox(height: kPadding * 2),
                                    BlocBuilder<SourceCubit, SourceState>(
                                        buildWhen: ((previous, current) =>
                                            (previous.isLoading !=
                                                current.isLoading) ||
                                            previous.dataModel !=
                                                current.dataModel),
                                        builder: (context, state) {
                                          List<String> list =
                                              (state.dataModel != null)
                                                  ? state
                                                      .dataModel!.keyPopulation!
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
                                            allowMultiSelect: false,
                                            crossAxisCount: 2,
                                            label: AppLocalizations.of(context)!
                                                .keyPopulation,
                                            selectedList: formGroup
                                                .control('key_population')
                                                .value,
                                            options: list,
                                            onChanged: (value) {
                                              if (value.isEmpty) {
                                                formGroup
                                                    .control('key_population')
                                                    .value = null;
                                                return;
                                              }

                                              final listOfValues =
                                                  value.split(',');

                                              formGroup
                                                  .control('key_population')
                                                  .value = listOfValues;
                                            },
                                          );
                                        }),
                                    const SizedBox(height: kPadding * 2),
                                    PrimaryTextField(
                                      formControlName: 'referred_by',
                                      label: AppLocalizations.of(context)!
                                          .referredBy,
                                      prefixIcon: Icons.location_city_outlined,
                                    ),
                                    const SizedBox(height: kPadding * 2),
                                    BlocBuilder<SourceCubit, SourceState>(
                                        buildWhen: ((previous, current) =>
                                            (previous.isLoading !=
                                                current.isLoading) ||
                                            previous.dataModel !=
                                                current.dataModel),
                                        builder: (context, state) {
                                          List<String> list =
                                              (state.dataModel != null)
                                                  ? state.dataModel!
                                                      .referrerSource!
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
                                            crossAxisCount: 2,
                                            label: AppLocalizations.of(context)!
                                                .referrerSource,
                                            options: list,
                                            selected: formGroup
                                                .control('referrer_source')
                                                .value,
                                            onChanged: (value) {
                                              formGroup
                                                  .control('referrer_source')
                                                  .value = value;
                                            },
                                          );
                                        }),
                                    const SizedBox(height: kPadding * 2),
                                    ReactiveValueListenableBuilder<String>(
                                        formControlName: 'referral_block',
                                        builder: (context, control,
                                                child) =>
                                            Visibility(
                                                visible: (formGroup
                                                        .control(
                                                            'referral_block')
                                                        .value) !=
                                                    null,
                                                child: BlocBuilder<SourceCubit,
                                                        SourceState>(
                                                    buildWhen: ((previous,
                                                            current) =>
                                                        (previous
                                                                .isLoading !=
                                                            current
                                                                .isLoading) ||
                                                        (previous.dataModel !=
                                                            current
                                                                .dataModel) ||
                                                        (previous
                                                                .panchayatList !=
                                                            current
                                                                .panchayatList)),
                                                    builder: (context, state) {
                                                      List<String>
                                                          panchayatList =
                                                          state.panchayatList ??
                                                              [];

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
                                                      return TextFieldWithList(
                                                        controlName:
                                                            'referrer_panchayat_code',
                                                        label: AppLocalizations
                                                                .of(context)!
                                                            .referrerPanchayatCode,
                                                        padding:
                                                            EdgeInsets.zero,
                                                        prefixIcon: Icons
                                                            .account_circle_outlined,
                                                        listData: panchayatList,
                                                        allowMultiSelection:
                                                            false,
                                                        onSelected: (value) {
                                                          formGroup
                                                              .control(
                                                                  'referrer_panchayat_code')
                                                              .value = value[0];
                                                        },
                                                        emptyString:
                                                            'No Panchayats available',
                                                      );
                                                    }))),
                                    const SizedBox(height: kPadding * 2),
                                    PrimaryTextField<int?>(
                                      formControlName: 'referred_ward',
                                      label: AppLocalizations.of(context)!
                                          .referredWard,
                                      prefixIcon: Icons.account_circle_outlined,
                                      keyboardType: TextInputType.number,
                                      inputFormatter: [
                                        FilteringTextInputFormatter.digitsOnly,
                                        LengthLimitingTextInputFormatter(2),
                                      ],
                                    ),
                                    const SizedBox(height: kPadding * 2),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          BottomButtonBar(
                            onSave: (_) async {
                              await _onSave(context, formGroup);
                            },
                            nextPage: CaseRouter(
                              caseModel:
                                  context.read<CaseCubit>().selectedCase ??
                                      const Case(),
                              children: const [TBScreeningRoute()],
                            ),
                            enableValidator: false,
                          ),
                          const SizedBox(height: kPadding * 2),
                        ],
                      )));
            })));
  }
}

_loadDistricts(FormGroup formGroup, BuildContext context) {
  return Column(
    children: [
      BlocBuilder<SourceCubit, SourceState>(
          buildWhen: ((previous, current) =>
              (previous.isLoading != current.isLoading) ||
              previous.dataModel != current.dataModel),
          builder: (context, state) {
            List<String> districts = (state.dataModel != null)
                ? state.dataModel!.districts!
                    .map((e) => '${e.district}')
                    .toList()
                : [];

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
              controlName: 'district',
              label: AppLocalizations.of(context)!.district,
              padding: EdgeInsets.zero,
              prefixIcon: Icons.account_circle_outlined,
              listData: districts,
              allowMultiSelection: false,
              onSelected: (value) {
                formGroup.control('district').value = value[0];
              },
              emptyString: 'No Districts available',
            );
          }),
      ReactiveValueListenableBuilder<String>(
          formControlName: 'district',
          builder: (context, control, child) => Visibility(
                visible: (formGroup.control('district').value) != null,
                child: BlocBuilder<SourceCubit, SourceState>(
                    buildWhen: ((previous, current) =>
                        (previous.isLoading != current.isLoading) ||
                        (previous.dataModel != current.dataModel) ||
                        (previous.blockList != current.blockList)),
                    builder: (context, state) {
                      List<String> blockList = state.blockList ?? [];
                      if (state.isLoading ?? false) {
                        return const SizedBox(
                          height: 15,
                          width: 15,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      return Column(
                        children: [
                          const SizedBox(height: kPadding * 2),
                          TextFieldWithList(
                            controlName: 'referral_block',
                            label: AppLocalizations.of(context)!.block,
                            padding: EdgeInsets.zero,
                            prefixIcon: Icons.account_circle_outlined,
                            listData: blockList,
                            allowMultiSelection: false,
                            onSelected: (value) {
                              formGroup.control('referral_block').value =
                                  value[0];
                            },
                            emptyString: 'No Blocks available',
                          ),
                        ],
                      );
                    }),
              )),
      ReactiveValueListenableBuilder<String>(
          formControlName: 'referral_block',
          builder: (context, control, child) => Visibility(
              visible: (formGroup.control('referral_block').value) != null,
              child: BlocBuilder<SourceCubit, SourceState>(
                  buildWhen: ((previous, current) =>
                      (previous.isLoading != current.isLoading) ||
                      (previous.dataModel != current.dataModel) ||
                      (previous.panchayatList != current.panchayatList)),
                  builder: (context, state) {
                    List<String> panchayatList = state.panchayatList ?? [];

                    if (state.isLoading ?? false) {
                      return const SizedBox(
                        height: 15,
                        width: 15,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    return Column(
                      children: [
                        const SizedBox(height: kPadding * 2),
                        TextFieldWithList(
                          controlName: 'panchayat_code',
                          label: AppLocalizations.of(context)!.panchayatCode,
                          padding: EdgeInsets.zero,
                          prefixIcon: Icons.account_circle_outlined,
                          listData: panchayatList,
                          allowMultiSelection: false,
                          onSelected: (value) {
                            formGroup.control('panchayat_code').value =
                                value[0];
                          },
                          emptyString: 'No Panchayats available',
                        ),
                      ],
                    );
                  }))),
      const SizedBox(height: kPadding * 2),
    ],
  );
}
