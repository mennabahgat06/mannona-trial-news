/// Current weather from OpenWeather (requested with units=metric).
class WeatherModel {
  final String cityName;
  final String country;
  final double temp;
  final String condition;
  final String description;
  final double feelsLike;
  final int humidity;
  final double windSpeed;
  final int pressure;

  WeatherModel({
    required this.cityName,
    required this.country,
    required this.temp,
    required this.condition,
    required this.description,
    required this.feelsLike,
    required this.humidity,
    required this.windSpeed,
    required this.pressure,
  });

  double get fahrenheit => temp * 9 / 5 + 32;

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    final main = json['main'] ?? {};
    final weatherList = json['weather'] as List? ?? [];
    final weather = weatherList.isNotEmpty ? weatherList.first : {};
    final wind = json['wind'] ?? {};
    final sys = json['sys'] ?? {};

    return WeatherModel(
      cityName: json['name'] ?? '',
      country: sys['country'] ?? '',
      temp: (main['temp'] as num? ?? 0).toDouble(),
      condition: weather['main'] ?? '',
      description: weather['description'] ?? '',
      feelsLike: (main['feels_like'] as num? ?? 0).toDouble(),
      humidity: (main['humidity'] as num? ?? 0).toInt(),
      windSpeed: (wind['speed'] as num? ?? 0).toDouble(),
      pressure: (main['pressure'] as num? ?? 0).toInt(),
    );
  }
}
