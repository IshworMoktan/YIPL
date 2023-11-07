import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:yipl/pages/others/photo_details_dialog.dart';
import 'dart:convert';

class PhotoListPage extends StatefulWidget {
  final int albumId;
  final String albumName;
  PhotoListPage(this.albumName, this.albumId, {super.key});

  @override
  _PhotoListPageState createState() => _PhotoListPageState();
}

class _PhotoListPageState extends State<PhotoListPage> {
  List<Photo> photos = [];

  @override
  void initState() {
    super.initState();
    fetchPhotos();
  }

  Future<void> _showFullPhoto(Photo photo) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.network(
                        photo.url,
                        fit: BoxFit.cover,
                      ),
                    )),
                Text('Title: ${photo.title}'),
                Text('ID: ${photo.id}'),
                Text('Album ID: ${photo.albumId}'),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> fetchPhotos() async {
    final response = await http.get(Uri.parse(
        'https://jsonplaceholder.typicode.com/albums/${widget.albumId}/photos'));

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
      appBar: AppBar(
        title: Text(
          widget.albumName,
          maxLines: 3,
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: photos.isEmpty
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: photos.length,
              itemBuilder: (context, index) {
                final photo = photos[index];
                return GestureDetector(
                  onTap: () => _showFullPhoto(photo),
                  child: Card(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 120,
                          width: 120,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.network(
                              photo.thumbnailUrl,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            photo.title.length <= 40
                                ? photo.title
                                : '${photo.title.substring(0, 40)}...',
                            style: TextStyle(fontSize: 10),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class Photo {
  final int id;
  final int albumId;
  final String title;
  final String url;
  final String thumbnailUrl;

  Photo({
    required this.id,
    required this.albumId,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'],
      albumId: json['albumId'],
      title: json['title'],
      url: json['url'],
      thumbnailUrl: json['thumbnailUrl'],
    );
  }
}
