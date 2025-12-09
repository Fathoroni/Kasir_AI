import '../models/product.dart';

final List<Product> dummyProducts = [
  const Product(
    id: '1',
    name: 'Nasi Goreng',
    price: 15000,
    category: 'Makanan',
    stock: 100,
    description: 'Nasi goreng spesial dengan telur',
  ),
  const Product(
    id: '2',
    name: 'Mie Goreng',
    price: 12000,
    category: 'Makanan',
    stock: 50,
    description: 'Mie goreng pedas manis',
  ),
  const Product(
    id: '3',
    name: 'Es Teh Manis',
    price: 5000,
    category: 'Minuman',
    stock: 200,
    description: 'Teh manis dingin segar',
  ),
  const Product(
    id: '4',
    name: 'Kopi Hitam',
    price: 8000,
    category: 'Minuman',
    stock: 150,
    description: 'Kopi hitam robusta',
  ),
  const Product(
    id: '5',
    name: 'Kerupuk',
    price: 2000,
    category: 'Snack',
    stock: 500,
    description: 'Kerupuk putih renyah',
  ),
  const Product(
    id: '6',
    name: 'Kopi susu',
    price: 2000,
    category: 'Minuman',
    stock: 500,
    description: 'Kopi susu segar',
  ),
];
