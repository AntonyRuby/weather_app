import 'package:flutter/material.dart';
import 'package:weather_app/utils/color_resources.dart';
import 'package:weather_app/utils/images_resources.dart';
import 'package:weather_app/utils/string_resources.dart';
import 'package:weather_app/widget/custom_text.dart';

class TodayReport extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                StringResource.today,
                fontWeight: FontWeight.bold,
              ),
              Row(
                children: [
                  CustomText(
                    StringResource.selevenDays,
                    color: ColorResource.grey,
                  ),
                  Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: ColorResource.white,
                    size: 12,
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Today("23" + '\u00B0', ImageResource.rain, "10:00"),
                Today("21" + '\u00B0', ImageResource.thunder, "11:00"),
                Today("22" + '\u00B0', ImageResource.sunny, "12:00"),
                Today("19" + '\u00B0', ImageResource.rain, "01:00"),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class Today extends StatelessWidget {
  final String text;
  final String image;
  final String time;

  Today(this.text, this.image, this.time);
  @override
  Widget build(BuildContext context) {
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
