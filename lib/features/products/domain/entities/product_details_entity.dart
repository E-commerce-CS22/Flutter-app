import 'package:flutter/material.dart';
import 'package:smartstore/features/products/domain/entities/product_image_entity.dart';
import 'package:smartstore/features/products/domain/entities/product_variant_entity.dart';

import 'attribute_entity.dart';


class ProductEntity {
  final int id;
  final String name;
  final String description;
  final double price;
  final String? discountType;
  final String? discountValue;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? image;
  final List<String> tags;
  final List<VariantEntity> variants;
  final List<ProductImageEntity> imageUrls;


  ProductEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.discountType,
    this.discountValue,
    required this.createdAt,
    required this.updatedAt,
    this.image,
    required this.tags,
    required this.variants,
    required this.imageUrls,
  });
}







