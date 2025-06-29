import 'package:elwekala/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final appTheme = ThemeData(
  primarySwatch: Colors.purple,
  scaffoldBackgroundColor: AppColors.primaryPurple.withAlpha(20),
  textTheme: GoogleFonts.interTextTheme().apply(
    bodyColor: AppColors.textWhite,
    displayColor: AppColors.textWhite,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.backgroundDark,
    elevation: 0,
  ),
  colorScheme: ColorScheme.dark(
    primary: AppColors.primaryPurple,
    secondary: AppColors.primaryPink,
    surface: AppColors.cardBackground,
    // ignore: deprecated_member_use
    background: AppColors.backgroundDark,
    error: AppColors.errorRed,
  ),
);
