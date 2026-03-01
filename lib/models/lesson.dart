import 'word.dart';

class Lesson {
  final String letter;
  final String audioAssetPath;
  final List<Word> words;

  const Lesson({
    required this.letter,
    required this.audioAssetPath,
    required this.words,
  });
}