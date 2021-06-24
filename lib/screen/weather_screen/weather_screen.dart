import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/screen/live_report_screen/live_report_screen.dart';
import 'package:weather_app/screen/today_report_screen/today_report_screen.dart';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                LiveReport(),
                SizedBox(
                  height: 10,
                ),
                TodayReport(),
              ],
            ),
          ),
        ));
  }
}
