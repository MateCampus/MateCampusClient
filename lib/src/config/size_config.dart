import 'package:flutter/material.dart';

// 사이즈 관련 기능
// 화면크기에 따라 적용되도록, 추후 pixel -> getProportionate으로 변경

class SizeConfig {
  static MediaQueryData? _mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;
  static double? defaultSize;
  static Orientation? orientation;

  void init({required BuildContext context}) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData!.size.width;
    screenHeight = _mediaQueryData!.size.height;
    orientation = _mediaQueryData!.orientation;
  }
  // 세로 최대 815, 가로 기준 414
}

// 세로 300, 가로 100
// getPro~~height(300)
// getPro~~height(100) 1/3
// getPro~~height(30) 1/10
// 세로 815
// getProheight(407.5) 1/2
// Get the proportionate height as per screen size
double getProportionateScreenHeight(double inputHeight) {
  double screenHeight = SizeConfig.screenHeight!;
  // Our designer use iPhone 11 Pro, that's why we use 815.0 -> 812.0으로 변경
  return (inputHeight / 812.0) * screenHeight;
}

// Get the proportionate height as per screen size
double getProportionateScreenWidth(double inputWidth) {
  double screenWidth = SizeConfig.screenWidth!;
  // 375 is the layout width that designer use or you can say iPhone 11 Pro width
  return (inputWidth / 375.0) * screenWidth;
}
