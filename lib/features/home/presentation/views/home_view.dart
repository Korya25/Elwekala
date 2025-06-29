import 'package:elwekala/features/home/data/model/lap_top_model.dart';
import 'package:elwekala/features/home/presentation/widgets/home/category_filter.dart';
import 'package:elwekala/features/home/presentation/widgets/home/cuatom_search_bar.dart';
import 'package:elwekala/features/home/presentation/widgets/home/home_header_widget.dart';
import 'package:elwekala/features/home/presentation/widgets/home/laptop_list_widget.dart';
import 'package:elwekala/features/home/presentation/widgets/home/resualt_eader.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(top: false, child: HomeViewBody()));
  }
}

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // Header
        HomeHeaderWidget(),

        // Search Bar
        CuatomSearchBar(),

        // Filter
        CategoryFilter(),

        // Resualt Header
        ResualtEader(),

        // List of products
        LaptopListWidget(laptops: laptopsData),
      ],
    );
  }
}
