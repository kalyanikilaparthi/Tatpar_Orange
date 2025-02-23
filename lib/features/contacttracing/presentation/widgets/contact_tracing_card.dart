// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tatpar_orange/configurations/configurations.dart';
import 'package:intl/intl.dart';
import 'package:tatpar_orange/features/case/blocs/source_cubit.dart';
import 'package:tatpar_orange/features/case/data/source_models/diagnosis_data_fields.dart';

import 'package:tatpar_orange/features/contacttracing/models/contact_tracing_model.dart';
import 'package:tatpar_orange/features/home/presentation/widgets/disease_chips.dart';

class ContactTracingCard extends StatelessWidget {
  const ContactTracingCard({super.key, required this.model});

  final ContactTracingModel model;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    //final primaryColor = theme.primaryColor;

    return InkWell(
        onTap: () {
          context.router
              .navigate(ContactTracingRouter(contactTracingModel: model));
        },
        child: Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.background,
            borderRadius: BorderRadius.circular(kPadding),
            border: Border.all(color: AppColors.grey90, width: 0.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 2,
                offset: const Offset(0, 2),
              )
            ],
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: kPadding, vertical: kPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  DiseaseChip(model.screeningOutcome ?? 'Not Screened',
                      color: AppColors.blueLight),
                  const Spacer(),
                  Text(
                    getFormattedDate(model.tptStartDate),
                    style: textTheme.labelMedium?.copyWith(
                      // fontSize: 9,
                      // height: 1.7,
                      // letterSpacing: 0.2,
                      color: AppColors.grey30,
                    ),
                  ),
                  const SizedBox(width: kPadding),
                  // PopupMenuButton<String>(
                  //   shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(10.0),
                  //   ),
                  //   icon: const Icon(Icons.more_vert),
                  //   offset: const Offset(30, 30), // Kebab icon
                  //   onSelected: (String value) async {
                  //     if (value == 'reassign') {
                  //       // context.router.navigate(
                  //       // CaseRouter(
                  //       //     model: model,
                  //       //     children: const [ReferralDetailsRoute()]),
                  //       //);
                  //     }
                  //   },
                  //   itemBuilder: (BuildContext context) =>
                  //       <PopupMenuEntry<String>>[
                  //     PopupMenuItem<String>(
                  //       value: 'reassign',
                  //       child: Container(
                  //         width: double.infinity,
                  //         alignment: Alignment.center,
                  //         child: Text(
                  //           'Reassign',
                  //           style: textTheme.labelMedium?.copyWith(
                  //             fontSize: 14,
                  //             height: 1.7,
                  //             letterSpacing: 0.2,
                  //             color: AppColors.grey30,
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //     PopupMenuItem<String>(
                  //       value: 'edit',
                  //       child: Container(
                  //         width: double.infinity,
                  //         alignment: Alignment.center,
                  //         child: Text(
                  //           'Edit',
                  //           style: textTheme.labelMedium?.copyWith(
                  //             fontSize: 14,
                  //             height: 1.7,
                  //             letterSpacing: 0.2,
                  //             color: AppColors.grey30,
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: kPadding, vertical: kPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${model.tbContactName}\t•\t ${model.age}',
                      style: textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        height: 1.14,
                        letterSpacing: 0.2,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: kPadding * 0.75,
                    ),
                    Text(
                      'TPT Regimen:\t ${calculateTPTRegimen(context)}', //${model.hub.toString()}',
                      style: textTheme.bodyMedium?.copyWith(
                        height: 1.33,
                        letterSpacing: 0.2,
                      ),
                    ),
                    const SizedBox(
                      height: kPadding * 0.75,
                    ),
                    Text(
                      'TPT Outcome:\t ${model.tptOutcome}', //${model.hub.toString()}',
                      style: textTheme.bodyMedium?.copyWith(
                        height: 1.33,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ],
                )),
          ]),
        ));
  }

  // String calculateScreeningStatus() {
  //   if (model.tbScreeningOutcome == "No Symptom") {
  //     return 'Scr Neg';
  //   } else if (model.tbScreeningOutcome == "") {
  //     return 'Scr Not Screened';
  //   } else {
  //     return 'Scr Pos';
  //   }
  // }
  String? calculateTPTRegimen(BuildContext context) {
    final tptRegimen = model.selectedTptRegimen;
    final tptRegimenData =
        context.read<SourceCubit>().state.diagnosisData?.tptRegimen?.firstWhere(
              (element) => element.id == tptRegimen,
              orElse: () => const TPTRegimen(name: null),
            );
    return tptRegimenData!.name.toString();
  }

  String getFormattedDate(DateTime? date) {
    if (date == null) return '';
    return DateFormat('dd MMM yy').format(date);
  }
}
