import 'package:zamongcampus/src/business_logic/models/voice_room.dart';
import 'package:zamongcampus/src/config/dummy_data.dart';
import 'voice_service.dart';

class FakeVoiceService implements VoiceService {
  @override
  Future<VoiceRoom> createVoiceRoom(
      {required String title,
      required List<String> selectedMemberLoginIds}) async {
    // TODO: implement createVoiceRoom
    throw UnimplementedError();
  }

  @override
  Future<VoiceRoom> fetchVoiceRoom({required int id}) async {
    return voiceRoomDummy[1];
  }

  @override
  Future<List<VoiceRoom>> fetchVoiceRooms({required int nextPageToken}) async {
    List<VoiceRoom> voiceRooms = [];
    voiceRooms.addAll(voiceRoomDummy);
    return voiceRooms;
  }

  @override
  Future<void> exitVoiceRoom({required int id}) {
    // TODO: implement exitVoiceRoom
    throw UnimplementedError();
  }

  @override
  Future<bool> inviteUsers(
      {required int id, required List<String> selectedMemberLoginIds}) {
    // TODO: implement inviteUsers
    throw UnimplementedError();
  }
}
