import 'package:flutter/material.dart';
import 'package:tatpar_orange/configurations/theme/size_constants.dart';
import 'package:tatpar_orange/configurations/theme/typography.dart';

class QuickAction extends StatelessWidget {
  const QuickAction({super.key});

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick Actions',
            style: AppTextStyle.bodyLarge.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: kPadding,
          )
        ],
      );
}
