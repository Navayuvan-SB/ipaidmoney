import 'package:flutter/material.dart';

InputDecorationTheme inputDecorationTheme = const InputDecorationTheme(
  border: InputBorder.none,
);

ThemeData DefaultTheme = ThemeData(
  fontFamily: 'Manrope',
  inputDecorationTheme: inputDecorationTheme,
);

ThemeData LightTheme = DefaultTheme.copyWith(
  colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.green, brightness: Brightness.light),
);

ThemeData DarkTheme = DefaultTheme.copyWith(
  colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.green, brightness: Brightness.dark),
  scaffoldBackgroundColor: const Color.fromARGB(255, 29, 29, 29),
  dialogBackgroundColor: const Color(0xFF333333),
);
