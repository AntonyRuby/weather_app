import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:weather_app/http/repository/home_repository.dart';
import 'package:weather_app/models/open_weather_api.dart';
import 'package:weather_app/utils/base_equatable.dart';
part 'live_report_event.dart';
part 'live_report_state.dart';

class LiveReportBloc extends Bloc<LiveReportEvent, LiveReportState> {
  LiveReportBloc() : super(LiveReportInitialState());
  String message;
  OpenWeatherApi weather;
  String cityName;

  @override
  Stream<LiveReportState> mapEventToState(
    LiveReportEvent event,
  ) async* {
    if ((event is LiveReportInitialEvent) ||
        (event is LiveReportRefreshEvent)) {
      yield LiveReportloadingState();

      Map<String, dynamic> weatherData =
          await getWeather(cityName ?? "Chennai");

      if (weatherData["success"] == true) {
        Map<String, dynamic> jsonData = weatherData["data"];
        weather = OpenWeatherApi.fromJson(jsonData);

        yield LiveReportLoadedState();
      } else {
        message = weatherData["data"];
        yield LiveReportFailureState();
      }
    }
  }
}
