import 'package:flutter/material.dart';

void showLoadingDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    barrierDismissible: true,
    useSafeArea: true,
    builder: (BuildContext context) {
      return Dialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(
              height: 10,
            ),
            Text(message),
          ],
        ),
      );
    },
  );
}
