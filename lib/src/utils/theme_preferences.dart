// Copyright © 2020 Birju Vachhani. All rights reserved.
// Use of this source code is governed by an Apache license that can be
// found in the LICENSE file.

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lets_theme/src/lets_theme.dart';

/// Utility for storing theme info in SharedPreferences
class ThemePreferences {
  ThemePreferences._(this.mode, this.defaultMode);

  ThemePreferences.initial({ThemeMode mode = ThemeMode.system})
      : this._(mode, mode);

  ThemePreferences.fromJson(Map<String, dynamic> json) {
    if (json['theme_mode'] != null) {
      mode = ThemeMode.values[json['theme_mode']];
    } else {
      mode = ThemeMode.system;
    }
    if (json['default_theme_mode'] != null) {
      defaultMode = ThemeMode.values[json['default_theme_mode']];
    } else {
      defaultMode = mode;
    }
  }

  late ThemeMode mode;
  late ThemeMode defaultMode;

  void reset() => mode = defaultMode;

  Map<String, dynamic> toJson() => <String, int>{
        'theme_mode': mode.index,
        'default_theme_mode': defaultMode.index,
      };

  /// saves the current theme preferences to the shared-preferences
  Future<bool> save() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(LetsTheme.preferencesKey, json.encode(toJson()));
  }

  /// retrieves preferences from the shared-preferences
  static Future<ThemePreferences?> fromPrefs() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? themeDataString = prefs.getString(LetsTheme.preferencesKey);
      if (themeDataString == null || themeDataString.isEmpty) return null;
      return ThemePreferences.fromJson(json.decode(themeDataString));
    } on Exception catch (error, stacktrace) {
      if (kDebugMode) {
        print(error);
        print(stacktrace);
      }
      return null;
    }
  }
}
