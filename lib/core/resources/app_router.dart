import 'package:elwekala/core/constants/app_routes.dart';
import 'package:elwekala/features/auth/presentation/views/login_view.dart';
import 'package:elwekala/features/auth/presentation/views/sign_up_view.dart';
import 'package:elwekala/features/cart/presentation/views/cart_screen.dart';
import 'package:elwekala/features/home/data/model/lap_top_model.dart';
import 'package:elwekala/features/home/presentation/views/favorite_cart_screen.dart';
import 'package:elwekala/features/home/presentation/views/home_view.dart';
import 'package:elwekala/features/home/presentation/views/laptop_detail_view.dart';
import 'package:elwekala/features/profile/presentation/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.home,
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
        builder: (context, state) => HomeView(),
        routes: [
          GoRoute(
            path: AppRoutes.profile,
            name: AppRoutes.profile,
            builder: (context, state) => const ProfileView(),
          ),

          GoRoute(
            path: AppRoutes.favorite,
            name: AppRoutes.favorite,

            builder: (context, state) => FavoritesScreen(
              favoriteLaptops: favoriteLaptops,
              onRemoveFromFavorites: (laptop) {
                //    setState(() {
                favoriteLaptops.removeWhere((fav) => fav.id == laptop.id);
                // });
              },
              onNavigateToDetails: (laptop) {
                context.pushNamed(AppRoutes.homeDetails, extra: laptop);
              },
            ),
          ),

          GoRoute(
            path: AppRoutes.cart,
            name: AppRoutes.cart,
            builder: (context, state) => CartScreen(
              cartItems: cartItems,
              onRemoveFromCart: (cartItem) {
                // setState(() {
                cartItems.removeWhere(
                  (item) => item.laptop.id == cartItem.laptop.id,
                );
                //  });
              },
              onUpdateQuantity: (cartItem, newQuantity) {
                //   setState(() {
                final index = cartItems.indexWhere(
                  (item) => item.laptop.id == cartItem.laptop.id,
                );
                if (index != -1) {
                  cartItems[index].quantity = newQuantity;
                }
                //  });
              },
              onCheckout: () {
                //   setState(() {
                cartItems.clear();
                //  });
                Navigator.pop(context);
              },
            ),
          ),

          GoRoute(
            path: AppRoutes.homeDetails,
            name: AppRoutes.homeDetails,
            builder: (context, state) {
              final laptop = state.extra as LaptopModel;
              return LaptopDetailView(laptop: laptop);
            },
          ),
        ],
      ),
    ],
  );
}

CustomTransitionPage<T> slideTransitionPage<T>({
  required Widget child,
  required LocalKey key,
}) {
  return CustomTransitionPage<T>(
    key: key,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1.0, 0.0),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      );
    },
  );
}
