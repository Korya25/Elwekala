import 'package:elwekala/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class LaptopImage extends StatelessWidget {
  final String imageUrl;
  final String laptopName;

  const LaptopImage({
    super.key,
    required this.imageUrl,
    required this.laptopName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryPurple.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Hero(
        tag: laptopName,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            imageUrl,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.laptop_mac,
                        size: 64,
                        color: AppColors.textGrey,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Image not available',
                        style: TextStyle(color: AppColors.textGrey),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}