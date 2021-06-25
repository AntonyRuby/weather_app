import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/screen/seven_days_screen/bloc/seven_days_bloc.dart';
import 'package:weather_app/screen/seven_days_screen/seven_days_screen.dart';
import 'package:weather_app/screen/weather_screen/bloc/weather_bloc.dart';
import 'package:weather_app/screen/weather_screen/weather_screen.dart';
import 'authentication/bloc/authentication_bloc.dart';

class AppRoutes {
  static const sevenDaysScreen = 'seven_days_screen';
  static const weatherScreen = 'weather_screen';
}

Route<dynamic> getRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.sevenDaysScreen:
      return _buildSevenDaysScreen();

    case AppRoutes.weatherScreen:
      return _buildWeatherScreen();
  }
}

Route<dynamic> _buildSevenDaysScreen() {
  return MaterialPageRoute(
    builder: (context) =>
        addAuthBloc(context, PageBuilder.buildSevenDaysScreen()),
  );
}

Route<dynamic> _buildWeatherScreen() {
  return MaterialPageRoute(
    builder: (context) =>
        addAuthBloc(context, PageBuilder.buildWeatherScreen()),
  );
}

class PageBuilder {
  static Widget buildSevenDaysScreen() {
    return BlocProvider(
      create: (context) {
        return SevenDaysBloc()..add(SevenDaysInitialEvent());
      },
      child: SevenDaysScreen(),
    );
  }

  static Widget buildWeatherScreen() {
    return BlocProvider(
      create: (context) {
        return WeatherBloc()..add(WeatherInitialEvent());
      },
      child: WeatherScreen(),
    );
  }
}

Widget addAuthBloc(BuildContext context, Widget widget) {
  return BlocListener(
    bloc: BlocProvider.of<AuthenticationBloc>(context),
    listener: (context, state) {
      if (state is AuthenticationAuthenticated) {
        Navigator.pushReplacementNamed(context, AppRoutes.weatherScreen);
      }
    },
    child: BlocBuilder(
      bloc: BlocProvider.of<AuthenticationBloc>(context),
      builder: (context, state) {
        return widget;
      },
    ),
  );
}
