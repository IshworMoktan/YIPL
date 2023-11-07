import 'package:flutter/material.dart';
import 'package:yipl/pages/tabs/user_tab_pages/user_album_page.dart';
import 'package:yipl/pages/tabs/user_tab_pages/user_post_page.dart';
import 'package:yipl/pages/tabs/user_tab_pages/user_todo_page.dart';
import 'package:yipl/services/models/userlist_data_model.dart';

class UserTabSection extends StatelessWidget {
  final User user;

  UserTabSection({required this.user});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(user.username),
          bottom: const TabBar(
            isScrollable: false,
            tabs: [
              Tab(text: 'Posts'),
              Tab(text: 'Todos'),
              Tab(text: 'Albums'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            UserPostsPage(
              userId: user.id,
            ),
            UserTodosPage(
              userId: user.id,
            ),
            // UserTodosPage(),
            AlbumListPage(
              userId: user.id,
            )
          ],
        ),
      ),
    );
  }
}
