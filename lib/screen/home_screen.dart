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
        // App Bar
        appBar: CustomAppBar(),

        // Body
        body: Column(
          children: [
            CategoryList(),
            Expanded(
              child: BlocBuilder<NewsBloc, NewsState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return RefreshIndicator(
                    onRefresh: () {
                      return context.read<NewsBloc>().fetchNews();
                    },
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
        ));
  }
}
