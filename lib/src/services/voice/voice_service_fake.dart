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
        members: userDummy2,
        chatMessages: chatMessageDummy,
        createdAt: DateTime(2022, 2, 3),
        categories: categoryDummy[Random().nextInt(2)],
        type: VoiceRoomType.PUBLIC));
    list.add(VoiceRoom(
        id: 2,
        title: "고정팟 구함!! 배틀그라운드 컴온",
        members: userDummy2,
        chatMessages: chatMessageDummy,
        createdAt: DateTime(2022, 2, 3),
        categories: categoryDummy[Random().nextInt(2)],
        type: VoiceRoomType.PUBLIC));
    list.add(VoiceRoom(
        id: 3,
        title: "프로자취러들의 모임~ 각자 꿀팁공유행",
        members: userDummy2,
        chatMessages: chatMessageDummy,
        createdAt: DateTime(2022, 2, 3),
        categories: categoryDummy[Random().nextInt(2)],
        type: VoiceRoomType.PUBLIC));
    list.add(VoiceRoom(
        id: 4,
        title: "경기대 새내기 손!!",
        members: userDummy2,
        chatMessages: chatMessageDummy,
        createdAt: DateTime(2022, 2, 3),
        categories: categoryDummy[Random().nextInt(2)],
        type: VoiceRoomType.PUBLIC));
    list.add(VoiceRoom(
        id: 5,
        title: "즐겁게 대화할사람 들어와주세요~~~컨셉질환영 과몰입환영 그냥 다 환영 드루와드루와",
        members: userDummy2,
        chatMessages: chatMessageDummy,
        createdAt: DateTime(2022, 2, 3),
        categories: categoryDummy[Random().nextInt(2)],
        type: VoiceRoomType.PUBLIC));
    return list;
  }
}
