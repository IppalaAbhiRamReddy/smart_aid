import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  static TextStyle get heading => GoogleFonts.outfit(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static TextStyle get subHeading => GoogleFonts.outfit(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  static TextStyle get buttonText => GoogleFonts.outfit(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
    letterSpacing: 0.5,
  );

  static TextStyle get inputLabel => GoogleFonts.outfit(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );

  static TextStyle get inputText =>
      GoogleFonts.outfit(fontSize: 16, color: AppColors.textPrimary);

  static TextStyle get sectionHeader => GoogleFonts.outfit(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.0,
    color: AppColors.textSecondary,
  );

  static TextStyle get cardTitle => GoogleFonts.outfit(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static TextStyle get bodyText => GoogleFonts.outfit(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
    height: 1.5,
  );
}

class AppStyles {
  static BoxDecoration get cardDecoration => BoxDecoration(
    color: AppColors.surface,
    borderRadius: BorderRadius.circular(24),
    boxShadow: const [
      BoxShadow(color: AppColors.shadow, blurRadius: 24, offset: Offset(0, 8)),
    ],
  );

  static BoxDecoration get logoContainerDecoration => BoxDecoration(
    gradient: AppColors.primaryGradient,
    borderRadius: BorderRadius.circular(32),
    boxShadow: [
      BoxShadow(
        color: AppColors.primaryBlue.withOpacity(0.3),
        blurRadius: 24,
        offset: const Offset(0, 12),
      ),
    ],
  );

  // Note: For real glassmorphism in Flutter, you need to use a Stack with BackdropFilter.
  // This decoration provides the visual style (semi-transparent white + border).
  static BoxDecoration get glassDecoration => BoxDecoration(
    color: AppColors.surfaceGlass,
    borderRadius: BorderRadius.circular(24),
    border: Border.all(color: Colors.white.withOpacity(0.5), width: 1.5),
    boxShadow: const [
      BoxShadow(color: AppColors.shadow, blurRadius: 24, offset: Offset(0, 8)),
    ],
  );

  static InputDecoration inputDecoration({
    required String hintText,
    String? labelText,
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,
      labelText: labelText,
      prefixIcon: prefixIcon != null
          ? Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 12.0),
              child: prefixIcon,
            )
          : null,
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      border: _defaultInputBorder,
      enabledBorder: _defaultInputBorder,
      focusedBorder: _focusedInputBorder,
      errorBorder: _errorInputBorder,
      hintStyle: GoogleFonts.outfit(color: AppColors.textLight),
      labelStyle: GoogleFonts.outfit(color: AppColors.textSecondary),
    );
  }

  static OutlineInputBorder get _defaultInputBorder => OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(color: Colors.grey.shade200),
  );

  static OutlineInputBorder get _focusedInputBorder => OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: const BorderSide(color: AppColors.primaryBlue, width: 2),
  );

  static OutlineInputBorder get _errorInputBorder => OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: const BorderSide(color: AppColors.error),
  );
}
