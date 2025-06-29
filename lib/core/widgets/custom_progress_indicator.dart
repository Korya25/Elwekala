
import 'package:elwekala/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CustomProgressIndicator extends StatelessWidget {
  const CustomProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      strokeWidth: 1.8,
      valueColor: AlwaysStoppedAnimation(AppColors.textWhite),
    );
  }
}
