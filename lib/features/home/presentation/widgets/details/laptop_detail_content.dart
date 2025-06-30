import 'package:elwekala/core/constants/app_colors.dart';
import 'package:elwekala/features/home/data/model/lap_top_model.dart';
import 'package:elwekala/features/home/presentation/widgets/details/action_buttons.dart';
import 'package:elwekala/features/home/presentation/widgets/details/product_header.dart';
import 'package:elwekala/features/home/presentation/widgets/details/quantity_selector.dart';
import 'package:elwekala/features/home/presentation/widgets/details/stock_status.dart';
import 'package:flutter/material.dart';

class LaptopDetailContent extends StatelessWidget {
  final LaptopModel laptop;
  final int quantity;
  final ValueChanged<int> onQuantityChanged;
  final bool isAddingToCart;
  final bool isPurchasing;
  final VoidCallback onAddToCart;
  final VoidCallback onBuyNow;
  final Animation<double> buttonAnimation;
  final bool showFullDescription;
  final VoidCallback onToggleDescription;

  const LaptopDetailContent({
    super.key,
    required this.laptop,
    required this.quantity,
    required this.onQuantityChanged,
    required this.isAddingToCart,
    required this.isPurchasing,
    required this.onAddToCart,
    required this.onBuyNow,
    required this.buttonAnimation,
    required this.showFullDescription,
    required this.onToggleDescription,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.backgroundDark,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductHeader(laptop: laptop),
            StockStatus(laptop: laptop),
            const SizedBox(height: 24),

            QuantitySelector(
              quantity: quantity,
              maxQuantity: laptop.countInStock,
              onChanged: onQuantityChanged,
            ),
            ActionButtons(
              isAddingToCart: isAddingToCart,
              isPurchasing: isPurchasing,
              onAddToCart: onAddToCart,
              onBuyNow: onBuyNow,
              isInStock: laptop.countInStock > 0,
              buttonAnimation: buttonAnimation,
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
