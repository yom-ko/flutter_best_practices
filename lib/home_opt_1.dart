// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

// 1. Use separate widgets instead of helper methods for composition.
// Refs:
// https://blog.codemagic.io/how-to-improve-the-performance-of-your-flutter-app./
// https://habr.com/ru/articles/502882/#ne-ispolzuyte-vidzhet-opacity-v-animaciyah
// https://www.youtube.com/watch?v=IOyq-eTRhvo
// https://stackoverflow.com/questions/53234825/what-is-the-difference-between-functions-and-classes-to-create-reusable-widgets
// https://github.com/flutter/flutter/issues/19269
// https://pub.dev/packages/functional_widget

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(context) {
    return CounterScope(
      notifier: Counter(),
      child: const HomeBody(),
    );
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    print('build `HomeBody`');
    return Scaffold(
      body: const Center(
        // GOOD
        // HomeBody doesn't rebuild when the counter changes.
        child: Title(),
        // BAD
        // HomeBody rebuilds when the counter changes.
        // child: title(context),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => CounterScope.of(context, listen: false).value++,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class Title extends StatelessWidget {
  const Title({super.key});

  @override
  Widget build(BuildContext context) {
    print('build `Title` from widget');
    return Text('Counter ${CounterScope.of(context).value}');
  }
}

Widget title(BuildContext context) {
  print('build `Title` from function');
  return Text('Counter ${CounterScope.of(context).value}');
}

class CounterScope extends InheritedNotifier {
  const CounterScope({
    super.key,
    required super.child,
    required super.notifier,
  });

  static Counter of(BuildContext context, {bool listen = true}) {
    if (listen) {
      return context.dependOnInheritedWidgetOfExactType<CounterScope>()!.notifier as Counter;
    } else {
      return context.getInheritedWidgetOfExactType<CounterScope>()!.notifier as Counter;
    }
  }
}

class Counter extends ValueNotifier<int> {
  Counter() : super(0);
}
