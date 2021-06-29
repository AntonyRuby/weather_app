import 'package:weather_app/utils/images_resources.dart';

class Constants {
  static const String AppKey = "bdb33eb6babc9d7ceb7758159297c8ad";
  static const Map<String, String> WeatherImage = {
    "03d": ImageResource.thunder,
    "10d": ImageResource.rain,
    "01d": ImageResource.sunny
  };
  static const String AccessToken = "AccessToken";
  static const String RefreshToken = "RefreshToken";
  static const String FingerPrint = "FingerPrint";

  static const String Name = "NAME";
}
