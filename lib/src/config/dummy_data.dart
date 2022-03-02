import 'dart:math';

import 'package:zamongcampus/src/business_logic/models/chat_message.dart';
import 'package:zamongcampus/src/business_logic/models/user.dart';
import 'package:zamongcampus/src/business_logic/utils/category_data.dart';
import 'package:zamongcampus/src/business_logic/utils/college_data.dart';
import 'package:zamongcampus/src/business_logic/utils/major_data.dart';

List<User> userDummy = [
  const User(
      loginId: "zm1",
      nickname: "가나초코릿",
      collegeCode: College.college0001,
      imageUrls: [
        "assets/images/user/user1.jpg",
        "assets/images/user/user2.jpg"
      ],
      majorCode: Major.major0001,
      isOnline: true),
  const User(
      loginId: "zm2",
      nickname: "나비야훨훨",
      collegeCode: College.college0002,
      imageUrls: ["assets/images/user/user2.jpg"],
      majorCode: Major.major0002,
      isOnline: true),
  const User(
      loginId: "zm3",
      nickname: "다부지",
      collegeCode: College.college0003,
      imageUrls: ["assets/images/user/user3.jpg"],
      majorCode: Major.major0003,
      isOnline: false),
  const User(
      loginId: "zm4",
      nickname: "라디오꾼",
      collegeCode: College.college0004,
      imageUrls: ["assets/images/user/user4.jpg"],
      majorCode: Major.major0004,
      isOnline: false),
  const User(
      loginId: "zm5",
      nickname: "마라탕궈",
      collegeCode: College.college0005,
      imageUrls: ["assets/images/user/user5.jpg"],
      majorCode: Major.major0005,
      isOnline: false),
];

List<User> userDummy2 = [
  const User(
      loginId: "zm6",
      nickname: "바나나",
      collegeCode: College.college0001,
      imageUrls: [
        "assets/images/user/user1.jpg",
        "assets/images/user/user2.jpg"
      ],
      majorCode: Major.major0001,
      isOnline: true),
  const User(
      loginId: "zm7",
      nickname: "사이다",
      collegeCode: College.college0002,
      imageUrls: ["assets/images/user/user2.jpg"],
      majorCode: Major.major0002,
      isOnline: true),
];
List<List<Category>> categoryDummy = [
  [Category.c0010, Category.c0002],
  [Category.c0003, Category.c0009],
  [Category.c0005, Category.c0007]
];

List<ChatMessage> chatMessageDummy = [
  ChatMessage(
      roomId: "1",
      loginId: "zm1",
      text: "하이루~",
      type: ChatMessageType.talk,
      createdAt: DateTime(2022, 02, 15)),
  ChatMessage(
      roomId: "1",
      loginId: "zm2",
      text: "방가방가",
      type: ChatMessageType.talk,
      createdAt: DateTime(2022, 02, 16)),
  ChatMessage(
      roomId: "1",
      loginId: "zm3",
      text: "헬로우",
      type: ChatMessageType.talk,
      createdAt: DateTime(2022, 02, 17)),
];
