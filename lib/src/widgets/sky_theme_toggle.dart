// Copyright (c) 2024. Talat El Beick. All rights reserved.
// Use of this source code is governed by a MIT-style license that can be
// found in the LICENSE file.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sky_theme/src/sky_theme.dart';
import 'package:sky_theme/src/utils/theme_mode_extension.dart';

enum _SkyThemeToggleVariant { card, compact, label, icon }

enum SkyThemeToggleSelectionMode { infinite, specific }

class SkyThemeToggleIcon {
  SkyThemeToggleIcon({
    required this.icon,
    required this.selected,
  });

  final IconData icon;
  final IconData selected;
}

class SkyThemeToggle extends StatefulWidget {
  const SkyThemeToggle({
    super.key,
    this.labels,
    this.selectionMode = SkyThemeToggleSelectionMode.specific,
  })  : _variant = _SkyThemeToggleVariant.card,
        lightIcon = null,
        darkIcon = null,
        systemIcon = null;

  const SkyThemeToggle.compact({
    super.key,
    this.labels,
    this.lightIcon,
    this.darkIcon,
    this.systemIcon,
    this.selectionMode = SkyThemeToggleSelectionMode.specific,
  }) : _variant = _SkyThemeToggleVariant.compact;

  const SkyThemeToggle.label({
    super.key,
    this.labels,
    this.selectionMode = SkyThemeToggleSelectionMode.specific,
  })  : _variant = _SkyThemeToggleVariant.label,
        lightIcon = null,
        darkIcon = null,
        systemIcon = null;

  const SkyThemeToggle.icon({
    super.key,
    this.lightIcon,
    this.darkIcon,
    this.systemIcon,
    this.selectionMode = SkyThemeToggleSelectionMode.specific,
  })  : _variant = _SkyThemeToggleVariant.icon,
        labels = null;

  final List<String>? labels;
  final SkyThemeToggleSelectionMode selectionMode;
  final SkyThemeToggleIcon? lightIcon;
  final SkyThemeToggleIcon? darkIcon;
  final SkyThemeToggleIcon? systemIcon;
  final _SkyThemeToggleVariant _variant;

  @override
  State<SkyThemeToggle> createState() => _SkyThemeToggleState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty<String>('labels', labels));
    properties.add(
      DiagnosticsProperty<SkyThemeToggleIcon?>('lightIcon', lightIcon),
    );
    properties.add(
      DiagnosticsProperty<SkyThemeToggleIcon?>('darkIcon', darkIcon),
    );
    properties.add(
      DiagnosticsProperty<SkyThemeToggleIcon?>('systemIcon', systemIcon),
    );
    properties.add(
      EnumProperty<SkyThemeToggleSelectionMode?>('changeStyle', selectionMode),
    );
  }
}

class _SkyThemeToggleState extends State<SkyThemeToggle> {
  late List<bool> _selections;

  List<String> get _labels =>
      widget.labels ??
      const <String>[
        'Light Mode',
        'Dark Mode',
        'System Mode',
      ];

  static const List<ThemeMode> _themeModes = <ThemeMode>[
    ThemeMode.light,
    ThemeMode.dark,
    ThemeMode.system,
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _selections = <bool>[
      SkyTheme.of(context).mode.isLight,
      SkyTheme.of(context).mode.isDark,
      SkyTheme.of(context).mode.isSystem,
    ];
  }

  void _onSelectThemeMode(int index) {
    for (int i = 0; i < _selections.length; i++) {
      _selections[i] = i == index;
    }
    switch (widget.selectionMode) {
      case SkyThemeToggleSelectionMode.infinite:
        SkyTheme.of(context).toggleThemeMode();
      case SkyThemeToggleSelectionMode.specific:
        SkyTheme.of(context).setThemeMode(_themeModes[index]);
    }
    setState(() {});
  }

  IconData _getIconData(int index) {
    return switch (_themeModes[index]) {
      ThemeMode.light => SkyTheme.of(context).mode.isLight
          ? widget.lightIcon?.selected ?? Icons.light_mode
          : widget.lightIcon?.icon ?? Icons.light_mode_outlined,
      ThemeMode.dark => SkyTheme.of(context).mode.isDark
          ? widget.darkIcon?.selected ?? Icons.dark_mode
          : widget.darkIcon?.icon ?? Icons.dark_mode_outlined,
      ThemeMode.system => SkyTheme.of(context).mode.isSystem
          ? widget.systemIcon?.icon ?? Icons.brightness_6
          : widget.systemIcon?.icon ?? Icons.brightness_6_outlined,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: switch (widget._variant) {
        _SkyThemeToggleVariant.card => _CardToggle(
            onSelectThemeMode: _onSelectThemeMode,
            selections: _selections,
            labels: _labels,
          ),
        _SkyThemeToggleVariant.compact => _buildCompactToggleVariant(),
        _SkyThemeToggleVariant.label => _buildLabelToggleVariant(),
        _SkyThemeToggleVariant.icon => _buildIconToggleVariant(),
      },
    );
  }

