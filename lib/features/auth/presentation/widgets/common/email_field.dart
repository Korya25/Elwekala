
import 'package:elwekala/core/constants/app_strings.dart';
import 'package:elwekala/core/utils/validators.dart';
import 'package:elwekala/features/auth/presentation/widgets/common/custom_auth_text_form_field.dart';
import 'package:flutter/material.dart';

class EmailField extends StatelessWidget {
  const EmailField({super.key, required this.emailController});
  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return CustomAuthTextFormField(
      controller: emailController,
      label: AppStrings.email,
      prefixIcon: Icons.email_outlined,
      keyboardType: TextInputType.emailAddress,
      validator: AuthValidators.emailValidator,
    );
  }
}
