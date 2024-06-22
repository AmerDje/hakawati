import 'package:flutter/material.dart';

class EdgeButton extends StatelessWidget {
  const EdgeButton({
    super.key,
    required this.onPressed,
    required this.iconData,
  });
  final VoidCallback onPressed;
  final IconData iconData;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 20,
      child: IconButton(
          padding: EdgeInsets.zero,
          onPressed: onPressed,
          icon: Icon(
            iconData,
            color: Colors.blueGrey.shade200,
            size: 25,
          )),
    );
  }
}
