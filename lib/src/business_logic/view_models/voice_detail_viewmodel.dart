import 'dart:math';

import 'package:zamongcampus/src/business_logic/init/auth_service.dart';
import 'package:zamongcampus/src/business_logic/models/chatMemberInfo.dart';
import 'package:zamongcampus/src/business_logic/models/chatMessage.dart';
import 'package:zamongcampus/src/business_logic/models/voice_room.dart';
import 'package:zamongcampus/src/business_logic/utils/category_data.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/business_logic/utils/date_convert.dart';
import 'package:zamongcampus/src/business_logic/view_models/base_model.dart';
import 'package:zamongcampus/src/config/dummy_data.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/object/stomp_object.dart';
import 'package:zamongcampus/src/services/voice/voice_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';

class VoiceDetailViewModel extends BaseModel {
  final VoiceService _voiceService = serviceLocator<VoiceService>();
  VoiceRoomPresentation _voiceRoom = VoiceRoomPresentation(
      id: -1,
      title: '',
      categories: [],
      createdAt: '',
      type: VoiceRoomType.PUBLIC);

  List<MemberPresentation> _voiceRoomMembers = List.empty(growable: true);

  List<ChatMessage> _chatMessages = List.empty(growable: true);
  RtcEngine? _engine;

  String _ownerLoginId = ''; //방장 아이디
  //int localuid = -1;

  VoiceRoomPresentation get voiceRoom => _voiceRoom;
  List<MemberPresentation> get voiceRoomMembers => _voiceRoomMembers;

  voiceDetailInit({int? id, VoiceRoom? createdVoiceRoom}) async {
    setBusy(true);

    VoiceRoom voiceRoom = (createdVoiceRoom == null && id != null)
        ? await _voiceService.fetchVoiceRoom(id: id)
        : createdVoiceRoom!;
    presentVoiceRoom(voiceRoom);
    await initAgoraRtcEngine(voiceRoom);
    addAgoraEventHandlers(_engine!);
    StompObject.subscribeVoiceRoomChat(voiceRoom.roomId!);

    setBusy(false);
  }

  Future<void> initAgoraRtcEngine(VoiceRoom voiceRoom) async {
    await [Permission.microphone].request();
    _engine = await RtcEngine.create(appIdForAgora);
    await _engine!.enableAudio();
    await _engine!.setChannelProfile(ChannelProfile
        .Communication); // 이게 정확히 어떤 역할인지는 모르겠음.. 무조건 channel join전에만 설정가능
    await _engine!.enableAudioVolumeIndication(200, 3, true); //말하는 사람 구분하기 위함
    await _engine!
        .joinChannel(voiceRoom.token, voiceRoom.roomId!, null, voiceRoom.uid!);
  }

  void addAgoraEventHandlers(RtcEngine engine) {
    engine.setEventHandler(RtcEngineEventHandler(error: (code) {
      print("error code : $code");
    }, joinChannelSuccess: (String channel, int uid, int elapsed) {
      print(channel);
      print('join 성공! 내 uid : $uid');
    }, userJoined: (int uid, int elapsed) {
      //테스트 후 삭제 ->테스트 완료. 감지됨
      print('uid : $uid 가 들어옴');
    }, userOffline: (int uid, elapsed) {
      //테스트 후 삭제
      print('uid : $uid 가 나감');
    }, leaveChannel: (status) {
      //테스트 후 삭제
      print('setEventHandler의 leaveChannel 작동');
    }, audioVolumeIndication: (List<AudioVolumeInfo> speakers, int volume) {
      speakers.forEach((speaker) {
        if (speaker.volume > 5) {
          try {
            for (MemberPresentation member in _voiceRoomMembers) {
              if (speaker.uid == 0 && member.loginId == AuthService.loginId) {
                member.isSpeaking = true;
                notifyListeners();
                print(member.uid.toString() +
                    '  ' +
                    speaker.uid.toString() +
                    '가 volume $volume로 말하고 있음. 그게 나야');
              } else if (member.uid == speaker.uid) {
                member.isSpeaking = true;
                notifyListeners();
                print(member.uid.toString() +
                    '  ' +
                    speaker.uid.toString() +
                    '가 volume $volume로 말하고 있음');
              }
            }
          } catch (error) {
            print('Error:${error.toString()}');
          }
        } else if (speaker.volume < 5) {
          try {
            for (MemberPresentation member in _voiceRoomMembers) {
              member.isSpeaking = false;
              notifyListeners();
            }
          } catch (error) {
            print('Error:${error.toString()}');
          }
        }
      });
    }));
  }

