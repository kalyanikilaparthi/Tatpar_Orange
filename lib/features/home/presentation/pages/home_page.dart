import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tatpar_orange/features/case/blocs/case_cubit.dart';
import 'package:tatpar_orange/features/home/presentation/widgets/home_action_card.dart';

import '../../../../configurations/configurations.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kPadding * 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: kPadding * 2,
              ),
              CardButton(
                icon: Icons.add_photo_alternate,
                title: 'Add Referral',
                subText: 'Add a new case',
                action: () {
                  context.read<CaseCubit>().resetSelectedCase();

                  context.router.navigate(const BasicDetails());
                  // showModalBottomSheet(context: context, builder: (BuildContext context) => const AddNotificationBottomSheet());
                },
              ),
              const SizedBox(
                height: kPadding * 2,
              ),

              const SizedBox(
                height: kPadding * 5,
              ),
              // const QuickAction(),
              // const LoginRegisterTab(),
              // GridView(
              //   shrinkWrap: true,
              //   physics: const NeverScrollableScrollPhysics(),
              //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              //       crossAxisCount: 2,
              //       crossAxisSpacing: 20,
              //       mainAxisSpacing: 20,
              //       childAspectRatio: 1.9),
              //   children: List.generate(
              //     6,
              //     (index) => QuickActionButton(
              //       icon: Icons.note_add,
              //       text: quickAction[index],
              //     ),
              //   ),
              // ),
              const SizedBox(
                height: kPadding * 2,
              ),
            ],
          ),
        ),
      );
}
