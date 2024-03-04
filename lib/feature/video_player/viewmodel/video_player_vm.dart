import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:vplay/commons/asset_paths.dart';
import 'package:vplay/feature/video_player/model/chapter_model.dart';

class VideoPlayerViewModel extends ChangeNotifier {
  List<ChapterModel> chapterList = [];
  List<double> breakPoints = [];
  late VideoPlayerController controller;
  bool _isPlaying = false;
  bool _showSeekbar = true;
  bool _showOutline = false;
  double _currentPosition = 0.0;
  double _totalDuration = 0.0;
  double breakpoint = 0.0;

  bool get isPlaying => _isPlaying;

  bool get showSeekbar => _showSeekbar;

  bool get showOutline => _showOutline;

  double get currentPosition => _currentPosition;

  double get totalDuration => _totalDuration;

  VideoPlayerViewModel() {
    loadExerciseData();
    controller = VideoPlayerController.asset(sampleVideoPath)
      ..initialize().then((_) {
        playPause();
        _totalDuration = controller.value.duration.inMilliseconds.toDouble();
        notifyListeners();
      });

    controller.addListener(() {
      _currentPosition = controller.value.position.inMilliseconds.toDouble();
      notifyListeners();
      if (controller.value.position.inSeconds.toDouble() == breakpoint) {
        pauseAndShowOutline();
      }
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
    updateNextBreakPoint(milliseconds);
  }

  void updateNextBreakPoint(double milliseconds) {
    breakpoint = breakPoints.firstWhere((element) => element * 1000 > milliseconds);
    notifyListeners();
  }

  void pauseAndShowOutline() {
    controller.pause();
    _isPlaying = false;
    _showOutline = true;
    _showSeekbar = false;
    notifyListeners();
  }

  void performSelectionFromOutline(int index) {
    seekTo(chapterList[index].seekLocation.inMilliseconds.toDouble());
    if (index != chapterList.length - 1) {
      breakpoint = chapterList[index + 1].seekLocation.inSeconds.toDouble();
    } else {
      breakpoint = controller.value.duration.inSeconds.toDouble();
    }
    controller.play();
    _showOutline = false;
    _isPlaying = true;
    notifyListeners();
  }

  void loadExerciseData() {
    chapterList.clear();
    chapterList.add(
        ChapterModel('Exercise 1', 'Test & Trick Your Brain', const Duration(minutes: 0, seconds: 41, milliseconds: 800)));
    chapterList.add(ChapterModel('Exercise 2', 'Hand Gestures', const Duration(minutes: 3, seconds: 52)));
    chapterList.add(ChapterModel('Exercise 3', 'Use Of Non Dominant Hand', const Duration(minutes: 5, seconds: 21)));
    chapterList.add(ChapterModel('Exercise 4', 'Play Mind Challenging Game', const Duration(minutes: 6, seconds: 13)));
    chapterList.add(ChapterModel('Exercise 5', 'Make Your Brain Work', const Duration(minutes: 7, seconds: 17)));

    for (var element in chapterList) {
      breakPoints.add(element.seekLocation.inSeconds.toDouble());
    }
    breakpoint = breakPoints[0];
  }

  String formatDuration(double milliseconds) {
    Duration duration = Duration(milliseconds: milliseconds.toInt());
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${duration.inHours}:$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
