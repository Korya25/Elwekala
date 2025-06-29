import 'package:elwekala/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class BadgedIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final int? count;
  final Color badgeColor;
  final Color iconColor;

  const BadgedIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.count,
    this.badgeColor = Colors.green,
    this.iconColor = AppColors.textWhite,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          icon: Icon(icon, size: 30, color: iconColor),
          onPressed: onPressed,
        ),
        if (count != null && count! > 0)
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: badgeColor,
                borderRadius: BorderRadius.circular(10),
              ),
              constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
              child: Text(
                '$count',
                style: const TextStyle(color: Colors.white, fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}
