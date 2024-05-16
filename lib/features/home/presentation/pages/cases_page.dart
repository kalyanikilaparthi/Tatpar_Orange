import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tatpar_acf/configurations/configurations.dart';
import 'package:tatpar_acf/features/authentication/blocs/auth_cubit.dart';
import 'package:tatpar_acf/features/case/blocs/case_list_cubit.dart';

import '../widgets/case_card.dart';

@RoutePage()
class CasesPage extends StatelessWidget {
  const CasesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cubit = context.read<CaseListCubit>();
    return Scaffold(
      body: BlocBuilder<CaseListCubit, CaseListState>(
        builder: (context, state) => state.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : RefreshIndicator(
                onRefresh: () async {
                  cubit.searchCases('');
                  cubit.getCasesForHealthWorker();
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: kPadding, horizontal: kPadding * 2),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.search),
                                hintText: 'Search by name or no.',
                              ),
                              onChanged: (value) {
                                cubit.searchCases(value);
                              },
                            ),
                          ),
                          const SizedBox(width: kPadding),
                          GestureDetector(
                            onTap: () {
                              context.router
                                  .navigate(const CasesFilterDialogRoute());
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: AppColors.blueMedium,
                                  borderRadius: BorderRadius.circular(4)),
                              padding: const EdgeInsets.symmetric(
                                  vertical: kPadding * 1.8,
                                  horizontal: kPadding * 1.8),
                              child: const Icon(
                                Icons.filter_alt_outlined,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    // SizedBox(
                    //   height: 70,
                    //   child: Padding(
                    //     padding: const EdgeInsets.symmetric(
                    //         vertical: kPadding * 1.5, horizontal: kPadding * 2),
                    //     child: ListView.separated(
                    //       scrollDirection: Axis.horizontal,
                    //       itemCount: FilterShortCut.values.length,
                    //       itemBuilder: (_, index) => AppFilterChip(
                    //           label: FilterShortCut.values[index].label,
                    //           isSelected: (state.casesFilter.selectedShortCut ==
                    //               FilterShortCut.values[index]),
                    //           onCLicked: () => cubit.applyPendingStageFilter(
                    //               FilterShortCut.values[index])),
                    //       separatorBuilder: (BuildContext context, int index) =>
                    //           const SizedBox(
                    //         width: kPadding,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    if (state.cases.isEmpty ||
                        (state.filteredCases != null &&
                            state.filteredCases!.isEmpty))
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: kPadding * 10,
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.search_off,
                              size: kPadding * 8,
                              color: theme.primaryColor,
                            ),
                            const SizedBox(
                              height: kPadding,
                            ),
                            Text(
                              'No Cases found',
                              style: theme.textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      ),
                    Expanded(
                      child: state.filteredCases == null
                          ? ListView.builder(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: kPadding * 2),
                              itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.only(
                                  bottom: kPadding * 2,
                                ),
                                child: CaseCard(
                                  caseModel: state.cases[index],
                                ),
                              ),
                              itemCount: state.cases.length,
                            )
                          : ListView.builder(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: kPadding * 2),
                              itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.only(
                                  bottom: kPadding * 2,
                                ),
                                child: CaseCard(
                                  caseModel: state.filteredCases![index],
                                ),
                              ),
                              itemCount: state.filteredCases!.length,
                            ),
                    ),
                    if (context.read<AuthCubit>().state.user?.isSupervisor ??
                        false)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: kPadding * 2,
                          vertical: kPadding / 2,
                        ),
                        child: Row(
                          children: [
                            const Text('Assigned to me cases only'),
                            const Spacer(),
                            Switch(
                              value: true,
                              onChanged: (value) {},
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
      ),
    );
  }
}
