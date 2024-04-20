import 'package:flutter/material.dart';
import 'package:ipaidmoney/config/initializations.dart';
import 'package:ipaidmoney/config/theme.dart';
import 'package:ipaidmoney/screens/home/home.screen.dart';

void main() async {
  await initializeAll();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IPaidMoney',
      theme: LightTheme,
      darkTheme: DarkTheme,
      themeMode: ThemeMode.dark,
      home: HomeScreen(),
    );
  }
}
