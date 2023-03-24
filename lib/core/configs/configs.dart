import 'package:flutter_dotenv/flutter_dotenv.dart';

class Configs {
  static final openWeatherApiKey = dotenv.get('open_weather_api_key');
  static const String openWeatherBaseUrl =
      'https://api.openweathermap.org/data/2.5';
}
