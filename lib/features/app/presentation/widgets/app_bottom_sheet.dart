import 'package:flutter/material.dart';
import 'package:tatpar_orange/configurations/theme/colors.dart';
import 'package:tatpar_orange/configurations/theme/size_constants.dart';

import '../../data/app_bottom_sheet_item.dart';

class AppBottomSheet extends StatelessWidget {
  const AppBottomSheet({super.key, required this.items});

  final List<AppBottomSheetItem> items;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: kPadding * 1.875,
          vertical: kPadding * 3,
        ),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: items.length,
          itemBuilder: (context, index) => Column(
            children: [
              GestureDetector(
                onTap: items[index].onTap,
                child: Row(
                  children: [
                    items[index].icon,
                    const SizedBox(
                      width: kPadding * 3,
                    ),
                    Text(
                      items[index].title,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: AppColors.black2,
                          fontWeight: FontWeight.w600,
                          height: 1.85,
                          wordSpacing: 0.46),
                    ),
                  ],
                ),
              ),
              if (index != items.length - 1)
                const Divider(
                  height: kPadding * 4,
                ),
            ],
          ),
        ),
      );
}
