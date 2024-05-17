import 'package:flutter/material.dart';

extension ThemeModeExtension on ThemeMode {
  bool get isLight => this == ThemeMode.light;

  bool get isDark => this == ThemeMode.dark;

  bool get isSystem => this == ThemeMode.system;

  ThemeMode next() {
    final int nextIndex = (index + 1) % ThemeMode.values.length;
    return ThemeMode.values[nextIndex];
  }

  ThemeMode previous() {
    final int previousIndex = (index - 1) % ThemeMode.values.length;
    return ThemeMode.values[previousIndex];
  }
}
