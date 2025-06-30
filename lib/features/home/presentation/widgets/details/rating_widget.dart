import 'package:elwekala/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class RatingWidget extends StatelessWidget {
  final int sales;

  const RatingWidget({super.key, required this.sales});

  @override
  Widget build(BuildContext context) {
    final rating = 4.0 + (sales % 10) / 10;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.star, color: AppColors.primaryYellow, size: 18),
          const SizedBox(width: 6),
          Text(
            rating.toStringAsFixed(1),
            style: const TextStyle(
              color: AppColors.textWhite,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            '($sales reviews)',
            style: const TextStyle(color: AppColors.textGrey, fontSize: 12),
          ),
        ],
      ),
    );
  }
}