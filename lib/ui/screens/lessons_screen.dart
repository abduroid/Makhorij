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
      Word(arabicText: "أَ", startMilliSeconds: 1000, endMilliSeconds: 2000),
      Word(arabicText: "إِ", startMilliSeconds: 3000, endMilliSeconds: 5000),
      Word(arabicText: "أُ", startMilliSeconds: 5000, endMilliSeconds: 7000),
      Word(arabicText: "أَءْ", startMilliSeconds: 8000, endMilliSeconds: 10000),
      Word(arabicText: "إِءْ", startMilliSeconds: 11000, endMilliSeconds: 12000),
      Word(arabicText: "أُءْ", startMilliSeconds: 14000, endMilliSeconds: 15000),
    ],
  ),
  // Lam
  Lesson(
    letter: 'ل',
    audioAssetPath: 'assets/lam.m4a',
    audioAssetPath: 'assets/Lam.m4a',
    words: [
      Word(arabicText: "لَ", startMilliSeconds: 0, endMilliSeconds: 2000),
      Word(arabicText: "لِ", startMilliSeconds: 2000, endMilliSeconds: 5000),
      Word(arabicText: "لُ", startMilliSeconds: 5000, endMilliSeconds: 7000),
    ],
  ),
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
