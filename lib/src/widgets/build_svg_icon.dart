import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BuildSvgIcon extends StatelessWidget {
  final String assetImagePath;
  final double? iconWidth;
  final double? iconHeight;
  final Color? color;

  const BuildSvgIcon(
      {Key? key,
      required this.assetImagePath,
      this.iconWidth,
      this.iconHeight,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      color: color,
      assetImagePath,
      width: iconWidth ?? 20,
      height: iconHeight ?? 20,
    );
  }
}
