
import 'package:flutter/material.dart';
import 'package:hakawati/core/utils/styles.dart';

class ProfileListTile extends StatelessWidget {
  const ProfileListTile({
    super.key,
    required this.title,
    required this.icon,
    this.onPressed,
    this.subtitle,
    this.trailing = const Icon(
      Icons.chevron_right_outlined,
      size: 35,
    ),
  });
  final String title;
  final String? subtitle;
  final IconData icon;
  final VoidCallback? onPressed;
  final Widget trailing;
  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: onPressed,
        horizontalTitleGap: 20,
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        title: Text(
          title,
          style: Styles.fontStyle18(context),
        ),
        subtitle: (subtitle?.isEmpty ?? true)
            ? null
            : Text(
                subtitle!,
                style: Styles.fontStyle14(context),
              ),
        leading: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.deepPurple,
            ),
            child: Icon(
              icon,
              size: 25,
            )),
        trailing: trailing);
  }
}
