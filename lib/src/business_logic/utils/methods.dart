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
      backgroundColor: Colors.black.withOpacity(0.75),
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
      //isScrollControlled: isScrollControlled,  //isScrollControlled는 ModalBottomSheet의 높이를 기본 높이보다 길게 하고 싶을 때 추가로 설정해야하는 프로퍼티
      //isDismissible: isScrollControlled,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return widget;
      });
}

void buildShowDialog(BuildContext context) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      });
}
