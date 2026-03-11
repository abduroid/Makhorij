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

  /// Derived from [audioAssetPath]: 'assets/audios/Sa.m4a' → 'Sa'
  String get routeName {
    final filename = audioAssetPath.split('/').last;
    return filename.split('.').first;
  }
}