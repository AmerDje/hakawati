import 'package:flutter/material.dart';
import 'package:hakawati/core/utils/styles.dart';

class CustomTextButton extends StatelessWidget {
  final String btnText;
  final VoidCallback? onPressed;
  const CustomTextButton({
    super.key,
    required this.btnText,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        btnText,
        style: Styles.fontStyle14.copyWith(
          decoration: TextDecoration.underline,
          decorationColor: Colors.yellow,
          color: Colors.yellow,
        ),
      ),
    );
  }
}
