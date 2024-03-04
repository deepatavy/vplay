import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:vplay/feature/video_player/viewmodel/video_player_vm.dart';

class VideoViewWidget extends StatelessWidget {
  final VideoPlayerViewModel viewModel;

  const VideoViewWidget(this.viewModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: VideoPlayer(viewModel.controller),
    );
  }
}
