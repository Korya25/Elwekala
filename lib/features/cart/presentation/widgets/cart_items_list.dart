import 'package:elwekala/features/cart/presentation/widgets/cart_item_card.dart';
import 'package:elwekala/features/home/data/model/lap_top_model.dart';
import 'package:flutter/material.dart';

class CartItemsList extends StatelessWidget {
  final List<CartItem> cartItems;
  final Function(CartItem) onRemove;
  final Function(CartItem, int) onUpdateQuantity;

  const CartItemsList({
    super.key,
    required this.cartItems,
    required this.onRemove,
    required this.onUpdateQuantity,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(20),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => AnimatedContainer(
            duration: Duration(milliseconds: 300 + (index * 100)),
            child: CartItemCard(
              cartItem: cartItems[index],
              onRemove: () => onRemove(cartItems[index]),
              onUpdateQuantity: (quantity) => onUpdateQuantity(cartItems[index], quantity),
            ),
          ),
          childCount: cartItems.length,
        ),
      ),
    );
  }
}