// ignore_for_file: avoid_print

import 'dart:math';

import 'package:flutter/material.dart';

// 2. Avoid rebuilding some widgets repetitively using `const` keyword.
// Refs:
// https://blog.codemagic.io/how-to-improve-the-performance-of-your-flutter-app./
// https://habr.com/ru/articles/502882/#ne-ispolzuyte-vidzhet-opacity-v-animaciyah

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color _currentColor = Colors.grey;

  final Random _random = Random();

  void _onPressed() {
    int randomNumber = _random.nextInt(30);
    setState(() {
      _currentColor = Colors.primaries[randomNumber % Colors.primaries.length];
    });
  }

  @override
  Widget build(BuildContext context) {
    print('building `HomePage`');
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
            child: Container(
              height: 150,
              width: 150,
              color: _currentColor,
            ),
          ),
        ],
      ),
    );
  }
}

// BAD
// class _BackgroundWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     print('building `_BackgroundWidget`');
//     return Image.network(
//       'https://cdn.pixabay.com/photo/2017/08/30/01/05/milky-way-2695569_960_720.jpg',
//       fit: BoxFit.cover,
//     );
//   }
// }

// GOOD
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
