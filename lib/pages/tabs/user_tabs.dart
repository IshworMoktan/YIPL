import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:yipl/pages/others/user_detail_page.dart';
import 'package:yipl/pages/tabs/user_tab_section.dart';
import 'package:yipl/services/models/userlist_data_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserTabbedPage extends StatefulWidget {
  @override
  _UserTabbedPageState createState() => _UserTabbedPageState();
}

class _UserTabbedPageState extends State<UserTabbedPage> {
  late List<User> users = [];
  bool isFetching = false;

  @override
  void initState() {
    super.initState();
    fetchAndCacheUsers();
  }

  Future<void> fetchAndCacheUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedData = prefs.getString('cached_users');

    if (cachedData != null) {
      // If cached data is available, use it
      final List<dynamic> cachedUsersData = json.decode(cachedData);
      final List<User> cachedUsers =
          cachedUsersData.map((json) => User.fromJson(json)).toList();

      setState(() {
        users = cachedUsers;
      });
    }

    // Regardless of cached data, initiate a new fetch in the background
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    if (!isFetching) {
      // Only fetch data if it's not already being fetched
      isFetching = true;

      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final List<User> fetchedUsers =
            data.map((json) => User.fromJson(json)).toList();

        // Cache the fetched data
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('cached_users', json.encode(data));

        setState(() {
          users = fetchedUsers;
          isFetching = false;
        });
      } else {
        isFetching = false;
        throw Exception('Failed to load users');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
      ),
      body: users.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.person)),
                  title: Text(users[index].username),
                  trailing: IconButton(
                    icon: const Icon(Icons.info_outline),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              UserDetailsPage(user: users[index]),
                        ),
                      );
                    },
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserTabSection(
                          user: users[index],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
