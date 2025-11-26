import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductItemTile extends StatelessWidget {
  final Product product;
  final Widget? trailing;
  final VoidCallback? onTap;

  const ProductItemTile({
    super.key,
    required this.product,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product.name),
      subtitle: Text('${product.category} - Stok: ${product.stock}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Rp ${product.price.toStringAsFixed(0)}'),
          if (trailing != null) ...[const SizedBox(width: 8), trailing!],
        ],
      ),
      onTap: onTap,
    );
  }
}
