import 'package:flutter/material.dart';

void showSnackbar(BuildContext context, String message, Color backgroundColor) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
    backgroundColor: backgroundColor,
    duration: const Duration(seconds: 3),
  ));
}
