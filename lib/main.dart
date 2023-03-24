import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_week/features/weather_forecast/views/weather_screen.dart';

void main() async {
  dotenv.load(fileName: '.env');
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // themeMode: ThemeMode.dark,
      home: const WeatherScreen(),
      theme: FlexColorScheme.light().toTheme,
      darkTheme: FlexColorScheme.dark().toTheme,
    );
  }
}
