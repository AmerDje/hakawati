import 'dart:ui';

import 'package:flutter/material.dart';

class GlassFilter extends StatelessWidget {
  const GlassFilter(
      {super.key,
      required this.child,
      this.borderRadius = const BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25))});
  final Widget child;
  final BorderRadiusGeometry borderRadius;
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(.1), spreadRadius: 10, blurRadius: 20, offset: const Offset(0, 0))
        ],
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(.1),
              // gradient: LinearGradient(
              //   begin: Alignment.topLeft,
              //   end: Alignment.bottomCenter,
              //   colors: [Colors.grey.shade600.withOpacity(.1), Colors.grey.shade100.withOpacity(.1)],
              // ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
