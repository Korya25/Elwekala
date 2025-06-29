
import 'package:elwekala/core/constants/app_strings.dart';
import 'package:elwekala/core/utils/validators.dart';
import 'package:elwekala/features/auth/presentation/widgets/common/custom_auth_text_form_field.dart';
import 'package:flutter/material.dart';

class PasswordField extends StatelessWidget {
  const PasswordField({
    super.key,
    required this.passwordController,
    required this.onTogglePasswordVisibility,
    this.isPasswordVisible = false,
  });
  final TextEditingController passwordController;
  final bool isPasswordVisible;
  final VoidCallback onTogglePasswordVisibility;

  @override
  Widget build(BuildContext context) {
    return CustomAuthTextFormField(
      controller: passwordController,
      label: AppStrings.password,
      prefixIcon: Icons.lock_outline,
      suffixIcon: isPasswordVisible ? Icons.visibility : Icons.visibility_off,
      obscureText: !isPasswordVisible,
      onSuffixIconPressed: onTogglePasswordVisibility,
      validator: AuthValidators.passwordValidator,
    );
  }
}