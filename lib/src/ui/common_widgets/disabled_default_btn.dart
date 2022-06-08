import 'package:flutter/material.dart';
import 'package:zamongcampus/src/config/size_config.dart';

class DisabledDefaultBtn extends StatelessWidget {
  final String text;
  final double? width;
  final double? height;
  const DisabledDefaultBtn(
      {Key? key, required this.text, this.height, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: null,
      child: Text(text),
      style: TextButton.styleFrom(
          minimumSize: Size(width ?? getProportionateScreenWidth(335),
              height ?? getProportionateScreenHeight(56)),
          backgroundColor: Colors.grey.withOpacity(0.4),
          textStyle: TextStyle(
              fontSize: getProportionateScreenHeight(14.0),
              fontWeight: FontWeight.bold)),
    );
  }
}
