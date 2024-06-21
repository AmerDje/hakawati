import 'package:flutter/material.dart';
import 'package:hakawati/core/utils/utils.dart';

class CustomElevatedIconButton extends StatelessWidget {
  const CustomElevatedIconButton({super.key, required this.text, required this.icon, required this.onPressed});
  final String text;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            elevation: 0,
            fixedSize: Size(context.width, 50),
            shape: const RoundedRectangleBorder(
              borderRadius: Constants.kCircularRadius12,
            )),
        onPressed: onPressed,
        label: Text(
          text,
          style: Styles.fontStyle18(context).copyWith(color: Theme.of(context).secondaryHeaderColor),
        ),
        icon: Icon(icon, color: Theme.of(context).secondaryHeaderColor));
  }
}
