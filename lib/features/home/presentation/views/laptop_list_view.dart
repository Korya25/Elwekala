import 'package:elwekala/core/constants/app_colors.dart';
import 'package:elwekala/features/home/data/model/lap_top_model.dart';
import 'package:elwekala/features/home/presentation/views/favorite_cart_screen.dart';
import 'package:flutter/material.dart';



class LaptopListView extends StatefulWidget {
  final List<LaptopModel> laptops;

  const LaptopListView({super.key, required this.laptops});

  @override
  State<LaptopListView> createState() => _LaptopListViewState();
}

class _LaptopListViewState extends State<LaptopListView>
    with TickerProviderStateMixin {

  String selectedCategory = "All";
  String searchQuery = "";
  late TextEditingController _searchController;
  late AnimationController _filterAnimationController;
  late Animation<double> _filterAnimation;

  final List<String> categories = ["All", "New", "Used", "Gaming", "Business"];


  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _filterAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _filterAnimation = CurvedAnimation(
      parent: _filterAnimationController,
      curve: Curves.easeInOut,
    );
    _filterAnimationController.forward();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _filterAnimationController.dispose();
    super.dispose();
  }

  // فلترة اللابتوبات حسب الفئة والبحث
  List<LaptopModel> get _filteredLaptops {
    List<LaptopModel> filtered = widget.laptops;

    // فلترة حسب الفئة
    if (selectedCategory != "All") {
      filtered = filtered.where((laptop) {
        switch (selectedCategory) {
          case "New":
            return laptop.status.toLowerCase() == "new";
          case "Used":
            return laptop.status.toLowerCase() == "used";
          case "Gaming":
            return laptop.name.toLowerCase().contains("gaming") ||
                laptop.description.toLowerCase().contains("gaming");
          case "Business":
            return laptop.name.toLowerCase().contains("business") ||
                laptop.description.toLowerCase().contains("business");
          default:
            return true;
        }
      }).toList();
    }

    // فلترة حسب البحث
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((laptop) {
        final query = searchQuery.toLowerCase();
        return laptop.name.toLowerCase().contains(query) ||
            laptop.company.toLowerCase().contains(query) ||
            laptop.description.toLowerCase().contains(query);
      }).toList();
    }

    return filtered;
  }

  void _onCategoryChanged(String category) {
    if (selectedCategory != category) {
      setState(() {
        selectedCategory = category;
      });
      _filterAnimationController.reset();
      _filterAnimationController.forward();
    }
  }

  void _onSearchChanged(String query) {
    setState(() {
      searchQuery = query;
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredLaptops = _filteredLaptops;

    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBar(
        title: Text('Laptop Store'),
        backgroundColor: Color(0xFF1A1A1A),
        actions: [
          // زر المفضلة
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.favorite),
                onPressed: () => _navigateToFavorites(),
              ),
              if (favoriteLaptops.isNotEmpty)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: BoxConstraints(minWidth: 16, minHeight: 16),
                    child: Text(
                      '${favoriteLaptops.length}',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
          // زر السلة
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () => _navigateToCart(),
              ),
              if (cartItems.isNotEmpty)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: BoxConstraints(minWidth: 16, minHeight: 16),
                    child: Text(
                      '${_getTotalCartItems()}',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          _buildAppBar(),
          _buildSearchBar(),
          _buildCategoryFilter(),
          _buildResultsHeader(filteredLaptops.length),
          _buildLaptopsList(filteredLaptops),
        ],
      ),
    );
  }

  // دالة إضافة/إزالة من المفضلة


  // دالة حساب إجمالي عناصر السلة
  int _getTotalCartItems() {
    return cartItems.fold(0, (sum, item) => sum + item.quantity);
  }

  // دالة للتنقل إلى شاشة المفضلة
  void _navigateToFavorites() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FavoritesScreen(
          favoriteLaptops: favoriteLaptops,
          onRemoveFromFavorites: (laptop) {
            setState(() {
              favoriteLaptops.removeWhere((fav) => fav.id == laptop.id);
            });
          },
          onNavigateToDetails: (laptop) {
            // يمكنك هنا إضافة التنقل إلى صفحة التفاصيل
            print('Navigate to details for: ${laptop.name}');
          },
        ),
      ),
    );
  }

  // دالة للتنقل إلى شاشة السلة
  void _navigateToCart() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartScreen(
          cartItems: cartItems,
          onRemoveFromCart: (cartItem) {
            setState(() {
              cartItems.removeWhere(
                (item) => item.laptop.id == cartItem.laptop.id,
              );
            });
          },
          onUpdateQuantity: (cartItem, newQuantity) {
            setState(() {
              final index = cartItems.indexWhere(
                (item) => item.laptop.id == cartItem.laptop.id,
              );
              if (index != -1) {
                cartItems[index].quantity = newQuantity;
              }
            });
          },
          onCheckout: () {
            // تنفيذ عملية الدفع
            setState(() {
              cartItems.clear();
            });
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 220,
      floating: false,
      pinned: true,
      backgroundColor: AppColors.backgroundDark,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.primaryPurple, AppColors.primaryPink, AppColors.primaryYellow],
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, AppColors.backgroundDark.withOpacity(0.3)],
              ),
            ),
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: 'app_logo',
                    child: Icon(
                      Icons.laptop_mac,
                      size: 64,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "TechHub Store",
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Premium Laptops Collection",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: AppColors.primaryPurple, width: 1),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryPurple.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: TextField(
            controller: _searchController,
            onChanged: _onSearchChanged,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: "Search for laptops, brands, specs...",
              hintStyle: TextStyle(color: Colors.grey[400]),
              prefixIcon: const Icon(Icons.search, color: AppColors.primaryPurple),
              suffixIcon: searchQuery.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear, color: Colors.grey),
                      onPressed: () {
                        _searchController.clear();
                        _onSearchChanged("");
                      },
                    )
                  : null,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 15,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 70,
        child: FadeTransition(
          opacity: _filterAnimation,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            physics: const BouncingScrollPhysics(),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              final isSelected = selectedCategory == category;

              return AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.only(right: 12),
                child: GestureDetector(
                  onTap: () => _onCategoryChanged(category),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      gradient: isSelected
                          ? const LinearGradient(
                              colors: [AppColors.primaryPurple, AppColors.primaryPink],
                            )
                          : null,
                      color: isSelected ? null : AppColors.cardBackground,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: isSelected ? Colors.transparent : AppColors.borderColor,
                        width: 1.5,
                      ),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: AppColors.primaryPurple.withOpacity(0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ]
                          : null,
                    ),
                    child: Center(
                      child: Text(
                        category,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.grey[300],
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildResultsHeader(int count) {
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

  Widget _buildLaptopsList(List<LaptopModel> laptops) {
    if (laptops.isEmpty) {
      return SliverToBoxAdapter(
        child: Container(
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
            child: _buildLaptopCard(laptops[index]),
          );
        }, childCount: laptops.length),
      ),
    );
  }

  Widget _buildLaptopCard(LaptopModel laptop) {
    return Hero(
      tag: 'laptop_${laptop.name}',
      child: GestureDetector(
        onTap: () => _navigateToDetails(laptop),
        child: Container(
          margin: const EdgeInsets.only(bottom: 24),
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppColors.borderColor, width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImageSection(laptop),
              _buildContentSection(laptop),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToDetails(LaptopModel laptop) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            LaptopDetailView(laptop: laptop),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOutCubic;

          var tween = Tween(
            begin: begin,
            end: end,
          ).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 400),
      ),
    );
  }

  Widget _buildImageSection(LaptopModel laptop) {
    return Container(
      height: 220,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primaryPurple.withOpacity(0.1),
            AppColors.primaryPink.withOpacity(0.1),
          ],
        ),
      ),
      child: Stack(
        children: [
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                laptop.image,
                height: 160,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 160,
                    width: 160,
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.laptop_mac,
                      size: 64,
                      color: Colors.grey,
                    ),
                  );
                },
              ),
            ),
          ),
          Positioned(
            top: 16,
            right: 16,
            child: _buildStatusBadge(laptop.status),
          ),
          Positioned(
            top: 16,
            left: 16,
            child: _buildCompanyBadge(laptop.company),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    final isNew = status.toLowerCase() == "new";
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isNew
              ? [AppColors.successGreen, const Color(0xFF059669)]
              : [AppColors.primaryYellow, const Color(0xFFD97706)],
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: (isNew ? AppColors.successGreen : AppColors.primaryYellow).withOpacity(0.3),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        status,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildCompanyBadge(String company) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.7),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        company,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildContentSection(LaptopModel laptop) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  laptop.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              _buildRating(laptop.sales),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            laptop.description,
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 14,
              height: 1.5,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(child: _buildPriceSection(laptop)),
              _buildActionButton(),
            ],
          ),
          const SizedBox(height: 16),
          _buildStockStatus(laptop),
        ],
      ),
    );
  }

  Widget _buildRating(int sales) {
    final rating = 4.0 + (sales % 10) / 10;
    return Row(
      children: [
        const Icon(Icons.star, color: AppColors.primaryYellow, size: 16),
        const SizedBox(width: 4),
        Text(
          rating.toStringAsFixed(1),
          style: TextStyle(
            color: Colors.grey[400],
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildPriceSection(LaptopModel laptop) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Price",
          style: TextStyle(
            color: Colors.grey[500],
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          "\$${laptop.price.toStringAsFixed(2)}",
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppColors.successGreen,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton() {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [AppColors.primaryPurple, AppColors.primaryPink]),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryPurple.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Icon(Icons.arrow_forward_ios, color: Colors.white, size: 20),
      ),
    );
  }

  Widget _buildStockStatus(LaptopModel laptop) {
    final inStock = laptop.countInStock > 0;
    return Row(
      children: [
        Icon(
          inStock ? Icons.check_circle : Icons.cancel,
          color: inStock ? AppColors.successGreen : AppColors.errorRed,
          size: 16,
        ),
        const SizedBox(width: 8),
        Text(
          inStock ? "In Stock (${laptop.countInStock})" : "Out of Stock",
          style: TextStyle(
            color: inStock ? AppColors.successGreen : AppColors.errorRed,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
