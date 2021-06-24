class Main {
  double temp;
  double feelsLike;
  double tempMin;
  double tempMax;
  int pressure;
  int humidity;

  Main({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.humidity,
  });

  factory Main.fromJson(Map<String, dynamic> json) => Main(
        temp: json['temp'] as double,
        feelsLike: json['feels_like'] as double,
        tempMin: json['temp_min'] as double,
        tempMax: json['temp_max'] as double,
        pressure: json['pressure'] as int,
        humidity: json['humidity'] as int,
      );

  Map<String, dynamic> toJson() => {
        'temp': temp,
        'feels_like': feelsLike,
        'temp_min': tempMin,
        'temp_max': tempMax,
        'pressure': pressure,
        'humidity': humidity,
      };
}
