import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:yipl/services/models/user_todo_data_model.dart';

class UserTodosPage extends StatefulWidget {
  final int userId;

  UserTodosPage({required this.userId});

  @override
  _UserTodosPageState createState() => _UserTodosPageState();
}

class _UserTodosPageState extends State<UserTodosPage> {
  List<UserTodo> todos = [];

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    final response = await http.get(Uri.parse(
        'https://jsonplaceholder.typicode.com/users/${widget.userId}/todos'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        todos = data.map((json) => UserTodo.fromJson(json)).toList();
      });
    }
  }

  Future<void> addPost(UserTodo post) async {
    final response = await http.post(
      Uri.parse('https://jsonplaceholder.typicode.com/${widget.userId}/todos'),
      headers: {"Content-Type": "application/json"},
      body: json.encode(post.toJson()),
    );

    if (response.statusCode == 201) {
      final newPost = UserTodo.fromJson(json.decode(response.body));
      setState(() {
        todos.add(newPost);
      });
    }
  }

  Future<void> updatePost(UserTodo post) async {
    final response = await http.put(
      Uri.parse(
          'https://jsonplaceholder.typicode.com/${widget.userId}/todos/${post.id}'),
      headers: {"Content-Type": "application/json"},
      body: json.encode(post.toJson()),
    );

    if (response.statusCode == 200) {
      final updatedPost = UserTodo.fromJson(json.decode(response.body));
      setState(() {
        final index = todos.indexWhere((p) => p.id == updatedPost.id);
        if (index != -1) {
          todos[index] = updatedPost;
        }
      });
    }
  }

  Future<void> deletePost(int postId) async {
    final response = await http.delete(
      Uri.parse(
          'https://jsonplaceholder.typicode.com/${widget.userId}/todos/$postId'),
    );

    if (response.statusCode == 200) {
      setState(() {
        todos.removeWhere((p) => p.id == postId);
      });
    }
  }

  Future<void> _showDeleteConfirmationDialog(UserTodo post) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Post'),
          content: const Text('Are you sure you want to delete this post?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                deletePost(post.id);
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("${post.title} deleted")));
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> editPostDialog(BuildContext context, UserTodo post) async {
    final TextEditingController titleController =
        TextEditingController(text: post.title);

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Post'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Update the post and close the dialog
                final updatedTitle = titleController.text;
                if (updatedTitle.isNotEmpty) {
                  final updatedPost = post.copyWith(title: updatedTitle);
                  updatePost(updatedPost);
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showAddPostDialog() async {
    TextEditingController titleController = TextEditingController();
    bool completed = false;

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New Post'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              CheckboxListTile(
                title: const Text('Completed'),
                value: completed,
                onChanged: (value) {
                  setState(() {
                    completed = value ?? false;
                  });
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Create a new post and add it to the list
                final newPost = UserTodo(
                  id: todos.length +
                      1, // Assign a unique ID (e.g., increment the length)
                  userId: widget.userId,
                  title: titleController.text,
                  completed: completed,
                );
                addPost(newPost);

                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: todos.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final post = todos[index];
                return Dismissible(
                  direction: DismissDirection.endToStart,
                  key: Key(post.id.toString()),
                  onDismissed: (direction) {
                    // Removes that item the list on swipwe
                    setState(() {
                      _showDeleteConfirmationDialog(post);

                      todos.removeAt(index);
                    });
                  },
                  background: Container(
                    color: Colors.red,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                  child: GestureDetector(
                    onTap: () => editPostDialog(context, post),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        tileColor: Colors.orangeAccent.withOpacity(0.1),
                        title: Text(post.title),
                        subtitle: Text('Completed: ${post.completed}'),
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddPostDialog(); // Show the dialog to add a new post
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
