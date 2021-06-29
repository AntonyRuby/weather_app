import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:weather_app/screen/seven_days_screen/bloc/seven_days_bloc.dart';
import 'package:weather_app/utils/color_resources.dart';
import 'package:weather_app/utils/constant.dart';
import 'package:weather_app/utils/images_resources.dart';
import 'package:weather_app/utils/string_resources.dart';
import 'package:weather_app/widget/custom_text.dart';
import 'package:weather_app/widget/details.dart';

class SevenDaysScreen extends StatefulWidget {
  @override
  _SevenDaysScreenState createState() => _SevenDaysScreenState();
}

class _SevenDaysScreenState extends State<SevenDaysScreen> {
  SevenDaysBloc bloc;

  @override
  void initState() {
    // bloc = BlocProvider.of<SevenDaysBloc>(context);
    bloc = SevenDaysBloc()..add(SevenDaysInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SevenDaysBloc, SevenDaysState>(
        bloc: bloc,
        listener: (context, state) {},
        child: BlocBuilder<SevenDaysBloc, SevenDaysState>(
            bloc: bloc,
            builder: (context, state) {
              if (state is SevenDaysLoadingState) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is SevenDaysFailureState) {
                return Center(child: Text(""));
              }
              if (state is SevenDaysLoadedState) {
                return Scaffold(
                    backgroundColor: ColorResource.black,
                    body: SafeArea(
                        child: SingleChildScrollView(
                            child: Column(children: [
                      Container(
                        height: MediaQuery.of(context).size.height - 500,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                stops: [
                                  0.5,
                                  2
                                ],
                                colors: [
                                  Colors.blue.shade400,
                                  Colors.blueAccent.shade700
                                ]),
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
                          padding: const EdgeInsets.fromLTRB(8, 32, 8, 26),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      margin: EdgeInsets.all(10),
                                      padding: EdgeInsets.all(3),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: ColorResource.white38)),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Icon(
                                          Icons.arrow_back_ios,
                                          color: Colors.white,
                                          size: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.calendar_today,
                                        color: Colors.white,
                                        size: 15,
                                      ),
                                      SizedBox(width: 3),
                                      CustomText(StringResource.seven,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)
                                    ],
                                  ),
                                  Icon(
                                    Icons.more_vert,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: 150,
                                    child: Image.asset(
                                      Constants.WeatherImage[bloc.weather
                                              .list[0].weather[0].icon] ??
                                          ImageResource.rain,
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      CustomText(
                                        // bloc.weather.weather[0].description,
                                        StringResource.today,
                                        fontSize: 16,
                                      ),
                                      SizedBox(height: 5),
                                      GlowText(
                                        bloc.weather.list[0].main.temp
                                                .toString() +
                                            '\u00B0',
                                        style: TextStyle(
                                            fontSize: 40,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 5),
                                      CustomText(
                                        bloc.weather.list[0].weather[0]
                                            .description,
                                        color: ColorResource.white38,
                                        fontSize: 14,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Divider(
                                    color:
                                        ColorResource.white.withOpacity(0.5)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Details(
                                        CupertinoIcons.wind,
                                        bloc.weather.list[0].wind.speed
                                            .toString(),
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
                      ),
                      // Details

                      // _reportsWidget(),

                      _reportsWidget(
                        StringResource.mon,
                        ImageResource.rain,
                        StringResource.today,
                        StringResource.today,
                      ),
                      _reportsWidget(
                        StringResource.tue,
                        ImageResource.rain,
                        StringResource.today,
                        StringResource.today,
                      ),
                      _reportsWidget(
                        StringResource.wed,
                        ImageResource.sunny,
                        StringResource.today,
                        StringResource.today,
                      ),
                      _reportsWidget(
                        StringResource.thu,
                        ImageResource.thunder,
                        StringResource.today,
                        StringResource.today,
                      ),
                      _reportsWidget(
                        StringResource.fri,
                        ImageResource.rain,
                        StringResource.today,
                        StringResource.today,
                      ),
                      _reportsWidget(
                        StringResource.sat,
                        ImageResource.rain,
                        StringResource.today,
                        StringResource.today,
                      ),
                      _reportsWidget(
                        StringResource.sun,
                        ImageResource.rain,
                        StringResource.today,
                        StringResource.today,
                      ),

                      // Expanded(
                      //   child: ListView.builder(
                      //     itemCount: bloc.weather.list.length,
                      //     itemBuilder: (BuildContext context, int index) {
                      //       return Padding(
                      //         padding: const EdgeInsets.only(top: 30),
                      //         child: Row(
                      //           mainAxisAlignment:
                      //               MainAxisAlignment.spaceAround,
                      //           children: [
                      //             CustomText(
                      //               bloc.weather.list[index].dtTxt,
                      //               fontSize: 14,
                      //               color: ColorResource.white54,
                      //             ),
                      //             Row(
                      //               children: [
                      //                 // Image.asset(
                      //                 //   // image,
                      //                 //   height: 25,
                      //                 //   width: 25,
                      //                 // ),
                      //                 SizedBox(width: 5),
                      //                 CustomText(
                      //                   bloc.weather.list[0].weather[0].main,
                      //                   fontSize: 14,
                      //                   color: ColorResource.white54,
                      //                 ),
                      //               ],
                      //             ),
                      //             Row(
                      //               children: [
                      //                 CustomText(
                      //                   bloc.weather.list[index].main.tempMax
                      //                       .toString(),
                      //                   fontSize: 14,
                      //                   color: ColorResource.white54,
                      //                 ),
                      //                 SizedBox(width: 2),
                      //                 CustomText(
                      //                   bloc.weather.list[index].main.tempMin
                      //                       .toString(),
                      //                   fontSize: 14,
                      //                   color: ColorResource.white54,
                      //                 ),
                      //               ],
                      //             ),
                      //           ],
                      //         ),
                      //       );
                      //     },
                      //   ),
                      // )
                    ]))));
              } else {
                return Container();
              }
            }));
  }

  Widget _reportsWidget(String day, String image, String temp, String temp1) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CustomText(
            bloc.weather.list[0].dtTxt,
            fontSize: 14,
            color: ColorResource.white54,
          ),
          Row(
            children: [
              Image.asset(
                image,
                height: 25,
                width: 25,
              ),
              SizedBox(width: 5),
              CustomText(
                bloc.weather.list[0].weather[0].main,
                fontSize: 14,
                color: ColorResource.white54,
              ),
            ],
          ),
          Row(
            children: [
              CustomText(
                bloc.weather.list[0].main.tempMax.toString(),
                fontSize: 14,
                color: ColorResource.white54,
              ),
              SizedBox(width: 2),
              // CustomText(
              //   bloc.weather.list[0].main.tempMin.toString(),
              //   fontSize: 14,
              //   color: ColorResource.white54,
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
