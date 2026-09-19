class WeatherModel {
  final String cityName;
  final String country;
  final double temp;
  final String condition;
  final String description;
  final double feelsLike;
  final int humidity;
  final double windSpeed;
  final double pressure;

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

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    final main = json['main'] ?? {};
    final weatherList = (json['weather'] as List?)?.first ?? {};
    final wind = json['wind'] ?? {};
    final sys = json['sys'] ?? {};

    // Temp comes in Kelvin from openweathermap default if units not specified
    double rawTemp = (main['temp'] is num) ? (main['temp'] as num).toDouble() : 300.0;
    // convert kelvin to celsius if > 200
    double tempC = rawTemp > 150 ? rawTemp - 273.15 : rawTemp;

    double rawFeels = (main['feels_like'] is num) ? (main['feels_like'] as num).toDouble() : 300.0;
    double feelsC = rawFeels > 150 ? rawFeels - 273.15 : rawFeels;

    return WeatherModel(
      cityName: json['name'] ?? 'Cairo',
      country: sys['country'] ?? 'EG',
      temp: tempC,
      condition: weatherList['main'] ?? 'Clear',
      description: weatherList['description'] ?? 'Clear Sky',
      feelsLike: feelsC,
      humidity: main['humidity'] ?? 48,
      windSpeed: (wind['speed'] is num) ? (wind['speed'] as num).toDouble() : 5.0,
      pressure: (main['pressure'] is num) ? (main['pressure'] as num).toDouble() : 1013.0,
    );
  }
}
