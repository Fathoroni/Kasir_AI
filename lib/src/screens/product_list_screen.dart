import 'package:flutter/material.dart';
import '../data/dummy_data.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Produk')),
      body: ListView.builder(
        itemCount: dummyProducts.length,
        itemBuilder: (context, index) {
          final product = dummyProducts[index];
          return ListTile(
            title: Text(product.name),
            subtitle: Text('${product.category} - Stok: ${product.stock}'),
            trailing: Text('Rp ${product.price.toStringAsFixed(0)}'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/product_form');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
