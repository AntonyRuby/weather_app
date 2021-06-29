class Rain {
  double h3;

  Rain({this.h3});

  factory Rain.fromJson(Map<String, dynamic> json) => Rain(
        h3: json['3h'] as double,
      );

  Map<String, dynamic> toJson() => {
        '3h': h3,
      };
}
