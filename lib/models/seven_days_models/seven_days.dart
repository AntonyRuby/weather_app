import 'city.dart';
import 'list.dart';

class SevenDays {
  String cod;
  int message;
  int cnt;
  List<DataList> list;
  City city;

  SevenDays({this.cod, this.message, this.cnt, this.list, this.city});

  factory SevenDays.fromJson(Map<String, dynamic> json) => SevenDays(
        cod: json['cod'] as String,
        message: json['message'] as int,
        cnt: json['cnt'] as int,
        list: (json['list'] as List<dynamic>)
            ?.map((e) => DataList.fromJson(e as Map<String, dynamic>))
            ?.toList(),
        city: json['city'] == null
            ? null
            : City.fromJson(json['city'] as Map<String, dynamic>),
      );
}
