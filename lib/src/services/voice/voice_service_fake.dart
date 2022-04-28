import 'package:zamongcampus/src/business_logic/models/voice_room.dart';
import 'package:zamongcampus/src/config/dummy_data.dart';

import 'voice_service.dart';

class FakeVoiceService implements VoiceService {
  @override
  Future<List<VoiceRoom>> fetchVoiceRooms({required int nextPageToken}) async {
    List<VoiceRoom> list = voiceRoomDummy;

    return list;
  }

  @override
  Future<VoiceRoom> fetchVoiceRoom({required int voiceRoomId}) async {
    VoiceRoom voiceRoom;
    voiceRoom = voiceRoomDummy.first;

    return voiceRoom;
  }
}
