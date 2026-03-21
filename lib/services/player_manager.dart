import 'dart:async';

import 'package:just_audio/just_audio.dart';

import '../models/word.dart';

class PlayerManager {
  final String _assetPath;
  final AudioPlayer _teacherPlayer = AudioPlayer();
  final AudioPlayer _studentPlayer = AudioPlayer();
  StreamSubscription<Duration>? _positionSub;
  bool _disposed = false;

  PlayerManager(this._assetPath);

  Stream<bool> get teacherPlayingStream =>
      _teacherPlayer.playerStateStream.map(
        (s) => s.playing && s.processingState != ProcessingState.completed,
      );

  Stream<bool> get studentPlayingStream =>
      _studentPlayer.playerStateStream.map(
        (s) => s.playing && s.processingState != ProcessingState.completed,
      );

  Future<void> init() async {
    await _teacherPlayer.setAsset(_assetPath);
  }

  Future<void> playTeacherRecording(Word word) async {
    await _positionSub?.cancel();
    _positionSub = null;
    await stop();

    await _teacherPlayer.seek(Duration(milliseconds: word.startMilliSeconds));

    if (_disposed) return;

    final endDuration = Duration(milliseconds: word.endMilliSeconds);
    _positionSub = _teacherPlayer.positionStream.listen((position) {
      if (_disposed) return;
      if (position >= endDuration) {
        _teacherPlayer.stop();
        _positionSub?.cancel();
        _positionSub = null;
      }
    });

    unawaited(_teacherPlayer.play());
  }

  Future<void> playStudentRecording(String filePath) async {
    await stop();
    await _studentPlayer.setFilePath(filePath);
    if (_disposed) return;
    unawaited(_studentPlayer.play());
  }

  Future<void> stop() async {
    await _positionSub?.cancel();
    _positionSub = null;
    await _teacherPlayer.stop();
    await _studentPlayer.stop();
  }

  Future<void> dispose() async {
    _disposed = true;
    await _positionSub?.cancel();
    _positionSub = null;
    await _teacherPlayer.stop();
    await _studentPlayer.stop();
    await _teacherPlayer.dispose();
    await _studentPlayer.dispose();
  }
}
