import 'package:elwekala/core/constants/app_colors.dart';
import 'package:elwekala/features/home/data/model/lap_top_model.dart';
import 'package:elwekala/features/home/presentation/widgets/details/company_badge.dart';
import 'package:elwekala/features/home/presentation/widgets/details/rating_widget.dart';
import 'package:elwekala/features/home/presentation/widgets/details/status_badge.dart';
import 'package:flutter/material.dart';

class ProductHeader extends StatelessWidget {
  final LaptopModel laptop;

  const ProductHeader({super.key, required this.laptop});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              StatusBadge(status: laptop.status),
              const Spacer(),
              CompanyBadge(company: laptop.company),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            laptop.name,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColors.textWhite,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              RatingWidget(sales: laptop.sales),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'Price',
                    style: TextStyle(color: AppColors.textGrey, fontSize: 12),
                  ),
                  Text(
                    '\$${laptop.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: AppColors.successGreen,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}