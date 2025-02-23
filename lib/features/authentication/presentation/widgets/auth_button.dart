import 'package:flutter/material.dart';
import 'package:tatpar_orange/configurations/theme/size_constants.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({super.key, required this.text, required this.onClick});

  final String text;
  final VoidCallback? onClick;

  @override
  Widget build(BuildContext context) => TextButton(
        onPressed: onClick,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(kPadding * 2),
          alignment: Alignment.center,
          child: Text(
            text,
          ),
        ),
      );
}
