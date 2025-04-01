import '../../domain/entities/category_entity.dart';

class CategoryModel {
  final int id;
  final String name;
  final String slug;
  final String description;
  final String? image;

  CategoryModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.description,
    this.image,
  });

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'] as int,
      name: map['name'] as String,
      slug: map['slug'] as String,
      description: map['description'] as String,
      image: map['image'] as String?,
    );
  }
}

extension CategoryXModel on CategoryModel {
  CategoryEntity toEntity() {
    return CategoryEntity(
      id: id,
      name: name,
      slug: slug,
      description: description,
      image: image,
    );
  }
}
