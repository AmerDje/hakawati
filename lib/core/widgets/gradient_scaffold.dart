import 'package:flutter/material.dart';
import 'package:hakawati/core/utils/colors.dart';

class GradientScaffold extends StatelessWidget {
  final Widget body;

  const GradientScaffold({Key? key, required this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: null,
      backgroundColor: null,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.gradientColor1,
              AppColors.gradientColor2,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: body,
        ),
      ),
    );
  }
}
