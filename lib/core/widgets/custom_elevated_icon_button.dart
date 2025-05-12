import 'package:flutter/material.dart';
import 'package:hakawati/core/utils/utils.dart';

class CustomElevatedIconButton extends StatelessWidget {
  const CustomElevatedIconButton({
    super.key,
    required this.child,
    required this.icon,
    required this.onPressed,
    this.padding = EdgeInsets.zero,
    this.fixedSize = const Size(95, 35),
    this.borderSide,
    this.iconSize = 18,
    this.backgroundColor,
  });

  final Widget child;
  final IconData icon;
  final VoidCallback onPressed;
  final EdgeInsetsGeometry padding;
  final Size fixedSize;
  final BorderSide? borderSide;
  final double iconSize;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        elevation: 0,
        padding: padding,
        fixedSize: fixedSize,
        shape: const RoundedRectangleBorder(
          borderRadius: Constants.kCircularRadius12,
        ),
        side: borderSide,
      ),
      onPressed: onPressed,
      label: child,
      icon: Icon(icon, color: Theme.of(context).secondaryHeaderColor, size: iconSize),
    );
  }
}
