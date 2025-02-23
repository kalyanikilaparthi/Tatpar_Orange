import 'package:flutter/material.dart';
import 'package:tatpar_orange/configurations/configurations.dart';

@RoutePage()
class SuccessDialogPage extends StatelessWidget {
  const SuccessDialogPage({
    super.key,
    required this.message,
    this.actionText = 'Okay',
  });

  final String message;
  final String actionText;

  @override
  Widget build(BuildContext context) => Container(
        alignment: Alignment.center,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.6,
          height: 300,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(kPadding),
          ),
          padding: const EdgeInsets.all(kPadding * 3),
          child: ListView(
            // mainAxisAlignment: MainAxisAlignment.center,
            shrinkWrap: true,
            children: [
              Assets.images.checkmark.image(
                width: kPadding * 10,
                height: kPadding * 10,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(height: kPadding * 2),
              Text(
                message,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      height: 2,
                    ),
              ),
              const SizedBox(height: kPadding * 3.5),
              TextButton(
                onPressed: () {
                  context.router.pop();
                },
                style: TextButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  padding: const EdgeInsets.symmetric(
                      horizontal: kPadding * 2, vertical: kPadding),
                ),
                child: Text(
                  actionText,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                ),
              ),
            ],
          ),
        ),
      );
}
