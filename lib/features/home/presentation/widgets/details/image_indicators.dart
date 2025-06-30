import 'package:elwekala/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class ImageIndicators extends StatelessWidget {
  final int count;
  final int currentIndex;

  const ImageIndicators({
    super.key,
    required this.count,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(count, (index) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: currentIndex == index ? 24 : 8,
            height: 8,
            decoration: BoxDecoration(
              color: currentIndex == index
                  ? AppColors.primaryPurple
                  : AppColors.textGrey.withOpacity(0.3),
              borderRadius: BorderRadius.circular(4),
            ),
          );
        }),
      ),
    );
  }
}