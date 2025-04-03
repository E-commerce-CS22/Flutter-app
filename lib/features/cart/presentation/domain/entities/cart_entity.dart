class CartItemEntity {
  final int id;
  final String name;
  final String description;
  final String price;
  final int quantity;

  const CartItemEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.quantity,
  });
}
