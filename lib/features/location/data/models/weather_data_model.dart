class WeatherData {
  final double temperature;
  final String condition;
  final String iconUrl;

  WeatherData({required this.temperature, required this.condition, required this.iconUrl});

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      temperature: json['current']['temp_c'],
      condition: json['current']['condition']['text'],
      iconUrl: json['current']['condition']['icon'],
    );
  }
}
