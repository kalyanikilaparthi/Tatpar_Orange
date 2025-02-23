import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tatpar_orange/configurations/configurations.dart';
import 'package:tatpar_orange/features/case/blocs/case_cubit.dart';
import 'package:tatpar_orange/features/referral/presentation/widgets/user_name_bar.dart';

class CaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CaseAppBar(this.title, {required this.onClick, super.key});

  final String title;
  final VoidCallback? onClick;

  @override
  Widget build(BuildContext context) => AppBar(
        leadingWidth: kPadding * 4,
        automaticallyImplyLeading: true,
        leading: IconButton(
            onPressed: () {
              context.router.pop();
            },
            icon: const Icon(Icons.arrow_back)),
        elevation: 1,
        backgroundColor: AppColors.grayLight,
        title: Text(
          title,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              height: 1.2,
              letterSpacing: 0.5),
        ),
        actions: [
          IconButton(onPressed: onClick, icon: const Icon(Icons.close))
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight + kPadding * 2.5),
          child: UserNameBar(
            context.read<CaseCubit>().state.caseWorkedUpon.referralName ?? '',
          ),
        ),
      );

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight + kPadding * 2.5);
}
