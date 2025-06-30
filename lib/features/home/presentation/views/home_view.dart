import 'package:flutter/material.dart';
import 'package:elwekala/features/home/data/model/lap_top_model.dart';
import 'package:elwekala/features/home/presentation/widgets/home/category_filter.dart';
import 'package:elwekala/features/home/presentation/widgets/home/cuatom_search_bar.dart';
import 'package:elwekala/features/home/presentation/widgets/home/home_header_widget.dart';
import 'package:elwekala/features/home/presentation/widgets/home/laptop_list_widget.dart';
import 'package:elwekala/features/home/presentation/widgets/home/resualt_eader.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SafeArea(top: false, child: HomeViewBody()));
  }
}

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  final TextEditingController _searchController = TextEditingController();

  String searchQuery = "";
  String selectedCategory = "All";

  final List<LaptopModel> allLaptops = laptopsData;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    setState(() => searchQuery = query);
  }

  void _onCategoryChanged(String category) {
    setState(() => selectedCategory = category);
  }

  void _clearFilters() {
    setState(() {
      searchQuery = "";
      selectedCategory = "All";
      _searchController.clear();
    });
  }

  List<LaptopModel> get _filteredLaptops {
    List<LaptopModel> filtered = allLaptops;

    if (selectedCategory != "All") {
      filtered = filtered.where((laptop) {
        final name = laptop.name.toLowerCase();
        final desc = laptop.description.toLowerCase();
        final status = laptop.status.toLowerCase();

        switch (selectedCategory) {
          case "New":
            return status == "new";
          case "Used":
            return status == "used";
          case "Gaming":
            return name.contains("gaming") || desc.contains("gaming");
          case "Business":
            return name.contains("business") || desc.contains("business");
          default:
            return true;
        }
      }).toList();
    }

    if (searchQuery.isNotEmpty) {
      final query = searchQuery.toLowerCase();
      filtered = filtered.where((laptop) {
        return laptop.name.toLowerCase().contains(query) ||
            laptop.company.toLowerCase().contains(query) ||
            laptop.description.toLowerCase().contains(query);
      }).toList();
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const HomeHeaderWidget(),
        CuatomSearchBar(
          controller: _searchController,
          onChanged: _onSearchChanged,
        ),
        CategoryFilter(
          selectedCategory: selectedCategory,
          onCategoryChanged: _onCategoryChanged,
        ),
        ResualtEader(
          count: _filteredLaptops.length,
          searchQuery: searchQuery,
          selectedCategory: selectedCategory,
          onClearFilters: _clearFilters,
          searchController: _searchController,
        ),
        LaptopListWidget(laptops: _filteredLaptops),
      ],
    );
  }
}
