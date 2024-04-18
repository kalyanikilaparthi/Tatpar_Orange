// ignore_for_file: depend_on_referenced_packages

import 'package:djangoflow_app/djangoflow_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_builder/progress_builder.dart';
import 'package:tatpar_acf/configurations/configurations.dart';
import 'package:intl/intl.dart';
import 'package:tatpar_acf/features/authentication/blocs/auth_cubit.dart';
import 'package:tatpar_acf/features/case/blocs/case_list_cubit.dart';
import 'package:tatpar_acf/features/case/data/models/case_model.dart';
import 'package:tatpar_acf/features/case/data/models/subordinates_model.dart';
import 'package:tatpar_acf/features/home/presentation/widgets/disease_chips.dart';

class CaseCard extends StatelessWidget {
  const CaseCard({super.key, required this.caseModel});

  final Case caseModel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final primaryColor = theme.primaryColor;

    return InkWell(
      onTap: () {
        context.router.navigate(
          CaseRouter(
            caseModel: caseModel,
          ),
        );
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: kPadding * 1.5, vertical: kPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  DiseaseChip('Referral', color: AppColors.blueLight),
                  Spacer(),
                  Text(
                    'Created on ${getFormattedDate(caseModel.createdAt)}',
                    style: textTheme.labelMedium?.copyWith(
                      fontSize: 9,
                      height: 1.7,
                      letterSpacing: 0.2,
                      color: AppColors.grey30,
                    ),
                  ),
                  const SizedBox(width: kPadding),
                  const Icon(Icons.more_horiz_rounded),
                  const SizedBox(width: kPadding * 0.5)
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: kPadding),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: kPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          // '${caseModel.patient?.name}\t•\t ${caseModel.patient?.gender},${caseModel.patient?.age}' ??
                          'Vineeth Singh\t•\tM,\t35',
                          style: textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                            height: 1.14,
                            letterSpacing: 0.2,
                            color: Colors.black,
                          ),
                        ),
                        // if (caseModel.assignedTo != null)
                        ...[
                          const SizedBox(height: kPadding * 0.75),
                          Text(
                            'Panchayat • Block',
                            style: textTheme.bodyMedium?.copyWith(
                              height: 1.33,
                              letterSpacing: 0.2,
                            ),
                          ),
                        ],
                        const SizedBox(
                          height: kPadding * 0.75,
                        ),
                        Text(
                          'Scr: Amit Kumar • Ref: Amit Kumar', //${caseModel.hub.toString()}',
                          style: textTheme.bodyMedium?.copyWith(
                            height: 1.33,
                            letterSpacing: 0.2,
                          ),
                        ),
                      ],
                    ),
                  )),
                  const Icon(Icons.phone, color: AppColors.blueMedium)
                ],
              ),
            ),
            // Container(
            //   height: 30,
            //   margin: const EdgeInsets.all(kPadding * 1.5),
            //   child: ListView.separated(
            //       scrollDirection: Axis.horizontal,
            //       itemCount: workingStatusList.length,
            //       itemBuilder: (_, index) {
            //         final disease = workingStatusList[index];
            //         return DiseaseChip(
            //           disease,
            //           color: getFormCompletedStatus(disease)
            //               ? AppColors.greenLight
            //               : null,
            //         );
            //       },
            //       separatorBuilder: (_, __) =>
            //           const SizedBox(width: kPadding * 0.75)),
            // ),
            // if (caseModel.assignedTo == null) ...[
            //   const SizedBox(height: kPadding * 0.75),
            //   LinearProgressBuilder(
            //     builder: (context, action, error) => GestureDetector(
            //       onTap: action,
            //       child: Container(
            //         padding:
            //             const EdgeInsets.symmetric(vertical: kPadding * 1.25),
            //         decoration: BoxDecoration(
            //           color: theme.colorScheme.secondary,
            //           borderRadius: const BorderRadius.vertical(
            //             bottom: Radius.circular(kPadding),
            //           ),
            //         ),
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             Icon(
            //               Icons.person_add_alt_1_outlined,
            //               color: primaryColor,
            //             ),
            //             const SizedBox(width: kPadding),
            //             Text(
            //               'Assign Case',
            //               style: Theme.of(context)
            //                   .textTheme
            //                   .labelMedium
            //                   ?.copyWith(
            //                       color: primaryColor,
            //                       fontWeight: FontWeight.w600),
            //             ),
            //             const SizedBox(width: kPadding),
            //             Icon(Icons.arrow_forward, size: 16, color: primaryColor)
            //           ],
            //         ),
            //       ),
            //     ),
            //     action: (progress) async {
            //       final user = AuthCubit.instance.state.user;
            //       if (user == null) {
            //         DjangoflowAppSnackbar.showInfo(
            //             'Session Expired. Please login again to assign case');
            //         return;
            //       }
            //       // context.router.navigate(
            //       //     AssignCaseOptionsDialogRoute(caseModel: caseModel));
            //       if (user.isSupervisor) {
            //         // context.router.navigate(AssignCaseBottomSheetRoute(caseID: caseModel.id!));
            //       } else {
            //         await context.read<CaseListCubit>().assignCase(
            //             caseModel.id!, SubordinatesModel(id: user.id));
            //       }
            //     },
            //   )
            // ]
          ],
        ),
      ),
    );
  }

  String getFormattedDate(DateTime? date) {
    if (date == null) return '';
    return DateFormat('dd MMM yyyy').format(date);
  }

  bool getFormCompletedStatus(String key) {
    switch (key) {
      case 'Referral':
        return caseModel.referralDetailsStatus;
      case 'TB Screening':
        return caseModel.tbScreeningStatus;
      case 'Mental Health Screening':
        return caseModel.mentalHealthScreeningStatus;
      case 'Diagnosis':
        return caseModel.diagnosisStatus;
      case 'Treatment':
        return caseModel.treatmentStatus;
      case 'Outcome':
        return caseModel.outcomeStatus;
      case 'Contact Tracing':
        return caseModel.contactTracingStatus;

      default:
        return false;
    }
  }
}
