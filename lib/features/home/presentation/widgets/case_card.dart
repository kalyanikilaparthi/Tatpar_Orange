// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tatpar_orange/configurations/configurations.dart';
import 'package:tatpar_orange/features/case/blocs/case_list_cubit.dart';
import 'package:tatpar_orange/features/case/data/case_models/case_model.dart';
import 'package:tatpar_orange/features/home/presentation/widgets/disease_chips.dart';
import 'package:url_launcher/url_launcher.dart';

class CaseCard extends StatelessWidget {
  const CaseCard({super.key, required this.caseModel});

  final Case caseModel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    //final primaryColor = theme.primaryColor;

    return InkWell(
      onTap: () {
        context.router.navigate(
          CaseRouter(caseModel: caseModel),
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
              padding: const EdgeInsets.only(
                  left: kPadding,
                  top: kPadding,
                  right: kPadding,
                  bottom: kPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  DiseaseChip(calculateScreeningStatus(),
                      color: calculateScreeningStatus() == 'Scr Neg'
                          ? AppColors.redLight
                          : AppColors.primary),
                  const Spacer(),
                  Text(
                    getFormattedDate(caseModel.createdOn),
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
                  //       context.router.navigate(
                  //         CaseRouter(
                  //             caseModel: caseModel,
                  //             children: const [ReferralDetailsRoute()]),
                  //       );
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
              padding: const EdgeInsets.symmetric(horizontal: kPadding),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(bottom: kPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${caseModel.referralName}\t• ${caseModel.gender},\t${caseModel.age}',
                          style: textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                            height: 1.33,
                            letterSpacing: 0.2,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: kPadding * 0.75),
                        Text(
                          'ID: ${caseModel.referralId}',
                          style: textTheme.labelMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: kPadding * 0.75),
                        Text(
                          '${caseModel.panchayat}',
                          style: textTheme.bodyMedium?.copyWith(
                            height: 1.33,
                            letterSpacing: 0.2,
                          ),
                        ),

                        const SizedBox(
                          height: kPadding * 0.75,
                        ),
                        RichText(
                          textAlign: TextAlign.start,
                          text: TextSpan(
                            text: '',
                            children: [
                              TextSpan(
                                text: 'Scr by:\t',
                                style: textTheme.bodyMedium?.copyWith(
                                    height: 1.33,
                                    letterSpacing: 0.2,
                                    fontWeight: FontWeight.w600),
                              ),
                              TextSpan(
                                text: '${caseModel.screenedBy} \t \t',
                                style: textTheme.bodyMedium?.copyWith(
                                  height: 1.33,
                                  letterSpacing: 0.2,
                                ),
                              ),
                              TextSpan(
                                text: 'Ref by:\t',
                                style: textTheme.bodyMedium?.copyWith(
                                    height: 1.33,
                                    letterSpacing: 0.2,
                                    fontWeight: FontWeight.w600),
                              ),
                              TextSpan(
                                text: '${caseModel.referredBy}',
                                style: textTheme.bodyMedium?.copyWith(
                                  height: 1.33,
                                  letterSpacing: 0.2,
                                ),
                              )
                            ],
                          ),
                        ),
                        // Text(
                        //   'Scr by: ${caseModel.screenedBy} • Ref by: ${caseModel.referredBy}', //${caseModel.hub.toString()}',
                        //   style: textTheme.bodyMedium?.copyWith(
                        //     height: 1.33,
                        //     letterSpacing: 0.2,
                        //   ),
                        // ),
                      ],
                    ),
                  )),
                  Column(
                    children: [
                      IconButton(
                        onPressed: () async {
                          String url = '${caseModel.referralMobileNumber}';
                          final Uri launchUri = Uri(
                            scheme: 'tel',
                            path: url,
                          );
                          await launchUrl(launchUri);
                        },
                        icon: const Icon(Icons.phone, color: AppColors.primary),
                      ),
                      IconButton(
                        onPressed: () async {
                          showDialog(
                            context: context,
                            builder: (context) => SizedBox(
                              width: kPadding * 40,
                              height: kPadding * 50,
                              child: AlertDialog(
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                  const SizedBox(height: kPadding),
                                  ElevatedButton(
                                    onPressed: () async {
                                      final caseID = caseModel.id;
                                      final caseListCubit =
                                          context.read<CaseListCubit>();
                                      await caseListCubit.deleteCase(caseID!);
                                      WidgetsBinding.instance
                                          .addPostFrameCallback(
                                              (_) => Navigator.pop(context));
                                    },
                                    child: const Text('Yes'),
                                  ),
                                ],
                                title: const Text(
                                    'Are you sure you want to Delete?'),
                              ),
                            ),
                          );
                        },
                        icon:
                            const Icon(Icons.delete, color: AppColors.redDark),
                      ),
                    ],
                  )
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

  String calculateScreeningStatus() {
    if (caseModel.tbScreeningOutcome == "No Symptom") {
      return 'Scr Neg';
    } else if (caseModel.tbScreeningOutcome == "") {
      return 'Referral';
    } else {
      return 'Scr Pos';
    }
  }

  String getFormattedDate(DateTime? date) {
    if (date == null) return '';
    return DateFormat('dd MMM yy').format(date);
  }

  // bool getFormCompletedStatus(String key) {
  //   switch (key) {
  //     case 'Referral':
  //       return caseModel.referralDetailsStatus;
  //     case 'TB Screening':
  //       return caseModel.tbScreeningStatus;
  //     case 'Mental Health Screening':
  //       return caseModel.mentalHealthScreeningStatus;
  //     case 'Diagnosis':
  //       return caseModel.diagnosisStatus;
  //     case 'Treatment':
  //       return caseModel.treatmentStatus;
  //     case 'Outcome':
  //       return caseModel.outcomeStatus;
  //     case 'Contact Tracing':
  //       return caseModel.contactTracingStatus;

  //     default:
  //       return false;
  //   }
  // }
}
