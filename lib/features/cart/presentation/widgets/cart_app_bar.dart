import 'package:elwekala/core/constants/app_colors.dart';
import 'package:elwekala/features/cart/presentation/widgets/reusable_components.dart';
import 'package:elwekala/features/home/data/model/lap_top_model.dart';
import 'package:flutter/material.dart';

class CartAppBar extends StatelessWidget {
  final List<CartItem> cartItems;
  final int totalItems;
  final AnimationController animationController;
  final Animation<double> fadeAnimation;
  final Animation<Offset> slideAnimation;
  final VoidCallback onBack;
  final VoidCallback onClearCart;

  const CartAppBar({
    super.key,
    required this.cartItems,
    required this.totalItems,
    required this.animationController,
    required this.fadeAnimation,
    required this.slideAnimation,
    required this.onBack,
    required this.onClearCart,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200,
      floating: false,
      pinned: true,
      backgroundColor: AppColors.backgroundDark,
      elevation: 0,
      leading: IconButtonWidget(
        icon: Icons.arrow_back_ios_new,
        onPressed: onBack,
      ),
      actions: [
        if (cartItems.isNotEmpty)
          IconButtonWidget(
            icon: Icons.delete_outline,
            color: AppColors.errorRed,
            onPressed: onClearCart,
          ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.primaryPurple, AppColors.primaryPink, AppColors.primaryYellow],
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.transparent, AppColors.backgroundDark.withOpacity(0.7)],
              ),
            ),
            child: FadeTransition(
              opacity: fadeAnimation,
              child: SlideTransition(
                position: slideAnimation,
                child: _buildAppBarContent(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBarContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              const Hero(
                tag: 'cart_icon',
                child: Icon(Icons.shopping_cart, size: 64, color: AppColors.textWhite),
              ),
              if (cartItems.isNotEmpty)
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: AppColors.errorRed,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      totalItems.toString(),
                      style: const TextStyle(
                        color: AppColors.textWhite,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            "Shopping Cart",
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: AppColors.textWhite,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            cartItems.isEmpty ? "Your cart is empty" : "$totalItems item${totalItems != 1 ? 's' : ''} in cart",
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.textWhite,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}