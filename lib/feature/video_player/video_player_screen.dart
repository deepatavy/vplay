import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:provider/provider.dart';
import 'package:vplay/feature/video_player/viewmodel/video_player_vm.dart';

class VideoPlayerScreen extends StatelessWidget {
  const VideoPlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => VideoPlayerViewModel(),
      child: const VideoPlayerWidget(),
    );
  }
}

class VideoPlayerWidget extends StatelessWidget {
  const VideoPlayerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<VideoPlayerViewModel>(context);
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          GestureDetector(
            onTap: () {
              viewModel.showHideSeekbar();
            },
            child: SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: MVideoPlayer(viewModel),
            ),
          ),
          if (viewModel.showSeekbar)
            Container(
              height: 72,
              color: const Color(0x88000000),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: IconButton(
                        onPressed: () {
                          viewModel.playPause();
                        },
                        color: Colors.white,
                        icon: Icon(viewModel.isPlaying ? Icons.pause : Icons.play_arrow)),
                  ),
                  Expanded(
                    child: Slider(
                      value: viewModel.currentPosition,
                      min: 0.0,
                      max: viewModel.totalDuration,
                      onChanged: (value) {
                        viewModel.seekTo(value);
                      },
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class MVideoPlayer extends StatelessWidget {
  final VideoPlayerViewModel viewModel;

  const MVideoPlayer(this.viewModel, {super.key});

  @override
  Widget build(BuildContext context) {

    return AspectRatio(
      aspectRatio: 16 / 9,
      child: VideoPlayer(viewModel.controller),
    );
  }
}
