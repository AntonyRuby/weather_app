import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:weather_app/http/repository/home_repository.dart';
import 'package:weather_app/models/seven_days_models/seven_days.dart';
import 'package:weather_app/utils/base_equatable.dart';
part 'seven_days_event.dart';
part 'seven_days_state.dart';

class SevenDaysBloc extends Bloc<SevenDaysEvent, SevenDaysState> {
  SevenDaysBloc() : super(SevenDaysInitialState());
  String message;
  SevenDays weather;
  String cityName;

  @override
  Stream<SevenDaysState> mapEventToState(
    SevenDaysEvent event,
  ) async* {
    if ((event is SevenDaysInitialEvent) || (event is SevenDaysRefreshEvent)) {
      yield SevenDaysLoadingState();

      Map<String, dynamic> weatherData =
          await getSevenDays(cityName ?? "Chennai");

      if (weatherData["success"] == true) {
        Map<String, dynamic> jsonData = weatherData["data"];
        weather = SevenDays.fromJson(jsonData);

        yield SevenDaysLoadedState();
      } else {
        message = weatherData["data"];
        yield SevenDaysFailureState();
      }
    }
  }
}
