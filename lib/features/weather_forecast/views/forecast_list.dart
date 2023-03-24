import 'package:flutter/material.dart';
import 'package:weather_week/core/utils/callbacks.dart';
import 'package:weather_week/core/utils/extensions.dart';
import 'package:weather_week/features/weather_forecast/models/forecast.dart';

class ForecastList extends StatefulWidget {
  final OnWeatherDaySelect onWeatherDaySelect;
  final City city;
  final List<ListElement> listElements;
  const ForecastList(
      {super.key,
      required this.listElements,
      required this.onWeatherDaySelect,
      required this.city});

  @override
  State<ForecastList> createState() => _ForecastListState();
}

class _ForecastListState extends State<ForecastList> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.listElements.length,
        itemBuilder: (ctx, index) {
          return ForecastCard(
            city: widget.city,
            onWeatherDaySelect: widget.onWeatherDaySelect,
            listElement: widget.listElements[index],
            index: index,
            onDaySelect: (selectedIndex) {
              setState(() {
                this.selectedIndex = selectedIndex;
              });
            },
            isSelected: selectedIndex == index,
          );
        });
  }
}

class ForecastCard extends StatelessWidget {
  final City city;
  final OnWeatherDaySelect onWeatherDaySelect;
  final ListElement listElement;
  final bool isSelected;
  final OnDaySelect onDaySelect;
  final int index;
  const ForecastCard(
      {super.key,
      required this.isSelected,
      required this.listElement,
      required this.city,
      required this.onDaySelect,
      required this.onWeatherDaySelect,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onDaySelect(index);
        onWeatherDaySelect(listElement, city);
      },
      child: Container(
        padding: isSelected
            ? const EdgeInsets.symmetric(vertical: 20, horizontal: 8)
            : const EdgeInsets.all(8),
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
            color:
                Theme.of(context).primaryColor.withAlpha(isSelected ? 100 : 10),
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 100,
              child: Text(
                  DateTime.now().day == listElement.dtTxt.day
                      ? 'Today'
                      : listElement.dtTxt.dayName!,
                  style: Theme.of(context).textTheme.titleSmall),
            ),
            Text('${listElement.main.tempMin.toStringAsFixed(2)}\u00b0',
                style: Theme.of(context).textTheme.bodySmall),
            Text('\u2014', style: Theme.of(context).textTheme.bodySmall),
            Text('${listElement.main.tempMax.toStringAsFixed(2)}\u00b0',
                style: Theme.of(context).textTheme.bodySmall),
            Image.network(
              'https://openweathermap.org/img/wn/${listElement.weather.first.icon}.png',
              errorBuilder: (context, error, stackTrace) => const SizedBox(),
            )
          ],
        ),
      ),
    );
  }
}
