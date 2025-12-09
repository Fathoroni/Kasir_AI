import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import '../models/product.dart';
import '../services/product_service.dart';
import '../services/transaction_service.dart';
import '../widgets/primary_button.dart';
import '../widgets/product_item_tile.dart';
import '../widgets/cart_item_tile.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  final ProductService _productService = ProductService();
  final TransactionService _transactionService = TransactionService();
  final _searchController = TextEditingController();

  List<Product> _allProducts = [];
  List<Product> _filteredProducts = [];
  final List<CartItem> _cartItems = [];
  List<Product> _recommendedProducts = [];

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    try {
      final products = await _productService.getProducts();
      if (mounted) {
        setState(() {
          _allProducts = products;
          _filteredProducts = products;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Gagal memuat produk: $e')));
      }
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterProducts(String query) {
    setState(() {
      _filteredProducts = _allProducts
          .where((p) => p.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _updateRecommendations() {
    final cartCategories = _cartItems
        .map((item) => item.product.category)
        .toSet();
    final recommendedCategories = <String>{};

    if (cartCategories.contains('Makanan')) {
      recommendedCategories.add('Minuman');
    }
    if (cartCategories.contains('Minuman')) {
      recommendedCategories.add('Snack');
    }

    setState(() {
      _recommendedProducts = _allProducts.where((p) {
        // Exclude items already in cart
        final isInCart = _cartItems.any((item) => item.product.id == p.id);
        if (isInCart) return false;

        // Include if category matches recommendation rules
        return recommendedCategories.contains(p.category);
      }).toList();
    });
  }

  void _addToCart(Product product) {
    setState(() {
      final existingIndex = _cartItems.indexWhere(
        (item) => item.product.id == product.id,
      );
      if (existingIndex != -1) {
        _cartItems[existingIndex].quantity++;
      } else {
        _cartItems.add(
          CartItem(id: DateTime.now().toString(), product: product),
        );
      }
      _updateRecommendations();
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${product.name} ditambahkan ke keranjang'),
          duration: const Duration(seconds: 1),
        ),
      );
    });
  }

  void _updateQuantity(CartItem item, int change) {
    setState(() {
      item.quantity += change;
      if (item.quantity <= 0) {
        _cartItems.remove(item);
      }
      _updateRecommendations();
    });
  }

  double get _total => _cartItems.fold(0, (sum, item) => sum + item.subtotal);

  void _showPaymentBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: _PaymentBottomSheetContent(
            total: _total,
            cartItems: _cartItems,
            transactionService: _transactionService,
            onPaymentSuccess: () {
              Navigator.pop(context); // Close bottom sheet
              setState(() {
                _cartItems.clear();
                _updateRecommendations();
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Transaksi Berhasil')),
              );
              Navigator.pushReplacementNamed(context, '/transactions/history');
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Transaksi Baru')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Search Bar
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                        labelText: 'Cari Produk',
                        prefixIcon: Icon(Icons.search),
                      ),
                      onChanged: _filterProducts,
                    ),
                  ),

                  // Product List
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = _filteredProducts[index];
                      return ProductItemTile(
                        product: product,
                        trailing: IconButton(
                          icon: Icon(
                            Icons.add_circle,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          onPressed: () => _addToCart(product),
                        ),
                      );
                    },
                  ),

                  const Divider(thickness: 1),

                  // Cart Header
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    child: Text(
                      'Keranjang',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  // Cart List
                  if (_cartItems.isEmpty)
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Belum ada item di keranjang',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    )
                  else
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _cartItems.length,
                      itemBuilder: (context, index) {
                        final item = _cartItems[index];
                        return CartItemTile(
                          item: item,
                          onIncrement: () => _updateQuantity(item, 1),
                          onDecrement: () => _updateQuantity(item, -1),
                        );
                      },
                    ),

                  // Recommendations
                  if (_recommendedProducts.isNotEmpty) ...[
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                      child: Text(
                        'Rekomendasi Produk (AI)',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      ),
                    ),
                    SizedBox(
                      height: 120,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        itemCount: _recommendedProducts.length,
                        itemBuilder: (context, index) {
                          final product = _recommendedProducts[index];
                          return Card(
                            margin: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 160,
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    'Rp ${product.price.toStringAsFixed(0)}',
                                  ),
                                  const Spacer(),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: InkWell(
                                      onTap: () => _addToCart(product),
                                      child: Icon(
                                        Icons.add_circle,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.primary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],

                  const SizedBox(height: 24),

                  // Continue to Payment Button
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: PrimaryButton(
                        text: 'Lanjut ke Pembayaran',
                        onPressed: _cartItems.isNotEmpty
                            ? _showPaymentBottomSheet
                            : null,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
    );
  }
}

class _PaymentBottomSheetContent extends StatefulWidget {
  final double total;
  final List<CartItem> cartItems;
  final TransactionService transactionService;
  final VoidCallback onPaymentSuccess;

  const _PaymentBottomSheetContent({
    required this.total,
    required this.cartItems,
    required this.transactionService,
    required this.onPaymentSuccess,
  });

  @override
  State<_PaymentBottomSheetContent> createState() =>
      _PaymentBottomSheetContentState();
}

class _PaymentBottomSheetContentState
    extends State<_PaymentBottomSheetContent> {
  String _selectedPaymentMethod = 'Tunai';
  final _paymentController = TextEditingController();
  double _amountPaid = 0;
  double _change = 0;
  bool _isProcessing = false;

  @override
  void dispose() {
    _paymentController.dispose();
    super.dispose();
  }

  void _calculateChange(String value) {
    setState(() {
      _amountPaid = double.tryParse(value) ?? 0;
      _change = _amountPaid - widget.total;
    });
  }

  Future<void> _submitPayment() async {
    if (_amountPaid < widget.total) return;

    setState(() {
      _isProcessing = true;
    });

    final transactionData = {
      "user_id": 1, // Hardcoded for now
      "items": widget.cartItems
          .map(
            (item) => {
              "product_id": item.product.id,
              "quantity": item.quantity,
              "price": item.product.price,
            },
          )
          .toList(),
      "total_amount": widget.total,
      "payment_method": _selectedPaymentMethod,
      "amount_paid": _amountPaid,
      "change": _change,
    };

    final success = await widget.transactionService.createTransaction(
      transactionData,
    );

    if (mounted) {
      setState(() {
        _isProcessing = false;
      });

      if (success) {
        widget.onPaymentSuccess();
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Transaksi Gagal!')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Pembayaran',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: _selectedPaymentMethod,
            decoration: const InputDecoration(
              labelText: 'Metode Pembayaran',
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 12,
              ),
            ),
            items: ['Tunai', 'Transfer', 'E-Wallet']
                .map(
                  (method) =>
                      DropdownMenuItem(value: method, child: Text(method)),
                )
                .toList(),
            onChanged: (value) {
              setState(() {
                _selectedPaymentMethod = value!;
              });
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _paymentController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Jumlah Dibayar',
              prefixText: 'Rp ',
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 12,
              ),
              errorText: _amountPaid > 0 && _amountPaid < widget.total
                  ? 'Jumlah bayar kurang'
                  : null,
            ),
            onChanged: _calculateChange,
          ),
          const SizedBox(height: 16),
          if (_change >= 0)
            Text(
              'Kembalian: Rp ${_change.toStringAsFixed(0)}',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Rp ${widget.total.toStringAsFixed(0)}',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 50,
            child: _isProcessing
                ? const Center(child: CircularProgressIndicator())
                : PrimaryButton(
                    text: 'Bayar',
                    onPressed: _amountPaid >= widget.total
                        ? _submitPayment
                        : null,
                  ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
