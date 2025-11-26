import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductItemTile extends StatelessWidget {
  final Product product;

  const ProductItemTile({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product.name),
      subtitle: Text('\$${product.price}'),
    );
  }
}
