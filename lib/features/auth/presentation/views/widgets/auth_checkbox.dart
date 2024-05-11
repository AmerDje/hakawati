import 'package:flutter/material.dart';
import 'package:hakawati/core/utils/utils.dart';
import 'package:hakawati/core/widgets/widgets.dart';

class AuthCheckbox extends StatelessWidget {
  final bool checkValue;
  final String? text;
  final void Function(bool?) onChanged;
  final VoidCallback? onPressed;
  final String? btnText;
  final Widget? widget;
  const AuthCheckbox({
    super.key,
    required this.checkValue,
    required this.onChanged,
    this.text,
    this.onPressed,
    this.btnText,
    this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 24.0,
          width: 24.0,
          child: Checkbox.adaptive(
              shape: const RoundedRectangleBorder(borderRadius: Constants.kCircularRadius6),
              value: checkValue,
              onChanged: onChanged),
        ),
        if (widget != null) ...[
          const SizedBox(
            width: 15,
          ),
          widget!
        ] else ...[
          Text(" $text", style: Styles.fontStyle16(context)),
          const Spacer(),
          CustomTextButton(
            btnText: btnText!,
            onPressed: onPressed,
          ),
        ]
      ],
    );
  }
}
