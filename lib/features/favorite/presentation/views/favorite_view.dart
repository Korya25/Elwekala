import 'package:elwekala/core/constants/app_colors.dart';
import 'package:elwekala/features/favorite/presentation/widgets/favorites_app_bar.dart';
import 'package:elwekala/features/favorite/presentation/widgets/favorites_content.dart';
import 'package:flutter/material.dart';

import '../../../home/data/model/lap_top_model.dart';


class FavoriteView extends StatefulWidget {
  final List<LaptopModel> favoriteLaptops;
  final Function(LaptopModel) onRemoveFromFavorites;
  final Function(LaptopModel) onNavigateToDetails;

  const FavoriteView({
    super.key,
    required this.favoriteLaptops,
    required this.onRemoveFromFavorites,
    required this.onNavigateToDetails,
  });

  @override
  State<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _listAnimationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _listAnimationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutCubic,
      ),
    );

    _animationController.forward();
    _listAnimationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _listAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          FavoritesAppBar(
            animationController: _animationController,
            fadeAnimation: _fadeAnimation,
            slideAnimation: _slideAnimation,
          ),
          FavoritesContent(
            favoriteLaptops: widget.favoriteLaptops,
            onRemoveFromFavorites: widget.onRemoveFromFavorites,
            onNavigateToDetails: widget.onNavigateToDetails,
            listAnimationController: _listAnimationController,
          ),
        ],
      ),
    );
  }
}


