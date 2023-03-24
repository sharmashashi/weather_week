import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:weather_week/core/services/http/http_service_impl.dart';
import 'package:weather_week/features/weather_forecast/models/forecast.dart';
import 'package:weather_week/features/weather_forecast/repository/forecast_repository_impl.dart';
import 'package:weather_week/features/weather_forecast/views/forecast_list.dart';
import 'package:weather_week/features/weather_forecast/views/weather_details.dart';

class WeatherScreenProvider extends ChangeNotifier {
  final cityFieldController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void onSearchClicked(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      try {
        await _getWeather(context);
      } catch (e) {
        log(e.toString());
        _disableLoading();
        _showSnackbar(context, 'Something went wrong. Please try again.');
      }
    }
  }

  String? textFieldValidator(String? value) {
    if (value!.length < 4 || value.isEmpty) {
      return "City name should have at least 4 characters!";
    }
    return null;
  }

  _enableLoading() {
    _weatherSelected = const LinearProgressIndicator();
    _weatherThisWeek = const SizedBox();
    notifyListeners();
  }

  _disableLoading() {
    _weatherSelected = const SizedBox();
    notifyListeners();
  }

  Future<void> _getWeather(BuildContext context) async {
    _enableLoading();
    final result = await ForecastRepositoryImpl(HttpServiceImpl())
        .getForecast(city: cityFieldController.text);
    if (result.cod == '200') {
      _handleOnSuccessfulFetchForecast(result);
    } else {
      log(result.message.toString());
      _disableLoading();
      // ignore: use_build_context_synchronously
      _showSnackbar(context, result.message);
    }
  }

  _showSnackbar(BuildContext context, String message) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Center(child: Text(message)),
      ));
    }
  }

  _handleOnSuccessfulFetchForecast(Forecast result) {
    final groupedByUniqueDay =
        groupBy(result.list!, (element) => element.dtTxt.day);
    final listElements = groupedByUniqueDay.values
        .map((e) => e.reduce((value, element) => value))
        .toList();

    _weatherThisWeek = ForecastList(
      listElements: listElements,
      city: result.city!,
      onWeatherDaySelect: (element, city) {
        _setSelectedWeather(element, city);
      },
    );
    _setSelectedWeather(listElements.first, result.city!);
  }

  _setSelectedWeather(ListElement element, City city) {
    _weatherSelected = WeatherDetails(
      listElement: element,
      city: city,
    );
    notifyListeners();
  }

  Widget _weatherThisWeek = const SizedBox();
  Widget _weatherSelected = const SizedBox();

  Widget get weatherThisWeek => _weatherThisWeek;
  Widget get weatherSelected => _weatherSelected;
}
