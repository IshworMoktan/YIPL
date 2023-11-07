import 'package:yipl/utils/styles.dart';
import 'package:yipl/widgets/global/globalWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class VideoCard extends StatelessWidget {
  final String title;
  final String thumbnail;
  final String videoUrl;

  VideoCard(
      {required this.title, required this.thumbnail, required this.videoUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 50,
            width: 180,
            child: Text(
              title,
              maxLines: 3,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                  width: 80,
                  height: 20,
                  child: pilllogo(
                      'assets/images/youtube_logo.svg', 'YouTube', '#E21F27')),
              timestamp('1 hour ago')
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 128,
            width: 166,
            child: Stack(
              children: [
                SizedBox(
                  height: 128,
                  width: 166,
                  child: Image.network(
                    thumbnail,
                    fit: BoxFit.cover,
                  ),
                ),
                const Center(
                    child: Icon(
                  Icons.circle,
                  color: Colors.white,
                  size: 50,
                )),
                const Center(
                    child: Icon(
                  Icons.play_arrow_rounded,
                  color: Colors.black,
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
