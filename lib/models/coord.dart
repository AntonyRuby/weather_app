class Coord {
  double lon;
  double lat;

  Coord({this.lon, this.lat});

  factory Coord.fromJson(Map<String, dynamic> json) => Coord(
        lon: json['lon'] as double,
        lat: json['lat'] as double,
      );

  Map<String, dynamic> toJson() => {
        'lon': lon,
        'lat': lat,
      };
}
