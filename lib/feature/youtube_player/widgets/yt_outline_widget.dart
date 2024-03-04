import 'package:flutter/material.dart';
import 'package:vplay/feature/youtube_player/viewmodel/youtube_vm.dart';

class YTOutlineWidget extends StatelessWidget {
  final YoutubePlayerViewModel viewModel;

  const YTOutlineWidget(this.viewModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            viewModel.vidList.length,
            (index) => SizedBox(
              width: 320,
              child: Card(
                color: Colors.white.withOpacity(1),
                elevation: 5,
                child: ListTile(
                  onTap: () {
                    viewModel.performSelectionFromOutline(index);
                  },
                  title: Text(
                    viewModel.vidList[index].title,
                    style: const TextStyle(color: Colors.black),
                  ),
                  leading: const Icon(
                    Icons.slow_motion_video_sharp,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
