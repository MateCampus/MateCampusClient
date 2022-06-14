import 'package:flutter/cupertino.dart';
import 'package:zamongcampus/src/config/size_config.dart';

class CustomAlertDialog extends StatelessWidget {
  Widget? titleWidget;
  final String contentText;
  final GestureTapCallback press;
  final String btnText;
  CustomAlertDialog(
      {Key? key,
      this.titleWidget,
      required this.contentText,
      required this.press,
      required this.btnText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context: context);
    return CupertinoAlertDialog(
      //타이틀 부분 ->아마 거의 안쓸거 같아서 ..
      title: titleWidget,

      content: Text(
        contentText,
        style: TextStyle(fontSize: getProportionateScreenWidth(14)),
      ),
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
        fontSize: getProportionateScreenWidth(12),
      ),
    );
  }
}
