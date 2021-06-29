import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:weather_app/utils/color_resources.dart';
import 'package:weather_app/utils/constant.dart';
import 'package:weather_app/utils/images_resources.dart';
import 'package:weather_app/utils/string_resources.dart';
import 'package:weather_app/widget/custom_text.dart';
import 'package:weather_app/widget/details.dart';
import '../../router.dart';
import 'bloc/weather_bloc.dart';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  WeatherBloc bloc;
  String dropdownValue = 'Chennai';
  @override
  void initState() {
    bloc = WeatherBloc()..add(WeatherInitialEvent());
    // bloc = BlocProvider.of<WeatherBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<WeatherBloc, WeatherState>(
      bloc: bloc,
      listener: (context, state) {},
      child: BlocBuilder<WeatherBloc, WeatherState>(
          bloc: bloc,
          builder: (context, state) {
            if (state is WeatherLoadingState) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is WeatherFailureState) {
              return Center(child: Text(bloc.message));
            }
            if (state is WeatherLoadedState) {
              return Scaffold(
                  backgroundColor: Colors.black,
                  body: SafeArea(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          //  _liveReportScreen();
                          Container(
                              height: MediaQuery.of(context).size.height - 200,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.blue.shade400,
                                      Colors.blue.shade800
                                    ],
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                                  bloc.add(
                                                      WeatherRefreshEvent());
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
                                          border: Border.all(
                                              color: Colors.white24, width: 1),
                                          borderRadius:
                                              BorderRadius.circular(40)),
                                      child: CustomText(
                                        StringResource.updating,
                                      ),
                                    ),
                                    Container(
                                      height: 300,
                                      child: Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 20.0),
                                          child: Image.asset(
                                            Constants.WeatherImage[bloc
                                                    .weather.weather[0].icon] ??
                                                ImageResource.rain,
                                          )),
                                    ),
                                    Center(
                                      child: GlowText(
                                        bloc.weather.main.temp.toString() +
                                            '\u00B0',
                                        style: TextStyle(
                                            fontSize: 60,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    CustomText(
                                        bloc.weather.weather[0].description,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                    CustomText(
                                      StringResource.date,
                                      color: ColorResource.white38,
                                      fontSize: 14,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Divider(
                                          color: ColorResource.white
                                              .withOpacity(0.5)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Details(
                                              CupertinoIcons.wind,
                                              bloc.weather.wind.speed
                                                  .toString(),
                                              StringResource.wind),
                                          Details(CupertinoIcons.drop, "24%",
                                              StringResource.humidity),
                                          Details(
                                              CupertinoIcons.cloud_rain,
                                              "87%",
                                              StringResource.chanceOfRain)
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )),

                          // TodayReportScreen(),

                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(
                                      StringResource.today,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, AppRoutes.sevenDaysScreen);
                                      },
                                      child: Row(
                                        children: [
                                          CustomText(
                                            StringResource.selevenDays,
                                            color: ColorResource.white54,
                                            fontSize: 12,
                                          ),
                                          SizedBox(width: 3),
                                          Icon(
                                            Icons.arrow_forward_ios_outlined,
                                            color: ColorResource.white,
                                            size: 12,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 25.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      _todayReport("23" + '\u00B0',
                                          ImageResource.rain, "10:00"),
                                      _todayReport("21" + '\u00B0',
                                          ImageResource.thunder, "11:00"),
                                      _todayReport("22" + '\u00B0',
                                          ImageResource.sunny, "12:00"),
                                      _todayReport("19" + '\u00B0',
                                          ImageResource.rain, "01:00"),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ));
            } else {
              return Container();
            }
          }),
    );
  }

  Widget _todayReport(String text, String image, String time) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white10, width: 1),
          borderRadius: BorderRadius.circular(40)),
      child: Column(
        children: [
          Text(text),
          SizedBox(
            height: 7,
          ),
          Image.asset(
            image,
            height: 50,
            width: 50,
          ),
          Text(time)
        ],
      ),
    );
  }
}
