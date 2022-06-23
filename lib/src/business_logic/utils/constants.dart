import 'dart:io';

import 'package:zamongcampus/src/business_logic/utils/college_data.dart';
import 'package:zamongcampus/src/business_logic/utils/major_data.dart';
import 'package:zamongcampus/src/config/size_config.dart';

import '../models/enums/collegeCode.dart';
import '../models/enums/interestCode.dart';
import '../models/enums/majorCode.dart';

// 상수

//가로패딩 값.(사용중)
double kHorizontalPadding = getProportionateScreenWidth(20);

// server
// final devServer = Platform.isAndroid
//     ? "https://109e-211-198-109-254.ngrok.io"
//     : "https://109e-211-198-109-254.ngrok.io";

final devServer =
    Platform.isAndroid ? "http://10.0.2.2:8080" : "http://localhost:8080";

// final devServer =
//     Platform.isAndroid ? "http://3.36.41.198:8080" : "http://3.36.41.198:8080";

const dankookEmail = "@dankook.ac.kr";

//대학교 리스트
const collegeList = [
  CollegeCode.college0001,
  CollegeCode.college0002,
  CollegeCode.college0003,
  CollegeCode.college0004,
  CollegeCode.college0005,
  CollegeCode.college0006,
  CollegeCode.college0007
];

//학과 리스트
const majorList = [
  MajorCode.major0001,
  MajorCode.major0002,
  MajorCode.major0003,
  MajorCode.major0004,
  MajorCode.major0005,
  MajorCode.major0006,
  MajorCode.major0007
];

//관심사 리스트
const allInterestList = [
  InterestCode.interest0001,
  InterestCode.interest0002,
  InterestCode.interest0003,
  InterestCode.interest0004,
  InterestCode.interest0005,
  InterestCode.interest0006,
  InterestCode.interest0007,
  InterestCode.interest0008,
  InterestCode.interest0009,
  InterestCode.interest0010,
  InterestCode.interest0011,
  InterestCode.interest0012,
  InterestCode.interest0013,
  InterestCode.interest0014,
  InterestCode.interest0015,
  InterestCode.interest0016,
];
const appIdForAgora = "1db42f592687465e9ad1564ae4b55221";
