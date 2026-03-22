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
    _pageController = PageController(initialPage: widget.initialPage, viewportFraction: 0.75);
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
      backgroundColor: const Color(0xFFF2F2F2),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32.0),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: MediaQuery.sizeOf(context).width * 0.75,
                      child: _buildPager(),
                    ),
                    const SizedBox(height: 48),
                    FractionallySizedBox(
                      widthFactor: 0.75,
                      child: _buildWordNav(),
                    ),
                  ],
                ),
              ),
            ),
            _buildControls(),
          ],
        ),
      ),
    );
  }

  Widget _buildPager() {
    return PageView.builder(
      controller: _pageController,
      clipBehavior: Clip.none,
      itemCount: words.length,
      onPageChanged: _onPageChanged,
      itemBuilder: (context, index) {
        final word = words[index];
        return AnimatedBuilder(
          animation: _pageController,
          builder: (context, child) {
            double scale = 1.0;
            double dx = 0.0;
            if (_pageController.hasClients && _pageController.page != null) {
              final pageDiff = _pageController.page! - index;
              final absDiff = pageDiff.abs();
              final t = (1.0 - absDiff).clamp(0.0, 1.0);
              scale = (1.0 - absDiff * 0.25).clamp(0.75, 1.0);
              dx = 16.0 * (1.0 - t) * pageDiff.sign;
            }
            return Transform.translate(
              offset: Offset(dx, 0),
              child: Transform.scale(scale: scale, child: child!),
            );
          },
          child: WordCard(
            word: word,
            onTap: () => unawaited(_playerManager.playTeacherRecording(word)),
          ),
        );
      },
    );
  }

  Widget _buildWordNav() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: _NavButton(
              icon: Icons.chevron_left,
              onPressed: _currentIndex > 0
                  ? () => _pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      )
                  : null,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _NavButton(
              icon: Icons.chevron_right,
              onPressed: _currentIndex < words.length - 1
                  ? () => _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      )
                  : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControls() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Row(
        children: [
          Expanded(child: _teacherButton()),
          const SizedBox(width: 32),
          Expanded(child: _studentButton()),
          const SizedBox(width: 32),
          Expanded(child: _recordButton()),
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

  Widget _studentButton() {
    if (_currentRecordingPath == null) {
      return Center(
        child: FractionallySizedBox(
          widthFactor: 0.88,
          child: AspectRatio(aspectRatio: 1.0, child: _DashedCircleSlot()),
        ),
      );
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
      child: Icon(
        _isRecording ? Icons.stop : Icons.mic,
        color: _isRecording ? Colors.white : const Color(0xFFD4622A),
      ),
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
    final hasBackground = backgroundColor != null;
    return AspectRatio(
      aspectRatio: 1.0,
      child: Material(
        color: backgroundColor ?? Colors.white,
        shape: CircleBorder(
          side: hasBackground
              ? BorderSide.none
              : const BorderSide(color: Color(0xFFE0E0E0)),
        ),
        elevation: hasBackground ? 2 : 1,
        child: InkWell(
          onTap: onPressed,
          customBorder: const CircleBorder(),
          child: LayoutBuilder(
            builder: (context, constraints) => Center(
              child: IconTheme(
                data: IconThemeData(size: constraints.maxWidth * 0.45),
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DashedCircleSlot extends StatelessWidget {
  const _DashedCircleSlot();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedCirclePainter(
        color: Theme.of(context).colorScheme.outline,
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;

  const _NavButton({required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      elevation: 1,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Icon(
            icon,
            color: onPressed != null ? const Color(0xFF1A1A2E) : const Color(0xFFCCCCCC),
          ),
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
