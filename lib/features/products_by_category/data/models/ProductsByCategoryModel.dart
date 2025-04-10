import 'package:smartstore/features/products_by_category/data/models/product_model.dart';
import 'package:smartstore/features/products_by_category/data/models/productpagination_Model.dart';
import 'package:smartstore/features/products_by_category/domain/entities/products_by_category_entity.dart';
import 'category_model.dart';

class ProductsByCategoryModel extends ProductsByCategoryEntity {
  final CategoryModel category;
  final ProductPaginationModel products;

  ProductsByCategoryModel({
    required this.category,
    required this.products,
  }) : super(
    category: category,  // تحويل CategoryModel إلى CategoryEntity
    products: products,  // تحويل ProductPaginationModel إلى ProductPaginationEntity
    pagination: products,  // تم تمرير الـ pagination بشكل صحيح
  );

  factory ProductsByCategoryModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    return ProductsByCategoryModel(
      category: CategoryModel.fromJson(data['category']),
      products: ProductPaginationModel.fromJson(data['products']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category': category.toJson(),
      'products': products.toJson(),
    };
  }
}
