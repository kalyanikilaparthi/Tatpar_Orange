import 'package:djangoflow_app/djangoflow_app.dart';
import 'package:flutter/material.dart';
import 'package:tatpar_orange/configurations/theme/colors.dart';
import 'package:tatpar_orange/configurations/theme/size_constants.dart';

class QuickActionButton extends StatelessWidget {
  const QuickActionButton(
      {super.key, required this.icon, required this.text, this.onClick});

  final IconData icon;
  final String text;
  final Function()? onClick;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onClick ??
            () {
              DjangoflowAppSnackbar.showInfo('Coming Soon');
            },
        child: Container(
          padding: const EdgeInsets.symmetric(
              vertical: kPadding, horizontal: kPadding),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: AppColors.surfaceVariant),
              boxShadow: [
                BoxShadow(
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                    color: Colors.black.withOpacity(0.12))
              ],
              borderRadius: BorderRadius.circular(8)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                    color: AppColors.secondary, shape: BoxShape.circle),
                child: Icon(icon),
              ),
              const SizedBox(
                width: kPadding * 2,
              ),
              Expanded(
                child: Text(text,
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        )),
              )
            ],
          ),
        ),
      );
}