  Widget _buildCompactToggleVariant() {
    return ToggleButtons(
      borderRadius: BorderRadius.circular(18),
      onPressed: _onSelectThemeMode,
      isSelected: _selections,
      children: List<Widget>.generate(
        _selections.length,
        (int index) {
          return SizedBox(
            width: MediaQuery.of(context).size.width * .3,
            child: FittedBox(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Icon(
                      _getIconData(index),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _labels[index],
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLabelToggleVariant() {
    return ToggleButtons(
      borderRadius: BorderRadius.circular(18),
      onPressed: _onSelectThemeMode,
      isSelected: _selections,
      children: List<SizedBox>.generate(
        _selections.length,
        (int index) {
          return SizedBox(
            width: MediaQuery.of(context).size.width * .3,
            child: FittedBox(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  _labels[index],
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildIconToggleVariant() {
    return ToggleButtons(
      borderRadius: BorderRadius.circular(18),
      onPressed: _onSelectThemeMode,
      isSelected: _selections,
      children: List<Tooltip>.generate(
        _selections.length,
        (int index) {
          return Tooltip(
            message: _labels[index],
            child: SizedBox(
              width: MediaQuery.of(context).size.width * .2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(_getIconData(index)),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _CardToggle extends StatelessWidget {
  const _CardToggle({
    required this.onSelectThemeMode,
    required this.selections,
    required this.labels,
  });

  final void Function(int index) onSelectThemeMode;
  final List<bool> selections;
  final List<String> labels;

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      borderRadius: BorderRadius.circular(18),
      onPressed: onSelectThemeMode,
      isSelected: selections,
      children: List<Widget>.generate(
        selections.length,
        (int index) {
          return Column(
            children: <Widget>[
              SizedBox(
                width: (MediaQuery.of(context).size.width - 20) / 3,
                height: MediaQuery.of(context).size.height * .15,
                child: Stack(
                  children: <Widget>[
                    if (index == 0)
                      _getToggleIllustration(
                        context: context,
                        background: const Color(0xFFf5f5f5),
                        theme: SkyTheme.of(context).lightTheme,
                      ),
                    if (index == 1)
                      _getToggleIllustration(
                        context: context,
                        background: const Color(0xFF4e4e4e),
                        theme: SkyTheme.of(context).darkTheme,
                      ),
                    if (index == 2)
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: _getToggleIllustration(
                              context: context,
                              background: const Color(0xFF4e4e4e),
                              theme: SkyTheme.of(context).darkTheme,
                              width: MediaQuery.of(context).size.width * .12,
                            ),
                          ),
                          Expanded(
                            child: _getToggleIllustration(
                              context: context,
                              background: const Color(0xFFf5f5f5),
                              theme: SkyTheme.of(context).lightTheme,
                              width: MediaQuery.of(context).size.width * .12,
                            ),
                          ),
                        ],
                      ),
                    if (selections[index]) _getCheckMark(context, index),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(labels[index]),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _getCheckMark(BuildContext context, int index) {
    if (SkyTheme.of(context).mode.isSystem &&
        SkyTheme.of(context).brightness == Brightness.dark) {
      return const Positioned(
        left: 25,
        bottom: 5,
        child: Icon(Icons.check_circle),
      );
    }

    return const Positioned(
      right: 5,
      bottom: 5,
      child: Icon(Icons.check_circle),
    );
  }

  Widget _getToggleIllustration({
    required BuildContext context,
    required Color background,
    required ThemeData theme,
    double? width,
  }) {
    return Container(
      color: background,
      child: Stack(
        children: <Widget>[
          Positioned(
            right: 0,
            bottom: -1,
            child: SizedBox(
              width: width ?? MediaQuery.of(context).size.width * .2,
              height: MediaQuery.of(context).size.height * .1,
              child: Material(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                ),
                elevation: 8,
                color: theme.colorScheme.background,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Aa',
                    style: TextStyle(
                      color: theme.colorScheme.onBackground,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
      ObjectFlagProperty<void Function(int index)>.has(
        'onSelectThemeMode',
        onSelectThemeMode,
      ),
    );
    properties.add(IterableProperty<bool>('selections', selections));
    properties.add(IterableProperty<String>('labels', labels));
  }
}
