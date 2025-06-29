import 'package:elwekala/core/constants/app_routes.dart';
import 'package:elwekala/core/constants/app_strings.dart';
import 'package:elwekala/features/auth/presentation/widgets/common/custom_auth_button.dart';
import 'package:elwekala/features/auth/presentation/widgets/common/email_field.dart';
import 'package:elwekala/features/auth/presentation/widgets/common/password_field.dart';
import 'package:elwekala/features/auth/presentation/widgets/login/forgot_password_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isLoading = false;

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    await Future.delayed(const Duration(seconds: 2));

    setState(() => _isLoading = false);

    // Navigate
    context.goNamed(AppRoutes.profile);
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
                EmailField(emailController: _emailController),
                const SizedBox(height: 20),
                PasswordField(
                  passwordController: _passwordController,
                  isPasswordVisible: _isPasswordVisible,
                  onTogglePasswordVisibility: () {
                    setState(() => _isPasswordVisible = !_isPasswordVisible);
                  },
                ),
                const SizedBox(height: 0),

                ForgotPasswordButton(),
                const SizedBox(height: 14),
                CustomAuthButton(
                  isLoading: _isLoading,
                  onPressed: _handleLogin,
                  label: AppStrings.singIn,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
