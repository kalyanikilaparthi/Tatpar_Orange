import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:tatpar_orange/configurations/configurations.dart';

class InfoTile extends StatelessWidget {
  const InfoTile(this.fieldName,
      {super.key, required this.fieldValue, this.fieldColor, this.useExpandedDots = true});

  final String fieldName;
  final String fieldValue;
  final Color? fieldColor;
  final bool useExpandedDots;

  @override
  Widget build(BuildContext context) {
    return Row(
        children: [
          Text(
            fieldName,
            style: Theme.of(context)
                .textTheme
                .labelMedium
                ?.copyWith(height: 2, letterSpacing: 0.5),
          ),
          const SizedBox(width: kPadding),
          useExpandedDots ? const Expanded(
            child: DottedLine(
              direction: Axis.horizontal,
              alignment: WrapAlignment.center,
              lineLength: double.infinity,
              lineThickness: 1.0,
              dashLength: 4.0,
              dashColor: Colors.black,
              dashRadius: 0.0,
              dashGapLength: 4.0,
              dashGapColor: Colors.transparent,
              dashGapRadius: 0.0,
            ),
          ) : const SizedBox(
            width: 80,
            child: DottedLine(
              direction: Axis.horizontal,
              alignment: WrapAlignment.center,
              lineLength: double.infinity,
              lineThickness: 1.0,
              dashLength: 4.0,
              dashColor: Colors.black,
              dashRadius: 0.0,
              dashGapLength: 4.0,
              dashGapColor: Colors.transparent,
              dashGapRadius: 0.0,
            ),
          ),
          const SizedBox(width: kPadding),
          Expanded(
            child: Text(
              fieldValue,
              softWrap: true,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    height: 2,
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.w600,
                    color: fieldColor,
                  ),
            ),
          ),
        ],
      );
  }
}
