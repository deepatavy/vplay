import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:vplay/commons/app_texts.dart';
import 'package:vplay/commons/asset_paths.dart';
import 'package:vplay/feature/home/widgets/video_item_widget.dart';
import 'package:vplay/feature/video_player/video_player_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late VideoPlayerController videoController;

  @override
  void initState() {
    super.initState();
    videoController = VideoPlayerController.asset(sampleVideoPath);
    videoController.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title:
            Text(appName, style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold)),
      ),
      body: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              child: VideoItemWidget(
            image: imgVidBw,
            navigateTo: VideoPlayerScreen(
              isLinearPlay: true,
              controller: videoController,
            ),
            title: linearVideoText,
          )),
          Expanded(
            child: VideoItemWidget(
              image: imgVidColor,
              navigateTo: VideoPlayerScreen(
                isLinearPlay: false,
                controller: videoController,
              ),
              title: nonLinearVideoText,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    videoController.dispose();
    super.dispose();
  }
}