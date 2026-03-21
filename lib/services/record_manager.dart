import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

import '../models/lesson.dart';
import '../models/word.dart';

/// Manages voice recordings for a single lesson.
///
/// Recordings are stored permanently in the app's documents directory,
/// keyed by lesson route name and word index.
class RecordManager {
  final Lesson lesson;
  final AudioRecorder _recorder = AudioRecorder();

  RecordManager(this.lesson);

  /// Start recording for [word]. Overwrites any previous recording.
  /// Returns false if microphone permission was denied.
  Future<bool> startRecording(Word word) async {
    final hasPermission = await _recorder.hasPermission();
    if (!hasPermission) return false;
    final filePath = await _filePathFor(word);
    await _recorder.start(
      const RecordConfig(encoder: AudioEncoder.aacLc),
      path: filePath,
    );
    return true;
  }

  /// Stop the active recording and persist it to disk.
  Future<void> stopRecording() async {
    await _recorder.stop();
  }

  /// Cancel the active recording and discard the file.
  Future<void> cancelRecording() async {
    await _recorder.cancel();
  }

  /// Returns the file path of the recording for [word], or null if none exists.
  Future<String?> getRecording(Word word) async {
    final filePath = await _filePathFor(word);
    return File(filePath).existsSync() ? filePath : null;
  }

  Future<void> dispose() async {
    await _recorder.dispose();
  }

  // --- helpers ---

  Future<String> _filePathFor(Word word) async {
    final base = await getApplicationDocumentsDirectory();
    final dir = Directory('${base.path}/recordings/${lesson.routeName}');
    await dir.create(recursive: true);
    final wordIndex = lesson.words.indexOf(word);
    final key = wordIndex >= 0 ? wordIndex.toString() : word.arabicText.hashCode.toString();
    return '${dir.path}/$key.m4a';
  }
}
