import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vplay/feature/video_player/viewmodel/video_player_vm.dart';
import 'package:vplay/feature/video_player/widgets/outline_widget.dart';
import 'package:vplay/feature/video_player/widgets/seekbar_widget.dart';
import 'package:vplay/feature/video_player/widgets/video_view_widget.dart';

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
              child: VideoViewWidget(viewModel),
            ),
          ),
          if (viewModel.showSeekbar && !viewModel.showOutline) SeekbarWidget(viewModel),
          if (viewModel.showOutline) OutlineWidget(viewModel)
        ],
      ),
    );
  }
}
