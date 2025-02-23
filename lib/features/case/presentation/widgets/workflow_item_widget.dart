import 'package:flutter/material.dart';
import 'package:tatpar_orange/configurations/configurations.dart';

import '../../data/case_models/workflow_item.dart';

class WorkFlowItemWidget extends StatelessWidget {
  const WorkFlowItemWidget({
    super.key,
    required this.workflow,
    required this.inProgress,
    required this.completed,
  });

  final WorkflowItem workflow;
  final bool inProgress;
  final bool completed;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () {
          context.router.navigate(workflow.route);
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: kPadding * 2),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        workflow.title,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                      ),
                      const SizedBox(width: kPadding),
                      if (inProgress)
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.4),
                              shape: BoxShape.circle),
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: const BoxDecoration(
                                color: Colors.red, shape: BoxShape.circle),
                          ),
                        )
                    ],
                  ),
                  const SizedBox(height: kPadding * 0.5),
                  Text(
                    workflow.description,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: completed
                            ? Theme.of(context).colorScheme.onSurface
                            : null),
                  ),
                  const SizedBox(
                    height: kPadding * 3,
                  )
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded),
          ],
        ),
      );
}
