import 'package:elwekala/core/resources/app_gradients.dart';
import 'package:elwekala/core/widgets/animate_do.dart';
import 'package:flutter/material.dart';

class CustomHeaderApp extends StatelessWidget {
  final String title;
  final String subTitle;
  final double? height;
  final Widget? icon;
  final Gradient? gradient;
  final Gradient? overlayGradient;
  final TextStyle? titleStyle;
  final TextStyle? subTitleStyle;
  final int animationDuration;
  final bool enableAnimation;
  final EdgeInsetsGeometry? padding;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  const CustomHeaderApp({
    super.key,
    required this.title,
    required this.subTitle,
    this.height,
    this.icon,
    this.gradient,
    this.overlayGradient,
    this.titleStyle,
    this.subTitleStyle,
    this.animationDuration = 800,
    this.enableAnimation = true,
    this.padding,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  });

  @override
  Widget build(BuildContext context) {
    final Widget content = Column(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      children: [
        icon ?? const Icon(Icons.laptop_mac, size: 80, color: Colors.white),
        const SizedBox(height: 16),
        Text(
          title,
          style:
              titleStyle ??
              Theme.of(
                context,
              ).textTheme.headlineLarge?.copyWith(color: Colors.white),
        ),
        const SizedBox(height: 8),
        Text(
          subTitle,
          style:
              subTitleStyle ??
              Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: Colors.white),
        ),
      ],
    );

    return Container(
      height: height ?? 200,
      decoration: BoxDecoration(
        gradient: gradient ?? AppGradients.headerLinearGradient(),
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient:
                  overlayGradient ??
                  AppGradients.defaultOverlayGradient(context),
            ),
          ),
          Padding(
            padding: padding ?? EdgeInsets.zero,
            child: Center(
              child: enableAnimation
                  ? CustomFadeInUp(duration: animationDuration, child: content)
                  : content,
            ),
          ),
        ],
      ),
    );
  }
}
