import 'dart:io';

import 'package:path_provider/path_provider.dart';

class RecordingStorage {
  Future<String> getStartPath(String lessonName, String wordKey) async {
    final base = await getApplicationDocumentsDirectory();
    final dir = Directory('${base.path}/recordings/$lessonName');
    await dir.create(recursive: true);
    return '${dir.path}/$wordKey.m4a';
  }

  // ignore: avoid_unused_parameters
  Future<void> saveRecording(String wordKey, String? url) async {
    // File is already written at the path we passed to start(); nothing to do.
  }

  Future<String?> getRecording(String lessonName, String wordKey) async {
    final base = await getApplicationDocumentsDirectory();
    final path = '${base.path}/recordings/$lessonName/$wordKey.m4a';
    return File(path).existsSync() ? path : null;
  }
}
