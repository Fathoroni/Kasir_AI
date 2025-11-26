class Product {
  final String id;
  final String name;
  final double price;
  final String? imageUrl;
  final String? description;

  const Product({
    required this.id,
    required this.name,
    required this.price,
    this.imageUrl,
    this.description,
  });
}
