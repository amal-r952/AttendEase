import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../utils/app_colors.dart';

class BuildLoadingWidget extends StatelessWidget {
  final Color? color;

  const BuildLoadingWidget({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 40,
      child: LoadingIndicator(
        indicatorType: Indicator.ballRotateChase,
        colors: color != null ? [color!] : [AppColors.primaryColorOrange],
        strokeWidth: 2,
      ),
    );
  }
}
