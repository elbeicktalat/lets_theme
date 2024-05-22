// Copyright (c) 2024. Talat El Beick. All rights reserved.
// Use of this source code is governed by a MIT-style license that can be
// found in the LICENSE file.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lets_theme/src/lets_theme.dart';
import 'package:lets_theme/src/utils/theme_mode_extension.dart';

enum _LetsThemeToggleVariant { toggle, card, compact, label, icon }

enum LetsThemeToggleSelectionMode { infinite, specific }

class LetsThemeToggleIcon {
  LetsThemeToggleIcon({
    required this.icon,
    required this.selected,
  });

  final IconData icon;
  final IconData selected;
}

class LetsThemeToggle extends StatefulWidget {
  const LetsThemeToggle({
    super.key,
    this.width,
    this.height,
    this.modes = _defaultMods,
    this.labels = _defaultLabels,
    this.tooltips,
    this.selectionMode = LetsThemeToggleSelectionMode.specific,
    this.mouseCursor,
    this.tapTargetSize,
    this.elevation,
    this.color,
    this.selectedColor,
    this.fillColor,
    this.focusColor,
    this.highlightColor,
    this.hoverColor,
    this.splashColor,
    this.shadowColor,
    this.focusNodes,
    this.renderBorder,
    this.borderColor,
    this.selectedBorderColor,
    this.borderRadius,
    this.borderWidth,
    this.textStyle,
  })  : _variant = _LetsThemeToggleVariant.toggle,
        lightIcon = null,
        darkIcon = null,
        systemIcon = null;

  const LetsThemeToggle.card({
    super.key,
    this.width,
    this.height,
    this.modes = _defaultMods,
    this.labels = _defaultLabels,
    this.tooltips,
    this.selectionMode = LetsThemeToggleSelectionMode.specific,
    this.elevation,
    this.color,
    this.selectedColor,
    this.fillColor,
    this.shadowColor,
    this.focusNodes,
    this.selectedBorderColor,
    this.borderWidth,
  })  : _variant = _LetsThemeToggleVariant.card,
        lightIcon = null,
        darkIcon = null,
        systemIcon = null,
        mouseCursor = null,
        tapTargetSize = null,
        focusColor = null,
        highlightColor = null,
        hoverColor = null,
        splashColor = null,
        renderBorder = null,
        borderColor = null,
        borderRadius = null,
        textStyle = null;

  const LetsThemeToggle.compact({
    super.key,
    this.width,
    this.height,
    this.modes = _defaultMods,
    this.labels = _defaultLabels,
    this.tooltips,
    this.lightIcon,
    this.darkIcon,
    this.systemIcon,
    this.selectionMode = LetsThemeToggleSelectionMode.specific,
    this.mouseCursor,
    this.tapTargetSize,
    this.elevation,
    this.color,
    this.selectedColor,
    this.fillColor,
    this.focusColor,
    this.highlightColor,
    this.hoverColor,
    this.splashColor,
    this.shadowColor,
    this.focusNodes,
    this.renderBorder,
    this.borderColor,
    this.selectedBorderColor,
    this.borderRadius,
    this.borderWidth,
    this.textStyle,
  }) : _variant = _LetsThemeToggleVariant.compact;

  const LetsThemeToggle.label({
    super.key,
    this.width,
    this.height,
    this.modes = _defaultMods,
    this.labels = _defaultLabels,
    this.tooltips,
    this.selectionMode = LetsThemeToggleSelectionMode.specific,
    this.mouseCursor,
    this.tapTargetSize,
    this.elevation,
    this.color,
    this.selectedColor,
    this.fillColor,
    this.focusColor,
    this.highlightColor,
    this.hoverColor,
    this.splashColor,
    this.shadowColor,
    this.focusNodes,
    this.renderBorder,
    this.borderColor,
    this.selectedBorderColor,
    this.borderRadius,
    this.borderWidth,
    this.textStyle,
  })  : _variant = _LetsThemeToggleVariant.label,
        lightIcon = null,
        darkIcon = null,
        systemIcon = null;

