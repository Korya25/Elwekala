import 'package:elwekala/core/constants/app_colors.dart';
import 'package:elwekala/core/constants/app_strings.dart';
import 'package:flutter/material.dart';

class TermsRow extends StatelessWidget {
  const TermsRow({super.key, required this.acceptTerms, this.onChangeCheckBox});
  final bool acceptTerms;
  final void Function(bool?)? onChangeCheckBox;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: acceptTerms,
          onChanged: onChangeCheckBox,
          activeColor: AppColors.primaryPurple,
          checkColor: Colors.white,
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: TextStyle(color: Colors.grey),
              children: [
                TextSpan(text: AppStrings.agreeToThe),
                TextSpan(
                  text: AppStrings.termsOfService,
                  style: TextStyle(color: AppColors.primaryPurple),
                ),
                TextSpan(text: ' ${AppStrings.and} '),
                TextSpan(
                  text: AppStrings.privacyPolicy,
                  style: TextStyle(color: AppColors.primaryPurple),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
