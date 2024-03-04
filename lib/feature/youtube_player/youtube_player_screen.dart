import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vplay/commons/app_texts.dart';
import 'package:vplay/feature/youtube_player/viewmodel/youtube_vm.dart';
import 'package:vplay/feature/youtube_player/viewmodel/yt_outline_widget.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubePlayerScreen extends StatelessWidget {
  const YoutubePlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => YoutubePlayerViewModel(initialVideoURL: baseYoutubeUrl),
      child: const YoutubePlayerWidget(),
    );
  }
}

class YoutubePlayerWidget extends StatelessWidget {
  const YoutubePlayerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<YoutubePlayerViewModel>(context);
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }
        if (viewModel.currentURL == baseYoutubeUrl) {
          Navigator.pop(context);
        } else {
          viewModel.manageCompletion();
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: YoutubePlayer(
                controller: viewModel.controller,
                showVideoProgressIndicator: true,
                onEnded: (metaData) {
                  viewModel.manageCompletion();
                },
              ),
            ),
            if (viewModel.showOutline) YTOutlineWidget(viewModel)
          ],
        ),
      ),
    );
  }
}
