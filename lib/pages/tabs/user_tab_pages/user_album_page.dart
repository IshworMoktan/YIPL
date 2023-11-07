import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:yipl/pages/others/album_detail_page.dart';
import 'package:yipl/services/models/user_album_data_model.dart';

class AlbumListPage extends StatefulWidget {
  final int userId;

  AlbumListPage({required this.userId});

  @override
  _AlbumListPageState createState() => _AlbumListPageState();
}

class _AlbumListPageState extends State<AlbumListPage> {
  List<UserAlbum> albums = [];
  List<Photo> photos = [];

  @override
  void initState() {
    super.initState();
    fetchAlbums();
  }

  Future<void> fetchAlbums() async {
    final response = await http.get(Uri.parse(
        'https://jsonplaceholder.typicode.com/users/${widget.userId}/albums'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      final List<UserAlbum> userAlbums =
          data.map((json) => UserAlbum.fromJson(json)).toList();
      setState(() {
        albums = userAlbums;
      });
    }
  }

  Future<int> fetchPhotoCountForAlbum(int albumId) async {
    final response = await http.get(Uri.parse(
        'https://jsonplaceholder.typicode.com/albums/$albumId/photos'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.length;
    }
    return 0; // Return 0 if there's an error or no photos
  }

  Future<void> fetchPhotos() async {
    final response = await http.get(Uri.parse(
        'https://jsonplaceholder.typicode.com/albums/${widget.userId}/photos'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        photos = data.map((json) => Photo.fromJson(json)).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: albums.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:
                    2, // You can adjust the number of columns as needed
              ),
              itemCount: albums.length,
              itemBuilder: (context, index) {
                return FutureBuilder<int>(
                  future: fetchPhotoCountForAlbum(albums[index].id),
                  builder: (context, snapshot) {
                    final photoCount = snapshot.data ?? 0;

                    return GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PhotoListPage(
                            albums[index].title,
                            albums[index].id,
                          ),
                        ),
                      ),
                      child: Card(
                        child: Column(
                          children: [
                            Text('Album ID: ${albums[index].id}'),
                            const Icon(
                              Icons.photo,
                              size: 70,
                              color: Colors.orange,
                            ),
                            Text('Photos: $photoCount'),
                            Text(albums[index].title),
                          ],
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
