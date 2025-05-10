import 'package:flutter/material.dart';

class NavigationItemModel {
  final IconData icon;
  final String title;
  final Color? activeColor;
  final Color? inactiveColor;
  final Gradient? gradient;
  final TextStyle? titleStyle;
  final EdgeInsets? padding;
  final double? height;

  const NavigationItemModel(
      {required this.icon,
      required this.title,
      this.activeColor,
      this.inactiveColor,
      this.gradient,
      this.titleStyle,
      this.padding = const EdgeInsets.symmetric(horizontal: 5),
      this.height =50});
}
