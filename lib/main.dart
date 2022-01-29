import 'package:flutter/material.dart';
import 'package:folkatech_test/pages/pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Folkatech Test',
      theme: ThemeData(
        primaryColor: const Color(0xFFb1001a),
        primarySwatch: Colors.red,
      ),
      home: const SplashScreenPage(),
    );
  }
}
