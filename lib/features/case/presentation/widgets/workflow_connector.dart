import 'package:flutter/material.dart';
import 'package:tatpar_orange/configurations/constants/assets.gen.dart';

import '../../../../configurations/theme/colors.dart';

class WorkflowConnector extends StatelessWidget {
  const WorkflowConnector(
      {super.key,
      this.completed = false,
      this.inProgress = false,
      this.isFinal = false});

  final bool completed;
  final bool inProgress;
  final bool isFinal;

  // width 20
  @override
  Widget build(BuildContext context) {
    if (completed) {
      return Assets.icons.compleatedCaseWorkflow.svg();
    }
    if (inProgress) {
      return Assets.icons.currentCaseWofkflow.svg();
    }
    if (isFinal) {
      return Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.grayDark, width: 2)),
      );
    }
    // common case
    return Assets.icons.pendingCaseWofkflow.svg();
  }
}
