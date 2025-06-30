import 'package:elwekala/core/constants/app_colors.dart';
import 'package:elwekala/features/cart/presentation/widgets/reusable_components.dart';
import 'package:flutter/material.dart';

class CheckoutButton extends StatelessWidget {
  final double totalPrice;
  final Animation<double> animation;
  final bool isProcessing;
  final VoidCallback onPressed;

  const CheckoutButton({
    super.key,
    required this.totalPrice,
    required this.animation,
    required this.isProcessing,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.backgroundDark,
        border: Border(top: BorderSide(color: AppColors.borderColor)),
      ),
      child: ScaleTransition(
        scale: animation,
        child: GradientButton(
          icon: Icons.shopping_bag,
          label: "Checkout - \$${(totalPrice + (totalPrice > 100 ? 0 : 9.99)).toStringAsFixed(2)}",
          gradient: const LinearGradient(colors: [AppColors.primaryPurple, AppColors.primaryPink]),
          isLoading: isProcessing,
          onPressed: onPressed,
        ),
      ),
    );
  }
}