import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_cloud_app/cubit/news_bloc.dart';
import 'package:news_cloud_app/widget/news_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _controller,
          decoration: const InputDecoration(
            hintText: 'Search news...',
            border: InputBorder.none,
          ),
          onSubmitted: (query) {
            context.read<NewsBloc>().selectCategory(query);
            Navigator.pop(context);
          },
        ),
      ),
      body: BlocBuilder<NewsBloc, NewsState>(
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
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
