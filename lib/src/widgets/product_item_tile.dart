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
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(
          product.name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(product.category),
            const SizedBox(height: 4),
            Text(
              'Stok: ${product.stock}',
              style: TextStyle(
                color: product.stock < 5 ? Colors.red : Colors.grey[600],
              ),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Rp ${product.price.toStringAsFixed(0)}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.indigo,
              ),
            ),
            if (trailing != null) ...[const SizedBox(width: 8), trailing!],
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}
