import '../models/product.dart';
import '../data/dummy_data.dart';

class ProductService {
  Future<List<Product>> getProducts() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    return dummyProducts;
  }
}
