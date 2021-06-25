part of 'weather_bloc.dart';

class WeatherState extends BaseEquatable {}

class WeatherInitialState extends WeatherState {}

class WeatherLoadingState extends WeatherState {}

class WeatherLoadedState extends WeatherState {}

class WeatherFailureState extends WeatherState {}

class WeatherNavigationState extends WeatherState {}
