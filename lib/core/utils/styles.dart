import 'package:flutter/material.dart';
import 'package:hakawati/core/utils/constants.dart';

abstract class Styles {
  static TextStyle getTextStyle(BuildContext context, double fontSize) {
    final locale = Localizations.localeOf(context);
    final fontFamily = locale.languageCode == 'ar'
        ? [Constants.kMarhey, Constants.kLalezar]
        : [Constants.kQuicksand, Constants.kWinterDrink];
    return TextStyle(fontSize: fontSize, fontFamily: fontSize > 24 ? fontFamily.last : fontFamily.first);
  }

  // Headings
  static TextStyle fontStyle48(BuildContext context) =>
      getTextStyle(context, 48.0).copyWith(fontWeight: FontWeight.bold);

  static TextStyle fontStyle54(BuildContext context) =>
      getTextStyle(context, 54.0).copyWith(fontWeight: FontWeight.bold);

  static TextStyle fontStyle40(BuildContext context) => getTextStyle(context, 40.0);

  static TextStyle fontStyle32(BuildContext context) => getTextStyle(context, 32.0);

  static TextStyle fontStyle24(BuildContext context) => getTextStyle(context, 24.0);

  // Body
  static TextStyle fontStyle18(BuildContext context) => getTextStyle(context, 18.0);

  static TextStyle fontStyle16(BuildContext context) => getTextStyle(context, 16.0);

  static TextStyle fontStyle14(BuildContext context) => getTextStyle(context, 14.0);

  static TextStyle fontStyle12(BuildContext context) => getTextStyle(context, 12.0);
}
