import 'package:flutter/material.dart';

class AppColors {
  // Primary Palette (Vibrant Blue & Gradients)
  static const Color primaryBlue = Color(0xFF3B82F6); // Vibrant Blue
  static const Color primaryDark = Color(0xFF1D4ED8); // Deep Blue
  static const Color secondary = Color(0xFF0EA5E9); // Sky Blue (Secondary)

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF3B82F6), Color(0xFF2563EB)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient dangerGradient = LinearGradient(
    colors: [Color(0xFFEF4444), Color(0xFFDC2626)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Backgrounds
  static const Color background = Color(
    0xFFF8FAFC,
  ); // Slate 50 (Very light cool grey)
  static const Color surface = Colors.white;
  static Color surfaceGlass = Colors.white.withOpacity(0.85);

  // Text
  static const Color textPrimary = Color(0xFF0F172A); // Slate 900
  static const Color textSecondary = Color(0xFF64748B); // Slate 500
  static const Color textLight = Color(0xFF94A3B8); // Slate 400

  // Functional Colors
  static const Color error = Color(0xFFEF4444);
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color emergencyRed = Color(0xFFDC2626);

  // UI Accents
  static const Color shadow = Color(
    0x0F000000,
  ); // 6% opacity black for subtle depth
  static const Color white = Colors.white;
}
