import 'package:dio/dio.dart';
import 'package:news_cloud_app/model/news.dart';

class NewsApiService {
  final Dio _dio;
  static const String _baseUrl = 'https://newsapi.org/v2';
  static const String _apiKey = '5bb659be54d4458abe3d92d3078c3bc2';

  NewsApiService()
      : _dio = Dio(BaseOptions(
          baseUrl: _baseUrl,
          connectTimeout: const Duration(seconds: 5),
          receiveTimeout: const Duration(seconds: 3),
        ));

  Future<List<News>> fetchArticles({required String category}) async {
    try {
      final String endpoint = category.toLowerCase() == 'General'
          ? '/everything?q=news'
          : '/top-headlines';

      final Map<String, dynamic> queryParams =
          category.toLowerCase() == 'General'
              ? {
                  'apiKey': _apiKey,
                  'pageSize': 50,
                  'language': 'en',
                }
              : {
                  'category': category.toLowerCase(),
                  'apiKey': _apiKey,
                  'pageSize': 50,
                  'language': 'en',
                };

      final response = await _dio.get(endpoint, queryParameters: queryParams);

      if (response.statusCode == 200) {
        final articles = response.data['articles'] as List;
        if (articles.isEmpty) {
          throw Exception('No articles found');
        }
        return articles.map((json) => News.fromJson(json, category)).toList();
      }

      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        message: 'Failed to fetch articles: ${response.statusCode}',
      );
    } catch (e) {
      print('Error fetching news: $e');
      rethrow;
    }
  }

  void dispose() {
    _dio.close();
  }
}
