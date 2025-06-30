import 'package:elwekala/core/constants/app_colors.dart';
import 'package:elwekala/features/home/data/model/lap_top_model.dart';
import 'package:flutter/material.dart';

class StockStatus extends StatelessWidget {
  final LaptopModel laptop;

  const StockStatus({super.key, required this.laptop});

  @override
  Widget build(BuildContext context) {
    final inStock = laptop.countInStock > 0;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: inStock ? AppColors.successGreen : AppColors.errorRed,
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: (inStock ? AppColors.successGreen : AppColors.errorRed).withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              inStock ? Icons.inventory_2 : Icons.error_outline,
              color: inStock ? AppColors.successGreen : AppColors.errorRed,
              size: 24,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    inStock ? "Available in Stock" : "Out of Stock",
                    style: TextStyle(
                      color: inStock ? AppColors.successGreen : AppColors.errorRed,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  if (inStock)
                    Text(
                      "${laptop.countInStock} units available",
                      style: const TextStyle(color: AppColors.textGrey, fontSize: 12),
                    ),
                ],
              ),
            ),
            if (inStock)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.successGreen.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Ready to ship',
                  style: TextStyle(
                    color: AppColors.successGreen,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}