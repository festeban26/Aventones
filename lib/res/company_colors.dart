import 'dart:ui' show Color;

import 'package:flutter/material.dart';

class CompanyColors {
  CompanyColors._();

  /// Company custom white color
  static const Color customWhite = Color(0xFFF7F7F7);

  /// Company custom blue color
  static const Color blue = Color(0xFF6BAFD3);

  /// Company custom green color
  static const Color green = Color(0xFF8BC24E);

  /// Company custom gray color
  static const Color customBlack = Color(0xFF353C42);

  static const Color homeScreenLightGray = Color(0xFFEFEFEF);

  static const Color customLightGray = Color(0xFFECECEC);

  static const Color textCustomLightGray = Color(0xFF72777b);
  //0xFFFb7b7c5

  static const MaterialColor whiteSwatch = MaterialColor(0xFFF7F7F7, _whiteSwatchMap);

  static const Map<int, Color> _whiteSwatchMap = {
    50: Color.fromRGBO(247, 247, 247, .1),
    100: Color.fromRGBO(247, 247, 247, .2),
    200: Color.fromRGBO(247, 247, 247, .3),
    300: Color.fromRGBO(247, 247, 247, .4),
    400: Color.fromRGBO(247, 247, 247, .5),
    500: Color.fromRGBO(247, 247, 247, .6),
    600: Color.fromRGBO(247, 247, 247, .7),
    700: Color.fromRGBO(247, 247, 247, .8),
    800: Color.fromRGBO(247, 247, 247, .9),
    900: Color.fromRGBO(247, 247, 247, 1),
  };
}