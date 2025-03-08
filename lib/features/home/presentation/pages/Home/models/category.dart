class Category {
  final String title;
  final String image;

  Category({
    required this.title,
    required this.image,
  });
}

final List<Category> categories = [
  Category(title: "أحذية", image: "assets/temp/shoes.jpg"),
  Category(title: "جمال", image: "assets/temp/beauty.png"),
  Category(title: "حاسوب", image: "assets/temp/pc.jpg"),
  Category(title: "هواتف", image: "assets/temp/mobile.jpg"),
  Category(title: "ساعات", image: "assets/temp/watch.png"), // تم تغيير "Watch" إلى "ساعات"
];
