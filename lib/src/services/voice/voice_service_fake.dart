import 'dart:math';

import 'package:zamongcampus/src/business_logic/models/voice_room.dart';
import 'package:zamongcampus/src/config/dummy_data.dart';

import 'voice_service.dart';

class FakeVoiceService implements VoiceService {
  @override
  Future<List<VoiceRoom>> fetchVoiceRooms({required int nextPageToken}) async {
    List<VoiceRoom> list = [];
    list.add(VoiceRoom(
        id: 1,
        title: "단국대 20학번 산업디자인과 드루왕!!",
        members: userDummy,
        chatMessages: chatMessageDummy,
        createdAt: DateTime(2022, 2, 3),
        categories: categoryDummy[Random().nextInt(2)]));
    list.add(VoiceRoom(
        id: 1,
        title: "고정팟 구함!! 배틀그라운드 컴온",
        members: userDummy,
        chatMessages: chatMessageDummy,
        createdAt: DateTime(2022, 2, 3),
        categories: categoryDummy[Random().nextInt(2)]));
    list.add(VoiceRoom(
        id: 1,
        title: "프로자취러들의 모임~ 각자 꿀팁공유행",
        members: userDummy,
        chatMessages: chatMessageDummy,
        createdAt: DateTime(2022, 2, 3),
        categories: categoryDummy[Random().nextInt(2)]));
    return list;
  }
}
