import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_cloud_app/cubit/news_bloc.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const List<String> categories = [
      'General',
      'Technology',
      'Sports',
      'Entertainment',
      'Science',
    ];

    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: BlocBuilder<NewsBloc, NewsState>(
              builder: (context, state) {
                final selected = state.selectedCategory == categories[index];
                return FilterChip(
                  selected: selected,
                  label: Text(categories[index]),
                  onSelected: (_) {
                    context.read<NewsBloc>().selectCategory(categories[index]);
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
