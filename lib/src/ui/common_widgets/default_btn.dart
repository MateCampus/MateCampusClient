import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/config/size_config.dart';

class DefaultBtn extends StatelessWidget {
  final String text;
  final GestureTapCallback? press;
  final double? width;
  final double? height;
  final double? fontsize;
  final Color? btnColor;
  final Color? textColor;
  final Color? borderColor;

  const DefaultBtn(
      {Key? key,
      required this.text,
      this.press,
      this.width,
      this.height,
      this.fontsize,
      this.btnColor,
      this.textColor,
      this.borderColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: press,
      child: Text(text),
      style: TextButton.styleFrom(
          primary: textColor ?? Colors.white,
          minimumSize: Size(width ?? getProportionateScreenWidth(335),
              height ?? getProportionateScreenHeight(56)),
          backgroundColor: btnColor ?? mainColor,
          side: (borderColor != null) ? BorderSide(color: borderColor!) : null,
          textStyle: TextStyle(
              fontSize: fontsize ?? getProportionateScreenHeight(14.0),
              fontWeight: FontWeight.bold)),
    );
  }
}
