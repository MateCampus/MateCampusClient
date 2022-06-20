import 'package:flutter/material.dart';
import 'package:zamongcampus/src/config/size_config.dart';

class CustomDragBar extends StatelessWidget {
  const CustomDragBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(5.5)),
      height: getProportionateScreenHeight(4),
      width: getProportionateScreenWidth(36),
      decoration: const BoxDecoration(
          color: Color(0xffe2e2e2),
          borderRadius: BorderRadius.all(Radius.circular(20))),
    );
  }
}