  const LetsThemeToggle.icon({
    super.key,
    this.width,
    this.height,
    this.modes = _defaultMods,
    this.tooltips,
    this.lightIcon,
    this.darkIcon,
    this.systemIcon,
    this.selectionMode = LetsThemeToggleSelectionMode.specific,
    this.mouseCursor,
    this.tapTargetSize,
    this.elevation,
    this.color,
    this.selectedColor,
    this.fillColor,
    this.focusColor,
    this.highlightColor,
    this.hoverColor,
    this.splashColor,
    this.shadowColor,
    this.focusNodes,
    this.renderBorder,
    this.borderColor,
    this.selectedBorderColor,
    this.borderRadius,
    this.borderWidth,
    this.textStyle,
  })  : _variant = _LetsThemeToggleVariant.icon,
        labels = null;

  final double? width;
  final double? height;
  final List<ThemeMode> modes;
  final List<String>? labels;
  final List<String>? tooltips;
  final LetsThemeToggleIcon? lightIcon;
  final LetsThemeToggleIcon? darkIcon;
  final LetsThemeToggleIcon? systemIcon;
  final LetsThemeToggleSelectionMode selectionMode;
  final MouseCursor? mouseCursor;
  final MaterialTapTargetSize? tapTargetSize;
  final double? elevation;
  final Color? color;
  final Color? selectedColor;
  final Color? fillColor;
  final Color? focusColor;
  final Color? highlightColor;
  final Color? hoverColor;
  final Color? splashColor;
  final Color? shadowColor;
  final List<FocusNode>? focusNodes;
  final bool? renderBorder;
  final Color? borderColor;
  final Color? selectedBorderColor;
  final BorderRadius? borderRadius;
  final double? borderWidth;
  final TextStyle? textStyle;

  final _LetsThemeToggleVariant _variant;

  static const List<ThemeMode> _defaultMods = <ThemeMode>[
    ThemeMode.light,
    ThemeMode.dark,
    ThemeMode.system,
  ];

  static const List<String> _defaultLabels = <String>[
    'Light Mode',
    'Dark Mode',
    'System Mode',
  ];

  @override
  State<LetsThemeToggle> createState() => _LetsThemeToggleState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('width', width));
    properties.add(DoubleProperty('height', height));
    properties.add(IterableProperty<ThemeMode>('mods', modes));
    properties.add(IterableProperty<String>('labels', labels));
    properties.add(IterableProperty<String>('tooltips', tooltips));
    properties
        .add(DiagnosticsProperty<LetsThemeToggleIcon?>('lightIcon', lightIcon));
    properties
        .add(DiagnosticsProperty<LetsThemeToggleIcon?>('darkIcon', darkIcon));
    properties.add(
      DiagnosticsProperty<LetsThemeToggleIcon?>('systemIcon', systemIcon),
    );
    properties.add(
      EnumProperty<LetsThemeToggleSelectionMode>(
        'selectionMode',
        selectionMode,
      ),
    );
    properties
        .add(DiagnosticsProperty<MouseCursor?>('mouseCursor', mouseCursor));
    properties.add(
      EnumProperty<MaterialTapTargetSize?>('tapTargetSize', tapTargetSize),
    );
    properties.add(ColorProperty('color', color));
    properties.add(ColorProperty('selectedColor', selectedColor));
    properties.add(ColorProperty('fillColor', fillColor));
    properties.add(ColorProperty('focusColor', focusColor));
    properties.add(ColorProperty('highlightColor', highlightColor));
    properties.add(ColorProperty('hoverColor', hoverColor));
    properties.add(ColorProperty('splashColor', splashColor));
    properties.add(IterableProperty<FocusNode>('focusNodes', focusNodes));
    properties.add(DiagnosticsProperty<bool?>('renderBorder', renderBorder));
    properties.add(ColorProperty('borderColor', borderColor));
    properties.add(ColorProperty('selectedBorderColor', selectedBorderColor));
    properties
        .add(DiagnosticsProperty<BorderRadius?>('borderRadius', borderRadius));
    properties.add(DoubleProperty('borderWidth', borderWidth));
    properties.add(DiagnosticsProperty<TextStyle?>('textStyle', textStyle));
    properties.add(DoubleProperty('elevation', elevation));
    properties.add(ColorProperty('shadowColor', shadowColor));
  }
}

