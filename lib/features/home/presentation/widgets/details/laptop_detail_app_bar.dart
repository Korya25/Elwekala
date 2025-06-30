import 'package:elwekala/core/constants/app_colors.dart';
import 'package:elwekala/features/home/presentation/widgets/details/image_indicators.dart';
import 'package:elwekala/features/home/presentation/widgets/details/laptop_image.dart';
import 'package:flutter/material.dart';

class LaptopDetailAppBar extends StatelessWidget {
  final List<String> images;
  final PageController pageController;
  final int currentImageIndex;
  final ValueChanged<int> onPageChanged;
  final VoidCallback onBackPressed;
  final bool isFavorite;
  final VoidCallback onFavoritePressed;
  final Animation<double> favoriteAnimation;

  const LaptopDetailAppBar({
    super.key,
    required this.images,
    required this.pageController,
    required this.currentImageIndex,
    required this.onPageChanged,
    required this.onBackPressed,
    required this.isFavorite,
    required this.onFavoritePressed,
    required this.favoriteAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 450,
      floating: false,
      pinned: true,
      backgroundColor: AppColors.backgroundDark,
      elevation: 0,
      leading: _buildBackButton(),
      actions: [_buildFavoriteButton()],
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [AppColors.primaryPurple.withOpacity(0.1), AppColors.backgroundDark],
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: pageController,
                  onPageChanged: onPageChanged,
                  itemCount: images.length,
                  itemBuilder: (context, index) => LaptopImage(
                    imageUrl: images[index],
                    laptopName: 'laptop_${images[index]}',
                  ),
                ),
              ),
              if (images.length > 1)
                ImageIndicators(
                  count: images.length,
                  currentIndex: currentImageIndex,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackButton() {
    return GestureDetector(
      onTap: onBackPressed,
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.cardBackground.withOpacity(0.9),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: const Icon(
          Icons.arrow_back_ios_new,
          color: AppColors.textWhite,
          size: 20,
        ),
      ),
    );
  }

  Widget _buildFavoriteButton() {
    return AnimatedBuilder(
      animation: favoriteAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: favoriteAnimation.value,
          child: GestureDetector(
            onTap: onFavoritePressed,
            child: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.cardBackground.withOpacity(0.9),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? AppColors.errorRed : AppColors.textWhite,
                size: 20,
              ),
            ),
          ),
        );
      },
    );
  }
}