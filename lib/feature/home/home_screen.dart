import 'package:flutter/material.dart';
import 'package:vplay/commons/app_texts.dart';
import 'package:vplay/feature/home/widgets/video_item_widget.dart';
import 'package:vplay/feature/youtube_player/youtube_player_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          appName,
          style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold),
        ),
      ),
      body: const Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: VideoItemWidget(isLinear: true)),
          Expanded(child: VideoItemWidget(isLinear: false)),
        ],
      ),
    );
  }
}
