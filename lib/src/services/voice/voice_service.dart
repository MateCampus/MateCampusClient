import 'package:zamongcampus/src/business_logic/models/voice_room.dart';

abstract class VoiceService {
  Future<List<VoiceRoom>> fetchVoiceRooms({required int nextPageToken});

  Future<VoiceRoom> fetchVoiceRoom({required int id});

  Future<VoiceRoom> createVoiceRoom(
      {required String title,
      required List<String> selectedMemberLoginIds,
      required List<String> categoryCodeList});

  Future<void> exitVoiceRoom({required int id});
  Future<bool> inviteUsers(
      {required int id, required List<String> selectedMemberLoginIds});
}
