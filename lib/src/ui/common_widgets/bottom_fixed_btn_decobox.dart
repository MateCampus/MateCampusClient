//사용중
//하단 고정되는 버튼에 대해서 padding 값과 shadow값을 주기위한 위젯

import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/config/size_config.dart';

class BottomFixedBtnDecoBox extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  const BottomFixedBtnDecoBox(
      {Key? key, required this.child, this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(
          horizontal: kHorizontalPadding,
          vertical: getProportionateScreenHeight(10)),
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        boxShadow: [kDefaultShadowOnlyTop],
      ),
      child: child,
    );
  }
}
