import 'package:flutter/material.dart';
import 'package:zamongcampus/src/config/size_config.dart';

const kMainColor = Color(0xFFFF6F5E);
const kSubColor = Color(0xFFFFC45E);
final kAppBarIconColor = Colors.black.withOpacity(0.7);
final kAppBarTextColor = Colors.black.withOpacity(0.9);
const kMainScreenBackgroundColor = Color(0xfff8f8f8);
const kSubScreenBackgroundColor = Colors.white;
const kPostBtnColor = Color(0xff818181);

const kTextFieldColor = Color(0xfff8f8f8); //나중에 테두리랑 나눠서 써야하면 이름 바꾸기

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
