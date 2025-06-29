import 'package:elwekala/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static TextStyle headlineLarge = GoogleFonts.inter(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.textWhite,
    letterSpacing: 1.2,
  );

  static TextStyle headlineMedium = GoogleFonts.inter(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textWhite,
  );

  static TextStyle headlineSmall = GoogleFonts.inter(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.textWhite,
  );

  static TextStyle bodyLarge = GoogleFonts.inter(
    fontSize: 16,
    color: AppColors.textWhite,
  );

  static TextStyle bodyMedium = GoogleFonts.inter(
    fontSize: 14,
    color: AppColors.textWhite,
  );

  static TextStyle bodySmall = GoogleFonts.inter(
    fontSize: 12,
    color: AppColors.textGrey,
  );

  static TextStyle button = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.textWhite,
  );
}
