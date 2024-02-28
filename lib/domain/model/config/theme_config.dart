import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'theme_config.freezed.dart';

@freezed
class ThemeConfig with _$ThemeConfig {
  const ThemeConfig._();

  const factory ThemeConfig({
    required MaterialColor primaryColor,
    required MaterialColor accentColor,
    required bool isDark,
  }) = _ThemeConfig;

  factory ThemeConfig.defaultTheme() => const ThemeConfig(
        primaryColor: Colors.deepPurple,
        accentColor: Colors.deepOrange,
        isDark: false,
      );
}
