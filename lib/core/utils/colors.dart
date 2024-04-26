import 'package:flutter/material.dart';

abstract class AppColors {
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color primaryColorDark = Color(0xFF412B98);
  static const Color secondaryColorDark = Colors.yellow;
  static const Color primaryColorLight = Colors.white;
  static const Color secondaryColorLight = Color(0xFFFE7B1B);
  static const Color disabledItemColor = Color(0xFF9F9F9F);
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
