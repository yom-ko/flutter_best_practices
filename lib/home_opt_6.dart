// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

// 6. Use itemExtent in ListView for long lists.
// Refs:
// https://blog.codemagic.io/how-to-improve-the-performance-of-your-flutter-app./
// https://habr.com/ru/articles/502882/#ne-ispolzuyte-vidzhet-opacity-v-animaciyah

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final widgets = List.generate(
    10000,
    (index) => Container(
      // BAD
      // height: 200.0,
      color: Colors.primaries[index % Colors.primaries.length],
      child: ListTile(
        title: Text('Index: $index'),
      ),
    ),
  );

  final _scrollController = ScrollController();

  void _onPressed() async {
    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _onPressed,
        splashColor: Colors.red,
        child: const Icon(Icons.slow_motion_video),
      ),
      body: ListView(
        // GOOD
        itemExtent: 200,
        controller: _scrollController,
        children: widgets,
      ),
    );
  }
}
