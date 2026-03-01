import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart' show AudioPlayer;
import 'package:makhorij_app/models/word.dart';

class SingleWordScreen extends StatefulWidget {
  const SingleWordScreen({super.key});

  @override
  State<SingleWordScreen> createState() => _SingleWordScreenState();
}

class _SingleWordScreenState extends State<SingleWordScreen> {

  @override
  Widget build(BuildContext context) {
    return Text("letter");
  }
}
