import 'package:zamongcampus/src/business_logic/init/auth_service.dart';
import 'package:zamongcampus/src/business_logic/models/voice_room.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/services/voice/voice_service.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class VoiceServiceImpl implements VoiceService {
  @override
  Future<List<VoiceRoom>> fetchVoiceRooms({required int nextPageToken}) async {
    final response = await http.get(Uri.parse(devServer + "/api/voiceRoom"),
        headers: AuthService.get_auth_header());

    if (response.statusCode == 200) {
      List<VoiceRoom> voiceRooms =
          await jsonDecode(utf8.decode(response.bodyBytes))
              .map<VoiceRoom>((voiceRoom) => VoiceRoom.fromJson(voiceRoom))
              .toList();
      print("fetchVoiceRooms ");
      return voiceRooms;
    } else {
      throw Exception('오류: 보이스룸 가져오기 실패');
    }
  }

  @override
  Future<VoiceRoom> fetchVoiceRoom({required int id}) async {
    final response = await http.get(
        Uri.parse(devServer + "/api/voiceRoom/" + id.toString()),
        headers: AuthService.get_auth_header());
    if (response.statusCode == 200) {
      VoiceRoom voiceRoom =
          VoiceRoom.fromJson(await jsonDecode(utf8.decode(response.bodyBytes)));
      return voiceRoom;
    } else {
      throw Exception('voiceRoom 패치 오류');
    }
  }

  @override
  Future<VoiceRoom> createVoiceRoom({required String title}) async {
    // String voiceRoomJson = jsonEncode({
    //   "title": title,
    //   "collegeOnly": collegeOnly,
    //   "majorOnly": majorOnly,
    //   "categories": categories.toList(),s
    //   "type": type,
    //   "members": members.toList(),  //리스트 인코딩하는법 알아야함
    // });
    String voiceRoomJson = jsonEncode({"title": title});
    final response = await http.post(Uri.parse(devServer + "/api/voiceRoom"),
        headers: AuthService.get_auth_header(), body: voiceRoomJson);
    if (response.statusCode == 201) {
      VoiceRoom createdVoiceRoom =
          VoiceRoom.fromJson(await jsonDecode(utf8.decode(response.bodyBytes)));
      return createdVoiceRoom;
    } else {
      print('보이스룸 생성 실패');
      print(response.reasonPhrase);
      throw Exception();
    }
  }
}
