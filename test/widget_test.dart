// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('My widget test', (tester) async {
    await tester.pumpWidget(const ExampleWidget(key: ValueKey(1)));
    await tester.pumpWidget(const ExampleWidget(key: ValueKey(2)));
  });
}

class ExampleWidget extends StatefulWidget {
  const ExampleWidget({super.key});

  @override
  State<ExampleWidget> createState() => _ExampleWidgetState();
}

class _ExampleWidgetState extends State<ExampleWidget> {
  @override
  void initState() {
    super.initState();
    print('initState called 1');

    Future.microtask(() {
      print('Microtask callback called');
    });

    RendererBinding.instance.addPostFrameCallback((_) {
      print('Post-frame callback called');
    });

    print('initState called 2');
  }

  @override
  Widget build(BuildContext context) {
    print('build called');
    return Container();
  }
}
