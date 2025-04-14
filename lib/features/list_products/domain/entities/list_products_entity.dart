class ListProductsEntity {
  final int id;
  final String name;
  final double price;
  final double? discountValue;
  final String? image;

  ListProductsEntity({
    required this.id,
    required this.name,
    required this.price,
    this.discountValue,
    this.image,
  });
}

