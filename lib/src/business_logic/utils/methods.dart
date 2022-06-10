import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/ui/common_widgets/custom_dialog_for_notice.dart';

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
      isScrollControlled: true,
      //isDismissible: isScrollControlled,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return widget;
      });
}

//회원가입에서 유저 생성 함수안에서 사용
//마이페이지에서 관심사 변경 적용할때 사용
//이름이 헷갈려서 buildShowDialog -> buildShowDialogForLoading 으로 변경
//무언가 로딩하거나, 아니면 만들어질때까지(적용될때까지) 기다릴때 사용
void buildShowDialogForLoading(BuildContext context) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(
            color: mainColor,
          ),
        );
      });
}

//간단한 경고용으로 사용
//ex) post_create에서 사진 10장 이상 못올린다고 알려줄때
//buildWidget은 common_widget의 CustomDialogForNotice을 사용
//확인버튼만 있고 누르면 무조건 pop
void buildShowDialogForNotice(
    {required BuildContext context, required String description}) {
  showDialog(
      context: context,
      barrierColor: Colors.black26, //배경색
      builder: (BuildContext context) {
        return CustomDialogForNotice(description: description);
      });
}
