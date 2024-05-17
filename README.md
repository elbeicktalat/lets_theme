# Easy Theme

The easiest way to control your app theme, this package provides couple of widgets to change
between **system and** **light/dark** theme.

[![Github stars](https://img.shields.io/github/stars/elbeicktalat/sky_theme?logo=github)](https://github.com/elbeicktalat/sky_theme)
[![Pub Version](https://img.shields.io/pub/v/sky_theme?color=blue&logo=dart)](https://pub.dev/packages/smart_theme)

## Index

- [Initialization](#initialization)
- [Getting Started](#getting-started)
- [Handling App Start](#get-themeMode-at-app-start)
- [Sky Theme Toggle Widget](#sky-theme-toggle-widget)
- [Sky Theme Toggle Widget Customization](#sky-theme-toggle-widget-customization)
- [Changing Theme Mode](#changing-theme-mode)
- [Toggle Theme Mode](#toggle-theme-mode)
- [Changing Themes](#changing-themes)
- [Reset Theme](#reset-theme)
- [Handling Theme Changes](#listen-to-the-theme-mode-changes)

## Initialization

Add this to your packages pubspec.yaml file:

```yaml
dependencies:
  sky_theme: <^last>
  shared_preferences: <^last>
```

## Getting Started

```dart
import 'package:sky_theme/sky_theme.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SkyTheme(
      light: ThemeData.light(useMaterial3: true),
      dark: ThemeData.dark(useMaterial3: true), 
      initialMode: ThemeMode.system, // bad: I'll in more detail below, but you need to know that this would fine if we don't save any preferences.
      builder: (ThemeData light, ThemeData dark) => MaterialApp(
        title: 'Easy Theme Demo',
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
  final savedThemeMode = await SkyTheme.getThemeMode();
  runApp(MyApp(savedThemeMode: savedThemeMode));
}
```

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SkyTheme(
      light: ThemeData.light(useMaterial3: true),
      dark: ThemeData.dark(useMaterial3: true),
      initial: savedThemeMode ?? ThemeMode.system, // good
      builder: (ThemeData light, ThemeData dark) => MaterialApp(
        title: 'Easy Theme Demo',
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

## Sky Theme Toggle Widget

A full-featured widget to play with for changing theme mode, this widget will save your time,
since it already includes the following widgets out of the box.

|                                                      Light                                                       |                                                 Dark                                                 |
|:----------------------------------------------------------------------------------------------------------------:|:----------------------------------------------------------------------------------------------------:|
| ![img.png](https://raw.githubusercontent.com/elbeicktalat/sky_theme/main/.doc/readme/light_theme_customized.png) | ![img.png](https://raw.githubusercontent.com/elbeicktalat/sky_theme/main/.doc/readme/dark_theme.png) |

|                                                 System Light                                                 |                                                 System Dark                                                 |
|:------------------------------------------------------------------------------------------------------------:|:-----------------------------------------------------------------------------------------------------------:|
| ![img.png](https://raw.githubusercontent.com/elbeicktalat/sky_theme/main/.doc/readme/system_light_theme.png) | ![img.png](https://raw.githubusercontent.com/elbeicktalat/sky_theme/main/.doc/readme/system_dark_theme.png) |

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
            SkyTheme.of(context).mode.name.toUpperCase(),
            style: Theme.of(context).textTheme.displaySmall,
          ),
        ),
        const SizedBox(height: 24),
        const SkyThemeToggle(),
        const SizedBox(height: 24),
        const SkyThemeToggle.compact(),
        const SizedBox(height: 24),
        const SkyThemeToggle.label(),
        const SizedBox(height: 24),
        const SkyThemeToggle.icon(),
      ],
    ),
  );
}
```

Yes, this is all that you need 👆 the `SkyThemeToggle` widget will manage everything for you!
As per example, there are multiple types of `SkyThemeToggle` such as `SkyThemeToggle.compact` so try them by yourself 😇  

## Sky Theme Toggle Widget Customization

As for now, there are no too many things to customize, but you still be able to customize the labels and icons.
I show you how:

```dart
const SkyThemeToggle() // before

// after
const SkyThemeToggle(
  labels: [
    'Day Mode',
    'Night Mode',
    'Auto Mode',
  ],
)
```


|                                                Before                                                 |                                                      Afters                                                      |
|:-----------------------------------------------------------------------------------------------------:|:----------------------------------------------------------------------------------------------------------------:|
| ![img.png](https://raw.githubusercontent.com/elbeicktalat/sky_theme/main/.doc/readme/light_theme.png) | ![img.png](https://raw.githubusercontent.com/elbeicktalat/sky_theme/main/.doc/readme/light_theme_customized.png) |


Tip: **icons** are not available in `SkyThemeToggle()` also **labels** are not available `SkyThemeToggle.icon()`

One last customization, you can control the behavior of how the toggles dose the changes.
There is 2 types of changing. One is `infinite` and next is `spesific`, the first dose accepts clicks on any Toggle, 
and everytime you click any one of the toggles, the selection moves to the next. The Second one instead,
moves straight away to the toggle you clicked on, changing the theme to what you have clicked on.  

[Video](https://raw.githubusercontent.com/elbeicktalat/sky_theme/main/.doc/readme/sky_toggle_selection_mode_demo.mp4)

```dart
const SkyThemeToggle(
  selectionMode: SkyThemeToggleSelectionMode.infinite,
)

// defaults
const SkyThemeToggle.compact(
  selectionMode: SkyThemeToggleSelectionMode.specific,
)
```

## Changing Theme Mode

Now that you have initialized your app as mentioned above. It's very easy and straight forward to
change your theme modes: **light to dark, dark to light or to system default**.

```dart
// sets theme mode to dark
SkyTheme.of(context).setDark();

// sets theme mode to light
SkyTheme.of(context).setLight();

// sets theme mode to system default
SkyTheme.of(context).setSystem();

// sets theme mode to light if current theme is dark and vice-versa.
SkyTheme.of(context).changeThemeMode();
```

## Toggle Theme Mode

`SkyTheme` allows you to toggle between light, dark and system theme the easiest way possible.

```dart
SkyTheme.of(context).toggleThemeMode();
```

Everytime you call this method the `ThemeData` will change starting from **Light** to **Dark** 
ending with **System Defaults**

## Changing Themes

If you want to change the theme entirely like changing all the colors to some other color swatch,
then you can use `setTheme` method.

```dart
SkyTheme.of(context).setTheme(
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

`SkyTheme` is smart enough to keep your hardcoded **default** themes provided at the time of initialization.
You can fall back to those default themes in a straightforward way.

```dart
SkyTheme.of(context).reset();
```

This will reset your `ThemeData` as well as `ThemeMode` to the **initial** values provided at the time of initialization.

## Listen to the theme mode changes

You can listen to the changes in the theme mode via a `ValueNotifier`. This can be useful when designing theme settings
screen or developing ui to show theme status.

```dart
SkyTheme.of(context).themeModeNotifier.addListener(() {
  // put your logic.
});
```

Or you can utilize it to react on UI with

```dart
ValueListenableBuilder(
  valueListenable: SkyTheme.of(context).themeModeNotifier,
  builder: (_, mode, child) {
    // update your UI
    return Container();
  },
);
```


