import 'package:elwekala/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class ResualtEader extends StatefulWidget {
  const ResualtEader({super.key});
  @override
  State<ResualtEader> createState() => _ResualtEaderState();
}

class _ResualtEaderState extends State<ResualtEader> {
    String selectedCategory = "All";
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          children: [
            Text(
              "Found $count laptop${count != 1 ? 's' : ''}",
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            if (searchQuery.isNotEmpty || selectedCategory != "All")
              TextButton.icon(
                onPressed: () {
                  setState(() {
                    selectedCategory = "All";
                    searchQuery = "";
                    _searchController.clear();
                  });
                },
                icon: const Icon(
                  Icons.clear_all,
                  size: 16,
                  color: AppColors.primaryPurple,
                ),
                label: const Text(
                  "Clear filters",
                  style: TextStyle(color: AppColors.primaryPurple, fontSize: 12),
                ),
              ),
          ],
        ),
      ),
    );
  }
}