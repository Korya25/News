import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_cloud_app/model/news.dart';
import 'package:news_cloud_app/services/news_services.dart';

class NewsState {
  final List<News> news;
  final String selectedCategory;
  final bool isLoading;
  final String? error;

  NewsState({
    required this.news,
    required this.selectedCategory,
    this.isLoading = false,
    this.error,
  });

  NewsState copyWith({
    List<News>? news,
    String? selectedCategory,
    bool? isLoading,
    String? error,
  }) {
    return NewsState(
      news: news ?? this.news,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class NewsBloc extends Cubit<NewsState> {
  final NewsApiService _newsService;

  NewsBloc()
      : _newsService = NewsApiService(Dio()),
        super(NewsState(news: [], selectedCategory: 'general')) {
    fetchNews();
  }

  Future<void> fetchNews() async {
    if (state.isLoading) return;

    emit(state.copyWith(isLoading: true, error: null));

    try {
      final news = await _newsService.fetchArticles(
        category: state.selectedCategory,
      );

      emit(state.copyWith(
        news: news,
        isLoading: false,
      ));
    } catch (e) {
      print('Error in NewsBloc: $e');

      emit(state.copyWith(
        news: [],
        isLoading: false,
        error: e.toString(),
      ));
    }
  }

  void selectCategory(String category) {
    if (category == state.selectedCategory) {
      return;
    }
    emit(state.copyWith(selectedCategory: category));
    fetchNews();
  }
}