  Future<void> leaveChannel() async {
    await _engine!.leaveChannel();
    print("leave channel");
    _voiceRoomMembers.clear();
  }

  void presentVoiceRoom(VoiceRoom voiceRoom) {
    //뷰에 필요한 룸 정보 매핑
    _voiceRoom = VoiceRoomPresentation(
        id: voiceRoom.id,
        title: voiceRoom.title,
        categories: categoryDummy[Random().nextInt(2)]
            .map((category) =>
                CategoryData.iconOf(category.name) +
                " " +
                CategoryData.korNameOf(category.name))
            .toList(),
        createdAt: dateToPastTime(DateTime(2022, 2, 3)),
        type: VoiceRoomType.PUBLIC);

    //이미 존재하고 있는 멤버 정보 매핑 -> '나'인 경우와 아닌 경우 닉네임 다르게 표시
    _ownerLoginId = voiceRoom.ownerLoginId!;
    _voiceRoomMembers.addAll(voiceRoom.memberInfos!.map((memberInfo) =>
        MemberPresentation(
            uid: memberInfo.id ?? -1,
            loginId: memberInfo.loginId,
            nickname: memberInfo.loginId == AuthService.loginId
                ? memberInfo.nickname + '(나)'
                : memberInfo.nickname,
            imageUrl: memberInfo.imageUrl.isNotEmpty
                ? memberInfo.imageUrl
                : 'assets/images/user/general_user.png',
            isSpeaking: false,
            isHost: memberInfo.loginId == _ownerLoginId ? true : false)));
  }

  //stomp_object의 subscribeVoiceRoomChat안에서 쓴다. 새로운 멤버가 들어오면 그 멤버의 정보를 맵핑해주고 멤버리스트에 추가
  void addChatMemberInfo(ChatMemberInfo chatMemberInfo) {
    _voiceRoomMembers.add(MemberPresentation(
        uid: chatMemberInfo.id ?? -1,
        loginId: chatMemberInfo.loginId,
        nickname: chatMemberInfo.nickname,
        imageUrl: chatMemberInfo.imageUrl.isNotEmpty
            ? chatMemberInfo.imageUrl
            : 'assets/images/user/general_user.png',
        isSpeaking: false,
        isHost: false));
    notifyListeners();
  }

  void setVoiceFilter1() {
    _engine!.setAudioEffectPreset(AudioEffectPreset.AudioEffectOff);
    _engine!.setLocalVoicePitch(2.0);
  }

  void setVoiceFilter2() {
    _engine!.setAudioEffectPreset(AudioEffectPreset.AudioEffectOff);
    _engine!.setLocalVoicePitch(0.5);
  }

  void setVoiceFilter3() {
    _engine!.setAudioEffectPreset(
        AudioEffectPreset.VoiceChangerEffectSister); //별로 목소리 차이가 안남..
  }

  void setOriginalVoice() {
    _engine!.setAudioEffectPreset(AudioEffectPreset.AudioEffectOff);
    _engine!.setLocalVoicePitch(1.0);
  }
}

class VoiceRoomPresentation {
  final int id;
  final String title;
  final List<dynamic> categories; //일단은 뷰모델에서 지정해두자. 서버에서는 아직 안넘어옴
  String createdAt; //얘도 서버에서 아직 안넘어옴
  VoiceRoomType type;

  VoiceRoomPresentation(
      {required this.id,
      required this.title,
      required this.categories,
      required this.createdAt,
      required this.type});
}

class MemberPresentation {
  int uid;
  String loginId;
  String nickname;
  String imageUrl;
  bool isSpeaking;
  bool isHost;

  MemberPresentation(
      {required this.uid,
      required this.loginId,
      required this.nickname,
      required this.imageUrl,
      required this.isSpeaking,
      required this.isHost});
}

class TextChatPresentation {}
