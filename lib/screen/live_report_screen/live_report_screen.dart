import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:weather_app/utils/color_resources.dart';
import 'package:weather_app/utils/images_resources.dart';
import 'package:weather_app/utils/string_resources.dart';
import 'package:weather_app/widget/custom_text.dart';
import 'bloc/live_report_bloc.dart';
import '../../utils/constant.dart';

class LiveReport extends StatefulWidget {
  @override
  _LiveReportState createState() => _LiveReportState();
}

class _LiveReportState extends State<LiveReport> {
  LiveReportBloc bloc;
  String dropdownValue = 'Chennai';
  @override
  void initState() {
    bloc = LiveReportBloc()..add(LiveReportInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LiveReportBloc, LiveReportState>(
        bloc: bloc,
        listener: (context, state) {},
        child: BlocBuilder<LiveReportBloc, LiveReportState>(
            bloc: bloc,
            builder: (context, state) {
              if (state is LiveReportloadingState) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is LiveReportFailureState) {
                return Center(child: Text(bloc.message));
              }
              if (state is LiveReportLoadedState) {
                // return GlowContainer(
                //   height: MediaQuery.of(context).size.height - 200,
                //   padding: EdgeInsets.all(12),
                //   glowColor: Colors.blue.shade500,
                //   borderRadius: BorderRadius.only(
                //       bottomLeft: Radius.circular(60),
                //       bottomRight: Radius.circular(60)),

                // spreadRadius: 5,
                return Container(
                  height: MediaQuery.of(context).size.height - 200,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.bottomCenter,
                        colors: [Colors.blue.shade400, Colors.blue.shade800],
                      ),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 4),
                            color: Colors.blueAccent,
                            spreadRadius: 5.0,
                            blurRadius: 5),
                      ],
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                          bottomRight: Radius.circular(50))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.grid_view,
                              color: Colors.white,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 3),
                                DropdownButton(
                                  value: dropdownValue,
                                  dropdownColor: Colors.blue,
                                  onChanged: (String newValue) {
                                    setState(() {
                                      dropdownValue = newValue;
                                      bloc.cityName = newValue;
                                      bloc.add(LiveReportRefreshEvent());
                                    });
                                  },
                                  items: <String>[
                                    StringResource.chennai,
                                    StringResource.bangalore,
                                    StringResource.delhi,
                                    StringResource.jammu,
                                    StringResource.kolkata,
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: CustomText(
                                        value,
                                        color: ColorResource.white,
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                            Icon(
                              Icons.more_vert,
                              color: Colors.white,
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.all(7),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.white24, width: 1),
                              borderRadius: BorderRadius.circular(40)),
                          child: CustomText(
                            StringResource.updating,
                          ),
                        ),
                        Container(
                          height: 370,
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20.0),
                                child: Image.asset(
                                  Constant.WeatherImage[
                                          bloc.weather.weather[0].icon] ??
                                      ImageResource.rain,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Center(
                                  child: GlowText(
                                    bloc.weather.main.temp.toString() +
                                        '\u00B0',
                                    style: TextStyle(
                                        fontSize: 60,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        CustomText(bloc.weather.weather[0].description,
                            fontSize: 20, fontWeight: FontWeight.bold),
                        CustomText(
                          StringResource.date,
                          color: ColorResource.white38,
                          fontSize: 14,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Divider(
                              color: ColorResource.white.withOpacity(0.5)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Details(
                                  CupertinoIcons.wind,
                                  bloc.weather.wind.speed.toString(),
                                  StringResource.wind),
                              Details(CupertinoIcons.drop, "24%",
                                  StringResource.humidity),
                              Details(CupertinoIcons.cloud_rain, "87%",
                                  StringResource.chanceOfRain)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return Container();
              }
            }));
  }
}

class Details extends StatelessWidget {
  final IconData icon;
  final String firstText;
  final String lastText;

  Details(this.icon, this.firstText, this.lastText);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            icon,
            color: Colors.white,
          ),
          SizedBox(
            height: 10,
          ),
          Text(firstText),
          Text(lastText, style: TextStyle(color: Colors.white54))
        ],
      ),
    );
  }
}
