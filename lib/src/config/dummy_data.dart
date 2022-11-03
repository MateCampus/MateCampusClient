import 'package:zamongcampus/src/business_logic/models/chatMemberInfo.dart';
import 'package:zamongcampus/src/business_logic/models/chatMessage.dart';

import 'package:zamongcampus/src/business_logic/models/voice_room.dart';

import '../business_logic/models/enums/categoryCode.dart';

import '../business_logic/models/enums/messageType.dart';

/**
 * 테스트를 위한 dummyData. 
 * 추후에 삭제할 예정
 */

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