class _LetsThemeToggleState extends State<LetsThemeToggle> {
  late List<bool> _selections;

  double get _width => widget.width ?? MediaQuery.of(context).size.width / 3;

  static const BorderRadius _defaultBorderRadius = BorderRadius.all(
    Radius.circular(18.0),
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _selections = <bool>[
      for (final ThemeMode mode in widget.modes)
        switch (mode) {
          ThemeMode.system => LetsTheme.of(context).mode.isSystem,
          ThemeMode.light => LetsTheme.of(context).mode.isLight,
          ThemeMode.dark => LetsTheme.of(context).mode.isDark,
        },
    ];
  }

  void _onSelectThemeMode(int index) {
    for (int i = 0; i < _selections.length; i++) {
      _selections[i] = i == index;
    }
    switch (widget.selectionMode) {
      case LetsThemeToggleSelectionMode.infinite:
        LetsTheme.of(context).toggleThemeMode();
      case LetsThemeToggleSelectionMode.specific:
        LetsTheme.of(context).setThemeMode(widget.modes[index]);
    }
    setState(() {});
  }

  IconData _getIconData(int index) {
    return switch (widget.modes[index]) {
      ThemeMode.light => LetsTheme.of(context).mode.isLight
          ? widget.lightIcon?.selected ?? Icons.light_mode
          : widget.lightIcon?.icon ?? Icons.light_mode_outlined,
      ThemeMode.dark => LetsTheme.of(context).mode.isDark
          ? widget.darkIcon?.selected ?? Icons.dark_mode
          : widget.darkIcon?.icon ?? Icons.dark_mode_outlined,
      ThemeMode.system => LetsTheme.of(context).mode.isSystem
          ? widget.systemIcon?.icon ?? Icons.brightness_6
          : widget.systemIcon?.icon ?? Icons.brightness_6_outlined,
    };
  }

  @override
  Widget build(BuildContext context) {
    if (widget.labels != null) {
      assert(
        widget.labels!.length == widget.modes.length,
        'labels.length must match modes.length.\n'
        'There are ${widget.labels!.length} labels, while '
        'there are ${widget.modes.length} modes.',
      );
    }
    if (widget.tooltips != null) {
      assert(
        widget.tooltips!.length == widget.modes.length,
        'tooltips.length must match modes.length.\n'
        'There are ${widget.tooltips!.length} tooltips, while '
        'there are ${widget.modes.length} modes.',
      );
    }

    if (widget._variant == _LetsThemeToggleVariant.card) {
      return _LetsThemeCardToggle(
        selections: _selections,
        onPressed: _onSelectThemeMode,
        modes: widget.modes,
        labels: widget.labels!,
        tooltips: widget.tooltips,
        width: _width,
        height: widget.height,
        elevation: widget.elevation,
        color: widget.color,
        selectedColor: widget.selectedColor,
        fillColor: widget.fillColor,
        shadowColor: widget.shadowColor,
        focusNodes: widget.focusNodes,
        selectedBorderColor: widget.borderColor,
        borderWidth: widget.borderWidth,
      );
    }

    final List<Widget> children = List<Widget>.generate(
      widget.modes.length,
      (int index) {
        final Widget child = switch (widget._variant) {
          _LetsThemeToggleVariant.toggle => _buildDefaultToggleBody(index),
          _LetsThemeToggleVariant.compact => _buildCompactToggleBody(index),
          _LetsThemeToggleVariant.label => _buildLabelToggleBody(index),
          _LetsThemeToggleVariant.icon => _buildIconToggleBody(index),

          // no effect because of above build return.
          _LetsThemeToggleVariant.card => const SizedBox.shrink(),
        };

        if (widget.tooltips != null) {
          return Tooltip(
            message: widget.tooltips![index],
            child: child,
          );
        }

        return child;
      },
    );

    return Material(
      elevation: widget.elevation ?? 0.0,
      shadowColor: widget.shadowColor,
      borderRadius: widget.borderRadius ?? _defaultBorderRadius,
      child: FittedBox(
        child: ToggleButtons(
          onPressed: _onSelectThemeMode,
          isSelected: _selections,
          mouseCursor: widget.mouseCursor,
          tapTargetSize: widget.tapTargetSize,
          color: widget.color,
          selectedColor: widget.selectedColor,
          fillColor: widget.fillColor,
          focusColor: widget.focusColor,
          highlightColor: widget.highlightColor,
          hoverColor: widget.hoverColor,
          splashColor: widget.splashColor,
          focusNodes: widget.focusNodes,
          renderBorder: widget.renderBorder ?? true,
          borderColor: widget.borderColor,
          selectedBorderColor: widget.selectedBorderColor,
          borderRadius: widget.borderRadius ?? _defaultBorderRadius,
          borderWidth: widget.borderWidth,
          textStyle: widget.textStyle,
          children: children,
        ),
      ),
    );
  }

