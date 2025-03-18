import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BuildSvgIconButton extends StatelessWidget {
  final String assetImagePath;
  final VoidCallback onTap;
  final double? iconWidth;
  final double? iconHeight;
  final Color? color;
  final Color? backgroundColor;

  const BuildSvgIconButton({
    Key? key,
    required this.assetImagePath,
    this.color,
    required this.onTap,
    this.iconWidth,
    this.iconHeight,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.transparent, // Set background color
          shape: BoxShape.circle, // This makes the background circular
        ),
        child: IconButton(
          icon: SvgPicture.asset(
            color: color,
            assetImagePath,
            width: iconWidth ?? 20,
            height: iconHeight ?? 20,
          ),
          onPressed: onTap,
        ),
      ),
    );
  }
}
