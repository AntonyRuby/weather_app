class Wind {
  double speed;
  int deg;
  double gust;

  Wind({this.speed, this.deg, this.gust});

  factory Wind.fromJson(Map<String, dynamic> json) => Wind(
        // speed: json['speed'] as double,
        speed: json['speed'] is int
            ? (json['speed'] as int).toDouble()
            : json['speed'],
        deg: json['deg'] as int,
        // gust: json['gust'] as double,
        gust: json['gust'] is int
            ? (json['gust'] as int).toDouble()
            : json['gust'],
      );

  Map<String, dynamic> toJson() => {
        'speed': speed,
        'deg': deg,
        'gust': gust,
      };
}
