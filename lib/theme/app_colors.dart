import 'package:flutter/material.dart';

class AppColors {
  // Primary Palette (Vibrant Blue & Gradients)
  static const Color primaryBlue = Color(0xFF2563EB); // Vibrant Royal Blue
  static const Color primaryDark = Color(
    0xFF1E40AF,
  ); // Darker shade for gradient
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Backgrounds
  static const Color background = Color(0xFFF3F4F6); // Soft Cool Grey
  static const Color surface = Colors.white;

  // Text
  static const Color textPrimary = Color(
    0xFF111827,
  ); // Very Dark Grey (Almost Black)
  static const Color textSecondary = Color(0xFF6B7280); // Cool Grey

  // Functional Colors
  static const Color error = Color(0xFFEF4444);
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color emergencyRed = Color(0xFFDC2626); // Strong Red for SOS

  // UI Accents
  static const Color shadow = Color(
    0x14000000,
  ); // Softer, more diffuse shadow (8% opacity)
  static const Color white = Colors.white;
}
