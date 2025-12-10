import 'package:flutter/material.dart';

class NavbarEntity {
  final IconData filledIcon;
  // final IconData outlinedIcon;
  final String title;
  final Widget page;

  NavbarEntity({
    required this.filledIcon,
    // required this.outlinedIcon,
    required this.title,
    required this.page,
  });
}
