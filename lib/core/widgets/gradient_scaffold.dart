import 'package:flutter/material.dart';
import 'package:hakawati/core/utils/utils.dart';

class GradientScaffold extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;

  const GradientScaffold({super.key, this.body = const SizedBox(), this.appBar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: null,
      body: Container(
        decoration: Constants.kGradientScaffoldDecoration,
        child: SafeArea(
          child: Column(
            children: [
              if (appBar != null) Container(child: appBar),
              Expanded(child: body),
            ],
          ),
        ),
      ),
    );
  }
}
