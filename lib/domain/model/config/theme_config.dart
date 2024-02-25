import 'package:flutter/material.dart';

class ThemeConfig {
  final MaterialColor primaryColor;
  final MaterialColor accentColor;
  final bool? isDark;

  ThemeConfig({
    required this.primaryColor,
    required this.accentColor,
    required this.isDark,
  });
}
