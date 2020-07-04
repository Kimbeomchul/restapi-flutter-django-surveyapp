import 'package:flutter/material.dart';
import 'package:flutter_django_quiz_app/screen_home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      home: HomeScreen(),
    );
  }
}
