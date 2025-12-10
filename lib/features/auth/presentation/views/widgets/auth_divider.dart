import 'package:flutter/material.dart';
import 'package:hakawati/core/utils/styles.dart';

class AuthDivider extends StatelessWidget {
  const AuthDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Expanded(child: Divider()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'OR',
            style: Styles.fontStyle14(context).copyWith(fontWeight: FontWeight.w600),
          ),
        ),
        const Expanded(child: Divider()),
      ],
    );
  }
}
