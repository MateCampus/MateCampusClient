import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_components/custom_alert_dialog_components/custom_alert_dialog.dart';
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

//이름이 헷갈려서 buildShowDialog -> buildShowDialogForLoading 으로 변경
//무언가 로딩하거나, 아니면 만들어질때까지(적용될때까지) 기다릴때 사용
//barrierColor를 Colors.transparent로 두면 overlay 같은 효과를 줄 수 있음 -> 포스트에서 댓글 생성할때 사용, 포스트메인에서 게시물 정보 추가 로드할 때 사용 가능
//단점 dialog를 빌드하면서 위젯트리를 하나 더 쌓기 때문에 자동으로 사라지는게 아니라 적절하게 pop을 써줘야함..
void buildShowDialogForLoading(
    {required BuildContext context, Color? barrierColor}) {
  showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: barrierColor ?? Colors.black54,
      builder: (BuildContext context) {
        return Center(
          child: SpinKitFadingCube(
            color: kMainColor,
            size: getProportionateScreenHeight(25),
          ),
        );
      });
}

//간단한 경고용으로 사용
//ex) post_create에서 사진 10장 이상 못올린다고 알려줄때
//buildWidget은 common_widget의 CustomDialogForNotice을 사용
//확인버튼만 있고 누르면 무조건 pop
void buildDialogForNotice(
    {required BuildContext context, required String description}) {
  showDialog(
      context: context,
      barrierColor: Colors.black38, //배경색
      builder: (BuildContext context) {
        return CustomDialogForNotice(description: description);
      });
}

///버튼이 최소 2개 이상일때 사용 (버튼을 눌렀을 때 동작하는 함수가 있을 때 사용)
///(취소/확인) 이렇게 두개가 있어야할때는 무조건 취소가 왼쪽, 확인이 오른쪽이며 취소는 텍스트, onpress모두 고정. onpress는 무조건 pop
/// 확인에 대한 text와 onpress는 변수로 둠.
void buildCustomAlertDialog({
  required BuildContext context,
  required String contentText,
  required GestureTapCallback press,
  required String btnText,
  Widget? titleWidget,
}) {
  showDialog(
      context: context,
      barrierColor: Colors.black38, //배경색
      builder: (BuildContext context) {
        return CustomAlertDialog(
          titleWidget: titleWidget,
          contentText: contentText,
          btnText: btnText,
          press: press,
        );
      });
}
