import 'package:record/record.dart';

import '_recording_storage_io.dart'
    if (dart.library.html) '_recording_storage_web.dart';
import '../models/lesson.dart';
import '../models/word.dart';

/// Manages voice recordings for a single lesson.
///
/// Recordings are stored permanently on native (app documents directory) and
/// in-memory for the session on web, keyed by lesson route name and word index.
class RecordManager {
  final Lesson lesson;
  final AudioRecorder _recorder = AudioRecorder();
  final RecordingStorage _storage = RecordingStorage();

  String? _currentWordKey;

  RecordManager(this.lesson);

  /// Start recording for [word]. Overwrites any previous recording.
  /// Returns false if microphone permission was denied.
  Future<bool> startRecording(Word word) async {
    final hasPermission = await _recorder.hasPermission();
    if (!hasPermission) return false;
    final key = _keyFor(word);
    _currentWordKey = key;
    final path = await _storage.getStartPath(lesson.routeName, key);
    await _recorder.start(
      const RecordConfig(encoder: AudioEncoder.aacLc),
      path: path,
    );
    return true;
  }

  /// Stop the active recording and persist it.
  Future<void> stopRecording() async {
    final url = await _recorder.stop();
    if (_currentWordKey != null) {
      await _storage.saveRecording(_currentWordKey!, url);
    }
    _currentWordKey = null;
  }

  /// Cancel the active recording and discard it.
  Future<void> cancelRecording() async {
    _currentWordKey = null;
    await _recorder.cancel();
  }

  /// Returns the path/URL of the recording for [word], or null if none exists.
  Future<String?> getRecording(Word word) async {
    return _storage.getRecording(lesson.routeName, _keyFor(word));
  }

  Future<void> dispose() async {
    await _recorder.dispose();
  }

  // --- helpers ---

  String _keyFor(Word word) {
    final wordIndex = lesson.words.indexOf(word);
    return wordIndex >= 0
        ? wordIndex.toString()
        : word.arabicText.hashCode.toString();
  }
}
