import 'package:flutter/material.dart';
import 'package:smartstore/core/configs/theme/app_colors.dart';

class CurvedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final Color? backgroundColor;
  final double? height;
  final bool hideBack;

  const CurvedAppBar({
    this.title,
    this.hideBack = false,
    this.backgroundColor,
    this.height,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipPath(
          clipper: AppBarClipper(),
          child: Container(
            height: height ?? 150.0,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.gradient1, AppColors.gradient2],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
        ),
        Container(
          child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              toolbarHeight: height != null ? height! * 0.7 : 105.0,
              // Adjust height for title centering
              title: Container(
                alignment: Alignment.bottomCenter,
                child: DefaultTextStyle(
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.w700,
                  ),
                  child: title!, // This will apply the style to the title
                ),
              )),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height ?? 150.0);
}

class AppBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double cornerRadius = 20.0; // Adjust for rounded corners

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
