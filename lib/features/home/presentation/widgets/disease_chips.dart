import 'package:flutter/material.dart';
import 'package:tatpar_orange/configurations/theme/colors.dart';
import 'package:tatpar_orange/configurations/theme/size_constants.dart';

class DiseaseChip extends StatelessWidget {
  const DiseaseChip(this.text, {super.key, this.color});

  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(
            vertical: kPadding / 1.5, horizontal: kPadding),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color ?? AppColors.grayLight2,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w500,
              height: 1.33,
              letterSpacing: 0.3,
              color: Colors.black),
        ),
      );
}
