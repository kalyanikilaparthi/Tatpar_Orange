import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tatpar_orange/configurations/configurations.dart';
import 'package:tatpar_orange/features/case/blocs/case_cubit.dart';
import 'package:tatpar_orange/features/case/data/repos/case_repo.dart';

import '../../blocs/case_list_cubit.dart';
import '../../data/case_models/case_model.dart';

@RoutePage(name: 'CaseRouter')
class CaseRouterPage extends StatelessWidget {
  const CaseRouterPage({
    super.key,
    required this.caseModel,
  });

  final Case caseModel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CaseCubit(
        caseRepo: context.read<CaseRepo>(),
        caseModel: caseModel,
      ),
      child: BlocListener<CaseCubit, CaseState>(
        listener: (context, state) {
          context.read<CaseListCubit>().updateSingleCase(state.caseWorkedUpon);
        },
        listenWhen: (previous, current) =>
            previous.caseWorkedUpon != current.caseWorkedUpon,
        child: const AutoRouter(),
      ),
    );
  }
}
