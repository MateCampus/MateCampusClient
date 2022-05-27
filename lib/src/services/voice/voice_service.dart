import 'package:zamongcampus/src/business_logic/models/voice_room.dart';

abstract class VoiceService {
  Future<List<VoiceRoom>> fetchVoiceRooms({required int nextPageToken});

  Future<VoiceRoom> fetchVoiceRoom({required int id});

  Future<VoiceRoom> createVoiceRoom({required String title});
}
