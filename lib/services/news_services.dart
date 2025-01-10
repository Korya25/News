import 'package:dio/dio.dart';
import 'package:news_cloud_app/model/news.dart';

class ApiConstants {
  static const String baseUrl = 'https://newsapi.org/v2';
  static const String apiKey = '5bb659be54d4458abe3d92d3078c3bc2';
}

class NewsApiService {
  final Dio dio;

  NewsApiService(this.dio);
  Future<List<News>> fetchArticles({required String category}) async {
    try {
      final response = await dio.get(
        '${ApiConstants.baseUrl}/everything',
        queryParameters: {
          'q': category,
          'apiKey': ApiConstants.apiKey,
        },
      );

      if (response.statusCode == 200) {
        final articles = response.data['articles'] as List;

        if (articles.isEmpty) {
          throw Exception('No articles found for category: $category');
        }

        return articles.map((json) => News.fromJson(json, category)).toList();
      }

      throw Exception('Failed to fetch articles: ${response.statusCode}');
    } on DioException catch (e) {
      print('Dio error fetching news: $e');
      if (e.response != null) {
        print('Status Code: ${e.response?.statusCode}');
        print('Response Data: ${e.response?.data}');
      }
      throw Exception('Failed to fetch articles due to network error');
    } catch (e) {
      print('Unexpected error fetching news: $e');
      throw Exception('Failed to fetch articles');
    }
  }
}
