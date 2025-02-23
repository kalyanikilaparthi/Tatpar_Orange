import 'package:flutter/material.dart';
import 'package:tatpar_orange/configurations/theme/colors.dart';
import 'package:tatpar_orange/configurations/theme/size_constants.dart';

class CasesFilterTabItem extends StatelessWidget {
  const CasesFilterTabItem(
      {super.key,
      required this.label,
      required this.isSelected,
      required this.onTap});

  final String label;
  final bool isSelected;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(kPadding * 1.5),
          decoration: BoxDecoration(
              color: isSelected ? Colors.white : Colors.transparent,
              border: isSelected
                  ? Border(
                      left: BorderSide(
                          color: Theme.of(context).primaryColor, width: 2))
                  : null),
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: isSelected
                    ? Theme.of(context).primaryColor
                    : AppColors.grey50,
                height: 1.25),
          ),
        ),
      );
}
