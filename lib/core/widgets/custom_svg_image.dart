import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../theme/theme_controller.dart';

class CustomSvgImage extends StatelessWidget {
  CustomSvgImage({
    super.key,
    required this.path,
    this.width,
    this.height,
    this.withFilterColor = true,
  });

  CustomSvgImage.withoutColor({
    super.key,
    required this.path,
    this.height,
    this.width,
  }) : withFilterColor = false;

  final String path;
  final double? width;
  final double? height;
  final bool withFilterColor;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      width: width,
      height: height,
      colorFilter: withFilterColor == true
          ? ColorFilter.mode(
              ThemeController.isDark() ? Color(0xFFFFFCFC) : Color(0xFF161F1B),
              BlendMode.srcIn,
            )
          : null,
    );
  }
}
