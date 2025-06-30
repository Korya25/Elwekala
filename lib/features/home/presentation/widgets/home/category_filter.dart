import 'package:elwekala/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CategoryFilter extends StatelessWidget {
  final String selectedCategory;
  final ValueChanged<String> onCategoryChanged;

  const CategoryFilter({
    super.key,
    required this.selectedCategory,
    required this.onCategoryChanged,
  });

  final List<String> categories = const ["All", "New", "Used", "Gaming", "Business"];

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 70,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            final isSelected = selectedCategory == category;

            return GestureDetector(
              onTap: () => onCategoryChanged(category),
              child: Container(
                margin: const EdgeInsets.only(right: 12),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                  gradient: isSelected
                      ? const LinearGradient(colors: [AppColors.primaryPurple, AppColors.primaryPink])
                      : null,
                  color: isSelected ? null : AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: isSelected ? Colors.transparent : AppColors.borderColor,
                    width: 1.5,
                  ),
                ),
                child: Center(
                  child: Text(
                    category,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.grey[300],
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
