import 'package:elwekala/core/constants/app_colors.dart';
import 'package:elwekala/core/constants/app_routes.dart';
import 'package:elwekala/core/constants/app_strings.dart';
import 'package:elwekala/core/widgets/custom_header_app.dart';
import 'package:elwekala/features/home/data/model/lap_top_model.dart';
import 'package:elwekala/features/home/presentation/widgets/home/badged_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeHeaderWidget extends StatelessWidget {
  const HomeHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200,
      backgroundColor: AppColors.primaryPurple,
      flexibleSpace: FlexibleSpaceBar(
        background: CustomHeaderApp(
          title: AppStrings.appName,
          subTitle: AppStrings.appTagline,
        ),
      ),
      actions: [
        BadgedIconButton(
          icon: Icons.favorite,
          onPressed: () {
            context.pushNamed(AppRoutes.favorite);
          },
          count: favoriteLaptops.length,
        ),
        BadgedIconButton(
          icon: Icons.shopping_cart,
          onPressed: () {
            context.pushNamed(AppRoutes.cart);
          },
          count: cartItems.fold(0, (sum, item) => sum! + item.quantity),
        ),
        const SizedBox(width: 8),
      ],
      pinned: true,
    );
  }
}