  Widget _buildDefaultToggleBody(int index) {
    final ThemeMode mode = widget.modes[index];

    return Column(
      children: <Widget>[
        SizedBox(
          width: _width,
          height: widget.height ?? MediaQuery.of(context).size.height * .15,
          child: Stack(
            children: <Widget>[
              switch (mode) {
                ThemeMode.light => _getToggleIllustration(
                    background: const Color(0xFFf5f5f5),
                    theme: LetsTheme.of(context).lightTheme,
                  ),
                ThemeMode.dark => _getToggleIllustration(
                    background: const Color(0xFF4e4e4e),
                    theme: LetsTheme.of(context).darkTheme,
                  ),
                ThemeMode.system => Row(
                    children: <Widget>[
                      Expanded(
                        child: _getToggleIllustration(
                          background: const Color(0xFF4e4e4e),
                          theme: LetsTheme.of(context).darkTheme,
                          width: MediaQuery.of(context).size.width * .12,
                        ),
                      ),
                      Expanded(
                        child: _getToggleIllustration(
                          background: const Color(0xFFf5f5f5),
                          theme: LetsTheme.of(context).lightTheme,
                          width: MediaQuery.of(context).size.width * .12,
                        ),
                      ),
                    ],
                  ),
              },
              if (_selections[index]) _getCheckMark(index),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          child: Text(widget.labels![index]),
        ),
      ],
    );
  }

  Widget _buildCompactToggleBody(int index) {
    return SizedBox(
      width: _width,
      height: widget.height,
      child: FittedBox(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: <Widget>[
              Icon(
                _getIconData(index),
              ),
              const SizedBox(width: 8),
              Text(
                widget.labels![index],
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabelToggleBody(int index) {
    return SizedBox(
      width: _width,
      height: widget.height,
      child: Text(
        widget.labels![index],
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildIconToggleBody(int index) {
    return SizedBox(
      width: widget.width ?? MediaQuery.of(context).size.width * .15,
      height: widget.height,
      child: Icon(_getIconData(index)),
    );
  }

  Widget _getCheckMark(int index) {
    if (LetsTheme.of(context).mode.isSystem &&
        LetsTheme.of(context).brightness == Brightness.dark) {
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
    required Color background,
    required ThemeData theme,
    double? width,
  }) {
    return ColoredBox(
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
                color: theme.colorScheme.surface,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Aa',
                    style: TextStyle(
                      color: theme.colorScheme.onSurface,
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
}

class _LetsThemeCardToggle extends StatelessWidget {
  const _LetsThemeCardToggle({
    required this.selections,
    required this.onPressed,
    required this.modes,
    required this.labels,
    required this.tooltips,
    required this.width,
    required this.height,
    required this.elevation,
    required this.color,
    required this.selectedColor,
    required this.fillColor,
    required this.shadowColor,
    required this.focusNodes,
    required this.selectedBorderColor,
    required this.borderWidth,
  });

  final List<bool> selections;
  final void Function(int index) onPressed;
  final List<ThemeMode> modes;
  final List<String> labels;
  final List<String>? tooltips;
  final double? width;
  final double? height;
  final double? elevation;
  final Color? color;
  final Color? selectedColor;
  final Color? fillColor;
  final Color? shadowColor;
  final List<FocusNode>? focusNodes;
  final Color? selectedBorderColor;
  final double? borderWidth;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    Widget child(int index) {
      return Column(
        children: <Widget>[
          Expanded(
            child: TextButton(
              onPressed: () => onPressed(index),
              focusNode: focusNodes?[index],
              style: TextButton.styleFrom(
                padding: const EdgeInsets.all(14.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                  side: selections[index]
                      ? BorderSide(
                          width: borderWidth ?? 4,
                          color: selectedBorderColor ?? colorScheme.primary,
                        )
                      : BorderSide.none,
                ),
              ),
              child: Card.outlined(
                margin: EdgeInsets.zero,
                elevation: elevation,
                shadowColor: shadowColor,
                child: switch (modes[index]) {
                  ThemeMode.system => Row(
                      children: <Widget>[
                        Expanded(
                          child: _buildCardIllustration(
                            theme: LetsTheme.of(context).lightTheme,
                            primaryColorShowWidth: 24,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              bottomLeft: Radius.circular(12),
                            ),
                          ),
                        ),
                        Expanded(
                          child: _buildCardIllustration(
                            theme: LetsTheme.of(context).darkTheme,
                            primaryColorShowWidth: 24,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(12),
                              bottomRight: Radius.circular(12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ThemeMode.light => _buildCardIllustration(
                      theme: LetsTheme.of(context).lightTheme,
                    ),
                  ThemeMode.dark => _buildCardIllustration(
                      theme: LetsTheme.of(context).darkTheme,
                    ),
                },
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            labels[index],
            textAlign: TextAlign.center,
            style: TextStyle(
              color: selections[index]
                  ? selectedColor ?? colorScheme.primary
                  : color ?? Colors.grey,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );
    }

    return FittedBox(
      child: Row(
        children: List<Widget>.generate(
          modes.length,
          (int index) => SizedBox(
            width: width ?? MediaQuery.of(context).size.width / 3,
            height: height ?? MediaQuery.of(context).size.height * .25,
            child: child(index),
          ),
        ),
      ),
    );
  }

  Widget _buildCardIllustration({
    required ThemeData theme,
    BorderRadius? borderRadius,
    double? primaryColorShowWidth,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: fillColor ?? theme.colorScheme.surface,
        borderRadius: borderRadius ?? BorderRadius.circular(12),
      ),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Text(
              'Aa',
              style: TextStyle(
                color: color ?? theme.colorScheme.onSurface,
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            width: primaryColorShowWidth,
            height: 24,
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty<bool>('selections', selections));
    properties.add(
      ObjectFlagProperty<void Function(int index)>.has(
        'onPressed',
        onPressed,
      ),
    );
    properties.add(IterableProperty<ThemeMode>('modes', modes));
    properties.add(IterableProperty<String>('labels', labels));
    properties.add(IterableProperty<String>('tooltips', tooltips));
    properties.add(DoubleProperty('width', width));
    properties.add(DoubleProperty('height', height));
    properties.add(DoubleProperty('elevation', elevation));
    properties.add(ColorProperty('color', color));
    properties.add(ColorProperty('selectedColor', selectedColor));
    properties.add(ColorProperty('fillColor', fillColor));
    properties.add(ColorProperty('shadowColor', shadowColor));
    properties.add(IterableProperty<FocusNode>('focusNodes', focusNodes));
    properties.add(ColorProperty('selectedBorderColor', selectedBorderColor));
    properties.add(DoubleProperty('borderWidth', borderWidth));
  }
}
