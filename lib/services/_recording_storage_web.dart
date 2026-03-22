class RecordingStorage {
  final Map<String, String> _recordings = {};

  // ignore: avoid_unused_parameters
  Future<String> getStartPath(String lessonName, String wordKey) async {
    // On web the path is just used as the output filename hint — not a real path.
    return wordKey;
  }

  Future<void> saveRecording(String wordKey, String? url) async {
    if (url != null) _recordings[wordKey] = url;
  }

  // ignore: avoid_unused_parameters
  Future<String?> getRecording(String lessonName, String wordKey) async {
    return _recordings[wordKey];
  }
}
