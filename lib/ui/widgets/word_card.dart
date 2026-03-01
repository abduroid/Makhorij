import 'package:flutter/material.dart';

import '../../models/word.dart';

class WordCard extends StatelessWidget {
  final Word word;
  final VoidCallback onTap;

  const WordCard({super.key, required this.word, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox.expand(
        child: Center(
          child: Text(
            word.arabicText,
            style: const TextStyle(fontSize: 256),
          ),
        ),
      ),
    );
  }
}