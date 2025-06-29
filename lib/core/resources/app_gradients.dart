import 'package:elwekala/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AppGradients {
  static  LinearGradient headerLinearGradient() {
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

   static Gradient defaultOverlayGradient(BuildContext context) {
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Colors.transparent,
        Theme.of(context).shadowColor.withOpacity(0.1),
      ],
    );
  }
}