import 'package:flutter/material.dart';
import 'package:tatpar_orange/configurations/theme/size_constants.dart';

class AppBarAction extends StatelessWidget {
  const AppBarAction({super.key, required this.icon, required this.onclick});
  final IconData icon;
  final Function() onclick;
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onclick,
      child: Container(
        padding: const EdgeInsets.all(kPadding),
        margin: const EdgeInsets.all(kPadding / 2),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: colorScheme.secondary,
        ),
        child: Icon(
          icon,
          color: colorScheme.onSurface,
        ),
      ),
    );
  }
}
