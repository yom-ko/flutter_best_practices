import 'package:flutter/material.dart';

import 'home_opt_1.dart';
// import 'home_opt_2.dart';
// import 'home_opt_3.dart';
// import 'home_opt_4.dart';
// import 'home_opt_5.dart';
// import 'home_opt_6.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
