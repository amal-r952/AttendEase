import 'package:attendance_tracker/src/utils/font_family.dart';
import 'package:flutter/material.dart';

TextTheme lightTextTheme = TextTheme(
  headlineLarge: TextStyle(
    color: Colors.black87,
    fontFamily: FontFamily.gothamBook,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  ),
  headlineMedium: TextStyle(
    color: Colors.black54,
    fontFamily: FontFamily.gothamBook,
    fontSize: 15,
    fontWeight: FontWeight.w500,
  ),
  headlineSmall: TextStyle(
    color: Colors.black45,
    fontSize: 14,
    fontFamily: FontFamily.gothamBook,
    fontWeight: FontWeight.w100,
  ),
  bodyLarge: TextStyle(
    color: Colors.black87,
    fontFamily: FontFamily.gothamBook,
    fontSize: 13,
    fontWeight: FontWeight.bold,
  ),
  bodyMedium: TextStyle(
    color: Colors.black54,
    fontSize: 12,
    fontFamily: FontFamily.gothamBook,
    fontWeight: FontWeight.w300,
  ),
  bodySmall: TextStyle(
    color: Colors.black38,
    fontFamily: FontFamily.gothamBook,
    fontSize: 11,
    fontWeight: FontWeight.w100,
  ),
  displayLarge: TextStyle(
      fontFamily: FontFamily.gothamBook,
      color: Colors.black87,
      fontSize: 16,
      fontWeight: FontWeight.w700),
  displaySmall: TextStyle(
      fontFamily: FontFamily.gothamBook,
      color: Colors.black54,
      fontSize: 11,
      fontWeight: FontWeight.w400),
  displayMedium: TextStyle(
      fontFamily: FontFamily.gothamBook,
      color: Colors.black87,
      fontSize: 14,
      fontWeight: FontWeight.w400),
);

TextTheme darkTextTheme = TextTheme(
  headlineLarge: TextStyle(
    fontFamily: FontFamily.gothamBook,
    color: Colors.grey[100],
    fontSize: 20,
    fontWeight: FontWeight.bold,
  ),
  headlineMedium: TextStyle(
    fontFamily: FontFamily.gothamBook,
    color: Colors.grey[300],
    fontSize: 15,
    fontWeight: FontWeight.w300,
  ),
  headlineSmall: TextStyle(
    color: Colors.grey[400],
    fontSize: 14,
    fontFamily: FontFamily.gothamBook,
    fontWeight: FontWeight.w100,
  ),
  bodyLarge: TextStyle(
    fontFamily: FontFamily.gothamBook,
    color: Colors.grey[100],
    fontSize: 14,
    fontWeight: FontWeight.bold,
  ),
  bodyMedium: TextStyle(
    color: Colors.grey[300],
    fontSize: 13,
    fontWeight: FontWeight.w300,
    fontFamily: FontFamily.gothamBook,
  ),
  bodySmall: TextStyle(
    fontFamily: FontFamily.gothamBook,
    color: Colors.grey[600],
    fontSize: 10,
    fontWeight: FontWeight.w100,
  ),
);
