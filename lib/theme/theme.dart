import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  colorScheme: const ColorScheme.light(
    background: Colors.white,
    inversePrimary: Colors.white,
    primary: Colors.black,
  ),
);

ThemeData darkMode = ThemeData(
  colorScheme: ColorScheme.light(
    background: Colors.grey[900]!,
    primary: Colors.white,
    inversePrimary: Colors.black,
  ),
);
