import 'package:flutter/material.dart';
import 'package:zamongcampus/src/config/size_config.dart';

const kMainColor = Color(0xFFFF6F5E);
const kSubColor = Color(0xFFFFC45E);
const kAppBarIconColor = Color(0xff111111);
const kAppBarTextColor = Color(0xff111111);
const kMainScreenBackgroundColor = Colors.white;
const kSubScreenBackgroundColor = Colors.white;
const kPostBtnColor = Color(0xff818181);

const kTextFieldColor = Color(0xfff8f8f8); //텍스트 필드 내부 색
const kTextFieldHintColor = Color(0xffADADAD); // 텍스트 필드 힌트 텍스트, 혹은 아이콘 색

final kDefaultShadowOnlyTop = BoxShadow(
  color: Colors.grey.withOpacity(0.1),
  offset: Offset(0, -getProportionateScreenHeight(5)),
  blurRadius: 3,
);

final kShadowForTile = BoxShadow(
  color: Colors.grey.withOpacity(0.1),
  blurRadius: 5,
  spreadRadius: 1,
);

class Palette {
  static const MaterialColor kToDark = MaterialColor(
    0xffff6f5e, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0xffe66455), //10%
      100: Color(0xffcc594b), //20%
      200: Color(0xffb34e42), //30%
      300: Color(0xff994338), //40%
      400: Color(0xff80382f), //50%
      500: Color(0xff662c26), //60%
      600: Color(0xff4c211c), //70%
      700: Color(0xff331613), //80%
      800: Color(0xff190b09), //90%
      900: Color(0xff000000), //100%
    },
  );
}
