import 'package:flutter/material.dart';
import 'package:hakawati/core/utils/utils.dart';
import 'package:hakawati/core/widgets/widgets.dart';

class AuthBottom extends StatelessWidget {
  const AuthBottom({
    super.key,
    required this.text,
    required this.onPressed,
    required this.btnText,
  });
  final String text, btnText;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(text, style: Styles.fontStyle16(context)),
        CustomTextButton(
          btnText: btnText,
          onPressed: onPressed,
        )
      ],
    );
  }
}
