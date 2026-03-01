import 'dart:async';

import 'package:flutter/material.dart';

import '../../models/word.dart';
import '../../services/player_manager.dart';
import '../widgets/word_card.dart';

class WordPagerScreen extends StatefulWidget {
  const WordPagerScreen({super.key});

  @override
  State<WordPagerScreen> createState() => _WordPagerScreenState();
}

class _WordPagerScreenState extends State<WordPagerScreen> {
  late final PlayerManager _playerManager;
  late final PageController _pageController;
  int _currentIndex = 0;

  final words = [
    Word(arabicText: "لَ", startSeconds: 0, endSeconds: 2),
    Word(arabicText: "لِ", startSeconds: 2, endSeconds: 5),
    Word(arabicText: "لُ", startSeconds: 5, endSeconds: 7),
  ];

  @override
  void initState() {
    super.initState();
    _playerManager = PlayerManager('assets/lam.m4a');
    unawaited(_playerManager.init());
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    unawaited(_playerManager.dispose());
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() => _currentIndex = index);
    unawaited(_playerManager.stop());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                onTap: () => unawaited(_playerManager.play(word)),
              );
            },
          ),
          if (_currentIndex > 0)
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: const Icon(Icons.chevron_left),
                iconSize: 40,
                onPressed: () => _pageController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                ),
              ),
            ),
          if (_currentIndex < words.length - 1)
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: const Icon(Icons.chevron_right),
                iconSize: 40,
                onPressed: () => _pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
