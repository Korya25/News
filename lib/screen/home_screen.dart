import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_cloud_app/cubit/news_bloc.dart';
import 'package:news_cloud_app/widget/category_list.dart';
import 'package:news_cloud_app/widget/custom_app_bar.dart';
import 'package:news_cloud_app/widget/news_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        children: [
          CategoryList(),
          Expanded(
            child: BlocBuilder<NewsBloc, NewsState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state.error != null) {
                  return Center(child: Text('Error: ${state.error}'));
                }
                return RefreshIndicator(
                  onRefresh: () => context.read<NewsBloc>().fetchNews(),
                  child: ListView.builder(
                    itemCount: state.news.length,
                    itemBuilder: (context, index) {
                      return NewsCard(news: state.news[index]);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
