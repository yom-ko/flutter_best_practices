// ignore_for_file: avoid_print

import 'dart:math';

import 'package:flutter/material.dart';

// 5. Avoid rebuilding unnecessary widgets inside `AnimatedBuilder` using `child` prop.
// Refs:
// https://blog.codemagic.io/how-to-improve-the-performance-of-your-flutter-app./
// https://habr.com/ru/articles/502882/#izbegayte-nenuzhnyh-perestroeniy-vidzhetov-vnutri-animatedbuilder

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int counter = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onPressed() {
    setState(() {
      counter++;
    });
    _controller.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _controller,
        // GOOD
        // Use `child` prop to avoid rebuilding unnecessary widgets during animation.
        child: _CounterWidget(counter: counter),
        builder: (_, child) => Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(360 * _controller.value * (pi / 180.0)),
          child: child,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onPressed,
        splashColor: Colors.red,
        child: const Icon(Icons.slow_motion_video),
      ),
    );
  }
}

class _CounterWidget extends StatelessWidget {
  final int counter;

  const _CounterWidget({required this.counter});

  @override
  Widget build(BuildContext context) {
    print('building `_CounterWidget`');
    return Center(
      child: Text(
        counter.toString(),
        style: Theme.of(context).textTheme.headlineLarge,
      ),
    );
  }
}
