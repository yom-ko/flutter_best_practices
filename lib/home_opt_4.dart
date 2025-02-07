// ignore_for_file: avoid_print

import 'dart:math';

import 'package:flutter/material.dart';

// 4. Avoid rebuilding widgets unnecessarily using `ChangeNotifier` instead of `setState`.
// Refs:
// https://blog.codemagic.io/how-to-improve-the-performance-of-your-flutter-app./
// https://habr.com/ru/articles/502882/#izbegayte-povtornyh-perestroeniy-vseh-vidzhetov

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _colorNotifier = MyColorNotifier();

  @override
  void dispose() {
    _colorNotifier.dispose();
    super.dispose();
  }

  void _onPressed() {
    _colorNotifier.changeColor();
  }

  @override
  Widget build(BuildContext context) {
    print('build `MyHomePage`');
    return Scaffold(
      body: Stack(
        children: [
          const _BackgroundWidget(),
          Center(
            child: ListenableBuilder(
              listenable: _colorNotifier,
              builder: (_, __) {
                print('build `Container`');
                return Container(
                  height: 150,
                  width: 150,
                  color: _colorNotifier.myColor,
                );
              },
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

class MyColorNotifier extends ChangeNotifier {
  final Random _random = Random();
  Color myColor = Colors.grey;

  void changeColor() {
    final randomNumber = _random.nextInt(30);
    myColor = Colors.primaries[randomNumber % Colors.primaries.length];
    notifyListeners();
  }
}

class _BackgroundWidget extends StatelessWidget {
  const _BackgroundWidget();

  @override
  Widget build(BuildContext context) {
    print('build `_BackgroundWidget`');
    return Positioned.fill(
      child: Image.network(
        'https://cdn.pixabay.com/photo/2017/08/30/01/05/milky-way-2695569_960_720.jpg',
        fit: BoxFit.cover,
      ),
    );
  }
}
