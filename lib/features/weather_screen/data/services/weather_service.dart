import '../../../../core/network/api_consumer.dart';
import '../../../../core/network/dio_consumer.dart';
import '../../../../core/network/end_points.dart';
import '../models/weather_model.dart';

/// GET /data/2.5/weather  (by coordinates or by city name).
class WeatherService {
  final ApiConsumer api = DioConsumer();

  Future<WeatherModel> getWeather({
    double? lat,
    double? lon,
    String? cityName,
  }) async {
    final queryParams = <String, dynamic>{
      'appid': EndPoints.weatherAppId,
      'units': 'metric', // Celsius + m/s
    };

    if (cityName != null && cityName.isNotEmpty) {
      queryParams['q'] = cityName;
    } else {
      queryParams['lat'] = lat;
      queryParams['lon'] = lon;
    }

    final response = await api.get(
      EndPoints.weather,
      baseUrl: EndPoints.weatherBaseUrl,
      queryParameters: queryParams,
    );
    return WeatherModel.fromJson(response as Map<String, dynamic>);
  }
}
