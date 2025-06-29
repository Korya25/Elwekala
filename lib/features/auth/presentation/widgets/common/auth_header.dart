import 'package:elwekala/core/constants/hero_tags.dart';
import 'package:elwekala/core/resources/app_gradients.dart';
import 'package:elwekala/core/resources/app_text_styles.dart';
import 'package:elwekala/core/widgets/animate_do.dart';
import 'package:flutter/material.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({
    super.key,
    required this.title,
    required this.subTitle,
    this.height,
  });
  final String title;
  final String subTitle;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 200,
      decoration: BoxDecoration(
        gradient: AppGradients.authHeaderLinearGradient(),
      ),
      child: Center(
        child: CustomFadeInDown(
          duration: 800,
          child: Column(
            spacing: 6,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: HeroTags.appLogo,
                child: Icon(Icons.laptop_mac, size: 80, color: Colors.white),
              ),
              SizedBox(height: 6),
              Text(title, style: AppTextStyles.headlineLarge),
              Text(subTitle, style: AppTextStyles.bodyLarge),
            ],
          ),
        ),
      ),
    );
  }
}
