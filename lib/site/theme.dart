import 'package:flutter/material.dart';

ThemeData buildSiteTheme() {
  final seed = const Color(0xFF0EA5E9);
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: seed),
    useMaterial3: true,
    scaffoldBackgroundColor: const Color(0xFFF8FAFC),
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 48, fontWeight: FontWeight.w800),
      displayMedium: TextStyle(fontSize: 36, fontWeight: FontWeight.w800),
      titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
      bodyLarge: TextStyle(fontSize: 16),
      bodyMedium: TextStyle(fontSize: 14),
    ),
  );
}
