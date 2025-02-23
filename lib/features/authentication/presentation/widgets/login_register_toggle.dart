import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tatpar_orange/configurations/configurations.dart';

class LoginRegisterToggle extends StatelessWidget {
  const LoginRegisterToggle({super.key, this.isLogin = true});

  final bool isLogin;

  @override
  Widget build(BuildContext context) {
    final labelMediumTextStyle = Theme.of(context).textTheme.labelMedium;

    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.all(kPadding * 2),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: '',
          children: [
            TextSpan(
              text: isLogin
                  ? 'Don’t have an account? '
                  : 'Already have an account? ',
              style: labelMediumTextStyle,
            ),
            TextSpan(
              text: isLogin ? 'Register' : 'Login',
              style: labelMediumTextStyle?.copyWith(
                color: const Color(0xff1172E3),
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  if (isLogin) {
                    context.router.parent()?.navigate(RegisterRoute());
                  } else {
                    context.router.navigate(const LoginRoute());
                  }
                },
            ),
          ],
        ),
      ),
    );
  }
}
