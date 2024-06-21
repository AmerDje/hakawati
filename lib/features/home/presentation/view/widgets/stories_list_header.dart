import 'package:flutter/material.dart';
import 'package:hakawati/core/utils/utils.dart';
import 'package:hakawati/core/widgets/widgets.dart';

class StoriesListHeader extends StatelessWidget {
  const StoriesListHeader({
    super.key,
    required this.headTitle,
    required this.onViewAllPressed,
  });
  final String headTitle;
  final VoidCallback onViewAllPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(headTitle, style: Styles.fontStyle32(context)),
        CustomTextButton(btnText: 'View All', onPressed: onViewAllPressed),
      ],
    );
  }
}
