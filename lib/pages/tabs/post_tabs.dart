import 'package:yipl/pages/tabs/post_tab_pages/new_post_page.dart';
import 'package:yipl/pages/tabs/post_tab_pages/post_favourite_page.dart';
import 'package:yipl/pages/tabs/post_tab_pages/post_trending_page.dart';
import 'package:flutter/material.dart';

class PostTabbedPage extends StatelessWidget {
  const PostTabbedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Latest'),
              Tab(text: 'Trending'),
              Tab(text: 'Favourite'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [NewPostsPage(), PostTrendingPage(), PostFavouritePage()],
        ),
      ),
    );
  }
}
