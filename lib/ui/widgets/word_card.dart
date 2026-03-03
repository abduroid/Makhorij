import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../models/word.dart';

class WordCard extends StatelessWidget {
  final Word word;
  final VoidCallback onTap;

  const WordCard({super.key, required this.word, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(64),
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox.expand(
          child: Center(
            child: AutoSizeText(
              word.arabicText,
              maxLines: 1,
              style: const TextStyle(fontSize: 200),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}