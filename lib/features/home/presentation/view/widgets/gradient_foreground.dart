import 'package:flutter/material.dart';
import 'package:hakawati/core/utils/utils.dart';

class GradientForeground extends StatelessWidget {
  const GradientForeground({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: const LinearGradient(
          colors: [AppColors.gradientColor1, Colors.transparent],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
    );
  }
}
