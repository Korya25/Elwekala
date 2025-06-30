import 'package:elwekala/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CompanyBadge extends StatelessWidget {
  final String company;

  const CompanyBadge({super.key, required this.company});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.primaryPurple.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primaryPurple.withOpacity(0.3)),
      ),
      child: Text(
        company,
        style: const TextStyle(
          color: AppColors.primaryPurple,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}