import 'package:attendance_tracker/src/utils/app_colors.dart';
import 'package:flutter/material.dart';

AppBarTheme lightAppBarTheme = const AppBarTheme(
    backgroundColor: AppColors.primaryColorLight,
    actionsIconTheme: IconThemeData(color: AppColors.svgButtonColorLight));
AppBarTheme darkAppbarTheme = const AppBarTheme(
    backgroundColor: AppColors.primaryColorDark,
    actionsIconTheme: IconThemeData(color: AppColors.svgButtonColorDark));
