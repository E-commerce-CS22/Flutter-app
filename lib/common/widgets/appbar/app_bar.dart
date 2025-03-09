import 'package:flutter/material.dart';
import 'package:smartstore/core/configs/theme/app_colors.dart';

class CurvedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final Color? backgroundColor;
  final double height;
  final bool hideBack;
  final double fontSize; // New property for font size

  const CurvedAppBar({
    this.title,
    this.hideBack = true,
    this.backgroundColor,
    this.height = 125.0, // Default height
    this.fontSize = 36.0, // Default font size
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipPath(
          clipper: AppBarClipper(),
          child: Container(
            height: height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.gradient2, AppColors.gradient2],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
        ),
        AppBar(
          automaticallyImplyLeading: !hideBack, // Use hideBack to control back button visibility
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          toolbarHeight: height * 0.7, // Dynamically calculate toolbar height
          title: Container(
            alignment: Alignment.bottomCenter,
            child: DefaultTextStyle(
              style: TextStyle(
                color: AppColors.white,
                fontSize: fontSize, // Use the fontSize parameter
                fontWeight: FontWeight.w700,
                fontFamily: "Almarai",
              ),
              child: title ?? const SizedBox.shrink(),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height - 40); // Dynamically return height
}

class AppBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double cornerRadius = 20.0;

    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height - cornerRadius);
    path.arcToPoint(
      Offset(cornerRadius, size.height),
      radius: Radius.circular(cornerRadius),
      clockwise: false,
    );
    path.lineTo(size.width - cornerRadius, size.height);
    path.arcToPoint(
      Offset(size.width, size.height - cornerRadius),
      radius: Radius.circular(cornerRadius),
      clockwise: false,
    );
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
