class ProductImageEntity {
  final String url;
  final bool isPrimary;
  final String altText;
  final int sortOrder;

  ProductImageEntity({
    required this.url,
    required this.isPrimary,
    required this.altText,
    required this.sortOrder,
  });
}
