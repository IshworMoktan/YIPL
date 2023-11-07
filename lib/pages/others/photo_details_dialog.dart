import 'package:flutter/material.dart';
import 'package:yipl/pages/others/album_detail_page.dart';

class PhotoDetailsDialog extends StatelessWidget {
  final Photo photo;

  PhotoDetailsDialog({required this.photo});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.network(photo.url),
          ),
          Text('Title: ${photo.title}'),
          Text('ID: ${photo.id}'),
          Text('Album ID: ${photo.albumId}'),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
