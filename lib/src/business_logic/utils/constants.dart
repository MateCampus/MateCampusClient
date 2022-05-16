import 'dart:io';
import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/utils/college_data.dart';
import 'package:zamongcampus/src/business_logic/utils/major_data.dart';
import 'package:zamongcampus/src/config/size_config.dart';

// 상수

// 컬러
const kPrimaryColor = Color(0xFFFF8655);
const kSecondaryColor = Color(0xFFFE6D8E);
const kTextColor = Color(0xFF3F4168);
const kIconColor = Color(0xFF5E5E5E);
const kTextLightColor = Color(0xFF9A9BB2);
const kFillStarColor = Color(0xFFFCC419);
const kBackgroundColor = Color(0xFFFFF9F7); // 옅은 회색

// 기본 padding 값
const kDefaultPadding = 20.0;

//새로운 padding 값 (사용중)
EdgeInsetsGeometry defaultPadding = EdgeInsets.fromLTRB(
    getProportionateScreenWidth(20),
    getProportionateScreenHeight(10),
    getProportionateScreenWidth(20),
    getProportionateScreenHeight(25));

// 새로운 컬러
const mainColor = Color(0xFFFF6F5E); //사용중
const subColor = Color(0xFFFFC45E); //사용중
const containerBackColor = Color(0xFFF7F4F4);
const normaltextColor = Color(0xFF363636);

// shadow => custom_bottom_navbar에서 쓰던데 무슨 용도일까나?
final kDefualtShadow = BoxShadow(
  offset: const Offset(5, 5),
  blurRadius: 10,
  color: const Color(0xFFE9E9E9).withOpacity(0.56),
);

const kDefaultShadow = BoxShadow(
  offset: Offset(0, 4),
  blurRadius: 4,
  color: Colors.black26,
);

// server
// final devServer = Platform.isAndroid
//     ? "https://febf-211-198-109-254.ngrok.io"
//     : "https://a0fa-175-223-33-165.ngrok.io";
final devServer =
    Platform.isAndroid ? "http://10.0.2.2:8080" : "http://localhost:8080";

const dankookEmail = "@dankook.ac.kr";

const appId = "1db42f592687465e9ad1564ae4b55221";
var token =
    "0061db42f592687465e9ad1564ae4b55221IAAgLYU6hd31ueZLHDAYTtKXBPmAoCySl+IrUk4FaqHxLei/5GcAAAAAEAAg4mLWC7RDYgEAAQALtENi";

//대학교 리스트
const collegeList = [
  College.college0001,
  College.college0002,
  College.college0003,
  College.college0004,
  College.college0005,
  College.college0006,
  College.college0007
];

//학과 리스트
const majorList = [
  Major.major0001,
  Major.major0002,
  Major.major0003,
  Major.major0004,
  Major.major0005,
  Major.major0006,
  Major.major0007
];
