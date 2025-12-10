import 'package:flutter/material.dart';

void showToast(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.grey.shade800,
      elevation: 10,
    ),
  );
}
