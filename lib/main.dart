import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:makhorij_app/data/content.dart';
import 'package:makhorij_app/ui/screens/lessons_screen.dart';
import 'package:makhorij_app/ui/screens/word_pager_screen.dart';

void main() {
  usePathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Makhorij',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        fontFamily: 'Uthman-taha-naskh-regular',
      ),
      initialRoute: '/',
      onGenerateRoute: _onGenerateRoute,
    );
  }

  /// Routes:
  ///   /                       → LessonsScreen
  ///   /lesson/:name/:index    → WordPagerScreen (index is 1-based)
  ///
  /// Example: /lesson/Sa/4 → 4th word of the Sa lesson.
  /// Lesson name is derived from audio asset path: 'assets/audios/Sa.m4a' → 'Sa'
  Route<dynamic> _onGenerateRoute(RouteSettings settings) {
    final uri = Uri.parse(settings.name ?? '/');
    final segments = uri.pathSegments;

    if (segments.length == 3 && segments[0] == 'lesson') {
      final lessonName = segments[1].toLowerCase();
      final oneBasedIndex = int.tryParse(segments[2]);
      if (oneBasedIndex != null) {
        final matches = lessons.where(
          (l) => l.routeName.toLowerCase() == lessonName,
        );
        if (matches.isNotEmpty) {
          final lesson = matches.first;
          final pageIndex = (oneBasedIndex - 1).clamp(0, lesson.words.length - 1);
          return MaterialPageRoute(
            builder: (_) => WordPagerScreen(lesson: lesson, initialPage: pageIndex),
            settings: settings,
          );
        }
      }
    }

    return MaterialPageRoute(
      builder: (_) => const LessonsScreen(),
      settings: settings,
    );
  }
}
