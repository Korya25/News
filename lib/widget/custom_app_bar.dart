import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:news_cloud_app/constant/app_text_style.dart';
import 'package:news_cloud_app/screen/search_screen.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          Text(
            'News',
            style: AppStyles.newsTitleStyle,
          ),
          Text(
            ' Cloud',
            style: AppStyles.newsCloudTitleStyle,
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SearchScreen(),
              ),
            );
          },
          icon: const Icon(LucideIcons.search),
        ),
        IconButton(
          onPressed: () {
            // Add theme mode functionality
          },
          icon: const Icon(LucideIcons.moon),
        ),
        IconButton(
          onPressed: () {
            // Add favorite page functionality
          },
          icon: const Icon(LucideIcons.heart),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
