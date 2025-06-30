import 'package:elwekala/core/constants/app_colors.dart';
import 'package:elwekala/features/home/data/model/lap_top_model.dart';
import 'package:elwekala/features/home/presentation/widgets/details/laptop_detail_app_bar.dart';
import 'package:elwekala/features/home/presentation/widgets/details/laptop_detail_content.dart';
import 'package:flutter/material.dart';

class LaptopDetailView extends StatefulWidget {
  final LaptopModel laptop;

  const LaptopDetailView({super.key, required this.laptop});

  @override
  State<LaptopDetailView> createState() => _LaptopDetailViewState();
}

class _LaptopDetailViewState extends State<LaptopDetailView>
    with TickerProviderStateMixin {
  bool isFavorite = false;
  int quantity = 1;
  int currentImageIndex = 0;
  bool isAddingToCart = false;
  bool isPurchasing = false;
  bool showFullDescription = false;

  late AnimationController _favoriteAnimationController;
  late AnimationController _buttonAnimationController;
  late Animation<double> _favoriteAnimation;
  late Animation<double> _buttonAnimation;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    _favoriteAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _buttonAnimationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _favoriteAnimation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(
        parent: _favoriteAnimationController,
        curve: Curves.elasticOut,
      ),
    );

    _buttonAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(
        parent: _buttonAnimationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _favoriteAnimationController.dispose();
    _buttonAnimationController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
    _favoriteAnimationController.forward().then((_) {
      _favoriteAnimationController.reverse();
    });
  }

  Future<void> _addToCart() async {
    if (widget.laptop.countInStock <= 0) return;

    setState(() {
      isAddingToCart = true;
    });

    _buttonAnimationController.forward();
    await Future.delayed(const Duration(seconds: 2));
    _buttonAnimationController.reverse();

    setState(() {
      isAddingToCart = false;
    });

    _showSuccessSnackBar('Added to cart successfully!');
  }

  Future<void> _buyNow() async {
    if (widget.laptop.countInStock <= 0) return;

    setState(() {
      isPurchasing = true;
    });

    _buttonAnimationController.forward();
    await Future.delayed(const Duration(seconds: 2));
    _buttonAnimationController.reverse();

    setState(() {
      isPurchasing = false;
    });

    _showPurchaseDialog();
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: AppColors.textWhite),
            const SizedBox(width: 12),
            Text(message),
          ],
        ),
        backgroundColor: AppColors.successGreen,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showPurchaseDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.cardBackground,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Row(
          children: [
            Icon(Icons.check_circle, color: AppColors.successGreen, size: 28),
            SizedBox(width: 12),
            Text('Purchase Successful!', style: TextStyle(color: AppColors.textWhite)),
          ],
        ),
        content: Text(
          'Your order for ${widget.laptop.name} has been placed successfully.',
          style: const TextStyle(color: AppColors.textGrey),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK', style: TextStyle(color: AppColors.primaryPurple)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final images = widget.laptop.images ?? [widget.laptop.image];
    
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          LaptopDetailAppBar(
            images: images,
            pageController: _pageController,
            currentImageIndex: currentImageIndex,
            onPageChanged: (index) => setState(() => currentImageIndex = index),
            onBackPressed: () => Navigator.pop(context),
            isFavorite: isFavorite,
            onFavoritePressed: _toggleFavorite,
            favoriteAnimation: _favoriteAnimation,
          ),
          LaptopDetailContent(
            laptop: widget.laptop,
            quantity: quantity,
            onQuantityChanged: (newQuantity) => setState(() => quantity = newQuantity),
            isAddingToCart: isAddingToCart,
            isPurchasing: isPurchasing,
            onAddToCart: _addToCart,
            onBuyNow: _buyNow,
            buttonAnimation: _buttonAnimation,
            showFullDescription: showFullDescription,
            onToggleDescription: () => setState(() => showFullDescription = !showFullDescription),
          ),
        ],
      ),
    );
  }
}