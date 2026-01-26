import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  static TextStyle get heading => GoogleFonts.inter(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static TextStyle get subHeading => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  static TextStyle get buttonText => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );

  static TextStyle get inputLabel => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );

  static TextStyle get inputText =>
      GoogleFonts.inter(fontSize: 16, color: AppColors.textPrimary);

  static TextStyle get sectionHeader => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.2,
    color: AppColors.textSecondary,
  );

  static TextStyle get cardTitle => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static TextStyle get bodyText => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );
}

class AppStyles {
  static BoxDecoration get cardDecoration => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(24),
    boxShadow: const [
      BoxShadow(
        color: AppColors.shadow,
        blurRadius: 20,
        offset: Offset(0, 8),
        spreadRadius: 2,
      ),
    ],
  );

  static BoxDecoration get logoContainerDecoration => BoxDecoration(
    gradient: AppColors.primaryGradient,
    borderRadius: BorderRadius.circular(24),
    boxShadow: [
      BoxShadow(
        color: AppColors.primaryBlue.withOpacity(0.3),
        blurRadius: 15,
        offset: const Offset(0, 8),
      ),
    ],
  );

  static BoxDecoration get glassDecoration => BoxDecoration(
    color: Colors.white.withOpacity(0.8),
    borderRadius: BorderRadius.circular(20),
    border: Border.all(color: Colors.white.withOpacity(0.5)),
    boxShadow: const [
      BoxShadow(color: AppColors.shadow, blurRadius: 15, offset: Offset(0, 4)),
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
              padding: const EdgeInsets.only(left: 12.0, right: 8.0),
              child: prefixIcon,
            )
          : null,
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: AppColors.background,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: _defaultInputBorder,
      enabledBorder: _defaultInputBorder,
      focusedBorder: _focusedInputBorder,
    );
  }

  static OutlineInputBorder get _defaultInputBorder => OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: Colors.grey.shade300),
  );

  static OutlineInputBorder get _focusedInputBorder => OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: const BorderSide(color: AppColors.primaryBlue, width: 2),
  );
}
