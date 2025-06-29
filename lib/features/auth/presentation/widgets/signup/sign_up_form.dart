import 'package:elwekala/core/constants/app_colors.dart';
import 'package:elwekala/core/constants/app_strings.dart';
import 'package:elwekala/features/auth/presentation/widgets/common/custom_auth_button.dart';
import 'package:elwekala/features/auth/presentation/widgets/common/email_field.dart';
import 'package:elwekala/features/auth/presentation/widgets/common/password_field.dart';
import 'package:elwekala/features/auth/presentation/widgets/signup/full_name_field.dart';
import 'package:elwekala/features/auth/presentation/widgets/signup/terms_row.dart';
import 'package:flutter/material.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _fullNameController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isLoading = false;
  bool _acceptTerms = false;

  Future<void> _handleSignUp() async {
    if (!_formKey.currentState!.validate()) return;
    if (!_acceptTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please accept the terms and conditions'),
          backgroundColor: AppColors.errorRed,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    await Future.delayed(const Duration(seconds: 2));

    setState(() => _isLoading = false);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                FullNameField(fullNameController: _fullNameController),
                SizedBox(height: 20),
                EmailField(emailController: _emailController),
                const SizedBox(height: 20),
                PasswordField(
                  passwordController: _passwordController,
                  isPasswordVisible: _isPasswordVisible,
                  onTogglePasswordVisibility: () {
                    setState(() => _isPasswordVisible = !_isPasswordVisible);
                  },
                ),
                const SizedBox(height: 16),

                TermsRow(
                  acceptTerms: _acceptTerms,
                  onChangeCheckBox: (value) =>
                      setState(() => _acceptTerms = value ?? false),
                ),
                const SizedBox(height: 32),
                CustomAuthButton(
                  isLoading: _isLoading,
                  onPressed: _handleSignUp,
                  label: AppStrings.signUp,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
