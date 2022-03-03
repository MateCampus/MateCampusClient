import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/config/size_config.dart';

class DefaultBtn extends StatelessWidget {
  final String text;
  final GestureTapCallback press;
  final double? width;
  final double? height;
  final double? fontsize;

  const DefaultBtn(
      {Key? key,
      required this.text,
      required this.press,
      this.width,
      this.height,
      this.fontsize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: press,
      child: Text(text),
      style: TextButton.styleFrom(
          primary: Colors.white,
          minimumSize: Size(width ?? getProportionateScreenWidth(335),
              height ?? getProportionateScreenHeight(56)),
          backgroundColor: mainColor,
          textStyle: TextStyle(fontSize: fontsize ?? 14.0)),
    );
  }
}
