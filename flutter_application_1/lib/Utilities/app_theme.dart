import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static const Color ratingColor = Color(0xfff7ca00);
  static const Color buyNowColor = Color(0xfffa8900);

  static TextTheme textTheme = TextTheme(
    headlineLarge: title,
    headlineMedium: description,
    headlineSmall: subtitle,
  );

  static TextStyle title = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 24.rs,
    letterSpacing: 0.27.rs,
    color: Colors.black,
  );
  static TextStyle description = TextStyle(
    fontSize: 16.rs,
    letterSpacing: 0.18.rs,
    color: Colors.black,
  );

  static TextStyle subtitle = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14.rs,
    letterSpacing: -0.04.rs,
    color: Colors.black,
  );
}
