import 'package:flutter/material.dart';
import 'package:vplay/commons/app_texts.dart';
import 'package:vplay/commons/asset_paths.dart';
import 'package:vplay/feature/video_player/video_player_screen.dart';
import 'package:vplay/feature/youtube_player/youtube_player_screen.dart';

class VideoItemWidget extends StatelessWidget {
  final bool isLocal;

  const VideoItemWidget({super.key, required this.isLocal});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isLocal) {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const VideoPlayerScreen()));
        } else {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const YoutubePlayerScreen()));
        }
      },
      child: Card(
        margin: const EdgeInsets.all(16),
        elevation: 4,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              isLocal ? imgVidBw : imgVidColor,
              height: 200,
            ),
            Text(
              isLocal ? localVideoText : youtubeVideoText,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
