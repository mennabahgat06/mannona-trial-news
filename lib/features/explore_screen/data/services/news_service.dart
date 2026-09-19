import '../../../../core/network/api_consumer.dart';
import '../../../../core/network/dio_consumer.dart';
import '../../../../core/network/end_points.dart';
import '../models/article_model.dart';

class NewsService {
  final ApiConsumer api = DioConsumer();

  Future<List<ArticleModel>> getEverything({String query = 'general', String language = 'en'}) async {
    try {
      final response = await api.get(
        EndPoints.everything,
        baseUrl: EndPoints.newsBaseUrl,
        queryParameters: {
          'q': query.isEmpty ? 'news' : query,
          'apiKey': EndPoints.newsApiKey,
          'language': language,
        },
      );

      if (response != null && response['articles'] is List) {
        return (response['articles'] as List)
            .map((item) => ArticleModel.fromJson(item as Map<String, dynamic>))
            .where((art) => art.title != '[Removed]')
            .toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  Future<List<ArticleModel>> getTopHeadlines({String country = 'us', String? category}) async {
    try {
      final queryParams = {
        'apiKey': EndPoints.newsApiKey,
        'country': country,
      };
      if (category != null && category.isNotEmpty) {
        queryParams['category'] = category;
      }

      final response = await api.get(
        EndPoints.topHeadlines,
        baseUrl: EndPoints.newsBaseUrl,
        queryParameters: queryParams,
      );

      if (response != null && response['articles'] is List) {
        return (response['articles'] as List)
            .map((item) => ArticleModel.fromJson(item as Map<String, dynamic>))
            .where((art) => art.title != '[Removed]')
            .toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }
}
