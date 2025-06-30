import 'package:elwekala/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../home/data/model/lap_top_model.dart';


class LaptopImage extends StatelessWidget {
  final LaptopModel laptop;

  const LaptopImage({super.key, required this.laptop});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primaryPurple.withOpacity(0.1),
            AppColors.primaryPink.withOpacity(0.1),
          ],
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          laptop.image,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.laptop_mac, size: 40, color: Colors.grey);
          },
        ),
      ),
    );
  }
}

