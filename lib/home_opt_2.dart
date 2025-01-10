// ignore_for_file: avoid_print

import 'dart:math';

import 'package:flutter/material.dart';

// 2. Avoid rebuilding certain widgets repetitively using `const` keyword.
// Refs:
// https://blog.codemagic.io/how-to-improve-the-performance-of-your-flutter-app./
// https://habr.com/ru/articles/502882/#ispolzuyte-const

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _random = Random();
  Color _currentColor = Colors.grey;

  void _onPressed() {
    final randomNumber = _random.nextInt(30);
    setState(() {
      _currentColor = Colors.primaries[randomNumber % Colors.primaries.length];
    });
  }

  @override
  Widget build(BuildContext context) {
    print('building `HomePage`');
    return Scaffold(
      body: Stack(
        children: [
          const Positioned.fill(
            child: _BackgroundWidget(),
          ),
          Center(
            child: Container(
              height: 150,
              width: 150,
              color: _currentColor,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onPressed,
        child: const Icon(Icons.colorize),
      ),
    );
  }
}

class _BackgroundWidget extends StatelessWidget {
  // GOOD with `const` constructor
  // _BackgroundWidget doesn't rebuild when the color changes.
  const _BackgroundWidget();
  // BAD without `const` constructor
  // _BackgroundWidget rebuilds when the color changes.

  @override
  Widget build(BuildContext context) {
    print('building `_BackgroundWidget`');
    return Image.network(
      'https://cdn.pixabay.com/photo/2017/08/30/01/05/milky-way-2695569_960_720.jpg',
      fit: BoxFit.cover,
    );
  }
}
