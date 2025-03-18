import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/constants.dart';
import '../utils/font_family.dart';

class BuildElevatedButton extends StatelessWidget {
  final double? elevation;
  final TextStyle? textStyle;
  final String? txt;
  final Function? onTap;
  final Color? backgroundColor;
  final double? borderRadiusBottomLeft;
  final double? borderRadiusBottomRight;
  final double? borderRadiusTopLeft;
  final double? borderRadiusTopRight;
  final double? width;
  final double? height;
  final double? borderThickness;
  final Color? borderColor;
  final Widget? child;

  const BuildElevatedButton({
    Key? key,
    this.txt,
    this.onTap,
    this.backgroundColor,
    this.width,
    this.textStyle,
    this.height,
    this.borderThickness,
    this.borderColor,
    this.child,
    this.borderRadiusBottomLeft,
    this.borderRadiusBottomRight,
    this.borderRadiusTopLeft,
    this.borderRadiusTopRight,
    this.elevation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: () => onTap!(),
        style: ElevatedButton.styleFrom(
          elevation: elevation ?? 0,
          backgroundColor:
              backgroundColor ?? Constants.kitGradients[3].withOpacity(.7),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(borderRadiusBottomLeft ?? 5),
              bottomRight: Radius.circular(borderRadiusBottomRight ?? 5),
              topLeft: Radius.circular(borderRadiusTopLeft ?? 5),
              topRight: Radius.circular(borderRadiusTopRight ?? 5),
            ),
            side: BorderSide(
              color: borderColor ?? Colors.transparent,
              width: borderThickness ?? 0,
            ),
          ),
        ),
        child: Center(
          child: child ??
              Text(
                txt!,
                style: textStyle ??
                    Theme.of(context).textTheme.displayLarge?.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          fontFamily: FontFamily.gothamBook,
                          color: AppColors.primaryColorLight,
                        ),
              ),
        ),
      ),
    );
  }
}
