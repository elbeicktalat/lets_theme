import 'package:flutter/material.dart';
import 'package:lets_theme/lets_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final ThemeMode? themeMode = await LetsTheme.getThemeMode();

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
    return LetsTheme(
      light: ThemeData.light(),
      dark: ThemeData.dark(),
      initialMode: themeMode ?? ThemeMode.light,
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 8),
          child: Column(
            children: [
              const SizedBox(height: 12),
              Text(
                'Current Theme Mode',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              Text(
                LetsTheme.of(context).mode.name.toUpperCase(),
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(height: 24),
              const LetsThemeToggle(
                selectionMode: LetsThemeToggleSelectionMode.infinite,
                labels: [
                  'Day Mode',
                  'Night Mode',
                  'Auto Mode',
                ],
              ),
              const SizedBox(height: 24),
              const LetsThemeToggle.card(),
              const SizedBox(height: 24),
              const LetsThemeToggle.compact(),
              const SizedBox(height: 24),
              const LetsThemeToggle.label(),
              const SizedBox(height: 24),
              const LetsThemeToggle.icon(),
            ],
          ),
        ),
      ),
    );
  }
}
