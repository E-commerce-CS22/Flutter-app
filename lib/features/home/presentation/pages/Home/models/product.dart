import 'package:flutter/material.dart';

class Product {
  final String title;
  final String description;
  final String image;
  final double price;
  final List<Color> colors;
  final String category;
  final double rate;

  Product({
    required this.title,
    required this.description,
    required this.image,
    required this.price,
    required this.colors,
    required this.category,
    required this.rate,
  });
}

final List<Product> products = [
  Product(
    title: "سماعة لاسلكية",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec massa sapien faucibus et molestie ac feugiat. In massa tempor nec feugiat nisl. Libero id faucibus nisl tincidunt.",
    image: "assets/temp/wireless.png",
    price: 120,
    colors: [
      Colors.black,
      Colors.blue,
      Colors.orange,
    ],
    category: "Headphones",
    rate: 4.8,
  ),
  Product(
    title: "سترة نسائية",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec massa sapien faucibus et molestie ac feugiat. In massa tempor nec feugiat nisl. Libero id faucibus nisl tincidunt.",
    image: "assets/temp/sweet.png",
    price: 120,
    colors: [
      Colors.brown,
      Colors.red,
      Colors.pink,
    ],
    category: "Woman Fashion",
    rate: 4.8,
  ),
  Product(
    title: "ساعة ذكية",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec massa sapien faucibus et molestie ac feugiat. In massa tempor nec feugiat nisl. Libero id faucibus nisl tincidunt.",
    image: "assets/temp/miband.jpg",
    price: 55,
    colors: [
      Colors.black,
    ],
    category: "Watch",
    rate: 4.8,
  ),
];
