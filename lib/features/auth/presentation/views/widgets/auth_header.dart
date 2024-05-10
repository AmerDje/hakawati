import 'package:flutter/material.dart';
import 'package:hakawati/core/utils/utils.dart';
import 'package:hakawati/core/widgets/widgets.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
        body: Stack(
      alignment: AlignmentDirectional.center,
      children: [
        PositionedDirectional(
          top: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            child: Text(
              Strings.appName,
              style: Styles.fontStyle54(context).copyWith(
                color: Theme.of(context).secondaryHeaderColor,
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: GlassFilter(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: SingleChildScrollView(
                child: child,
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
