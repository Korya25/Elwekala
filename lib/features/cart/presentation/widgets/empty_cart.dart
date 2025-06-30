import 'package:elwekala/core/constants/app_colors.dart';
import 'package:elwekala/features/cart/presentation/widgets/reusable_components.dart';
import 'package:flutter/material.dart';

class EmptyCart extends StatelessWidget {
  final Animation<double> animation;

  const EmptyCart({super.key, required this.animation});

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: FadeTransition(
        opacity: animation,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.borderColor, width: 2),
                ),
                child: const Icon(Icons.shopping_cart_outlined, size: 64, color: Colors.grey),
              ),
              const SizedBox(height: 24),
              const Text(
                "Your Cart is Empty",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.textWhite),
              ),
              const SizedBox(height: 12),
              Text(
                "Add some laptops to your cart\nto see them here",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey[400], height: 1.5),
              ),
              const SizedBox(height: 32),
              GradientButton(
                icon: Icons.shopping_bag,
                label: "Start Shopping",
                gradient: const LinearGradient(colors: [AppColors.primaryPurple, AppColors.primaryPink]),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}