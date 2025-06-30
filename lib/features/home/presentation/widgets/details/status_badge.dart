import 'package:elwekala/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class StatusBadge extends StatelessWidget {
  final String status;

  const StatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final isNew = status.toLowerCase() == "new";
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isNew
              ? [AppColors.successGreen, const Color(0xFF059669)]
              : [AppColors.primaryYellow, const Color(0xFFD97706)],
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: (isNew ? AppColors.successGreen : AppColors.primaryYellow).withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Text(
        status,
        style: const TextStyle(
          color: AppColors.textWhite,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}