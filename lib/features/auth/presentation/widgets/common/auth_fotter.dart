import 'package:elwekala/core/constants/app_colors.dart';
import 'package:elwekala/core/resources/app_text_styles.dart';
import 'package:flutter/material.dart';

class AuthFotter extends StatelessWidget {
  const AuthFotter({
    super.key,
    required this.title,
    required this.screenTitle,
    required this.onTap,
  });
  final String title;
  final String screenTitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(title, style: AppTextStyles.bodySmall),
        GestureDetector(
          onTap: onTap,
          child: Text(
       screenTitle,
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.primaryPurple,
            ),
          ),
        ),
      ],
    );
  }
}
