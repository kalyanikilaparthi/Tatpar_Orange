import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tatpar_orange/features/case/blocs/case_cubit.dart';
import 'package:tatpar_orange/features/case/presentation/widgets/case_profile_card.dart';
import 'package:tatpar_orange/features/referral/presentation/widgets/case_app_bar.dart';
import 'package:timelines_plus/timelines_plus.dart';

import '../../../../configurations/configurations.dart';
import '../widgets/workflow_connector.dart';
import '../widgets/workflow_item_widget.dart';

@RoutePage()
class CaseProfilePage extends StatelessWidget {
  const CaseProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final caseCubit = context.read<CaseCubit>();
    final workflows = caseCubit.workflows(caseCubit.state.caseWorkedUpon);
    return PopScope(
      onPopInvoked: (didPop) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          context.router.pushAndPopUntil(
            const AppHomeRoute(children: [CasesRoute()]),
            predicate: (Route<dynamic> route) => false,
          );
        });
      },
      child: Scaffold(
        appBar: CaseAppBar(
          'Case Profile',
          onClick: () {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.router.pushAndPopUntil(
                  const AppHomeRoute(children: [CasesRoute()]),
                  predicate: (Route<dynamic> route) => false);
            });
          },
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kPadding * 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: kPadding),
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Referral ID:\t${caseCubit.state.caseWorkedUpon.referralId}',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(
                                fontSize: 12,
                                color: Theme.of(context).colorScheme.primary,
                                fontFamily: FontFamily.poppins),
                      ),
                    ),
                    BlocBuilder<CaseCubit, CaseState>(
                      builder: (context, state) {
                        final caseWorkedUpon = state.caseWorkedUpon;
                        return Stack(
                          children: [
                            CaseProfileCard(
                              patientName:
                                  caseWorkedUpon.referralName ?? 'Unknown',
                              mobileNumber:
                                  caseWorkedUpon.referralMobileNumber ?? '',
                              panchayat:
                                  (caseWorkedUpon.panchayat ?? '').toString(),
                              district:
                                  (caseWorkedUpon.district ?? '').toString(),
                              screeningStatus:
                                  (caseWorkedUpon.tbScreeningOutcome ?? '')
                                      .toString(),
                              rifResistance:
                                  (caseWorkedUpon.dstRifResistanceResult ==
                                              'Detected'
                                          ? 'RR'
                                          : ''),
                              statusAfterDx:
                                  (caseWorkedUpon.statusAfterDx ?? '')
                                      .toString(),
                              treatmentOutcome:
                                  (caseWorkedUpon.treatmentOutcome ?? '')
                                      .toString(),
                            ),
                            Positioned(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: kPadding * 0.25,
                                        horizontal: kPadding),
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        borderRadius: BorderRadius.circular(
                                            kPadding * 0.5)),
                                    child: Text(
                                      'Active',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            fontSize: 13,
                                            // height: 2.4,
                                            fontFamily: FontFamily.poppins,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimary,
                                          ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: kPadding * 2),
                    Text(
                      'Work Flow',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          height: 1.7,
                          letterSpacing: 0.5),
                    ),
                    const SizedBox(height: kPadding * 3),
                    BlocBuilder<CaseCubit, CaseState>(
                      builder: (context, state) => Expanded(
                        child: Timeline.tileBuilder(
                          builder: TimelineTileBuilder.connected(
                            contentsAlign: ContentsAlign.basic,
                            contentsBuilder: (context, index) {
                              final item = workflows[index];
                              return WorkFlowItemWidget(
                                workflow: item,
                                completed: item.status,
                                inProgress: item.inProgress,
                              );
                            },
                            indicatorBuilder: (context, index) {
                              final item = workflows[index];
                              return WorkflowConnector(
                                completed: item.status,
                                inProgress: item.inProgress,
                                isFinal: index == workflows.length - 1,
                              );
                            },
                            connectorBuilder: (context, index, t) {
                              final item = workflows[index];
                              final nextItem = index < workflows.length - 1
                                  ? workflows[index + 1]
                                  : null;
                              if (item.status && nextItem?.status == true) {
                                return SolidLineConnector(
                                  color: Theme.of(context).primaryColor,
                                  thickness: 2,
                                );
                              }
                              return DashedLineConnector(
                                color: item.status
                                    ? Theme.of(context).primaryColor
                                    : Theme.of(context).colorScheme.onSurface,
                                gap: kPadding,
                              );
                            },
                            itemCount: workflows.length,
                            nodePositionBuilder: (context, node) => 0,
                            indicatorPositionBuilder: (context, node) => 0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  // context.router.navigate(const CaseBasicDetailsRoute());
                },
                child: Container(
                  height: 48,
                  margin: const EdgeInsets.only(
                      top: kPadding * 2, bottom: kPadding * 3),
                  color: Theme.of(context).primaryColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Next',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                                fontSize: 15,
                                height: 1.06,
                                wordSpacing: 0.2,
                                color: Theme.of(context).colorScheme.onPrimary),
                      ),
                      const SizedBox(width: kPadding),
                      Icon(
                        Icons.arrow_forward,
                        color: Theme.of(context).colorScheme.onPrimary,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
