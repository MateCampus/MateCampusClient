import 'package:zamongcampus/src/business_logic/models/voice_room.dart';
import 'package:zamongcampus/src/business_logic/utils/category_data.dart';
import 'package:zamongcampus/src/business_logic/utils/date_convert.dart';
import 'package:zamongcampus/src/business_logic/view_models/base_model.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/services/voice/voice_service.dart';

class VoiceDetailViewModel extends BaseModel {
  final VoiceService _voiceService = serviceLocator<VoiceService>();

  VoiceRoomPresentation _voiceRoom = defaultVoiceRoom;

  VoiceRoomPresentation get voiceRoom => _voiceRoom;

  static final VoiceRoomPresentation defaultVoiceRoom = VoiceRoomPresentation(
      id: 0,
      title: '',
      members: [],
      categories: [],
      createdAt: '',
      type: VoiceRoomType.PUBLIC);

  void loadVoiceRoom(int voiceRoomId) async {
    setBusy(true);

    print(voiceRoomId); //test

    VoiceRoom voiceRoomResult =
        await _voiceService.fetchVoiceRoom(voiceRoomId: voiceRoomId);

    _voiceRoom = VoiceRoomPresentation(
        id: voiceRoomResult.id,
        title: voiceRoomResult.title,
        members: voiceRoomResult.members
            .map((member) => UserPresentation(
                loginId: member.loginId,
                nickname: member.nickname,
                imageUrl: member.imageUrls?.first ??
                    'assets/images/user/general_user.png',
                isHost: false,
                isSpeaking: false))
            .toList(),
        categories: voiceRoomResult.categories
            .map((category) =>
                CategoryData.iconOf(category.name) +
                " " +
                CategoryData.korNameOf(category.name))
            .toList(),
        createdAt: dateToPastTime(voiceRoomResult.createdAt),
        type: voiceRoomResult.type);
    setBusy(false);
  }

  void setHost() {
    _voiceRoom.members.first.isHost = true;
    notifyListeners();
  }
}

class VoiceRoomPresentation {
  final int id;
  final String title;
  final List<UserPresentation> members;
  final List<dynamic> categories;
  String createdAt;
  VoiceRoomType type;

  VoiceRoomPresentation(
      {required this.id,
      required this.title,
      required this.members,
      required this.categories,
      required this.createdAt,
      required this.type});
}

class UserPresentation {
  String loginId;
  String nickname;
  String imageUrl;
  bool isSpeaking;
  bool isHost;

  UserPresentation(
      {required this.loginId,
      required this.nickname,
      required this.imageUrl,
      required this.isHost,
      required this.isSpeaking});
}

class TextChatPresentation {}
