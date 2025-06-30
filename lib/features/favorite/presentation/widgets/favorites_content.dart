
import 'package:elwekala/core/constants/app_colors.dart';
import 'package:elwekala/features/favorite/presentation/widgets/empty_favorites_state.dart';
import 'package:elwekala/features/favorite/presentation/widgets/favorite_card.dart';
import 'package:flutter/material.dart';

import '../../../home/data/model/lap_top_model.dart';

class FavoritesContent extends StatelessWidget {
  final List<LaptopModel> favoriteLaptops;
  final Function(LaptopModel) onRemoveFromFavorites;
  final Function(LaptopModel) onNavigateToDetails;
  final AnimationController listAnimationController;

  const FavoritesContent({super.key, 
    required this.favoriteLaptops,
    required this.onRemoveFromFavorites,
    required this.onNavigateToDetails,
    required this.listAnimationController,
  });

  @override
  Widget build(BuildContext context) {
    if (favoriteLaptops.isEmpty) {
      return EmptyFavoritesState(
        fadeAnimation: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: listAnimationController,
            curve: Curves.easeOut,
          ),
        ),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.all(20),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          return AnimatedBuilder(
            animation: listAnimationController,
            builder: (context, child) {
              final slideAnimation = Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(
                CurvedAnimation(
                  parent: listAnimationController,
                  curve: Interval(
                    (index * 0.1).clamp(0.0, 1.0),
                    ((index * 0.1) + 0.3).clamp(0.0, 1.0),
                    curve: Curves.easeOutCubic,
                  ),
                ),
              );

              return SlideTransition(
                position: slideAnimation,
                child: FavoriteCard(
                  laptop: favoriteLaptops[index],
                  onRemove: () => _showRemoveDialog(context, favoriteLaptops[index]),
                  onNavigate: () => onNavigateToDetails(favoriteLaptops[index]),
                ),
              );
            },
          );
        }, childCount: favoriteLaptops.length),
      ),
    );
  }

  void _showRemoveDialog(BuildContext context, LaptopModel laptop) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.cardBackground,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(color: AppColors.borderColor),
          ),
          title: const Row(
            children: [
              Icon(Icons.favorite_border, color: AppColors.errorRed),
              SizedBox(width: 12),
              Text(
                'Remove from Favorites',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ],
          ),
          content: Text(
            'Are you sure you want to remove "${laptop.name}" from your favorites?',
            style: TextStyle(color: Colors.grey[300]),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel', style: TextStyle(color: Colors.grey[400])),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.errorRed, Color(0xFFDC2626)],
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  onRemoveFromFavorites(laptop);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${laptop.name} removed from favorites'),
                      backgroundColor: AppColors.cardBackground,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  );
                },
                child: const Text(
                  'Remove',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
