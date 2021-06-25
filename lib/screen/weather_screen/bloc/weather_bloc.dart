import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/http/repository/home_repository.dart';
import 'package:weather_app/models/open_weather_api.dart';
import 'package:weather_app/utils/base_equatable.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitialState());
  String message;
  OpenWeatherApi weather;
  String cityName;

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    if ((event is WeatherInitialEvent) || (event is WeatherRefreshEvent)) {
      yield WeatherLoadingState();

      Map<String, dynamic> weatherData =
          await getWeather(cityName ?? "Chennai");

      if (weatherData["success"] == true) {
        Map<String, dynamic> jsonData = weatherData["data"];
        weather = OpenWeatherApi.fromJson(jsonData);

        yield WeatherLoadedState();
      } else {
        message = weatherData["data"];
        yield WeatherFailureState();
      }
    }
  }
}
