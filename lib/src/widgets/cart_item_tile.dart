import 'package:flutter/material.dart';
import '../models/cart_item.dart';

class CartItemTile extends StatelessWidget {
  final CartItem item;

  const CartItemTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(item.product.name),
      subtitle: Text('Qty: ${item.quantity}'),
      trailing: Text('\$${item.subtotal}'),
    );
  }
}
