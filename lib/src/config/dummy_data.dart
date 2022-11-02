import 'dart:math';

import 'package:zamongcampus/src/business_logic/models/chatMemberInfo.dart';
import 'package:zamongcampus/src/business_logic/models/chatMessage.dart';
import 'package:zamongcampus/src/business_logic/models/comment.dart';
import 'package:zamongcampus/src/business_logic/models/enums/postCategoryCode.dart';
import 'package:zamongcampus/src/business_logic/models/interest.dart';
import 'package:zamongcampus/src/business_logic/models/post.dart';
import 'package:zamongcampus/src/business_logic/models/user.dart';
import 'package:zamongcampus/src/business_logic/models/voice_room.dart';
import 'package:zamongcampus/src/business_logic/utils/category_data.dart';
import 'package:zamongcampus/src/business_logic/utils/college_data.dart';
import 'package:zamongcampus/src/business_logic/utils/major_data.dart';

import '../business_logic/models/enums/categoryCode.dart';
import '../business_logic/models/enums/collegeCode.dart';
import '../business_logic/models/enums/interestCode.dart';
import '../business_logic/models/enums/majorCode.dart';
import '../business_logic/models/enums/messageType.dart';

/**
 * 테스트를 위한 dummyData. 
 * 추후에 삭제할 예정
 */

List<User> userDummy = [
  User(
      loginId: "zm1",
      nickname: "가나초코릿",
      collegeCode: CollegeCode.college0001,
      imageUrl: "assets/images/user/user1.jpg",
      majorCode: MajorCode.major0001,
      introduction: "자기개발, 꾸준함, 성실한 사람 좋아해요\n저랑 잘 맞는 친구 찾구싶어요!",
      isOnline: true,
      interests: [
        Interest(codeNum: InterestCode.interest0001),
        Interest(codeNum: InterestCode.interest0004),
        Interest(codeNum: InterestCode.interest0006)
      ]),
  const User(
      loginId: "zm2",
      nickname: "나비야훨훨",
      collegeCode: CollegeCode.college0002,
      imageUrl: null,
      majorCode: MajorCode.major0002,
      isOnline: false,
      interests: []),
  const User(
      loginId: "zm3",
      nickname: "다부지",
      collegeCode: CollegeCode.college0003,
      imageUrl: "assets/images/user/user3.jpg",
      majorCode: MajorCode.major0003,
      isOnline: null,
      interests: []),
  const User(
      loginId: "zm4",
      nickname: "라디오꾼",
      collegeCode: CollegeCode.college0004,
      imageUrl: "assets/images/user/user4.jpg",
      majorCode: MajorCode.major0004,
      isOnline: false,
      interests: []),
  const User(
      loginId: "zm5",
      nickname: "마라탕궈",
      collegeCode: CollegeCode.college0005,
      imageUrl: "assets/images/user/user5.jpg",
      majorCode: MajorCode.major0005,
      isOnline: false,
      interests: []),
  const User(
      loginId: "zm6",
      nickname: "나비야훨훨",
      collegeCode: CollegeCode.college0002,
      imageUrl: null,
      majorCode: MajorCode.major0002,
      isOnline: false,
      interests: []),
  const User(
      loginId: "zm7",
      nickname: "다부지",
      collegeCode: CollegeCode.college0003,
      imageUrl: "assets/images/user/user1.jpg",
      majorCode: MajorCode.major0003,
      isOnline: null,
      interests: []),
  const User(
      loginId: "zm8",
      nickname: "라디오꾼",
      collegeCode: CollegeCode.college0004,
      imageUrl: "assets/images/user/user4.jpg",
      majorCode: MajorCode.major0004,
      isOnline: false,
      interests: []),
  const User(
      loginId: "zm9",
      nickname: "마라탕궈",
      collegeCode: CollegeCode.college0005,
      imageUrl: "assets/images/user/user5.jpg",
      majorCode: MajorCode.major0005,
      isOnline: false,
      interests: []),
];

List<User> userDummy2 = [
  const User(
      loginId: "zm10",
      nickname: "바나나2",
      collegeCode: CollegeCode.college0001,
      imageUrl: "assets/images/user/user1.jpg",
      majorCode: MajorCode.major0001,
      isOnline: true,
      interests: []),
  const User(
      loginId: "zm11",
      nickname: "사이다",
      collegeCode: CollegeCode.college0002,
      imageUrl: "assets/images/user/user2.jpg",
      majorCode: MajorCode.major0002,
      isOnline: true,
      interests: []),
];

