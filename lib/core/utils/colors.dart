import 'dart:math';

import 'package:flutter/material.dart';

abstract class AppColors {
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color primaryColorDark = Color(0xFF412B98);
  static const Color secondaryColorDark = Color(0xFFEDB97F);
  static const Color primaryColorLight = Colors.white;
  static const Color secondaryColorLight = Color(0xFFFE7B1B);
  static const Color disabledItemColor = Color(0xFF9F9F9F);
  static const Color gradientColor1 = Color(0xFF12031F);
  static const Color gradientColor2 = Color(0xFF23103A);
  static const Color buttonGradientColor1 = Color(0xFF5D61A4);
  static const Color buttonGradientColor2 = Color(0xFF331893);

  static Color getRandomColor() {
    final Random random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
