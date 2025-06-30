import 'package:elwekala/core/constants/app_colors.dart';
import 'package:elwekala/features/cart/presentation/widgets/reusable_components.dart';
import 'package:elwekala/features/home/data/model/lap_top_model.dart';
import 'package:flutter/material.dart';

class CartItemCard extends StatelessWidget {
  final CartItem cartItem;
  final VoidCallback onRemove;
  final Function(int) onUpdateQuantity;

  const CartItemCard({
    super.key,
    required this.cartItem,
    required this.onRemove,
    required this.onUpdateQuantity,
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
          BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                LaptopImage(imageUrl: cartItem.laptop.image),
                const SizedBox(width: 16),
                Expanded(child: LaptopInfo(laptop: cartItem.laptop)),
                RemoveButton(onPressed: onRemove),
              ],
            ),
            const SizedBox(height: 16),
            QuantityAndPriceRow(
              laptop: cartItem.laptop,
              quantity: cartItem.quantity,
              onUpdateQuantity: onUpdateQuantity,
            ),
          ],
        ),
      ),
    );
  }
}