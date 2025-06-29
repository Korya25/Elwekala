import 'package:elwekala/features/profile/presentation/widgets/profile_form.dart';
import 'package:elwekala/features/profile/presentation/widgets/profile_info.dart';
import 'package:flutter/material.dart';

class ProfileContent extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final bool isEditing;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final bool isLoading;
  final VoidCallback onSave;

  const ProfileContent({
    super.key,
    required this.formKey,
    required this.isEditing,
    required this.nameController,
    required this.emailController,
    required this.isLoading,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (isEditing)
            ProfileForm(
              formKey: formKey,
              nameController: nameController,
              emailController: emailController,
              isLoading: isLoading,
              onSave: onSave,
            )
          else
            ProfileInfo(name: nameController.text, email: emailController.text),
        ],
      ),
    );
  }
}
