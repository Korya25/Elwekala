import 'package:elwekala/features/home/data/model/lap_top_model.dart';
import 'package:elwekala/features/home/presentation/widgets/home/laptop_card.dart';
import 'package:flutter/material.dart';

class LaptopListWidget extends StatelessWidget {
  const LaptopListWidget({super.key, required this.laptops});
  final List<LaptopModel> laptops;
  @override
  Widget build(BuildContext context) {
    if (laptops.isEmpty) {
      return SliverToBoxAdapter(
        child: SizedBox(
          height: 300,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.search_off, size: 64, color: Colors.grey[600]),
                const SizedBox(height: 16),
                Text(
                  "No laptops found",
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Try adjusting your search or filters",
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.all(20),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          return AnimatedContainer(
            duration: Duration(milliseconds: 200 + (index * 50)),
            child: LaptopCard(laptop: laptops[index]),
          );
        }, childCount: laptops.length),
      ),
    );
  }
}
