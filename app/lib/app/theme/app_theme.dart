import 'package:flutter/material.dart';

abstract final class AppTheme {
  static const Color _seedColor = Color(0xFF738641);

  static ThemeData get light {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: _seedColor,
      brightness: Brightness.light,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: const Color(0xFFF7F7F2),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFFF7F7F2),
        surfaceTintColor: Colors.transparent,
      ),
    );
  }
}
