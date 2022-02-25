import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// snackbar
void snackBar({required String message, Color color = Colors.redAccent}) {
  SnackBar(
      content: Text(message),
      backgroundColor: color,
      action: SnackBarAction(
        label: '취소',
        onPressed: () {
          // Some code to undo the change.
        },
      ));
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
