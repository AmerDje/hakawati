import 'package:flutter/material.dart';

extension MediaQueryValues on BuildContext {
  double get height => MediaQuery.sizeOf(this).height;
  double get width => MediaQuery.sizeOf(this).width;
  double get topPadding => MediaQuery.of(this).viewPadding.top;
  double get bottomInsets => MediaQuery.of(this).viewInsets.bottom;
}
