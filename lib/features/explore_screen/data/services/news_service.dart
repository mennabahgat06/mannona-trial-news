import '../../../../core/network/api_consumer.dart';
import '../../../../core/network/dio_consumer.dart';
import '../../../../core/network/end_points.dart';
import '../models/article_model.dart';

/// Calls NewsAPI. Errors are thrown so the screen can show them.
class NewsService {
  final ApiConsumer api = DioConsumer();

  /// GET /v2/everything  -> Explore, categories and search.
  Future<List<ArticleModel>> getEverything({
    required String query,
    String language = 'en',
  }) async {
    final response = await api.get(
      EndPoints.everything,
      baseUrl: EndPoints.newsBaseUrl,
      queryParameters: {
        'q': query.trim().isEmpty ? 'news' : query.trim(),
        'apiKey': EndPoints.newsApiKey,
        'language': language,
      },
    );
    return _parseArticles(response);
  }

  /// GET /v2/top-headlines -> Home feed (featured + most popular).
  Future<List<ArticleModel>> getTopHeadlines({
    String country = 'us',
    String? category,
  }) async {
    final queryParams = <String, dynamic>{
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
    return _parseArticles(response);
  }

  List<ArticleModel> _parseArticles(dynamic response) {
    if (response is! Map || response['articles'] is! List) return [];
    return (response['articles'] as List)
        .map((item) => ArticleModel.fromJson(item as Map<String, dynamic>))
        .where((article) => article.title != '[Removed]')
        .toList();
  }
}
