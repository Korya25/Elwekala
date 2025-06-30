import 'package:elwekala/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
class ResualtEader extends StatelessWidget {
  final int count;
  final String searchQuery;
  final String selectedCategory;
  final VoidCallback onClearFilters;
  final TextEditingController searchController;

  const ResualtEader({
    super.key,
    required this.count,
    required this.searchQuery,
    required this.selectedCategory,
    required this.onClearFilters,
    required this.searchController,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          children: [
            Text(
              "Found $count laptop${count != 1 ? 's' : ''}",
              style: TextStyle(color: Colors.grey[400], fontSize: 14),
            ),
            const Spacer(),
            if (searchQuery.isNotEmpty || selectedCategory != "All")
              TextButton.icon(
                onPressed: onClearFilters,
                icon: const Icon(Icons.clear_all, size: 16, color: AppColors.primaryPurple),
                label: const Text("Clear filters", style: TextStyle(color: AppColors.primaryPurple, fontSize: 12)),
              ),
          ],
        ),
      ),
    );
  }
}
