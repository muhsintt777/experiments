import 'package:flutter/material.dart';
import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Currency Converter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF176B5B),
          surface: const Color(0xFFF5F7F4),
        ),
        scaffoldBackgroundColor: const Color(0xFFF5F7F4),
        fontFamily: 'Roboto',
      ),
      home: const MyHomePage(),
    );
  }
}