List<User> userDummy3 = [
  const User(
      loginId: "zm10",
      nickname: "바나나2",
      collegeCode: CollegeCode.college0001,
      imageUrl: "assets/images/user/user1.jpg",
      majorCode: MajorCode.major0001,
      isOnline: true,
      interests: []),
  const User(
      loginId: "zm11",
      nickname: "나랑드사이다",
      collegeCode: CollegeCode.college0002,
      imageUrl: "assets/images/user/user2.jpg",
      majorCode: MajorCode.major0002,
      isOnline: true,
      interests: []),
  const User(
      loginId: "zm3",
      nickname: "삼부지",
      collegeCode: CollegeCode.college0003,
      imageUrl: "assets/images/user/user3.jpg",
      majorCode: MajorCode.major0003,
      isOnline: null,
      interests: []),
  const User(
      loginId: "zm4",
      nickname: "라디오꾼",
      collegeCode: CollegeCode.college0004,
      imageUrl: "assets/images/user/user4.jpg",
      majorCode: MajorCode.major0004,
      isOnline: false,
      interests: []),
  const User(
      loginId: "zm5",
      nickname: "마라탕궈",
      collegeCode: CollegeCode.college0005,
      imageUrl: "assets/images/user/user5.jpg",
      majorCode: MajorCode.major0005,
      isOnline: false,
      interests: []),
];

List<List<CategoryCode>> categoryDummy = [
  [CategoryCode.c0010, CategoryCode.c0002],
  [CategoryCode.c0003, CategoryCode.c0009],
  [CategoryCode.c0005, CategoryCode.c0007]
];

List<ChatMemberInfo> chatMemberInfo = [
  ChatMemberInfo(loginId: 'hi1', nickname: 'nickname', imageUrl: "")
];

List<VoiceRoom> voiceRoomDummy = [
  VoiceRoom(
      id: 1,
      ownerLoginId: "zm10",
      roomId: '',
      title: "단국대 20학번 산업디자인과 드루왕!!",
      token: '',
      uid: 4,
      memberInfos: chatMemberInfo,
      //createdAt: DateTime(2022, 2, 3),
      //type: VoiceRoomType.PUBLIC
      userImageUrls: []),
  VoiceRoom(
      //voiceDetail의 dummy로 사용중
      id: 2,
      ownerLoginId: "zm11",
      roomId: '0525zamong',
      title: "고정팟 구함!! 배틀그라운드 컴온",
      token:
          '0061db42f592687465e9ad1564ae4b55221IABJCnKGlfUjZNgQ3vRhjYc+RyYkebLyXF0471Ao3YbG3G3Q6H4AAAAAEAAPZcnS5z6PYgEAAQDmPo9i',
      uid: 4,
      memberInfos: chatMemberInfo,
      //createdAt: DateTime(2022, 2, 3),
      //type: VoiceRoomType.PUBLIC
      userImageUrls: []),
  VoiceRoom(
      id: 3,
      ownerLoginId: "zm11",
      roomId: '',
      title: "프로자취러들의 모임~ 각자 꿀팁공유행",
      token: '',
      uid: 4,
      memberInfos: chatMemberInfo,
      //createdAt: DateTime(2022, 2, 3),
      //type: VoiceRoomType.PUBLIC
      userImageUrls: []),
];

List<ChatMessage> chatMessageDummy = [
  ChatMessage(
      roomId: "1",
      loginId: "zm1",
      text: "하이루~",
      type: MessageType.TALK,
      createdAt: DateTime(2022, 02, 15)),
  ChatMessage(
      roomId: "1",
      loginId: "zm2",
      text: "방가방가",
      type: MessageType.TALK,
      createdAt: DateTime(2022, 02, 16)),
  ChatMessage(
      roomId: "1",
      loginId: "zm3",
      text: "헬로우",
      type: MessageType.TALK,
      createdAt: DateTime(2022, 02, 17)),
];

List<Comment> commentDummy = [
  Comment(
      id: 1,
      loginId: "jun",
      userNickname: "댓글러1",
      body: "와 댓글 일빠다.이게 과연 줄이 넘어가면 어떻게 될까 제발 그냥 좀 됐으면 좋겠다 근데 얼마나 더 길게 써야할까?",
      createdAt: DateTime(2022, 3, 28),
      deleted: false,
      parentId: 0,
      children: nestedCommentDummy),
  Comment(
      id: 2,
      loginId: "hithere",
      userNickname: "댓글러2",
      body: "두번째 댓글~",
      createdAt: DateTime(2022, 3, 28),
      deleted: false,
      parentId: 0,
      children: []),
  Comment(
      id: 3,
      loginId: "lilly",
      userNickname: "댓글러3",
      body: "세번째 메롱",
      createdAt: DateTime(2022, 3, 28),
      deleted: false,
      parentId: 0,
      children: [])
];

List<Comment> nestedCommentDummy = [
  Comment(
      id: 4,
      loginId: "asd",
      userNickname: "대댓글러1",
      body: "와 대댓글 일빠다. 제발 됐으면 좋겠다",
      createdAt: DateTime(2022, 3, 28),
      deleted: false,
      parentId: 1,
      children: []),
  Comment(
      id: 5,
      loginId: "ohoh",
      userNickname: "대댓글러2",
      body: "두번째 대댓글~",
      createdAt: DateTime(2022, 3, 28),
      deleted: false,
      parentId: 1,
      children: []),
  Comment(
      id: 6,
      loginId: "li",
      userNickname: "대댓글러3",
      body: "세번째 메롱",
      createdAt: DateTime(2022, 3, 28),
      deleted: false,
      parentId: 1,
      children: [])
];
