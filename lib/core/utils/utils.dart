import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast(String message, {BuildContext? context}) {
  final colorScheme = context == null ? null : Theme.of(context).colorScheme;
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: colorScheme?.surfaceContainerHighest ?? Colors.black87,
      textColor: colorScheme?.onSurface ?? Colors.white,
      fontSize: 16.0);
}
