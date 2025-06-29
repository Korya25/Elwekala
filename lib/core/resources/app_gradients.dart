import 'package:elwekala/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AppGradients {
  static  LinearGradient authHeaderLinearGradient() {
    return LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          AppColors.primaryPurple,
          AppColors.primaryPink,
          AppColors.primaryYellow,
        ],
      );
  }
}