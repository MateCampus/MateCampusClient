import 'dart:math';

import 'package:zamongcampus/src/business_logic/models/chat_message.dart';
import 'package:zamongcampus/src/business_logic/models/post.dart';
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

List<Post> postDummy1 = [
  Post(
      id: 1,
      loginId: "sye",
      categories: categoryDummy[Random().nextInt(2)],
      title: "제 이상형을 찾은것 같아요!",
      userNickname: "폼포코팡팡",
      body:
          "저는 묶은머리를 좋아해요. 뒷머리는 산뜻하게 묶고 옆머리는 흘러내리는 얼마전에 동기가 그 머리를 하고 왔어요. 완전 내 이상형",
      createdAt: DateTime(2022, 2, 3),
      likedCount: 874,
      viewCount: 3123,
      commentCount: 671,
      imageUrls: null),
  Post(
      id: 2,
      loginId: "zamong",
      categories: categoryDummy[Random().nextInt(2)],
      title: "줄서서 기다리는 단국대 맛집",
      userNickname: "자몽쟁이",
      body:
          "점심마다 메뉴가 고민된다면, 제가 먹어본 단국대 맛집을 소개합니다! 제가 입이 짧아서 맛집이라고 생각하는 곳이 잘 없는데 여기는 대박이에요",
      createdAt: DateTime(2022, 2, 13),
      likedCount: 789,
      viewCount: 2132,
      commentCount: 345,
      imageUrls: [
        "assets/images/event/event1.jpg",
        "assets/images/event/event2.jpg"
      ]),
  Post(
      id: 3,
      loginId: "suss",
      categories: categoryDummy[Random().nextInt(2)],
      title: "고양이들이 코 박고 자는 이유",
      userNickname: "미완성작품",
      body:
          "고양이들 코 시려우면 이런대ㅇㅇ 근데 추워서라기보단 흥분해서 코가 촉촉해지면 그러는거임. 너무 귀엽지 않니? 그런의미에서 우리 집 고양이 사진 올려두고감",
      createdAt: DateTime(2022, 1, 31),
      likedCount: 688,
      viewCount: 897,
      commentCount: 156,
      imageUrls: null),
  Post(
      id: 3,
      loginId: "suss",
      categories: categoryDummy[Random().nextInt(2)],
      title: "고양이들이 코 박고 자는 이유",
      userNickname: "미완성작품",
      body:
          "고양이들 코 시려우면 이런대ㅇㅇ 근데 추워서라기보단 흥분해서 코가 촉촉해지면 그러는거임. 너무 귀엽지 않니? 그런의미에서 우리 집 고양이 사진 올려두고감",
      createdAt: DateTime(2022, 1, 31),
      likedCount: 688,
      viewCount: 897,
      commentCount: 156,
      imageUrls: null),
  Post(
      id: 3,
      loginId: "suss",
      categories: categoryDummy[Random().nextInt(2)],
      title: "고양이들이 코 박고 자는 이유",
      userNickname: "미완성작품",
      body:
          "고양이들 코 시려우면 이런대ㅇㅇ 근데 추워서라기보단 흥분해서 코가 촉촉해지면 그러는거임. 너무 귀엽지 않니? 그런의미에서 우리 집 고양이 사진 올려두고감",
      createdAt: DateTime(2022, 1, 31),
      likedCount: 688,
      viewCount: 897,
      commentCount: 156,
      imageUrls: null),
  Post(
      id: 3,
      loginId: "suss",
      categories: categoryDummy[Random().nextInt(2)],
      title: "고양이들이 코 박고 자는 이유",
      userNickname: "미완성작품",
      body:
          "고양이들 코 시려우면 이런대ㅇㅇ 근데 추워서라기보단 흥분해서 코가 촉촉해지면 그러는거임. 너무 귀엽지 않니? 그런의미에서 우리 집 고양이 사진 올려두고감",
      createdAt: DateTime(2022, 1, 31),
      likedCount: 688,
      viewCount: 897,
      commentCount: 156,
      imageUrls: null),
];
