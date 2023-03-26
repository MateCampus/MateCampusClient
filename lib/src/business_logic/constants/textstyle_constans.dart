import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/config/size_config.dart';

TextStyle kPostBodyStyle = TextStyle(
    fontSize: resizeFont(14.5), color: Colors.grey.shade900, height: 1.5);

TextStyle kPostCommentBodyStyle = TextStyle(
    fontSize: resizeFont(13),
    color: Color(0xff111111),
    fontWeight: FontWeight.w400,
    height: 1.3);

TextStyle kBottomNavigationBarTextStyleDeactive = TextStyle(
    fontSize: resizeFont(11),
    color: Color(0xff767676),
    fontWeight: FontWeight.w400);

TextStyle kBottomNavigationBarTextStyleActive = TextStyle(
    fontSize: resizeFont(11), color: kMainColor, fontWeight: FontWeight.w400);

TextStyle kLabelTextStyle = TextStyle(
    fontSize: resizeFont(13),
    color: const Color(0xFF111111),
    fontWeight: FontWeight.w700);
