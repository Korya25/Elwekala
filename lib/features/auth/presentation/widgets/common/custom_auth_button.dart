import 'package:elwekala/core/resources/app_gradients.dart';
import 'package:flutter/material.dart';

class CustomAuthButton extends StatelessWidget {
  const CustomAuthButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.isLoading = false,
    this.gradient,
    this.textStyle,
    this.height = 56,
    this.borderRadius = 16,
    this.boxShadowColor,
    this.loadingIndicator,
  });

  final VoidCallback? onPressed;
  final String label;
  final bool isLoading;
  final Gradient? gradient;
  final TextStyle? textStyle;
  final double height;
  final double borderRadius;
  final Color? boxShadowColor;
  final Widget? loadingIndicator;

  @override
  Widget build(BuildContext context) {
    final defaultBoxShadowColor = boxShadowColor ?? const Color(0xFF6C63FF);

    final defaultTextStyle =
        textStyle ??
        const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        );

    return Container(
      height: height,
      decoration: BoxDecoration(
        gradient: AppGradients.authHeaderLinearGradient(),
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: defaultBoxShadowColor.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextButton(
        onPressed: isLoading ? null : onPressed,
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: EdgeInsets.zero,
        ),
        child: isLoading
            ? Center(
                child:
                    loadingIndicator ??
                    const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      ),
                    ),
              )
            : Center(child: Text(label, style: defaultTextStyle)),
      ),
    );
  }
}
