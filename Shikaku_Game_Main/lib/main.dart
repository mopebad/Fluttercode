import 'package:flutter/material.dart';
import 'package:minigames/shikaku.dart';

void main() async{
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daily Shikaku',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ShikakuGame(numbers: [
        3, 0, 0, 3, 0, 0, 4,
        0, 4, 0, 0, 4, 0, 0,
        0, 0, 0, 0, 0, 6, 0,
        2, 0, 0, 0, 0, 0, 0,
        0, 0, 4, 0, 0, 4, 0,
        0, 6, 0, 2, 0, 0, 3,
        0, 0, 0, 0, 4, 0, 0
      ]),
    );
  }
}


