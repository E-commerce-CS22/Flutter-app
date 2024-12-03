import 'package:flutter/material.dart';
import 'app_colors.dart';

class GradientText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final Gradient gradient;

  const GradientText({
    Key? key,
    required this.text,
    required this.style,
    this.gradient = const LinearGradient(
      colors: [AppColors.gradient1, AppColors.gradient2],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return gradient.createShader(
          Rect.fromLTWH(0, 0, bounds.width, bounds.height),
        );
      },
      child: Text(
        text,
        style: style.copyWith(color: Colors.white), // Text color is ignored; gradient is applied
      ),
    );
  }
}
