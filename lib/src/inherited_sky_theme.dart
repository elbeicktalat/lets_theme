// Copyright (c) 2024. Talat El Beick. All rights reserved.
// Use of this source code is governed by a MIT-style license that can be
// found in the LICENSE file.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sky_theme/src/sky_theme_manager.dart';

/// An inherited widget that saves provides current mode, theme, dark theme and
/// brightness to its children.
/// This is an internal widget and should not be used directly.
class InheritedSkyTheme extends InheritedWidget {
  InheritedSkyTheme({
    required SkyThemeManager manager,
    required super.child,
    super.key,
  })  : mode = manager.mode,
        theme = manager.theme,
        darkTheme = manager.darkTheme,
        brightness = manager.brightness;

  final ThemeMode mode;
  final ThemeData theme;
  final ThemeData darkTheme;
  final Brightness? brightness;

  @override
  bool updateShouldNotify(covariant InheritedSkyTheme oldWidget) {
    return oldWidget.mode != mode ||
        oldWidget.theme != theme ||
        oldWidget.darkTheme != darkTheme ||
        oldWidget.brightness != brightness;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(EnumProperty<ThemeMode>('mode', mode));
    properties.add(DiagnosticsProperty<ThemeData>('theme', theme));
    properties.add(DiagnosticsProperty<ThemeData>('darkTheme', darkTheme));
    properties.add(EnumProperty<Brightness?>('brightness', brightness));
  }
}
