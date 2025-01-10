// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

// 1. Use separate widgets instead of helper methods for composition.
// Refs:
// https://blog.codemagic.io/how-to-improve-the-performance-of-your-flutter-app./
// https://habr.com/ru/articles/502882/#ne-ispolzuyte-vidzhet-opacity-v-animaciyah
// https://youtu.be/IOyq-eTRhvo
// https://stackoverflow.com/questions/53234825/what-is-the-difference-between-functions-and-classes-to-create-reusable-widgets
// https://github.com/flutter/flutter/issues/19269
// https://pub.dev/packages/functional_widget

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _onPressed() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _onPressed,
        child: const Icon(Icons.colorize),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // BAD
            _buildHeader(),
            _buildMain(context),
            _buildFooter(),
            // GOOD
            const _Header(),
            const _Main(),
            const _Footer(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    print('building `Header` from method');
    const size = 40.0;
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: CircleAvatar(
        backgroundColor: Colors.grey,
        radius: size,
        child: FlutterLogo(
          size: size,
        ),
      ),
    );
  }

  Widget _buildMain(BuildContext context) {
    return Expanded(
      child: Container(
        color: Colors.grey[700],
        child: Center(
          child: Text(
            'Hello Flutter',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Text('This is the footer '),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    print('building `_Header` widget');
    const size = 40.0;
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: CircleAvatar(
        backgroundColor: Colors.grey,
        radius: size,
        child: FlutterLogo(
          size: size,
        ),
      ),
    );
  }
}

class _Main extends StatelessWidget {
  const _Main();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Colors.grey[700],
        child: Center(
          child: Text(
            'Hello Flutter',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Text('This is the footer '),
    );
  }
}
