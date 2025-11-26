class Product {
  final String id;
  final String name;
  final double price;
  final String? imageUrl;
  final String? description;
  final String category;
  final int stock;

  const Product({
    required this.id,
    required this.name,
    required this.price,
    this.imageUrl,
    this.description,
    required this.category,
    required this.stock,
  });
}
