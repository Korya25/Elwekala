import 'package:elwekala/features/home/data/model/lap_top_model.dart';
import 'package:flutter/material.dart';


class CartScreen extends StatefulWidget {
  final List<CartItem> cartItems;
  final Function(CartItem) onRemoveFromCart;
  final Function(CartItem, int) onUpdateQuantity;
  final Function() onCheckout;

  const CartScreen({
    Key? key,
    required this.cartItems,
    required this.onRemoveFromCart,
    required this.onUpdateQuantity,
    required this.onCheckout,
  }) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _checkoutAnimationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _checkoutButtonAnimation;
  bool isProcessingCheckout = false;

  // Colors matching your app theme
  static const Color _backgroundDark = Color(0xFF0A0A0A);
  static const Color _cardBackground = Color(0xFF1A1A1A);
  static const Color _primaryPurple = Color(0xFF8B5CF6);
  static const Color _primaryPink = Color(0xFFEC4899);
  static const Color _primaryYellow = Color(0xFFF59E0B);
  static const Color _successGreen = Color(0xFF10B981);
  static const Color _errorRed = Color(0xFFEF4444);
  static const Color _borderColor = Color(0xFF2A2A2A);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _checkoutAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOutCubic,
          ),
        );

    _checkoutButtonAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(
        parent: _checkoutAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _checkoutAnimationController.dispose();
    super.dispose();
  }

  double get totalPrice {
    return widget.cartItems.fold(
      0.0,
      (sum, item) => sum + (item.laptop.price * item.quantity),
    );
  }

  int get totalItems {
    return widget.cartItems.fold(0, (sum, item) => sum + item.quantity);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundDark,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          _buildAppBar(),
          if (widget.cartItems.isNotEmpty) ...[
            _buildCartItems(),
            _buildSummarySection(),
          ] else
            _buildEmptyCart(),
        ],
      ),
      bottomNavigationBar: widget.cartItems.isNotEmpty
          ? _buildCheckoutButton()
          : null,
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 200,
      floating: false,
      pinned: true,
      backgroundColor: _backgroundDark,
      elevation: 0,
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _cardBackground,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _borderColor),
          ),
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 20,
          ),
        ),
      ),
      actions: [
        if (widget.cartItems.isNotEmpty)
          Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _cardBackground,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _borderColor),
            ),
            child: IconButton(
              onPressed: _showClearCartDialog,
              icon: const Icon(Icons.delete_outline, color: _errorRed),
            ),
          ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [_primaryPurple, _primaryPink, _primaryYellow],
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, _backgroundDark.withOpacity(0.7)],
              ),
            ),
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          const Hero(
                            tag: 'cart_icon',
                            child: Icon(
                              Icons.shopping_cart,
                              size: 64,
                              color: Colors.white,
                            ),
                          ),
                          if (widget.cartItems.isNotEmpty)
                            Positioned(
                              right: 0,
                              top: 0,
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: const BoxDecoration(
                                  color: _errorRed,
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  totalItems.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        "Shopping Cart",
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.cartItems.isEmpty
                            ? "Your cart is empty"
                            : "${totalItems} item${totalItems != 1 ? 's' : ''} in cart",
                        style: const TextStyle(
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
        ),
      ),
    );
  }

  Widget _buildEmptyCart() {
    return SliverFillRemaining(
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: _cardBackground,
                  shape: BoxShape.circle,
                  border: Border.all(color: _borderColor, width: 2),
                ),
                child: const Icon(
                  Icons.shopping_cart_outlined,
                  size: 64,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                "Your Cart is Empty",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                "Add some laptops to your cart\nto see them here",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[400],
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 32),
              Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [_primaryPurple, _primaryPink],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: _primaryPurple.withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: ElevatedButton.icon(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  icon: const Icon(Icons.shopping_bag, color: Colors.white),
                  label: const Text(
                    "Start Shopping",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCartItems() {
    return SliverPadding(
      padding: const EdgeInsets.all(20),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          final cartItem = widget.cartItems[index];
          return AnimatedContainer(
            duration: Duration(milliseconds: 300 + (index * 100)),
            child: _buildCartItemCard(cartItem, index),
          );
        }, childCount: widget.cartItems.length),
      ),
    );
  }

  Widget _buildCartItemCard(CartItem cartItem, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: _cardBackground,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                _buildLaptopImage(cartItem.laptop),
                const SizedBox(width: 16),
                Expanded(child: _buildLaptopInfo(cartItem)),
                _buildRemoveButton(cartItem),
              ],
            ),
            const SizedBox(height: 16),
            _buildQuantityAndPrice(cartItem),
          ],
        ),
      ),
    );
  }

  Widget _buildLaptopImage(LaptopModel laptop) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            _primaryPurple.withOpacity(0.1),
            _primaryPink.withOpacity(0.1),
          ],
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          laptop.image,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.laptop_mac, size: 40, color: Colors.grey);
          },
        ),
      ),
    );
  }

  Widget _buildLaptopInfo(CartItem cartItem) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          cartItem.laptop.name,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 8),
        Text(
          cartItem.laptop.company,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[400],
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "\$${cartItem.laptop.price.toStringAsFixed(2)}",
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: _successGreen,
          ),
        ),
      ],
    );
  }

  Widget _buildRemoveButton(CartItem cartItem) {
    return GestureDetector(
      onTap: () => _showRemoveDialog(cartItem),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: _errorRed.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _errorRed.withOpacity(0.3)),
        ),
        child: const Icon(Icons.delete_outline, color: _errorRed, size: 20),
      ),
    );
  }

  Widget _buildQuantityAndPrice(CartItem cartItem) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _backgroundDark,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _borderColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Text(
                "Quantity:",
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
              const SizedBox(width: 12),
              _buildQuantityControls(cartItem),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "Total",
                style: TextStyle(color: Colors.grey[400], fontSize: 12),
              ),
              Text(
                "\$${(cartItem.laptop.price * cartItem.quantity).toStringAsFixed(2)}",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: _successGreen,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityControls(CartItem cartItem) {
    return Container(
      decoration: BoxDecoration(
        color: _cardBackground,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _borderColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              if (cartItem.quantity > 1) {
                setState(() {
                  cartItem.quantity--;
                });
                widget.onUpdateQuantity(cartItem, cartItem.quantity);
              }
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: cartItem.quantity > 1
                    ? _primaryPurple.withOpacity(0.1)
                    : Colors.grey.withOpacity(0.1),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
              ),
              child: Icon(
                Icons.remove,
                size: 16,
                color: cartItem.quantity > 1 ? _primaryPurple : Colors.grey,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              cartItem.quantity.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (cartItem.quantity < cartItem.laptop.countInStock) {
                setState(() {
                  cartItem.quantity++;
                });
                widget.onUpdateQuantity(cartItem, cartItem.quantity);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Maximum stock reached'),
                    backgroundColor: _errorRed,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                );
              }
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: cartItem.quantity < cartItem.laptop.countInStock
                    ? _successGreen.withOpacity(0.1)
                    : Colors.grey.withOpacity(0.1),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              child: Icon(
                Icons.add,
                size: 16,
                color: cartItem.quantity < cartItem.laptop.countInStock
                    ? _successGreen
                    : Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummarySection() {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: _cardBackground,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: _borderColor),
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
            const Text(
              "Order Summary",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Items (${totalItems})",
                  style: TextStyle(color: Colors.grey[400], fontSize: 16),
                ),
                Text(
                  "\$${totalPrice.toStringAsFixed(2)}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Shipping",
                  style: TextStyle(color: Colors.grey[400], fontSize: 16),
                ),
                Text(
                  totalPrice > 100 ? "FREE" : "\$9.99",
                  style: TextStyle(
                    color: totalPrice > 100 ? _successGreen : Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(height: 1, color: _borderColor),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Total",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "\$${(totalPrice + (totalPrice > 100 ? 0 : 9.99)).toStringAsFixed(2)}",
                  style: const TextStyle(
                    color: _successGreen,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            if (totalPrice <= 100)
              Container(
                margin: const EdgeInsets.only(top: 16),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _primaryYellow.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: _primaryYellow.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.local_shipping, color: _primaryYellow, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "Add \$${(100 - totalPrice).toStringAsFixed(2)} more for FREE shipping!",
                        style: TextStyle(
                          color: _primaryYellow,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckoutButton() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _backgroundDark,
        border: Border(top: BorderSide(color: _borderColor)),
      ),
      child: ScaleTransition(
        scale: _checkoutButtonAnimation,
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [_primaryPurple, _primaryPink],
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: _primaryPurple.withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: isProcessingCheckout ? null : _handleCheckout,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              padding: const EdgeInsets.symmetric(vertical: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: isProcessingCheckout
                ? const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      ),
                      SizedBox(width: 12),
                      Text(
                        "Processing...",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.shopping_bag, color: Colors.white),
                      const SizedBox(width: 12),
                      Text(
                        "Checkout - \$${(totalPrice + (totalPrice > 100 ? 0 : 9.99)).toStringAsFixed(2)}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  void _handleCheckout() async {
    setState(() {
      isProcessingCheckout = true;
    });

    _checkoutAnimationController.forward().then((_) {
      _checkoutAnimationController.reverse();
    });

    // Simulate checkout process
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isProcessingCheckout = false;
    });

    widget.onCheckout();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Order placed successfully!'),
        backgroundColor: _successGreen,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        action: SnackBarAction(
          label: 'View Order',
          textColor: Colors.white,
          onPressed: () {
            // Navigate to order details
          },
        ),
      ),
    );
  }

  void _showRemoveDialog(CartItem cartItem) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: _cardBackground,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(color: _borderColor),
          ),
          title: const Row(
            children: [
              Icon(Icons.remove_shopping_cart, color: _errorRed),
              SizedBox(width: 12),
              Text(
                'Remove from Cart',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ],
          ),
          content: Text(
            'Are you sure you want to remove "${cartItem.laptop.name}" from your cart?',
            style: TextStyle(color: Colors.grey[300]),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel', style: TextStyle(color: Colors.grey[400])),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [_errorRed, Color(0xFFDC2626)],
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  widget.onRemoveFromCart(cartItem);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        '${cartItem.laptop.name} removed from cart',
                      ),
                      backgroundColor: _cardBackground,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  );
                },
                child: const Text(
                  'Remove',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showClearCartDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: _cardBackground,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(color: _borderColor),
          ),
          title: const Row(
            children: [
              Icon(Icons.delete_forever, color: _errorRed),
              SizedBox(width: 12),
              Text(
                'Clear Cart',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ],
          ),
          content: const Text(
            'Are you sure you want to remove all items from your cart?',
            style: TextStyle(color: Colors.grey),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel', style: TextStyle(color: Colors.grey[400])),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [_errorRed, Color(0xFFDC2626)],
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    widget.cartItems.clear();
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Cart cleared successfully'),
                      backgroundColor: _errorRed,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                child: const Text(
                  'Clear All',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class FavoritesScreen extends StatefulWidget {
  final List<LaptopModel> favoriteLaptops;
  final Function(LaptopModel) onRemoveFromFavorites;
  final Function(LaptopModel) onNavigateToDetails;

  const FavoritesScreen({
    Key? key,
    required this.favoriteLaptops,
    required this.onRemoveFromFavorites,
    required this.onNavigateToDetails,
  }) : super(key: key);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _listAnimationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  // Colors matching your app theme
  static const Color _backgroundDark = Color(0xFF0A0A0A);
  static const Color _cardBackground = Color(0xFF1A1A1A);
  static const Color _primaryPurple = Color(0xFF8B5CF6);
  static const Color _primaryPink = Color(0xFFEC4899);
  static const Color _primaryYellow = Color(0xFFF59E0B);
  static const Color _successGreen = Color(0xFF10B981);
  static const Color _errorRed = Color(0xFFEF4444);
  static const Color _borderColor = Color(0xFF2A2A2A);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _listAnimationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOutCubic,
          ),
        );

    _animationController.forward();
    _listAnimationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _listAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundDark,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [_buildAppBar(), _buildContent()],
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 200,
      floating: false,
      pinned: true,
      backgroundColor: _backgroundDark,
      elevation: 0,
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _cardBackground,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _borderColor),
          ),
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 20,
          ),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [_primaryPurple, _primaryPink, _primaryYellow],
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, _backgroundDark.withOpacity(0.7)],
              ),
            ),
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Hero(
                        tag: 'favorites_icon',
                        child: Icon(
                          Icons.favorite,
                          size: 64,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        "Favorites",
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1.2,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Your Wishlist Collection",
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
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (widget.favoriteLaptops.isEmpty) {
      return _buildEmptyState();
    }

    return SliverPadding(
      padding: const EdgeInsets.all(20),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          return AnimatedBuilder(
            animation: _listAnimationController,
            builder: (context, child) {
              final slideAnimation =
                  Tween<Offset>(
                    begin: const Offset(1, 0),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: _listAnimationController,
                      curve: Interval(
                        (index * 0.1).clamp(0.0, 1.0),
                        ((index * 0.1) + 0.3).clamp(0.0, 1.0),
                        curve: Curves.easeOutCubic,
                      ),
                    ),
                  );

              return SlideTransition(
                position: slideAnimation,
                child: _buildFavoriteCard(widget.favoriteLaptops[index], index),
              );
            },
          );
        }, childCount: widget.favoriteLaptops.length),
      ),
    );
  }

  Widget _buildEmptyState() {
    return SliverFillRemaining(
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: _cardBackground,
                  shape: BoxShape.circle,
                  border: Border.all(color: _borderColor, width: 2),
                ),
                child: const Icon(
                  Icons.favorite_border,
                  size: 64,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                "No Favorites Yet",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                "Start adding laptops to your favorites\nto see them here",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[400],
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 32),
              Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [_primaryPurple, _primaryPink],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: _primaryPurple.withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: ElevatedButton.icon(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  icon: const Icon(Icons.explore, color: Colors.white),
                  label: const Text(
                    "Explore Laptops",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFavoriteCard(LaptopModel laptop, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: _cardBackground,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        onTap: () => widget.onNavigateToDetails(laptop),
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              _buildLaptopImage(laptop),
              const SizedBox(width: 16),
              Expanded(child: _buildLaptopInfo(laptop)),
              _buildActionButtons(laptop),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLaptopImage(LaptopModel laptop) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            _primaryPurple.withOpacity(0.1),
            _primaryPink.withOpacity(0.1),
          ],
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          laptop.image,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.laptop_mac, size: 40, color: Colors.grey);
          },
        ),
      ),
    );
  }

  Widget _buildLaptopInfo(LaptopModel laptop) {
    final rating = 4.0 + (laptop.sales % 10) / 10;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          laptop.name,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 8),
        Text(
          laptop.company,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[400],
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Icon(Icons.star, color: _primaryYellow, size: 14),
            const SizedBox(width: 4),
            Text(
              rating.toStringAsFixed(1),
              style: TextStyle(color: Colors.grey[400], fontSize: 12),
            ),
            const SizedBox(width: 12),
            Text(
              "\$${laptop.price.toStringAsFixed(2)}",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: _successGreen,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Icon(
              laptop.countInStock > 0 ? Icons.check_circle : Icons.cancel,
              color: laptop.countInStock > 0 ? _successGreen : _errorRed,
              size: 12,
            ),
            const SizedBox(width: 4),
            Text(
              laptop.countInStock > 0 ? "In Stock" : "Out of Stock",
              style: TextStyle(
                color: laptop.countInStock > 0 ? _successGreen : _errorRed,
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButtons(LaptopModel laptop) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => _showRemoveDialog(laptop),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _errorRed.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _errorRed.withOpacity(0.3)),
            ),
            child: const Icon(Icons.favorite, color: _errorRed, size: 20),
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () => widget.onNavigateToDetails(laptop),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [_primaryPurple, _primaryPink],
              ),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: _primaryPurple.withOpacity(0.3),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
              size: 16,
            ),
          ),
        ),
      ],
    );
  }

  void _showRemoveDialog(LaptopModel laptop) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: _cardBackground,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(color: _borderColor),
          ),
          title: const Row(
            children: [
              Icon(Icons.favorite_border, color: _errorRed),
              SizedBox(width: 12),
              Text(
                'Remove from Favorites',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ],
          ),
          content: Text(
            'Are you sure you want to remove "${laptop.name}" from your favorites?',
            style: TextStyle(color: Colors.grey[300]),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel', style: TextStyle(color: Colors.grey[400])),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [_errorRed, Color(0xFFDC2626)],
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  widget.onRemoveFromFavorites(laptop);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${laptop.name} removed from favorites'),
                      backgroundColor: _cardBackground,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  );
                },
                child: const Text(
                  'Remove',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
