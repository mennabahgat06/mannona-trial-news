import '../../../../core/network/api_consumer.dart';
import '../../../../core/network/dio_consumer.dart';
import '../../../../core/network/end_points.dart';
import '../models/weather_model.dart';

class WeatherService {
  final ApiConsumer api = DioConsumer();

  Future<WeatherModel> getWeather({
    double lat = 30.5877893,
    double lon = 31.4798788,
  }) async {
    final response = await api.get(
      EndPoints.weather,
      baseUrl: EndPoints.weatherBaseUrl,
      queryParameters: {
        'lat': lat,
        'lon': lon,
        'appid': EndPoints.weatherAppId,
      },
    );

    return WeatherModel.fromJson(response as Map<String, dynamic>);
  }
}
