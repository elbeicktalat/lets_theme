// Copyright (c) 2024. Talat El Beick. All rights reserved.
// Use of this source code is governed by a MIT-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:lets_theme/src/utils/theme_mode_extension.dart';
import 'package:lets_theme/src/utils/theme_preferences.dart';

mixin LetsThemeManager {
  /// Returns the light theme, it is the theme passed to [MaterialApp].
  ThemeData get lightTheme => _lightTheme;
  late ThemeData _lightTheme;

  /// Returns the dark theme, it is the theme passed to [MaterialApp].
  ThemeData get darkTheme => _darkTheme;
  late ThemeData _darkTheme;

  /// Allows to listen to changes in [ThemeMode].
  ValueNotifier<ThemeMode> get themeModeNotifier => _themeModeNotifier;
  late ValueNotifier<ThemeMode> _themeModeNotifier;

  /// Returns current theme.
  ThemeData get theme {
    if (_preferences.mode.isSystem) {
      final Brightness brightness =
          WidgetsBinding.instance.platformDispatcher.platformBrightness;
      return brightness == Brightness.light ? _lightTheme : _darkTheme;
    }
    return _preferences.mode.isDark ? _darkTheme : _lightTheme;
  }

  /// Returns current theme mode.
  ThemeMode get mode => _preferences.mode;

  /// Returns the default(initial) theme mode.
  ThemeMode get defaultMode => _preferences.defaultMode;

  /// Provides brightness of the current theme.
  Brightness? get brightness => theme.brightness;

  /// Whether brightness is dark.
  bool get isDarkMode => brightness == Brightness.dark;

  /// Checks whether current theme is default theme or not.
  /// Default theme refers to the themes provided at the time
  /// of initialization of the [MaterialApp].
  bool get isDefault;

  late ThemePreferences _preferences;

  void initialize({
    required ThemeData light,
    required ThemeData dark,
    required ThemeMode initialMode,
  }) {
    _lightTheme = light;
    _themeModeNotifier = ValueNotifier<ThemeMode>(initialMode);
    _darkTheme = dark;
    _preferences = ThemePreferences.initial(mode: initialMode);

    ThemePreferences.fromPrefs().then((ThemePreferences? pref) {
      if (pref == null) {
        _preferences.save();
      } else {
        _preferences = pref;
        updateState();
      }
    });
  }

  /// Sets light theme as current.
  void setLight() => setThemeMode(ThemeMode.light);

  /// Sets dark theme as current.
  void setDark() => setThemeMode(ThemeMode.dark);

  /// Sets theme based on the theme of the underlying OS.
  void setSystem() => setThemeMode(ThemeMode.system);

  /// Allows to set/change theme mode.
  void setThemeMode(ThemeMode mode) {
    _preferences.mode = mode;
    updateState();
    _themeModeNotifier.value = mode;
    _preferences.save();
  }

  /// Allows to set/change the entire theme.
  /// [notify] when set to true, will update the UI to use the new theme.
  void setTheme({
    required ThemeData light,
    ThemeData? dark,
    bool notify = true,
  }) {
    _lightTheme = light;
    if (dark != null) _darkTheme = dark;
    if (notify) updateState();
  }

  /// Allows to toggle between theme modes [ThemeMode.light],
  /// [ThemeMode.dark] and [ThemeMode.system].
  void toggleThemeMode({bool useSystem = true}) {
    ThemeMode nextMode = mode.next();
    if (!useSystem && nextMode.isSystem) {
      // Skip system mode.
      nextMode = nextMode.next();
    }
    setThemeMode(nextMode);
  }

  /// Switch between dark and light mode.
  void changeThemeMode() {
    if (isDarkMode) {
      setThemeMode(ThemeMode.light);
    } else {
      setThemeMode(ThemeMode.dark);
    }
  }

  /// Saves the configuration to the shared-preferences. This can be useful
  /// when you want to persist theme settings after clearing
  /// shared-preferences. e.g. when user logs out, usually, preferences
  /// are cleared. Call this method after clearing preferences to
  /// persist theme mode.
  Future<bool> persist() async => _preferences.save();

  /// Resets configuration to default configuration which has been provided
  /// while initializing [MaterialApp].
  /// If [setTheme] method has been called with [isDefault] to true, Calling
  /// this method afterwards will use theme provided by [setTheme] as default
  /// themes.
  @mustCallSuper
  Future<bool> reset() async {
    _preferences.reset();
    updateState();
    themeModeNotifier.value = mode;
    return _preferences.save();
  }

  void updateState();
}
