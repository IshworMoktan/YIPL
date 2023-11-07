import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:yipl/services/models/user_post_model.dart';
import 'package:yipl/utils/styles.dart';
import 'package:yipl/widgets/features/longtext.dart';

class UserPostsPage extends StatefulWidget {
  final int userId;

  UserPostsPage({required this.userId});

  @override
  _UserPostsPageState createState() => _UserPostsPageState();
}

class _UserPostsPageState extends State<UserPostsPage> {
  List<UserPost> posts = [];

  @override
  void initState() {
    super.initState();
    fetchPosts(widget.userId);
  }

  Future<void> fetchPosts(int userId) async {
    final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/users/$userId/posts'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      setState(() {
        posts = data.map((json) => UserPost.fromJson(json)).toList();
      });
    } else {
      throw Exception('Failed to load posts');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: posts.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          contentTitle(posts[index].title),
                          LongText(longText: posts[index].body),
                          const Divider(
                            color: Colors.grey,
                            thickness: 0.5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.favorite_outline_rounded,
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.comment_outlined),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.bookmark_add_outlined),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
