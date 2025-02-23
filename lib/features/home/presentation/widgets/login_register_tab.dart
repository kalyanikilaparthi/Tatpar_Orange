import 'package:djangoflow_app/djangoflow_app.dart';

import 'package:flutter/material.dart';
import 'package:tatpar_orange/configurations/constants/constants.dart';
import 'package:tatpar_orange/features/home/presentation/widgets/quick_action_button.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginRegisterTab extends StatefulWidget {
  const LoginRegisterTab({super.key});

  @override
  State<LoginRegisterTab> createState() => _LoginRegisterTabState();
}

class _LoginRegisterTabState extends State<LoginRegisterTab> {
  @override
  Widget build(BuildContext context) => Column(
        children: [
          QuickActionButton(
            icon: Icons.app_registration,
            text: 'Register on Nikshay',
            onClick: () async {
              try {
                await launchUrl(
                  Uri.parse(registerLink), // Replace with your desired URL
                  mode: LaunchMode.inAppWebView,
                );
              } catch (e) {
                // Handle errors, such as if the URL cannot be launched
                DjangoflowAppSnackbar.showInfo('Something went wrong : $e');
              }
            },
          ),
          const SizedBox(
            height: 10,
          ),
          QuickActionButton(
            icon: Icons.login,
            text: 'Login to Nikshay',
            onClick: () async {
              try {
                await launchUrl(
                  Uri.parse(loginLink), // Replace with your desired URL
                  mode: LaunchMode.inAppWebView,
                );
              } catch (e) {
                // Handle errors, such as if the URL cannot be launched
                DjangoflowAppSnackbar.showInfo('Something went wrong : $e');
              }
            },
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      );
}
