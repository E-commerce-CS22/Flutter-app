class ProductEntity {
  final int id;
  final String name;
  final String description;
  final double price;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? image;

  const ProductEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
    this.image,
  });
}
