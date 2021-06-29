import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/router.dart';
import 'package:weather_app/screen/seven_days_screen/bloc/seven_days_bloc.dart';
import 'authentication/bloc/authentication_bloc.dart';
import 'bloc.dart';
import 'screen/weather_screen/weather_screen.dart';

void main(List<String> args) {
  Bloc.observer = EchoBlocDelegate();
  runApp(BlocProvider<AuthenticationBloc>(
    create: (BuildContext context) {
      return AuthenticationBloc()..add(AppStartedEvent());
    },
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AuthenticationBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<AuthenticationBloc>(context);
    super.initState();
  }

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
        onGenerateRoute: getRoute,
        home: addAuthBloc(
          context,
          WeatherScreen(),
        ));
  }
}
