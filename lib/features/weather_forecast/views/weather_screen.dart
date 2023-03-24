import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_week/features/weather_forecast/providers/weather_screen_provider.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ChangeNotifierProvider(
          create: (context) => WeatherScreenProvider(),
          child: _body(),
        ),
      ),
    );
  }

  _body() {
    return Consumer<WeatherScreenProvider>(
      builder: (context, state, child) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Flexible(
                    child: Form(
                        key: state.formKey,
                        child: TextFormField(
                          controller: state.cityFieldController,
                          validator: state.textFieldValidator,
                          autovalidateMode: AutovalidateMode.disabled,
                          decoration: const InputDecoration(
                            isDense: true,
                          ),
                        )),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      state.onSearchClicked(context);
                    },
                    child: Row(children: const [
                      Text("Search"),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(Icons.search)
                    ]),
                  )
                ],
              ),
              state.weatherSelected,
              const SizedBox(
                height: 10,
              ),
              Expanded(child: state.weatherThisWeek)
            ],
          ),
        );
      },
    );
  }
}
