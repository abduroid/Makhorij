import 'package:flutter/material.dart';
import 'package:makhorij_app/ui/screens/lessons_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Makhorij',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: const WordPagerScreen(),
      theme: ThemeData(
          colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const LessonsScreen(),
    );
  }
}
