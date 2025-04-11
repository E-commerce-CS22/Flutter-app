import 'package:flutter/material.dart';

class ImageSlider extends StatelessWidget {
  final Function(int) onChange;
  final int currentImage;
  final String image;
  const ImageSlider({
    super.key,
    required this.onChange,
    required this.currentImage,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: PageView.builder(
        reverse: true, // عكس الاتجاه من اليمين لليسار
        itemCount: 5,
        onPageChanged: onChange,
        itemBuilder: (context, index) {
          return Image.asset(image);
        },
      ),
    );
  }
}
