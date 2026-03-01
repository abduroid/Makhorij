import 'package:flutter/material.dart';

import '../../models/lesson.dart';
import '../../models/word.dart';
import 'word_pager_screen.dart';

final lessons = [
  // Alif
  Lesson(
    letter: 'ا',
    audioAssetPath: 'assets/Alif.m4a',
    words: [
      Word(arabicText: "أَ", startSeconds: 1, endSeconds: 2),
      Word(arabicText: "إِ", startSeconds: 3, endSeconds: 5),
      Word(arabicText: "أُ", startSeconds: 5, endSeconds: 7),
      Word(arabicText: "أَءْ", startSeconds: 8, endSeconds: 10),
      Word(arabicText: "إِءْ", startSeconds: 11, endSeconds: 12),
      Word(arabicText: "أُءْ", startSeconds: 14, endSeconds: 15),
    ],
  ),
  // Lam
  Lesson(
    letter: 'ل',
    audioAssetPath: 'assets/lam.m4a',
    words: [
      Word(arabicText: "لَ", startSeconds: 0, endSeconds: 2),
      Word(arabicText: "لِ", startSeconds: 2, endSeconds: 5),
      Word(arabicText: "لُ", startSeconds: 5, endSeconds: 7),
    ],
  ),
];

class LessonsScreen extends StatelessWidget {
  const LessonsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lessons')),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: lessons.length,
        itemBuilder: (context, index) {
          final lesson = lessons[index];
          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => WordPagerScreen(lesson: lesson),
              ),
            ),
            child: Card(
              child: Center(
                child: Text(
                  lesson.letter,
                  style: const TextStyle(fontSize: 64),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
