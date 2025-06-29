import 'package:elwekala/core/constants/app_strings.dart';
import 'package:elwekala/core/extensions/context_extensions.dart';
import 'package:elwekala/features/auth/presentation/widgets/common/auth_header.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(child: LoginViewBody()),
      ),
    );
  }
}

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.screenHeight - context.screenPadding.top,
      child: Column(
        children: [
          // Auth Header
          AuthHeader(
            title: AppStrings.loginTitle,
            subTitle: AppStrings.loginSubTitle,
          ),

          // Login Form

          // Fotter
        ],
      ),
    );
  }
}
