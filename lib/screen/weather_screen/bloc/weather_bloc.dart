import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:weather_app/http/repository/home_repository.dart';
import 'package:weather_app/models/seven_days_models/seven_days.dart';
import 'package:weather_app/models/weather_models/open_weather_api.dart';
import 'package:weather_app/utils/base_equatable.dart';
part 'weather_event.dart';
part 'weather_state.dart';

// class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
//   WeatherBloc() : super(WeatherInitialState());
//   String message;
//   OpenWeatherApi weather;
//   String cityName;

//   @override
//   Stream<WeatherState> mapEventToState(
//     WeatherEvent event,
//   ) async* {
//     if ((event is WeatherInitialEvent) || (event is WeatherRefreshEvent)) {
//       yield WeatherLoadingState();

//       Map<String, dynamic> weatherData =
//           await getWeather(cityName ?? "Chennai");

//       if (weatherData["success"] == true) {
//         Map<String, dynamic> jsonData = weatherData["data"];
//         weather = OpenWeatherApi.fromJson(jsonData);

//         yield WeatherLoadedState();
//       } else {
//         message = weatherData["data"];
//         yield WeatherFailureState();
//       }
//     }
//   }
// }

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitialState());
  String message;
  SevenDays weather;
  String cityName = "Chennai";

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    if (event is WeatherInitialEvent) {
      yield WeatherInitialState();

      Map<String, dynamic> weatherData = await getSevenDays(cityName);

      if (weatherData["success"] == true) {
        Map<String, dynamic> jsonData = weatherData["data"];
        weather = SevenDays.fromJson(jsonData);

        yield WeatherLoadedState();
      } else {
        message = weatherData["data"];
        yield WeatherFailureState();
      }
    }
    if (event is WeatherRefreshEvent) {
      yield WeatherLoadingState();

      Map<String, dynamic> weatherData = await getSevenDays(cityName);

      if (weatherData["success"] == true) {
        Map<String, dynamic> jsonData = weatherData["data"];
        weather = SevenDays.fromJson(jsonData);

        yield WeatherLoadedState();
      } else {
        message = weatherData["data"];
        yield WeatherFailureState();
      }
    }
  }
}
