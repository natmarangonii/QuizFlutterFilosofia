import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      scaffoldBackgroundColor: const Color(0xFFEFEBE9), // marrom fundo

      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF3E2723), // marrom escuro
        foregroundColor: Color(0xFFD7CCC8), // marrom claro
        centerTitle: true,
        elevation: 0,
      ),

      textTheme: const TextTheme(
        titleMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Color(0xFF3E2723), // marrom escuro
        ),
        bodyMedium: TextStyle(
          fontSize: 16,
          color: Color(0xFF3E2723), // marrom escuro
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF6D4C41), // marrom médio
          foregroundColor: Colors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }
}