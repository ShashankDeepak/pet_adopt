import 'package:adopt_pet/theme/theme.dart';
import 'package:adopt_pet/view/details/details.dart';
import 'package:adopt_pet/view/history/history.dart';
import 'package:adopt_pet/view/home/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: lightMode,
      darkTheme: darkMode,
      routes: {
        "/": (context) => const HomePage(),
        "/details": (context) => const Details(),
        "/history": (context) => const History(),
      },
      // home: const HomePage(),
    );
  }
}
