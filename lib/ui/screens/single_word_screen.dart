import 'package:flutter/material.dart';

class SingleWordScreen extends StatefulWidget {
  const SingleWordScreen({super.key});

  @override
  State<SingleWordScreen> createState() => _SingleWordScreenState();
}

class _SingleWordScreenState extends State<SingleWordScreen> {
  @override
  Widget build(BuildContext context) {
    return const Text("Hello World");
  }
}

