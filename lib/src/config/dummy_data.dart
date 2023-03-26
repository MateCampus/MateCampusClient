import 'package:zamongcampus/src/business_logic/models/chatMemberInfo.dart';
import 'package:zamongcampus/src/business_logic/models/chatMessage.dart';


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
