import 'package:elwekala/core/constants/app_routes.dart';
import 'package:elwekala/features/auth/presentation/views/login_view.dart';
import 'package:elwekala/features/auth/presentation/views/sign_up_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.login,
    routes: [
      GoRoute(
        path: AppRoutes.login,
        name: AppRoutes.login,
        builder: (context, state) => LoginView(),
      ),

      GoRoute(
        path: AppRoutes.signup,
        name: AppRoutes.signup,
        builder: (context, state) => const SignUpView(),
      ),

      GoRoute(
        path: AppRoutes.home,
        name: AppRoutes.home,
        builder: (context, state) => Scaffold(),
        routes: [
          GoRoute(
            path: AppRoutes.profile,
            name: AppRoutes.profile,
            builder: (context, state) => const Scaffold(),
          ),

          GoRoute(
            path: AppRoutes.favorite,
            name: AppRoutes.favorite,
            builder: (context, state) => Scaffold(),
          ),

          GoRoute(
            path: AppRoutes.cart,
            name: AppRoutes.cart,
            builder: (context, state) => Scaffold(),
          ),

          GoRoute(
            path: AppRoutes.homeDetails,
            name: AppRoutes.homeDetails,
            builder: (context, state) => Scaffold(),
          ),
        ],
      ),
    ],
  );
}
