import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather_week/core/utils/extensions.dart';
import 'package:weather_week/features/weather_forecast/models/forecast.dart';

class WeatherDetails extends StatelessWidget {
  final City city;
  final ListElement listElement;
  const WeatherDetails(
      {super.key, required this.listElement, required this.city});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              city.name,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(
                '${listElement.dtTxt.day} ${listElement.dtTxt.dayName}, ${listElement.dtTxt.monthName}')
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${listElement.main.temp} \u00b0',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  Text(listElement.weather.first.main)
                ],
              ),
              Image.network(
                'https://openweathermap.org/img/wn/${listElement.weather.first.icon}@4x.png',
                height: 150,
              )
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Theme.of(context).primaryColor.withAlpha(25)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _otherData(
                  iconData: FontAwesomeIcons.wind,
                  type: 'Wind',
                  data: '${listElement.wind.speed} km/h'),
              _otherData(
                  iconData: FontAwesomeIcons.droplet,
                  type: 'Humidity',
                  data: '${listElement.main.humidity}%'),
              _otherData(
                  iconData: Icons.foggy,
                  type: 'Visibility',
                  data: '${listElement.visibility / 1000} km'),
            ],
          ),
        )
      ],
    );
  }

  _otherData(
      {required IconData iconData,
      required String type,
      required String data}) {
    return Builder(builder: (context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            iconData,
            color: Theme.of(context).primaryColor,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              type,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          Text(
            data,
            style: Theme.of(context).textTheme.bodySmall,
          )
        ],
      );
    });
  }
}
