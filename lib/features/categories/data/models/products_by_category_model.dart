// class CategoryModel {
//   final int id;
//   final String name;
//   final String slug;
//   final String description;
//   final String? image;
//
//   CategoryModel({
//     required this.id,
//     required this.name,
//     required this.slug,
//     required this.description,
//     this.image,
//   });
//
//   factory CategoryModel.fromJson(Map<String, dynamic> json) {
//     return CategoryModel(
//       id: json['id'],
//       name: json['name'],
//       slug: json['slug'],
//       description: json['description'],
//       image: json['image'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'slug': slug,
//       'description': description,
//       'image': image,
//     };
//   }
// }
//
//
// class ProductModel {
//   final int id;
//   final String name;
//   final String description;
//   final double price;
//   final bool hasDiscount;
//   final double? discountValue;
//   final String status;
//   final String? primaryImage;
//
//   ProductModel({
//     required this.id,
//     required this.name,
//     required this.description,
//     required this.price,
//     required this.hasDiscount,
//     this.discountValue,
//     required this.status,
//     this.primaryImage,
//   });
//
//   factory ProductModel.fromJson(Map<String, dynamic> json) {
//     return ProductModel(
//       id: json['id'],
//       name: json['name'],
//       description: json['description'],
//       price: double.parse(json['price']),
//       hasDiscount: json['has_discount'] ?? false,
//       discountValue: json['discount_value'] != null ? double.parse(json['discount_value']) : null,
//       status: json['status'],
//       primaryImage: json['primary_image'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'description': description,
//       'price': price,
//       'has_discount': hasDiscount,
//       'discount_value': discountValue,
//       'status': status,
//       'primary_image': primaryImage,
//     };
//   }
// }
//
//
// class ProductsResponseModel {
//   final CategoryModel category;
//   final List<ProductModel> products;
//   final int currentPage;
//   final int lastPage;
//   final String firstPageUrl;
//   final String lastPageUrl;
//   final String? nextPageUrl;
//
//   ProductsResponseModel({
//     required this.category,
//     required this.products,
//     required this.currentPage,
//     required this.lastPage,
//     required this.firstPageUrl,
//     required this.lastPageUrl,
//     this.nextPageUrl,
//   });
//
//   factory ProductsResponseModel.fromJson(Map<String, dynamic> json) {
//     var productsList = json['data']['products']['data'] as List;
//     List<ProductModel> products = productsList.map((product) => ProductModel.fromJson(product)).toList();
//
//     return ProductsResponseModel(
//       category: CategoryModel.fromJson(json['data']['category']),
//       products: products,
//       currentPage: json['data']['products']['current_page'],
//       lastPage: json['data']['products']['last_page'],
//       firstPageUrl: json['data']['products']['first_page_url'],
//       lastPageUrl: json['data']['products']['last_page_url'],
//       nextPageUrl: json['data']['products']['next_page_url'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'category': category.toJson(),
//       'products': {
//         'data': products.map((product) => product.toJson()).toList(),
//         'current_page': currentPage,
//         'last_page': lastPage,
//         'first_page_url': firstPageUrl,
//         'last_page_url': lastPageUrl,
//         'next_page_url': nextPageUrl,
//       },
//     };
//   }
// }
//
//
