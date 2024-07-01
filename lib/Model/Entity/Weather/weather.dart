class Weather {
  final String type;
  final String date;
  final double rainfall;

  Weather({
    required this.type,
    required this.date,
    required this.rainfall,
  });

  factory Weather.nowDataFromJson(Map<String, dynamic> json) {
    const int minuets = 0;
    return Weather(
      type: json['YDF']['Feature']['Property']['WeatherList']['Weather'][minuets]['Type'], // json['type
      date: json['YDF']['Feature']['Property']['WeatherList']['Weather'][minuets]['Date'], // json['date']
      rainfall: double.parse(json['YDF']['Feature']['Property']['WeatherList']['Weather'][minuets]['Rainfall']),
    );
  }

  factory Weather.afterOneHourDataFromJson(Map<String, dynamic> json) {
    const int minuets = 6;
    return Weather(
      type: json['YDF']['Feature']['Property']['WeatherList']['Weather'][minuets]['Type'], // json['type
      date: json['YDF']['Feature']['Property']['WeatherList']['Weather'][minuets]['Date'], // json['date']
      rainfall: double.parse(json['YDF']['Feature']['Property']['WeatherList']['Weather'][minuets]['Rainfall']),
    );
  }
}
