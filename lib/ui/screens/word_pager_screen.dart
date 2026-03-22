import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../models/lesson.dart';
import '../../models/word.dart';
import '../../services/player_manager.dart';
import '../../services/record_manager.dart';
import '../widgets/word_card.dart';

class WordPagerScreen extends StatefulWidget {
  final Lesson lesson;
  final int initialPage;

  const WordPagerScreen({super.key, required this.lesson, this.initialPage = 0});

  @override
  State<WordPagerScreen> createState() => _WordPagerScreenState();
}

// TODO #1 Show page number # / $page_count
// TODO #1 Button to navigate to the first element.
class _WordPagerScreenState extends State<WordPagerScreen> {
  late final PlayerManager _playerManager;
  late final RecordManager _recordManager;
  late final PageController _pageController;

  StreamSubscription<bool>? _teacherStateSub;
  StreamSubscription<bool>? _studentStateSub;

  int _currentIndex = 0;
  bool _isTeacherPlaying = false;
  bool _isStudentPlaying = false;
  bool _isRecording = false;
  String? _currentRecordingPath;

  List<Word> get words => widget.lesson.words;
  Word get _currentWord => words[_currentIndex];

  @override
  void initState() {
    super.initState();
    _playerManager = PlayerManager(widget.lesson.audioAssetPath);
    _recordManager = RecordManager(widget.lesson);
    unawaited(_playerManager.init());
    _currentIndex = widget.initialPage;
    _pageController = PageController(initialPage: widget.initialPage);
    _subscribeToPlayerStates();
    unawaited(_loadCurrentRecording());
  }

  void _subscribeToPlayerStates() {
    _teacherStateSub = _playerManager.teacherPlayingStream.listen((playing) {
      if (mounted) setState(() => _isTeacherPlaying = playing);
    });
    _studentStateSub = _playerManager.studentPlayingStream.listen((playing) {
      if (mounted) setState(() => _isStudentPlaying = playing);
    });
  }

  @override
  void dispose() {
    _teacherStateSub?.cancel();
    _studentStateSub?.cancel();
    _pageController.dispose();
    unawaited(_playerManager.dispose());
    unawaited(_recordManager.dispose());
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
      _currentRecordingPath = null;
    });
    unawaited(SystemNavigator.routeInformationUpdated(
      uri: Uri.parse('/lesson/${widget.lesson.routeName}/${index + 1}'),
      replace: true,
    ));
    if (_isRecording) {
      unawaited(_recordManager.cancelRecording());
      setState(() => _isRecording = false);
    }
    unawaited(_playerManager.stop());
    unawaited(_loadCurrentRecording());
  }

  Future<void> _loadCurrentRecording() async {
    final path = await _recordManager.getRecording(_currentWord);
    if (mounted) setState(() => _currentRecordingPath = path);
  }

  Future<void> _cancelRecordingIfActive() async {
    if (!_isRecording) return;
    await _recordManager.cancelRecording();
    if (mounted) setState(() => _isRecording = false);
  }

  Future<void> _startRecording() async {
    await _playerManager.stop();
    final started = await _recordManager.startRecording(_currentWord);
    if (mounted && started) setState(() => _isRecording = true);
  }

  Future<void> _stopRecording() async {
    await _recordManager.stopRecording();
    if (mounted) setState(() => _isRecording = false);
    await _loadCurrentRecording();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                PageView.builder(
                  controller: _pageController,
                  itemCount: words.length,
                  onPageChanged: _onPageChanged,
                  itemBuilder: (context, index) {
                    final word = words[index];
                    return WordCard(
                      word: word,
                      onTap: () => unawaited(_playerManager.playTeacherRecording(word)),
                    );
                  },
                ),
                if (_currentIndex > 0)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.chevron_left),
                      iconSize: 40,
                      onPressed: () => _pageController.previousPage(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.linear,
                      ),
                    ),
                  ),
                if (_currentIndex < words.length - 1)
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: const Icon(Icons.chevron_right),
                      iconSize: 40,
                      onPressed: () => _pageController.nextPage(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.linear,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          _buildControls(),
        ],
      ),
    );
  }

  Widget _buildControls() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _teacherButton(),
          _studentSlot(),
          _recordButton(),
        ],
      ),
    );
  }

  Widget _teacherButton() {
    return _CircleButton(
      onPressed: _isTeacherPlaying
          ? null
          : () async {
              await _cancelRecordingIfActive();
              unawaited(_playerManager.playTeacherRecording(_currentWord));
            },
      child: _isTeacherPlaying
          ? const Icon(Icons.graphic_eq)
          : const Icon(Icons.play_arrow),
    );
  }

  Widget _studentSlot() {
    if (_currentRecordingPath == null) {
      return const _DashedCircleSlot();
    }
    return _CircleButton(
      onPressed: _isStudentPlaying
          ? null
          : () async {
              await _cancelRecordingIfActive();
              unawaited(_playerManager.playStudentRecording(_currentRecordingPath!));
            },
      child: _isStudentPlaying
          ? const Icon(Icons.graphic_eq)
          : const Icon(Icons.play_arrow),
    );
  }

  Widget _recordButton() {
    return _CircleButton(
      onPressed: _isRecording
          ? () => unawaited(_stopRecording())
          : () => unawaited(_startRecording()),
      backgroundColor: _isRecording ? Colors.red : null,
      child: Icon(_isRecording ? Icons.stop : Icons.mic),
    );
  }
}

class _CircleButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final Color? backgroundColor;

  const _CircleButton({
    required this.onPressed,
    required this.child,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(16),
        backgroundColor: backgroundColor,
      ),
      child: child,
    );
  }
}

class _DashedCircleSlot extends StatelessWidget {
  const _DashedCircleSlot();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 56,
      height: 56,
      child: CustomPaint(
        painter: _DashedCirclePainter(
          color: Theme.of(context).colorScheme.outline,
        ),
      ),
    );
  }
}

class _DashedCirclePainter extends CustomPainter {
  final Color color;

  const _DashedCirclePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 2;

    const dashCount = 12;
    const dashAngle = 2 * pi / dashCount;
    const gapFraction = 0.4;

    for (int i = 0; i < dashCount; i++) {
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        i * dashAngle,
        dashAngle * (1 - gapFraction),
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_DashedCirclePainter old) => old.color != color;
}
