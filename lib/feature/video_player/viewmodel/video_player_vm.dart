import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:vplay/commons/asset_paths.dart';

class VideoPlayerViewModel extends ChangeNotifier {
  late VideoPlayerController controller;
  bool _isPlaying = false;
  bool _showSeekbar = true;
  double _currentPosition = 0.0;
  double _totalDuration = 0.0;

  bool get isPlaying => _isPlaying;

  bool get showSeekbar => _showSeekbar;

  double get currentPosition => _currentPosition;

  double get totalDuration => _totalDuration;

  VideoPlayerViewModel() {
    controller = VideoPlayerController.asset(sampleVideoPath)
      ..initialize().then((_) {
        playPause();
        _totalDuration = controller.value.duration.inMilliseconds.toDouble();
        notifyListeners();
      });

    controller.addListener(() {
      _currentPosition = controller.value.position.inMilliseconds.toDouble();
      notifyListeners();
    });
  }

  void showHideSeekbar() {
    _showSeekbar = !_showSeekbar;
    notifyListeners();
  }

  void playPause() {
    if (_isPlaying) {
      controller.pause();
    } else {
      controller.play();
    }
    _isPlaying = !_isPlaying;
    notifyListeners();
  }

  void seekTo(double milliseconds) {
    controller.seekTo(Duration(milliseconds: milliseconds.toInt()));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
