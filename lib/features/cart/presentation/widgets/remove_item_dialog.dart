import 'package:elwekala/core/constants/app_colors.dart';
import 'package:elwekala/features/cart/presentation/widgets/reusable_components.dart';
import 'package:flutter/material.dart';

class RemoveItemDialog extends StatelessWidget {
  final String itemName;
  final VoidCallback onConfirm;

  const RemoveItemDialog({
    super.key,
    required this.itemName,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.cardBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: AppColors.borderColor),
      ),
      title: const Row(
        children: [
          Icon(Icons.remove_shopping_cart, color: AppColors.errorRed),
          SizedBox(width: 12),
          Text('Remove from Cart', style: TextStyle(color: AppColors.textWhite, fontSize: 18)),
        ],
      ),
      content: Text(
        'Are you sure you want to remove "$itemName" from your cart?',
        style: TextStyle(color: Colors.grey[300]),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel', style: TextStyle(color: Colors.grey[400])),
        ),
        GradientButton(
          label: 'Remove',
          gradient: const LinearGradient(colors: [AppColors.errorRed, Color(0xFFDC2626)]),
          onPressed: onConfirm,
        ),
      ],
    );
  }
}

class ClearCartDialog extends StatelessWidget {
  final VoidCallback onConfirm;

  const ClearCartDialog({super.key, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.cardBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: AppColors.borderColor),
      ),
      title: const Row(
        children: [
          Icon(Icons.delete_forever, color: AppColors.errorRed),
          SizedBox(width: 12),
          Text('Clear Cart', style: TextStyle(color: AppColors.textWhite, fontSize: 18)),
        ],
      ),
      content: const Text(
        'Are you sure you want to remove all items from your cart?',
        style: TextStyle(color: Colors.grey),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel', style: TextStyle(color: Colors.grey[400])),
        ),
        GradientButton(
          label: 'Clear All',
          gradient: const LinearGradient(colors: [AppColors.errorRed, Color(0xFFDC2626)]),
          onPressed: onConfirm,
        ),
      ],
    );
  }
}