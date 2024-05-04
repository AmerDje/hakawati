import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hakawati/core/utils/styles.dart';

class PrivacyAndConditions extends StatelessWidget {
  const PrivacyAndConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: "By continuing you agree the",
        children: [
          TextSpan(
              text: " Terms and Conditions",
              style: TextStyle(color: Theme.of(context).secondaryHeaderColor),
              recognizer: TapGestureRecognizer()
                ..onTap = () =>
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const TermsAndConditions()))),
          const TextSpan(text: " and "),
          TextSpan(
              text: "Privacy Policy",
              style: TextStyle(color: Theme.of(context).secondaryHeaderColor),
              recognizer: TapGestureRecognizer()
                ..onTap =
                    () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const PrivacyAndPolicy())))
        ],
        style: Styles.fontStyle16(context),
      ),
    );
  }
}

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class PrivacyAndPolicy extends StatelessWidget {
  const PrivacyAndPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
