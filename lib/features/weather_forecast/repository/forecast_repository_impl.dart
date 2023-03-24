import 'package:weather_week/core/configs/configs.dart';
import 'package:weather_week/core/services/http/http_service.dart';
import 'package:weather_week/features/weather_forecast/models/forecast.dart';
import 'package:weather_week/features/weather_forecast/repository/forecast_repository.dart';

class ForecastRepositoryImpl implements ForecastRepository {
  final HttpService httpService;
  ForecastRepositoryImpl(this.httpService);
  @override
  Future<Forecast> getForecast(
      {required String city, String units = 'metric'}) async {
    final Map<String, dynamic> queryParameters = {
      'q': city,
      'units': units,
      'appid': Configs.openWeatherApiKey
    };
    final json = await httpService.get(Configs.openWeatherBaseUrl + path,
        queryParameters: queryParameters);

    return Forecast.fromJson(json);
  }

  @override
  String get path => '/forecast';
}
