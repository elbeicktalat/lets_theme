import 'package:flutter/material.dart';
import 'package:sky_theme/sky_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final ThemeMode? themeMode = await SkyTheme.getThemeMode();

  runApp(MyApp(themeMode));
}

class MyApp extends StatelessWidget {
  const MyApp(
    this.themeMode, {
    super.key,
  });

  final ThemeMode? themeMode;

  @override
  Widget build(BuildContext context) {
    return SkyTheme(
      light: ThemeData.light(),
      dark: ThemeData.dark(),
      initialMode: themeMode ?? ThemeMode.system,
      builder: (ThemeData light, ThemeData dark) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: light,
          darkTheme: dark,
          home: const MyHomePage(title: 'Flutter Demo Home Page'),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
          const SkyThemeToggle(
            selectionMode: SkyThemeToggleSelectionMode.specific,
            labels: [
              'Day Mode',
              'Night Mode',
              'Auto Mode',
            ],
          ),
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
}
