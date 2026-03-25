import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../models/lesson.dart';
import '../../models/word.dart';
import '../../services/player_manager.dart';
import '../widgets/word_card.dart';

class AutoPlayWordsScreen extends StatefulWidget {
  final Lesson lesson;
  final int initialPage;

  const AutoPlayWordsScreen({super.key, required this.lesson, this.initialPage = 0});

  @override
  State<AutoPlayWordsScreen> createState() => _AutoPlayWordsScreenState();
}

// TODO #1 Show page number # / $page_count
// TODO #1 Button to navigate to the first element.
class _AutoPlayWordsScreenState extends State<AutoPlayWordsScreen> {
  late final PlayerManager _playerManager;
  late final PageController _pageController;
  int _currentIndex = 0;
  bool _isAutoPlaying = false;
  Timer? _autoPlayTimer;

  List<Word> get words => widget.lesson.words;

  @override
  void initState() {
    super.initState();
    _playerManager = PlayerManager(widget.lesson.audioAssetPath);
    unawaited(_playerManager.init());
    _currentIndex = widget.initialPage;
    _pageController = PageController(initialPage: widget.initialPage);
  }

  @override
  void dispose() {
    _autoPlayTimer?.cancel();
    _pageController.dispose();
    unawaited(_playerManager.dispose());
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() => _currentIndex = index);
    unawaited(SystemNavigator.routeInformationUpdated(
      uri: Uri.parse('/lesson/${widget.lesson.routeName}/${index + 1}'),
      replace: true,
    ));
    if (_isAutoPlaying) {
      _scheduleAutoPlay();
    } else {
      unawaited(_playerManager.stop());
    }
  }

  // Stop auto-playing when pagecontroller took control or manual playback is triggered.
  void _scheduleAutoPlay() {
    final word = words[_currentIndex];
    unawaited(_playerManager.playTeacherRecording(word));

    _autoPlayTimer?.cancel();
    // TODO It's holding shorter than needed. The goal duration of the word from teacher's recording + 2000.
    final holdDuration = Duration(milliseconds: word.endMilliSeconds - word.startMilliSeconds + 2000);
    _autoPlayTimer = Timer(holdDuration, () {
      if (!_isAutoPlaying) return;
      if (_currentIndex < words.length - 1) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      } else {
        _stopAutoPlay();
      }
    });
  }

  void _startAutoPlay() {
    setState(() => _isAutoPlaying = true);
    _scheduleAutoPlay();
  }

  void _stopAutoPlay() {
    _autoPlayTimer?.cancel();
    _autoPlayTimer = null;
    setState(() => _isAutoPlaying = false);
    unawaited(_playerManager.stop());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _isAutoPlaying ? _stopAutoPlay : _startAutoPlay,
        child: Icon(_isAutoPlaying ? Icons.stop : Icons.play_arrow),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: words.length,
            onPageChanged: _onPageChanged,
            itemBuilder: (context, index) {
              final word = words[index];
              return WordCard(
                word: word,
                onTap: () => unawaited(_playerManager.playTeacherRecording(word)),
              );
            },
          ),
          if (_currentIndex > 0 && !_isAutoPlaying)
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: const Icon(Icons.chevron_left),
                iconSize: 40,
                onPressed: () => _pageController.previousPage(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.linear,
                ),
              ),
            ),
          if (_currentIndex < words.length - 1 && !_isAutoPlaying)
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: const Icon(Icons.chevron_right),
                iconSize: 40,
                onPressed: () => _pageController.nextPage(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.linear,
                ),
              ),
            ),
        ],
      ),
    );
  }
}