import 'package:attendance_tracker/src/theme/widget_theme/app_bar_theme.dart';
import 'package:attendance_tracker/src/theme/widget_theme/text_theme.dart';
import 'package:attendance_tracker/src/utils/app_colors.dart';
import 'package:flutter/material.dart';

final ThemeData darkThemeData = ThemeData(
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primaryColorDark,
      secondary: AppColors.accentColorDark,
    ),
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.primaryColorDark,
    cardColor: AppColors.darkGrey,
    shadowColor: AppColors.primaryColorOrange,
    textTheme: darkTextTheme,
    appBarTheme: darkAppbarTheme,
    dividerColor: AppColors.lightGrey);
