import 'package:elwekala/core/constants/app_colors.dart';
import 'package:elwekala/features/home/data/model/lap_top_model.dart';
import 'package:flutter/material.dart';

class IconButtonWidget extends StatelessWidget {
  final IconData icon;
  final Color? color;
  final VoidCallback onPressed;

  const IconButtonWidget({
    super.key,
    required this.icon,
    this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.borderColor),
        ),
        child: IconButton(
          onPressed: onPressed,
          icon: Icon(icon, color: color ?? AppColors.textWhite, size: 20),
        ),
      ),
    );
  }
}

class GradientButton extends StatelessWidget {
  final String label;
  final Gradient gradient;
  final IconData? icon;
  final bool isLoading;
  final VoidCallback onPressed;

  const GradientButton({
    super.key,
    required this.label,
    required this.gradient,
    this.icon,
    this.isLoading = false,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryPurple.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        child: isLoading
            ? const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(color: AppColors.textWhite, strokeWidth: 2),
                  ),
                  SizedBox(width: 12),
                  Text(
                    "Processing...",
                    style: TextStyle(color: AppColors.textWhite, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    Icon(icon, color: AppColors.textWhite),
                    const SizedBox(width: 12),
                  ],
                  Text(
                    label,
                    style: const TextStyle(color: AppColors.textWhite, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
      ),
    );
  }
}

class LaptopImage extends StatelessWidget {
  final String imageUrl;

  const LaptopImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          colors: [
            AppColors.primaryPurple.withOpacity(0.1),
            AppColors.primaryPink.withOpacity(0.1),
          ],
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          imageUrl,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.laptop_mac, size: 40, color: Colors.grey);
          },
        ),
      ),
    );
  }
}

class LaptopInfo extends StatelessWidget {
  final LaptopModel laptop;

  const LaptopInfo({super.key, required this.laptop});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          laptop.name,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textWhite),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 8),
        Text(
          laptop.company,
          style: TextStyle(fontSize: 12, color: Colors.grey[400], fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        Text(
          "\$${laptop.price.toStringAsFixed(2)}",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.successGreen),
        ),
      ],
    );
  }
}

class RemoveButton extends StatelessWidget {
  final VoidCallback onPressed;

  const RemoveButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.errorRed.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.errorRed.withOpacity(0.3)),
        ),
        child: const Icon(Icons.delete_outline, color: AppColors.errorRed, size: 20),
      ),
    );
  }
}

class QuantityAndPriceRow extends StatelessWidget {
  final LaptopModel laptop;
  final int quantity;
  final Function(int) onUpdateQuantity;

  const QuantityAndPriceRow({
    super.key,
    required this.laptop,
    required this.quantity,
    required this.onUpdateQuantity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.backgroundDark,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Text("Quantity:", style: TextStyle(color: Colors.white70, fontSize: 14)),
              const SizedBox(width: 12),
              QuantityControls(
                quantity: quantity,
                maxQuantity: laptop.countInStock,
                onDecrease: () => onUpdateQuantity(quantity - 1),
                onIncrease: () => onUpdateQuantity(quantity + 1),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text("Total", style: TextStyle(color: Colors.grey[400], fontSize: 12)),
              Text(
                "\$${(laptop.price * quantity).toStringAsFixed(2)}",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.successGreen,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class QuantityControls extends StatelessWidget {
  final int quantity;
  final int maxQuantity;
  final VoidCallback onDecrease;
  final VoidCallback onIncrease;

  const QuantityControls({
    super.key,
    required this.quantity,
    required this.maxQuantity,
    required this.onDecrease,
    required this.onIncrease,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildControlButton(
            icon: Icons.remove,
            isActive: quantity > 1,
            isLeft: true,
            onPressed: onDecrease,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              quantity.toString(),
              style: const TextStyle(color: AppColors.textWhite, fontWeight: FontWeight.bold),
            ),
          ),
          _buildControlButton(
            icon: Icons.add,
            isActive: quantity < maxQuantity,
            isLeft: false,
            onPressed: onIncrease,
          ),
        ],
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required bool isActive,
    required bool isLeft,
    required VoidCallback onPressed,
  }) {
    final color = isActive
        ? (icon == Icons.add ? AppColors.successGreen : AppColors.primaryPurple)
        : AppColors.textWhite;

    return GestureDetector(
      onTap: isActive ? onPressed : null,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.only(
            topLeft: isLeft ? Radius.zero : const Radius.circular(8),
            bottomLeft: isLeft ? Radius.zero : const Radius.circular(8),
            topRight: isLeft ? const Radius.circular(8) : Radius.zero,
            bottomRight: isLeft ? const Radius.circular(8) : Radius.zero,
          ),
        ),
        child: Icon(icon, size: 16, color: color),
      ),
    );
  }
}