import 'package:flutter/material.dart';
import 'package:hakawati/core/utils/styles.dart';

class CustomTextButton extends StatelessWidget {
  final String btnText;
  final VoidCallback? onPressed;
  final bool applyUnderLine;
  const CustomTextButton({
    super.key,
    required this.btnText,
    this.onPressed,
     this.applyUnderLine = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        btnText,
        style: Styles.fontStyle14(context).copyWith(
          decoration: applyUnderLine ? TextDecoration.underline : null,
          decorationColor: Colors.yellow,
          color: Colors.yellow,
        ),
      ),
    );
  }
}
