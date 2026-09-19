import '../../../../core/network/api_consumer.dart';
import '../../../../core/network/dio_consumer.dart';
import '../../../../core/network/end_points.dart';
import '../models/weather_model.dart';

class WeatherService {
  final ApiConsumer api = DioConsumer();
  Future<WeatherModel> getWeather({
    double? lat,
    double? lon,
    String? cityName,
  }) async {
    final Map<String, dynamic> queryParams = {
      'appid': EndPoints.weatherAppId,
    };

    if (cityName != null && cityName.isNotEmpty) {
      queryParams['q'] = cityName;
    } else {
      queryParams['lat'] = lat ?? 30.5877893;
      queryParams['lon'] = lon ?? 31.4798788;
    }

    final response = await api.get(
      EndPoints.weather,
      baseUrl: EndPoints.weatherBaseUrl,
      queryParameters: queryParams,
    );

    return WeatherModel.fromJson(response as Map<String, dynamic>);
  }
}
