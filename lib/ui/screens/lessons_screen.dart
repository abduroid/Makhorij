import 'package:flutter/material.dart';

import '../../data/content.dart';
import '../../models/lesson.dart';
import '../../models/word.dart';
import 'word_pager_screen.dart';

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
