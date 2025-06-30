import 'package:elwekala/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../home/data/model/lap_top_model.dart';

class LaptopInfo extends StatelessWidget {
  final LaptopModel laptop;

  const LaptopInfo({super.key, required this.laptop});

  @override
  Widget build(BuildContext context) {
    final rating = 4.0 + (laptop.sales % 10) / 10;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          laptop.name,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 8),
        Text(
          laptop.company,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[400],
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Icon(Icons.star, color: AppColors.primaryYellow, size: 14),
            const SizedBox(width: 4),
            Text(
              rating.toStringAsFixed(1),
              style: TextStyle(color: Colors.grey[400], fontSize: 12),
            ),
            const SizedBox(width: 12),
            Text(
              "\$${laptop.price.toStringAsFixed(2)}",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.successGreen,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Icon(
              laptop.countInStock > 0 ? Icons.check_circle : Icons.cancel,
              color: laptop.countInStock > 0 ? AppColors.successGreen : AppColors.errorRed,
              size: 12,
            ),
            const SizedBox(width: 4),
            Text(
              laptop.countInStock > 0 ? "In Stock" : "Out of Stock",
              style: TextStyle(
                color: laptop.countInStock > 0 ? AppColors.successGreen : AppColors.errorRed,
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
