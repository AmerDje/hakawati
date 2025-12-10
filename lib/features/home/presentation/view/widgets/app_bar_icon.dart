import 'package:flutter/material.dart';

class AppBarIcon extends StatelessWidget {
  const AppBarIcon({
    super.key,
    required this.icon,
    required this.onPressed,
  });
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 27,
      backgroundColor: Colors.grey.shade600.withOpacity(.5),
      child: IconButton(
        padding: EdgeInsets.zero,
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: Colors.white,
          size: 25,
        ),
      ),
    );
  }
}
