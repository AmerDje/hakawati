import 'package:flutter/material.dart';
import 'package:hakawati/core/utils/utils.dart';
import 'package:hakawati/core/widgets/widgets.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
        body: Align(
      alignment: Alignment.bottomCenter,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              Strings.appName,
              style: Styles.fontStyle54(context).copyWith(
                color: Theme.of(context).secondaryHeaderColor,
              ),
            ),
            SizedBox(
              height: context.height * .15,
            ),
            GlassFilter(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: child,
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
