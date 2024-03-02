import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  final bool isLinearPlay;
  final VideoPlayerController controller;

  const VideoPlayerScreen({super.key, required this.isLinearPlay, required this.controller});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  @override
  void initState() {
    super.initState();
    widget.controller.play();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: widget.controller.value.isInitialized
          ? AspectRatio(
              aspectRatio: widget.controller.value.aspectRatio,
              child: VideoPlayer(widget.controller),
            )
          : const CircularProgressIndicator(),
    );
  }

  @override
  void dispose() {
    widget.controller.pause();
    widget.controller.seekTo(Duration.zero);
    super.dispose();
  }
}
