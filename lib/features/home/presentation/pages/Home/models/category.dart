class Category {
  final String title;
  final String image;

  Category({
    required this.title,
    required this.image,
  });
}

final List<Category> categories = [
  Category(title: "Shoes", image: "assets/temp/shoes.jpg"),
  Category(title: "Beauty", image: "assets/temp/beauty.png"),
  Category(title: "PC", image: "assets/temp/pc.jpg"),
  Category(title: "Mobile", image: "assets/temp/mobile.jpg"),
  Category(title: "Watch", image: "assets/temp/watch.png"),
];
