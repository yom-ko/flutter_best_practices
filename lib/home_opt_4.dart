// ignore_for_file: avoid_print

import 'dart:math';

import 'package:flutter/material.dart';

// 4. Avoid rebuilding widgets repetitively using `ChangeNotifier` instead of `setState`.
// Refs:
// https://blog.codemagic.io/how-to-improve-the-performance-of-your-flutter-app./
// https://habr.com/ru/articles/502882/#ne-ispolzuyte-vidzhet-opacity-v-animaciyah

class MyColorNotifier extends ChangeNotifier {
  Color myColor = Colors.grey;
  final Random _random = Random();

  void changeColor() {
    int randomNumber = _random.nextInt(30);
    myColor = Colors.primaries[randomNumber % Colors.primaries.length];
    notifyListeners();
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _colorNotifier = MyColorNotifier();

  void _onPressed() {
    _colorNotifier.changeColor();
  }

  @override
  void dispose() {
    _colorNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('building `MyHomePage`');
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _onPressed,
        child: const Icon(Icons.colorize),
      ),
      body: Stack(
        children: [
          const Positioned.fill(
            child: _BackgroundWidget(),
          ),
          Center(
            child: AnimatedBuilder(
              animation: _colorNotifier,
              builder: (_, __) => Container(
                height: 150,
                width: 150,
                color: _colorNotifier.myColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BackgroundWidget extends StatelessWidget {
  const _BackgroundWidget();

  @override
  Widget build(BuildContext context) {
    print('building `_BackgroundWidget`');
    return Image.network(
      'https://cdn.pixabay.com/photo/2017/08/30/01/05/milky-way-2695569_960_720.jpg',
      fit: BoxFit.cover,
    );
  }
}
