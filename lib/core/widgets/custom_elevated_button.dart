import 'package:flutter/material.dart';
import 'package:hakawati/core/utils/colors.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final Size fixedSize;

  const CustomElevatedButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.fixedSize = const Size.fromHeight(50.0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            HexColor("#5D61A4"),
            HexColor("#331893"),
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          fixedSize: fixedSize,
          side: BorderSide(width: 1, color: Theme.of(context).secondaryHeaderColor),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
        ),
        child: child,
      ),
    );
  }
}
