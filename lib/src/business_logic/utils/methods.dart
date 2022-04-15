import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// snackbar => 해결 필요.
void snackBar(
    {required BuildContext context,
    required String message,
    Color color = Colors.redAccent}) {
  final snackBar = SnackBar(
    content: Text(message),
    backgroundColor: color,
  );
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);
}

// toast
void toastMessage(String message) {
  Fluttertoast.showToast(
      msg: message,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.black87,
      fontSize: 15.0,
      textColor: Colors.white,
      toastLength: Toast.LENGTH_SHORT);
}

// back and toast
void backWithToast(message, BuildContext context) {
  Navigator.pop(context);
  toastMessage(message);
}

void showCustomModalBottomSheet(BuildContext context, Widget widget) {
  showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return widget;
      });
}
