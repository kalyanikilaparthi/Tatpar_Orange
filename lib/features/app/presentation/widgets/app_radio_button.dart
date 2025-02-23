import 'package:flutter/material.dart';
import 'package:tatpar_orange/features/app/presentation/widgets/radio_items.dart';

import '../../../../configurations/configurations.dart';

class AppRadioButton extends StatelessWidget {
  const AppRadioButton({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(
          kPadding / 2,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(
              height: kPadding,
            ),
            const RadioItems(),
            const SizedBox(height: kPadding / 2),
            const RadioItems(),
            const SizedBox(height: kPadding / 2),
            const RadioItems(),
            const SizedBox(height: kPadding / 2),
            const RadioItems(),
            const SizedBox(height: kPadding / 2),
            const RadioItems(),
          ],
        ),
      );
}
