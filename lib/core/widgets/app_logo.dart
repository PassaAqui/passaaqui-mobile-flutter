import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppLogo extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;

  const AppLogo({
    super.key,
    required this.width,
    required this.height,
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: SvgPicture.asset(
        "assets/images/logo/logo.svg",
        width: width,
        height: height,
      ),
    );
  }
}
