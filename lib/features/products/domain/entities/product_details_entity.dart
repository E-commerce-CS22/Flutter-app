import 'package:flutter/material.dart';
import 'package:smartstore/features/products/domain/entities/product_variant_entity.dart';

class ProductDetailsEntity {
    final int id;
    final String name;
    final String description;
    final double price;
    final String? image;
    final List<String> tags;
    final String? discountType; // مثال: "percentage" أو "fixed"
    final double? discountValue;
    final List<Color>? colors;
    // final List<ProductVariantEntity> variants;


    const ProductDetailsEntity({
      required this.id,
      required this.name,
      required this.description,
      required this.price,
      required this.tags,
      this.discountType,
      this.discountValue,
      this.image,
      this.colors,
      // required this.variants
    });
  }
