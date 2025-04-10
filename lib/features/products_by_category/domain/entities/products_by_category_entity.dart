class CategoryEntity {
  final int id;
  final String name;
  final String slug;
  final String description;
  final String? image;

  CategoryEntity({
    required this.id,
    required this.name,
    required this.slug,
    required this.description,
    this.image,
  });
}

class ProductEntity {
  final int id;
  final String name;
  final String description;
  final double price;
  final double finalPrice;
  final bool hasDiscount;
  final String? primaryImage;

  ProductEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.finalPrice,
    required this.hasDiscount,
    this.primaryImage,
  });
}

class ProductPaginationEntity {
  final int currentPage;
  final int lastPage;
  final int total;
  final int perPage;
  final List<ProductEntity> products;

  ProductPaginationEntity({
    required this.currentPage,
    required this.lastPage,
    required this.total,
    required this.perPage,
    required this.products,
  });
}

class ProductsByCategoryEntity{
  final CategoryEntity category;
  final ProductPaginationEntity products;
  final ProductPaginationEntity pagination;

  ProductsByCategoryEntity({
    required this.category,
    required this.products,
    required this.pagination,
  });
}
