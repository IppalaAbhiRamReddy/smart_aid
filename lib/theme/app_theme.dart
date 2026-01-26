import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

final ThemeData appTheme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: AppColors.background,
  primaryColor: AppColors.primaryBlue,
  fontFamily: GoogleFonts.outfit().fontFamily,
  textTheme: GoogleFonts.outfitTextTheme().apply(
    bodyColor: AppColors.textPrimary,
    displayColor: AppColors.textPrimary,
  ),

  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: AppColors.primaryBlue,
    secondary: AppColors.primaryBlue,
    background: AppColors.background,
    surface: AppColors.surface,
    error: AppColors.error,
  ),

  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    centerTitle: false,
    iconTheme: IconThemeData(color: AppColors.textPrimary),
    titleTextStyle: TextStyle(
      color: AppColors.textPrimary,
      fontSize: 22,
      fontWeight: FontWeight.bold,
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
    hintStyle: TextStyle(color: Colors.grey.shade400),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Colors.grey.shade200),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: AppColors.primaryBlue, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: AppColors.error),
    ),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primaryBlue,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 18),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      shadowColor: AppColors.primaryBlue.withOpacity(0.4),
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    ),
  ),

  cardTheme: CardThemeData(
    color: Colors.white,
    elevation: 0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    margin: EdgeInsets.zero,
  ),
);
