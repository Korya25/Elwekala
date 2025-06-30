import 'package:elwekala/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class OrderSummarySection extends StatelessWidget {
  final int totalItems;
  final double totalPrice;

  const OrderSummarySection({
    super.key,
    required this.totalItems,
    required this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.borderColor),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 4)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Order Summary",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textWhite),
            ),
            const SizedBox(height: 16),
            _buildSummaryRow("Items ($totalItems)", "\$${totalPrice.toStringAsFixed(2)}"),
            const SizedBox(height: 12),
            _buildShippingRow(),
            const SizedBox(height: 16),
            Container(height: 1, color: AppColors.borderColor),
            const SizedBox(height: 16),
            _buildTotalRow(),
            if (totalPrice <= 100) _buildFreeShippingNotice(),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(color: Colors.grey[400], fontSize: 16)),
        Text(value, style: const TextStyle(color: AppColors.textWhite, fontSize: 16, fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _buildShippingRow() {
    final isFreeShipping = totalPrice > 100;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Shipping", style: TextStyle(color: Colors.grey, fontSize: 16)),
        Text(
          isFreeShipping ? "FREE" : "\$9.99",
          style: TextStyle(
            color: isFreeShipping ? AppColors.successGreen : AppColors.textWhite,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildTotalRow() {
    final shippingCost = totalPrice > 100 ? 0 : 9.99;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Total", style: TextStyle(color: AppColors.textWhite, fontSize: 20, fontWeight: FontWeight.bold)),
        Text(
          "\$${(totalPrice + shippingCost).toStringAsFixed(2)}",
          style: const TextStyle(color: AppColors.successGreen, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildFreeShippingNotice() {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.primaryYellow.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primaryYellow.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.local_shipping, color: AppColors.primaryYellow, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              "Add \$${(100 - totalPrice).toStringAsFixed(2)} more for FREE shipping!",
              style: TextStyle(
                color: AppColors.primaryYellow,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}