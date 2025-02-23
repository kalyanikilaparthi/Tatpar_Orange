import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tatpar_orange/configurations/configurations.dart';
import 'package:tatpar_orange/features/authentication/presentation/widgets/auth_button.dart';
import 'package:tatpar_orange/features/case/blocs/case_cubit.dart';
import 'package:tatpar_orange/features/contacttracing/models/contact_tracing_model.dart';
import 'package:tatpar_orange/features/contacttracing/presentation/widgets/contact_tracing_card.dart';
import 'package:tatpar_orange/features/referral/presentation/widgets/case_app_bar.dart';

@RoutePage()
class ContactTracingListPage extends StatelessWidget {
  const ContactTracingListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cubit = context.read<CaseCubit>();

    return PopScope(
      onPopInvoked: (didPop) {
        context.router.pushAndPopUntil(const CaseProfileRoute(),
            predicate: (Route<dynamic> route) => false);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: CaseAppBar(
          'Contact Tracing List',
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
        floatingActionButton: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.1),
          child: CircleAvatar(
            radius: 30,
            backgroundColor: AppColors.blueMedium,
            child: Center(
              child: IconButton(
                icon: const Icon(
                  Icons.add,
                  weight: 300,
                  color: Colors.white,
                  size: 25,
                ),
                onPressed: () {
                  context.router.navigate(ContactTracingRouter(
                    contactTracingModel: const ContactTracingModel(),
                  ));
                },
              ),
            ),
          ),
        ),
        //  ),
        body: BlocBuilder<CaseCubit, CaseState>(
          buildWhen: (previous, current) => previous != current,
          builder: (context, state) {
            if (state.isLoading ||
                (state.caseWorkedUpon.contactTracingList != null &&
                    state.caseWorkedUpon.contactTracingList!.isNotEmpty &&
                    state.contactTracingList.isEmpty)) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return RefreshIndicator(
                onRefresh: () async {
                  cubit.searchCases('');
                  await cubit.getContactTracingListData();
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: kPadding, left: kPadding * 2, right: kPadding * 2),
                  child: Column(
                    children: [
                      TextField(
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          hintText: 'Search by name',
                        ),
                        onChanged: (value) {
                          cubit.searchCases(value);
                        },
                      ),
                      const SizedBox(height: kPadding * 2),
                      Expanded(
                        child: state.contactTracingList.isEmpty ||
                                (state.filteredContacts != null &&
                                    state.filteredContacts!.isEmpty)
                            ? ListView(
                                children: [
                                  SingleChildScrollView(
                                    child: Padding(
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
                                  ),
                                ],
                              )
                            : ListView.builder(
                                itemBuilder: (context, index) {
                                  final model = state.filteredContacts == null
                                      ? state.contactTracingList[index]
                                      : state.filteredContacts![index];
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: kPadding * 2),
                                    child: ContactTracingCard(model: model),
                                  );
                                },
                                itemCount: state.filteredContacts == null
                                    ? state.contactTracingList.length
                                    : state.filteredContacts!.length,
                              ),
                      ),
                      AuthButton(
                        text: 'Next',
                        onClick: () {
                          context.router.navigate(const OutcomeRoute());
                        },
                      ),
                      const SizedBox(height: kPadding * 2),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
