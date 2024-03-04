import 'package:flutter/material.dart';
import 'package:vplay/commons/app_texts.dart';
import 'package:vplay/feature/youtube_player/model/video_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubePlayerViewModel with ChangeNotifier {
  late YoutubePlayerController _controller;
  List<VideoModel> vidList = [];
  final String initialVideoURL;
  final int breakPoint = const Duration(minutes: 2, seconds: 16).inSeconds.toInt();
  bool _showOutline = false;

  bool get showOutline => _showOutline;
  String get currentURL => _currentURL;
  String _currentURL = '';

  YoutubePlayerController get controller => _controller;

  YoutubePlayerViewModel({required this.initialVideoURL}) {
    loadData();
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(initialVideoURL)!,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );

    _currentURL = initialVideoURL;

    _controller.addListener(() {
      if (_currentURL == initialVideoURL && controller.value.position.inSeconds.toDouble() == breakPoint) {
        pauseAndShowOutline();
      }

      if (_controller.value.isDragging) {
        _showOutline = false;
        notifyListeners();
      }
    });
  }

  void performSelectionFromOutline(int index) {
    changeVideo(vidList[index].url);
    notifyListeners();
  }

  void pauseAndShowOutline() {
    _controller.pause();
    _showOutline = true;
    notifyListeners();
  }

  void play() {
    _controller.play();
  }

  void pause() {
    _controller.pause();
  }

  void changeVideo(String vidUrl) {
    _controller.load(YoutubePlayer.convertUrlToId(vidUrl)!, startAt: 0);
    _controller.play();
    _currentURL = vidUrl;
    _showOutline = false;
    notifyListeners();
  }

  void manageCompletion() {
    if (_currentURL != initialVideoURL) {
      _controller.load(YoutubePlayer.convertUrlToId(initialVideoURL)!, startAt: 0);
      _controller.pause();
      _currentURL = initialVideoURL;
      _showOutline = true;
      notifyListeners();
    } else {
      _controller.load(YoutubePlayer.convertUrlToId(initialVideoURL)!, startAt: 0);
      _controller.play();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void loadData() {
    vidList.clear();
    vidList.add(VideoModel("1 Game Of Thrones", gotURL));
    vidList.add(VideoModel("2 Breaking Bad", bbURL));
    vidList.add(VideoModel("3 The Sopranos", sopranosURL));
  }
}
