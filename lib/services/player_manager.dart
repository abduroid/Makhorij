import 'dart:async';

import 'package:just_audio/just_audio.dart';

import '../models/word.dart';

class PlayerManager {
  final String _assetPath;
  final AudioPlayer _player = AudioPlayer();
  StreamSubscription<Duration>? _positionSub;
  bool _disposed = false;

  PlayerManager(this._assetPath);

  Future<void> init() async {
    await _player.setAsset(_assetPath);
  }

  Future<void> play(Word word) async {
    await _positionSub?.cancel();
    _positionSub = null;
    await _player.stop();
    await _player.seek(Duration(seconds: word.startSeconds));

    if (_disposed) return;

    final endDuration = Duration(seconds: word.endSeconds);
    _positionSub = _player.positionStream.listen((position) {
      if (_disposed) return;
      if (position >= endDuration) {
        _player.stop();
        _positionSub?.cancel();
        _positionSub = null;
      }
    });

    unawaited(_player.play());
  }

  Future<void> stop() async {
    await _positionSub?.cancel();
    _positionSub = null;
    await _player.stop();
  }

  Future<void> dispose() async {
    _disposed = true;
    await _positionSub?.cancel();
    _positionSub = null;
    await _player.stop();
    await _player.dispose();
  }
}
