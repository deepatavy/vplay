import 'package:flutter/material.dart';
import 'package:vplay/feature/video_player/viewmodel/video_player_vm.dart';

class SeekbarWidget extends StatelessWidget {
  final VideoPlayerViewModel viewModel;

  const SeekbarWidget(this.viewModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Text(
            '${viewModel.formatDuration(viewModel.currentPosition)} / ${viewModel.formatDuration(viewModel.totalDuration)}',
            style: const TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
