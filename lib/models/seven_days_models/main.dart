class Main {
  double temp;
  double feelsLike;
  double tempMin;
  double tempMax;
  int pressure;
  int seaLevel;
  int grndLevel;
  int humidity;
  double tempKf;

  Main({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.seaLevel,
    this.grndLevel,
    this.humidity,
    this.tempKf,
  });

  factory Main.fromJson(Map<String, dynamic> json) => Main(
        temp: json['temp'] as double,
        // feelsLike: json['feels_like'] as double,
        feelsLike: json['feelsLike'] is int
            ? (json['feelsLike'] as int).toDouble()
            : json['feelsLike'],

        tempMin: json['temp_min'] as double,
        tempMax: json['temp_max'] as double,
        pressure: json['pressure'] as int,
        seaLevel: json['sea_level'] as int,
        grndLevel: json['grnd_level'] as int,
        humidity: json['humidity'] as int,
        // tempKf: json['temp_kf'] as double,
        tempKf: json['temp_kf'] is int
            ? (json['temp_kf'] as int).toDouble()
            : json['temp_kf'],
      );

  Map<String, dynamic> toJson() => {
        'temp': temp,
        'feels_like': feelsLike,
        'temp_min': tempMin,
        'temp_max': tempMax,
        'pressure': pressure,
        'sea_level': seaLevel,
        'grnd_level': grndLevel,
        'humidity': humidity,
        'temp_kf': tempKf,
      };
}
