import 'package:flutter/material.dart';
import 'package:vplay/commons/app_texts.dart';
import 'package:vplay/commons/asset_paths.dart';
import 'package:vplay/feature/video_player/video_player_screen.dart';

class VideoItemWidget extends StatelessWidget {
  final bool isLinear;

  const VideoItemWidget({super.key, required this.isLinear});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const VideoPlayerScreen(),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.all(16),
        elevation: 4,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              isLinear ? imgVidBw : imgVidColor,
              height: 200,
            ),
            Text(
              isLinear ? linearVideoText : nonLinearVideoText,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
