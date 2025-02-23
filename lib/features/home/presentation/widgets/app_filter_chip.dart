import 'package:flutter/material.dart';
import 'package:tatpar_orange/configurations/theme/colors.dart';
import 'package:tatpar_orange/configurations/theme/size_constants.dart';
import 'package:tatpar_orange/configurations/theme/typography.dart';

class AppFilterChip extends StatelessWidget {
  const AppFilterChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onCLicked,
    this.selectedTextColor = AppColors.blueDark,
    this.selectedBgColor = AppColors.blueLight,
  });

  final String label;
  final bool isSelected;
  final void Function() onCLicked;
  final Color selectedTextColor;
  final Color selectedBgColor;

  @override
  Widget build(BuildContext context) {
    Color bgColor = Colors.white, textColor = AppColors.grey50;
    if (isSelected) {
      bgColor = selectedBgColor;
      textColor = selectedTextColor;
    }
    return GestureDetector(
      onTap: onCLicked,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(
            horizontal: kPadding * 2, vertical: kPadding * 0.75),
        decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: textColor)),
        child: Text(
          label,
          maxLines: 1,
          style: AppTextStyle.labelMedium
              .copyWith(fontWeight: FontWeight.w600, color: textColor),
        ),
      ),
    );
  }
}
