import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zamongcampus/src/config/size_config.dart';

class CustomAlertDialog extends StatelessWidget {
  Widget? titleWidget;
  final Widget contentWidget;
  final GestureTapCallback press;
  final String btnText;
  CustomAlertDialog(
      {Key? key,
      this.titleWidget,
      required this.contentWidget,
      required this.press,
      required this.btnText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context: context);
    return CupertinoAlertDialog(
      //타이틀 부분 ->아마 거의 안쓸거 같아서 ..
      title: titleWidget,

      content: contentWidget,
      actions: [
        _cancleBtn(context),
        _customBtn(context),
      ],
    );
  }

  Widget _cancleBtn(BuildContext context) {
    return CupertinoDialogAction(
      onPressed: () {
        Navigator.pop(context);
      },
      child: const Text('취소'),
      textStyle: TextStyle(
        fontSize: getProportionateScreenWidth(12),
      ),
    );
  }

  Widget _customBtn(BuildContext context) {
    return CupertinoDialogAction(
      onPressed: press,
      child: Text(btnText),
      textStyle: TextStyle(
          fontSize: getProportionateScreenWidth(12), color: Colors.red),
    );
  }
}
