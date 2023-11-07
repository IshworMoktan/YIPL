import 'dart:convert';
import 'package:yipl/utils/colors.dart';
import 'package:yipl/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PostDetailPage extends StatefulWidget {
  final int postId;
  final String postDetail;
  final String postTitle;
  const PostDetailPage(this.postId, this.postDetail, this.postTitle);
  @override
  _PostDetailPageState createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  List<dynamic> comments = [];

  TextEditingController commentController = TextEditingController();
  @override
  void initState() {
    super.initState();
    fetchComments();
  }

  Future<void> fetchComments() async {
    final response = await http.get(Uri.parse(
        'https://jsonplaceholder.typicode.com/posts/${widget.postId}/comments'));

    if (response.statusCode == 200) {
      setState(() {
        comments = json.decode(response.body);
      });
    } else {
      print('Failed to load comments');
    }
  }

  Future<void> addComment() async {
    final Map<String, dynamic> commentData = {
      'postId': widget.postId,
      'name': 'Your Name',
      'email': 'your.email@example.com',
      'body': commentController.text,
    };

    final response = await http.post(
      Uri.parse(
          'https://jsonplaceholder.typicode.com/posts/${widget.postId}/comments'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(commentData),
    );

    if (response.statusCode == 201) {
      // print(response.body);
      // print(response.statusCode);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Comment added successfully')),
      );
      commentController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add comment')),
      );
      print('Failed to add comment. Status Code: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appbarTitle('Post'),
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.favorite_outline)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.share_outlined))
        ],
      ),
      body: Column(
        children: [
          Container(
            color: mainColor.withOpacity(0.1),
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                contentTitle(widget.postTitle),
                contentBody(widget.postDetail),
              ],
            ),
          ),
          contentTitle('Comments'),
          const Divider(
            color: Colors.black12,
            thickness: 0.5,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: comments.length,
              itemBuilder: (context, index) {
                final comment = comments[index];
                return ListTile(
                  title: contentTitle(comment['name']),
                  subtitle: Text(comment['body']),
                  contentPadding: const EdgeInsets.all(16),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(20), // Rounded corners
                      border: Border.all(color: Colors.black12), // Border
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextField(
                        controller: commentController,
                        decoration: const InputDecoration(
                          hintText: 'Add a comment...',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.send,
                    color: mainColor,
                  ),
                  onPressed: () => addComment(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
