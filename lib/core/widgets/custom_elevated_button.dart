import 'package:flutter/material.dart';
import 'package:hakawati/core/utils/utils.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final Size? fixedSize;

  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.fixedSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: fixedSize?.height,
      width: fixedSize?.width,
      decoration: const BoxDecoration(
        borderRadius: Constants.kCircularRadius12,
        gradient: LinearGradient(
          colors: [
            AppColors.buttonGradientColor1,
            AppColors.buttonGradientColor2,
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          fixedSize: fixedSize ?? Size(context.width, 50),
          side: BorderSide(width: 1, color: Theme.of(context).secondaryHeaderColor),
          shape: const RoundedRectangleBorder(
            borderRadius: Constants.kCircularRadius12,
          ),
        ),
        child: child,
      ),
    );
  }
}
