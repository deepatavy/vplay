import 'package:flutter/material.dart';
import 'package:vplay/feature/video_player/viewmodel/video_player_vm.dart';

class OutlineWidget extends StatelessWidget {
  final VideoPlayerViewModel viewModel;

  const OutlineWidget(this.viewModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              viewModel.chapterList.length,
              (index) => SizedBox(
                width: 320,
                child: Card(
                  color: Colors.white.withOpacity(1),
                  elevation: 5,
                  child: ListTile(
                    dense: true,
                    onTap: () {
                      viewModel.performSelectionFromOutline(index);
                    },
                    title: Text(
                      viewModel.chapterList[index].title,
                      style: const TextStyle(color: Colors.black),
                    ),
                    leading: const Icon(
                      Icons.slow_motion_video_sharp,
                      color: Colors.black,
                    ),
                    subtitle: Text(
                      viewModel.chapterList[index].subTitle,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
