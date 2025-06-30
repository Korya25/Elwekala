import 'package:elwekala/core/constants/app_colors.dart';
import 'package:elwekala/features/favorite/presentation/widgets/action_buttons.dart';
import 'package:elwekala/features/favorite/presentation/widgets/laptop_image.dart';
import 'package:elwekala/features/favorite/presentation/widgets/laptop_info.dart';
import 'package:flutter/material.dart';

import '../../../home/data/model/lap_top_model.dart';

class FavoriteCard extends StatelessWidget {
  final LaptopModel laptop;
  final VoidCallback onRemove;
  final VoidCallback onNavigate;

  const FavoriteCard({
    super.key,
    required this.laptop,
    required this.onRemove,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        onTap: onNavigate,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              LaptopImage(laptop: laptop),
              const SizedBox(width: 16),
              Expanded(child: LaptopInfo(laptop: laptop)),
              ActionButtons(onRemove: onRemove, onNavigate: onNavigate),
            ],
          ),
        ),
      ),
    );
  }
}
