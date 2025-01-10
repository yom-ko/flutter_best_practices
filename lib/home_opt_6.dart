// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

// 6. Use itemExtent in ListView for long lists.
// Refs:
// https://blog.codemagic.io/how-to-improve-the-performance-of-your-flutter-app./
// https://habr.com/ru/articles/502882/#ispolzuyte-itemextent-v-listview-dlya-bolshih-spiskov

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scrollController = ScrollController();

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

  void _onPressed() async {
    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        controller: _scrollController,
        // GOOD
        // Use itemExtent for optimal list rendering.
        itemExtent: 200,
        children: widgets,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onPressed,
        splashColor: Colors.red,
        child: const Icon(Icons.slow_motion_video),
      ),
    );
  }
}
