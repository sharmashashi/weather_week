import 'package:weather_week/features/weather_forecast/models/forecast.dart';

abstract class ForecastRepository {
  String get path;
  Future<Forecast> getForecast({required String city, String units});
}
