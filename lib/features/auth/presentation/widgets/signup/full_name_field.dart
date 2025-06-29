import 'package:elwekala/core/constants/app_strings.dart';
import 'package:elwekala/core/utils/validators.dart';
import 'package:elwekala/features/auth/presentation/widgets/common/custom_auth_text_form_field.dart';
import 'package:flutter/material.dart';

class FullNameField extends StatelessWidget {
  const FullNameField({
    super.key,
    required this.fullNameController,
  });
  final TextEditingController fullNameController;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: fullNameController,
      label: AppStrings.fullName,
      prefixIcon: Icons.person,
      validator: AuthValidators.fullNameValidator,
    );
  }
}
