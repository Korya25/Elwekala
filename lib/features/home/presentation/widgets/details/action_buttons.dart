import 'package:elwekala/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class ActionButtons extends StatelessWidget {
  final bool isAddingToCart;
  final bool isPurchasing;
  final VoidCallback onAddToCart;
  final VoidCallback onBuyNow;
  final bool isInStock;
  final Animation<double> buttonAnimation;

  const ActionButtons({
    super.key,
    required this.isAddingToCart,
    required this.isPurchasing,
    required this.onAddToCart,
    required this.onBuyNow,
    required this.isInStock,
    required this.buttonAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: buttonAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: buttonAnimation.value,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 56,
                    decoration: BoxDecoration(
                      color: AppColors.cardBackground,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.primaryPurple, width: 2),
                    ),
                    child: TextButton.icon(
                      onPressed: isInStock ? onAddToCart : null,
                      icon: isAddingToCart
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation(
                                  AppColors.primaryPurple,
                                ),
                              ),
                            )
                          : const Icon(
                              Icons.shopping_cart_outlined,
                              color: AppColors.primaryPurple,
                            ),
                      label: Text(
                        isAddingToCart ? 'Adding...' : 'Add to Cart',
                        style: const TextStyle(
                          color: AppColors.primaryPurple,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Container(
                    height: 56,
                    decoration: BoxDecoration(
                      gradient: isInStock
                          ? const LinearGradient(
                              colors: [AppColors.primaryPurple, AppColors.primaryPink],
                            )
                          : null,
                      color: isInStock ? null : Colors.grey[700],
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: isInStock
                          ? [
                              BoxShadow(
                                color: AppColors.primaryPurple.withOpacity(0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ]
                          : null,
                    ),
                    child: TextButton.icon(
                      onPressed: isInStock ? onBuyNow : null,
                      icon: isPurchasing
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation(
                                  AppColors.textWhite,
                                ),
                              ),
                            )
                          : const Icon(Icons.flash_on, color: AppColors.textWhite),
                      label: Text(
                        isPurchasing ? 'Processing...' : 'Buy Now',
                        style: const TextStyle(
                          color: AppColors.textWhite,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}