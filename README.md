# Let's Theme

The easiest way to control your app theme, this package provides couple of widgets to change
between **system and** **light/dark** theme.

[![Github stars](https://img.shields.io/github/stars/elbeicktalat/lets_theme?logo=github)](https://github.com/elbeicktalat/lets_theme)
[![Pub Version](https://img.shields.io/pub/v/lets_theme?color=blue&logo=dart)](https://pub.dev/packages/smart_theme)

## Index

- [Installation](#installation)
- [Getting Started](#getting-started)
- [Handling App Start](#get-themeMode-at-app-start)
- [Let's Theme Toggle Widget](#lets-theme-toggle-widget)
- [Let's Theme Toggle Widget Customization](#lets-theme-toggle-widget-customization)
- [Changing Theme Mode](#changing-theme-mode)
- [Toggle Theme Mode](#toggle-theme-mode)
- [Changing Themes](#changing-themes)
- [Reset Theme](#reset-theme)
- [Handling Theme Changes](#listen-to-the-theme-mode-changes)

## Installation

Add this to your packages pubspec.yaml file:

```yaml
dependencies:
  lets_theme: <^last>
  shared_preferences: <^last>
```

## Getting Started

```dart
import 'package:lets_theme/lets_theme.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LetsTheme(
      light: ThemeData.light(useMaterial3: true),
      dark: ThemeData.dark(useMaterial3: true), 
      initialMode: ThemeMode.system, // bad: I'll in more detail below, but you need to know that this would fine if we don't save any preferences.
      builder: (ThemeData light, ThemeData dark) => MaterialApp(
        title: "Let's Theme Demo",
        theme: light,
        darkTheme: dark,
        home: MyHomePage(),
      ),
    );
  }
}
```

## Get ThemeMode at App Start

When you change your theme, the next app run won't be able to pick the most recent theme directly before rendering with
default theme first time. This is because at the time of initialization, we cannot run async code to get previous theme
mode. However, it can be avoided if you make your `main()` method async and load previous theme mode asynchronously.
The Below example shows how it can be done.

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final savedThemeMode = await LetsTheme.getThemeMode();
  runApp(MyApp(savedThemeMode: savedThemeMode));
}
```

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LetsTheme(
      light: ThemeData.light(useMaterial3: true),
      dark: ThemeData.dark(useMaterial3: true),
      initial: savedThemeMode ?? ThemeMode.system, // good
      builder: (ThemeData light, ThemeData dark) => MaterialApp(
        title: "Let's Theme Demo",
        theme: light,
        darkTheme: dark,
        home: MyHomePage(),
      ),
    );
  }
}
```

Notice that I passed the retrieved `ThemeMode` to my `MaterialApp` so that I can use it while initializing the default
theme. This helps avoid theme change flickering on app startup.

## Let's Theme Toggle Widget

A full-featured widget to play with for changing theme mode, this widget will save your time,
since it already includes the following widgets out of the box.

|                                                      Light                                                       |                                                 Dark                                                 |
|:----------------------------------------------------------------------------------------------------------------:|:----------------------------------------------------------------------------------------------------:|
| ![img.png](https://raw.githubusercontent.com/elbeicktalat/lets_theme/main/.doc/readme/light_theme_customized.png) | ![img.png](https://raw.githubusercontent.com/elbeicktalat/lets_theme/main/.doc/readme/dark_theme.png) |

|                                                 System Light                                                 |                                                 System Dark                                                 |
|:------------------------------------------------------------------------------------------------------------:|:-----------------------------------------------------------------------------------------------------------:|
| ![img.png](https://raw.githubusercontent.com/elbeicktalat/lets_theme/main/.doc/readme/system_light_theme.png) | ![img.png](https://raw.githubusercontent.com/elbeicktalat/lets_theme/main/.doc/readme/system_dark_theme.png) |

```dart
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text(widget.title),
    ),
    body: Column(
      children: [
        const SizedBox(height: 12),
        Text(
          'Current Theme Mode',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            LetsTheme.of(context).mode.name.toUpperCase(),
            style: Theme.of(context).textTheme.displaySmall,
          ),
        ),
        const SizedBox(height: 24),
        const LetsThemeToggle(),
        const SizedBox(height: 24),
        const LetsThemeToggle.compact(),
        const SizedBox(height: 24),
        const LetsThemeToggle.label(),
        const SizedBox(height: 24),
        const LetsThemeToggle.icon(),
      ],
    ),
  );
}
```

Yes, this is all that you need 👆 the `LetsThemeToggle` widget will manage everything for you!
As per example, there are multiple types of `LetsThemeToggle` such as `LetsThemeToggle.compact` so try them by yourself 😇  

## Let's Theme Toggle Widget Customization

As for now, there are no too many things to customize, but you still be able to customize the labels and icons.
I show you how:

```dart
const LetsThemeToggle() // before

// after
const LetsThemeToggle(
  labels: [
    'Day Mode',
    'Night Mode',
    'Auto Mode',
  ],
)
```


|                                                Before                                                 |                                                      Afters                                                      |
|:-----------------------------------------------------------------------------------------------------:|:----------------------------------------------------------------------------------------------------------------:|
| ![img.png](https://raw.githubusercontent.com/elbeicktalat/lets_theme/main/.doc/readme/light_theme.png) | ![img.png](https://raw.githubusercontent.com/elbeicktalat/lets_theme/main/.doc/readme/light_theme_customized.png) |


Tip: **icons** are not available in `LetsThemeToggle()` also **labels** are not available `LetsThemeToggle.icon()`

One last customization, you can control the behavior of how the toggles dose the changes.
There is 2 types of changing. One is `infinite` and next is `spesific`, the first dose accepts clicks on any Toggle, 
and everytime you click any one of the toggles, the selection moves to the next. The Second one instead,
moves straight away to the toggle you clicked on, changing the theme to what you have clicked on.  

[Video](https://raw.githubusercontent.com/elbeicktalat/lets_theme/main/.doc/readme/sky_toggle_selection_mode_demo.mp4)

```dart
const LetsThemeToggle(
  selectionMode: LetsThemeToggleSelectionMode.infinite,
)

// defaults
const LetsThemeToggle.compact(
  selectionMode: LetsThemeToggleSelectionMode.specific,
)
```

## Changing Theme Mode

Now that you have initialized your app as mentioned above. It's very easy and straight forward to
change your theme modes: **light to dark, dark to light or to system default**.

```dart
// sets theme mode to dark
LetsTheme.of(context).setDark();

// sets theme mode to light
LetsTheme.of(context).setLight();

// sets theme mode to system default
LetsTheme.of(context).setSystem();

// sets theme mode to light if current theme is dark and vice-versa.
LetsTheme.of(context).changeThemeMode();
```

## Toggle Theme Mode

`LetsTheme` allows you to toggle between light, dark and system theme the easiest way possible.

```dart
LetsTheme.of(context).toggleThemeMode();
```

Everytime you call this method the `ThemeData` will change starting from **Light** to **Dark** 
ending with **System Defaults**

## Changing Themes

If you want to change the theme entirely like changing all the colors to some other color swatch,
then you can use `setTheme` method.

```dart
LetsTheme.of(context).setTheme(
  light: ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorSchemeSeed: Colors.blue,
  ),
  dark: ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorSchemeSeed: Colors.blue,
  ),
);
```

## Reset Theme

`LetsTheme` is smart enough to keep your hardcoded **default** themes provided at the time of initialization.
You can fall back to those default themes in a straightforward way.

```dart
LetsTheme.of(context).reset();
```

This will reset your `ThemeData` as well as `ThemeMode` to the **initial** values provided at the time of initialization.

## Listen to the theme mode changes

You can listen to the changes in the theme mode via a `ValueNotifier`. This can be useful when designing theme settings
screen or developing ui to show theme status.

```dart
LetsTheme.of(context).themeModeNotifier.addListener(() {
  // put your logic.
});
```

Or you can utilize it to react on UI with

```dart
ValueListenableBuilder(
  valueListenable: LetsTheme.of(context).themeModeNotifier,
  builder: (_, mode, child) {
    // update your UI
    return Container();
  },
);
```


