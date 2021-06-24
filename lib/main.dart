import 'package:flutter/material.dart';

import 'screen/weather_screen/weather_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
          textTheme: Theme.of(context).textTheme.apply(
                bodyColor: Colors.white,
                displayColor: Colors.blue,
              )),
      debugShowCheckedModeBanner: false,
      home: WeatherScreen(),
    );
  }
}
