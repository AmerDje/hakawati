import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      backgroundColor: Colors.blueGrey,
      elevation: 10,
      showCloseIcon: true,
      closeIconColor: Colors.grey,
      // action: SnackBarAction(label: 'Ignore', onPressed: () {}),
      content: Text(
        text,
        textAlign: TextAlign.center,
      )));
}
