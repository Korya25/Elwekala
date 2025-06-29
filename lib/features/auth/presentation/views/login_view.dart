import 'package:elwekala/core/constants/app_routes.dart';
import 'package:elwekala/core/constants/app_strings.dart';
import 'package:elwekala/core/widgets/animate_do.dart';
import 'package:elwekala/features/auth/presentation/widgets/common/auth_fotter.dart';
import 'package:elwekala/features/auth/presentation/widgets/common/auth_header.dart';
import 'package:elwekala/features/auth/presentation/widgets/login/login_form.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
    return Column(
      spacing: 10,
      children: [
        // Auth Header
        AuthHeader(
          title: AppStrings.loginTitle,
          subTitle: AppStrings.loginSubTitle,
        ),

        // Login Form
        CustomFadeInLeft(duration: 800, child: LoginForm()),

        // Fotter
        CustomFadeInUp(
          duration: 800,
          child: AuthFotter(
            title: AppStrings.noAccount,
            screenTitle: AppStrings.signUp,
            onTap: () {
              context.pushNamed(AppRoutes.signup);
            },
          ),
        ),
      ],
    );
  }
}
