import 'package:flutter/material.dart';
import 'package:hakawati/core/utils/styles.dart';

void showSnackBar(BuildContext context, String text, {bool isError = false}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      behavior: SnackBarBehavior.floating,
      // margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      backgroundColor: isError ? Colors.red : Colors.purple.shade800,
      showCloseIcon: true,
      closeIconColor: Colors.grey,
      // action: SnackBarAction(label: 'Ignore', onPressed: () {}),
      content: Text(
        text,
        style: Styles.fontStyle16(context)
            .copyWith(fontWeight: FontWeight.w400, color: isError ? Colors.black : Colors.white),
        textAlign: TextAlign.center,
      )));
}
