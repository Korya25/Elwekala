import 'package:elwekala/core/constants/app_strings.dart';
import 'package:elwekala/core/widgets/animate_do.dart';
import 'package:elwekala/features/auth/presentation/widgets/common/auth_fotter.dart';
import 'package:elwekala/features/auth/presentation/widgets/common/auth_header.dart';
import 'package:elwekala/features/auth/presentation/widgets/signup/sign_up_form.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(child: SignUpViewBody()),
      ),
    );
  }
}

class SignUpViewBody extends StatelessWidget {
  const SignUpViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        // Auth Header
        AuthHeader(
          title: AppStrings.signUpTitle,
          subTitle: AppStrings.signUpSubTitle,
        ),

        // Login Form
        CustomFadeInLeft(duration: 800, child: SignUpForm()),

        // Fotter
        CustomFadeInUp(
          duration: 800,
          child: AuthFotter(
            title: AppStrings.haveAccount,
            screenTitle: AppStrings.singIn,
            onTap: () {
              context.pop();
            },
          ),
        ),
      ],
    );
  }
}
