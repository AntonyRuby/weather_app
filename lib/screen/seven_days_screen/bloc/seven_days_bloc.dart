import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:weather_app/http/repository/home_repository.dart';
import 'package:weather_app/models/open_weather_api.dart';
import 'package:weather_app/utils/base_equatable.dart';

part 'seven_days_event.dart';
part 'seven_days_state.dart';

class SevenDaysBloc extends Bloc<SevenDaysEvent, SevenDaysState> {
  SevenDaysBloc() : super(SevenDaysInitialState());
  String message;
  OpenWeatherApi weather;
  String cityName;

  @override
  Stream<SevenDaysState> mapEventToState(
    SevenDaysEvent event,
  ) async* {
    if ((event is SevenDaysInitialEvent) || (event is SevenDaysRefreshEvent)) {
      yield SevenDaysLoadingState();

      Map<String, dynamic> weatherData =
          await getWeather(cityName ?? "Chennai");

      if (weatherData["success"] == true) {
        Map<String, dynamic> jsonData = weatherData["data"];
        weather = OpenWeatherApi.fromJson(jsonData);

        yield SevenDaysLoadedState();
      } else {
        message = weatherData["data"];
        yield SevenDaysFailureState();
      }
    }
  }
}
