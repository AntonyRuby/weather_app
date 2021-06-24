part of 'live_report_bloc.dart';

class LiveReportState extends BaseEquatable {}

class LiveReportInitialState extends LiveReportState {}

class LiveReportloadingState extends LiveReportState {}

class LiveReportLoadedState extends LiveReportState {
  // final Weather weatherData;
  // LiveReportLoadedState({this.weatherData});
}

class LiveReportFailureState extends LiveReportState {}
