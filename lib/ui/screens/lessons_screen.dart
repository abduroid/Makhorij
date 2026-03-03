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
    audioAssetPath: 'assets/Lam.m4a',
    words: [
      Word(arabicText: "لَ", startMilliSeconds: 0, endMilliSeconds: 2000),
      Word(arabicText: "لِ", startMilliSeconds: 2000, endMilliSeconds: 5000),
      Word(arabicText: "لُ", startMilliSeconds: 5000, endMilliSeconds: 7000),
    ],
  ),
  // Ha
  Lesson(
      letter: 'ه',
      audioAssetPath: 'assets/Ha.m4a',
      words: [
        Word(arabicText: 'هَ', startMilliSeconds: 800, endMilliSeconds: 2200),
        Word(arabicText: 'هِ', startMilliSeconds: 3000, endMilliSeconds: 4400),
        Word(arabicText: 'هُ', startMilliSeconds: 5300, endMilliSeconds: 6600),
        Word(arabicText: 'ه', startMilliSeconds: 7300, endMilliSeconds: 8600),
        Word(arabicText: 'هَبْ', startMilliSeconds: 9800, endMilliSeconds: 10700),
        Word(arabicText: 'هَمْ', startMilliSeconds: 12300, endMilliSeconds: 13200),
        Word(arabicText: 'هَلْ', startMilliSeconds: 14600, endMilliSeconds: 15600),
        Word(arabicText: 'هُوَ', startMilliSeconds: 16900, endMilliSeconds: 17800),
        Word(arabicText: 'هِيَ', startMilliSeconds: 19250, endMilliSeconds: 20100),
        Word(arabicText: 'هُمْ', startMilliSeconds: 21700, endMilliSeconds: 22600),
        Word(arabicText: 'زُهْ', startMilliSeconds: 24150, endMilliSeconds: 25200),
        Word(arabicText: 'اَهَمْ', startMilliSeconds: 26700, endMilliSeconds: 27800),
        Word(arabicText: 'وَهَبْ', startMilliSeconds: 29550, endMilliSeconds: 30600),
        Word(arabicText: 'لَهَبْ', startMilliSeconds: 32400, endMilliSeconds: 33500),
        Word(arabicText: 'وَهَمْ', startMilliSeconds: 35400, endMilliSeconds: 36500),
        Word(arabicText: 'لَهُمْ', startMilliSeconds: 38200, endMilliSeconds: 39600),
        Word(arabicText: 'بِهِمْ', startMilliSeconds: 41150, endMilliSeconds: 42400),
        Word(arabicText: 'مِنْهُ', startMilliSeconds: 44250, endMilliSeconds: 45800),
        Word(arabicText: 'مِنْهُمْ', startMilliSeconds: 47700, endMilliSeconds: 49600),
        Word(arabicText: 'اِلَيْهِ', startMilliSeconds: 51650, endMilliSeconds: 53300),
        Word(arabicText: 'اِلَيْهِمْ', startMilliSeconds: 55400, endMilliSeconds: 57300),
        Word(arabicText: 'اَمْهِلْهُمْ', startMilliSeconds: 59500, endMilliSeconds: 62100),
      ]
  ),
  // Fa
  Lesson(
      letter: 'ف',
      audioAssetPath: 'assets/Fa.m4a',
    words: [
      Word(arabicText: 'le', startMilliSeconds: 200, endMilliSeconds: 1700),
      Word(arabicText: 'le', startMilliSeconds: 2920, endMilliSeconds: 6300),
      Word(arabicText: 'le', startMilliSeconds: 7100, endMilliSeconds: 8200),
      Word(arabicText: 'le', startMilliSeconds: 9560, endMilliSeconds: 10600),
      Word(arabicText: 'le', startMilliSeconds: 12400, endMilliSeconds: 13740),
      Word(arabicText: 'le', startMilliSeconds: 14800, endMilliSeconds: 16220),
      Word(arabicText: 'le', startMilliSeconds: 17980, endMilliSeconds: 19120),
      Word(arabicText: 'le', startMilliSeconds: 20720, endMilliSeconds: 22060),
      Word(arabicText: 'le', startMilliSeconds: 23940, endMilliSeconds: 25020),
      Word(arabicText: 'le', startMilliSeconds: 26960, endMilliSeconds: 28720),
      Word(arabicText: 'le', startMilliSeconds: 29820, endMilliSeconds: 32040),
      Word(arabicText: 'le', startMilliSeconds: 33840, endMilliSeconds: 35440),
      Word(arabicText: 'le', startMilliSeconds: 36440, endMilliSeconds: 36540),
      Word(arabicText: 'le', startMilliSeconds: 37320, endMilliSeconds: 39020),
      Word(arabicText: 'le', startMilliSeconds: 40640, endMilliSeconds: 43200),
      Word(arabicText: 'le', startMilliSeconds: 43940, endMilliSeconds: 45600),
      Word(arabicText: 'le', startMilliSeconds: 46860, endMilliSeconds: 49420),
      Word(arabicText: 'le', startMilliSeconds: 51360, endMilliSeconds: 53160),
      Word(arabicText: 'le', startMilliSeconds: 55020, endMilliSeconds: 56700),
      Word(arabicText: 'le', startMilliSeconds: 57460, endMilliSeconds: 57560),
      Word(arabicText: 'le', startMilliSeconds: 58540, endMilliSeconds: 59740),
      Word(arabicText: 'le', startMilliSeconds: 61900, endMilliSeconds: 63540),
      Word(arabicText: 'le', startMilliSeconds: 65820, endMilliSeconds: 67320),
      Word(arabicText: 'le', startMilliSeconds: 68460, endMilliSeconds: 71220),
      Word(arabicText: 'le', startMilliSeconds: 73480, endMilliSeconds: 75520),
      Word(arabicText: 'le', startMilliSeconds: 76380, endMilliSeconds: 76480),
      Word(arabicText: 'le', startMilliSeconds: 77560, endMilliSeconds: 79280),
      Word(arabicText: 'le', startMilliSeconds: 79980, endMilliSeconds: 80080),
      Word(arabicText: 'le', startMilliSeconds: 81380, endMilliSeconds: 83320),
      Word(arabicText: 'le', startMilliSeconds: 84740, endMilliSeconds: 84860),
    ]
  )
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
