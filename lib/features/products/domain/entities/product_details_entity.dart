  class ProductDetailsEntity {
    final int id;
    final String name;
    final String description;
    final double price;
    final String status;
    final List<String> tags;
    final String? discountType; // مثال: "percentage" أو "fixed"
    final double? discountValue;

    const ProductDetailsEntity({
      required this.id,
      required this.name,
      required this.description,
      required this.price,
      required this.status,
      required this.tags,
      this.discountType,
      this.discountValue,
    });
  }
