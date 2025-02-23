import 'package:flutter/material.dart';

class AppBottomSheetItem {
  final String title;
  final Widget icon;
  final void Function() onTap;

  AppBottomSheetItem({
    required this.title,
    required this.icon,
    required this.onTap,
  });
}