import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/models/user.dart';
import 'package:zamongcampus/src/business_logic/models/voice_room.dart';
import 'package:zamongcampus/src/business_logic/utils/category_data.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/business_logic/utils/date_convert.dart';
import 'package:zamongcampus/src/business_logic/view_models/base_model.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/services/voice/voice_service.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtm/agora_rtm.dart';

class VoiceDetailViewModel extends BaseModel {
  final VoiceService _voiceService = serviceLocator<VoiceService>();
  VoiceRoomPresentation _voiceRoom = defaultVoiceRoom;
  static final VoiceRoomPresentation defaultVoiceRoom = VoiceRoomPresentation(
      id: -1,
      title: '',
      members: [],
      categories: [],
      createdAt: '',
      type: VoiceRoomType.PUBLIC);

  RtcEngine? _engine;
  int localuid = -1;
  final chatMessageController = TextEditingController();
  VoiceRoomPresentation get voiceRoom => _voiceRoom;

  Future<void> initAgoraRtcEngine() async {
    await [Permission.microphone].request();
    _engine = await RtcEngine.create(appId);
    await _engine!.enableAudio();
    await _engine!.setChannelProfile(ChannelProfile
        .Communication); // 이게 정확히 어떤 역할인지는 모르겠음.. 무조건 channel join전에만 설정가능

    await _engine!.enableAudioVolumeIndication(200, 3, true); //말하는 사람 구분하기 위함
    addAgoraEventHandlers();
  }

  void addAgoraEventHandlers() {
    _engine!.setEventHandler(RtcEngineEventHandler(error: (code) {
      print("error code : $code");
    }, joinChannelSuccess: (String channel, int uid, int elapsed) {
      print(channel);
      print('join 성공! uid : $uid');
      localuid = uid;
      _voiceRoom.members.add(MemberPresentation(
          id: localuid,
          loginId: myInfo.loginId,
          nickname: myInfo.nickname,
          imageUrl: 'assets/images/user/general_user.png',
          isSpeaking: false,
          isHost: false));
      notifyListeners();
    }, userJoined: (int uid, int elapsed) {
      _voiceRoom.members.add(MemberPresentation(
          id: uid,
          loginId: 'remoteUser',
          nickname: '나아님',
          imageUrl: 'assets/images/user/general_user.png',
          isSpeaking: false,
          isHost: false));
      print('join 성공! uid : $uid');
      notifyListeners();
    }, userOffline: (int uid, elapsed) {
      for (MemberPresentation member in _voiceRoom.members) {
        if (member.id == uid) {
          _voiceRoom.members.remove(member);
          print(member.nickname +
              member.id.toString() +
              ' ' +
              uid.toString() +
              '나감');
          notifyListeners();
        }
      }
    }, audioVolumeIndication: (List<AudioVolumeInfo> speakers, int volume) {
      speakers.forEach((speaker) {
        if (speaker.volume > 5) {
          try {
            for (MemberPresentation member in _voiceRoom.members) {
              if (speaker.uid == 0 && member.id == localuid) {
                member.isSpeaking = true;
                notifyListeners();
                print(member.id.toString() +
                    '  ' +
                    speaker.uid.toString() +
                    '말하고 있음');
              } else if (member.id == speaker.uid) {
                member.isSpeaking = true;
                notifyListeners();
                print(member.id.toString() +
                    '  ' +
                    speaker.uid.toString() +
                    '말하고 있음');
              }
              // else {
              //   testnum = 0;
              //   member.isSpeaking = false;
              //   notifyListeners();
              //   print(testnum.toString() + 'tesetnum');
              // }
            }
          } catch (error) {
            print('Error:${error.toString()}');
          }
        } else if (speaker.volume < 5) {
          try {
            for (MemberPresentation member in _voiceRoom.members) {
              if (speaker.uid == 0 && member.id == localuid) {
                member.isSpeaking = false;
                notifyListeners();
              } else if (member.id == speaker.uid) {
                member.isSpeaking = false;
                notifyListeners();
              }
            }
          } catch (error) {
            print('Error:${error.toString()}');
          }
        }
      });
    }));
    // notifyListeners();
  }

  Future<void> leaveChannel() async {
    print("leave channel");
    await _engine!.leaveChannel();
    _voiceRoom.members.clear();
    //notifyListeners();
  }

  void _initAgoraRtm() async {
    //일단 보류
  }

  void loadVoiceRoom(int voiceRoomId) async {
    setBusy(true);

    await initAgoraRtcEngine();
    addAgoraEventHandlers();

    VoiceRoom voiceRoomResult =
        await _voiceService.fetchVoiceRoom(voiceRoomId: voiceRoomId);

    _voiceRoom = VoiceRoomPresentation(
        id: voiceRoomResult.voiceRoomAndTokenInfo.id,
        title: voiceRoomResult.voiceRoomAndTokenInfo.title,
        members: voiceRoomResult.membersInfo
            .map((member) => MemberPresentation(
                id: member.id ?? -1,
                loginId: member.loginId,
                nickname: member.nickname,
                imageUrl:
                    member.imageUrl ?? 'assets/images/user/general_user.png',
                isHost: voiceRoomResult.voiceRoomAndTokenInfo.ownerLoginId ==
                        member.loginId
                    ? true
                    : false,
                isSpeaking: false))
            .toList(),
        categories: voiceRoomResult.categories!
            .map((category) =>
                CategoryData.iconOf(category.name) +
                " " +
                CategoryData.korNameOf(category.name))
            .toList(),
        createdAt: dateToPastTime(voiceRoomResult.createdAt),
        type: voiceRoomResult.type ?? defaultVoiceRoom.type);

    await _engine!.joinChannel(
        voiceRoomResult.voiceRoomAndTokenInfo.token,
        voiceRoomResult.voiceRoomAndTokenInfo.roomId,
        null,
        0); //서버에서 받아온 토큰과 roomId로 채널 입장. //여기에 0을 uid로 넣으면 될 것 같기두.. 확인해봐야함.

    setBusy(false);
  }
}

class VoiceRoomPresentation {
  final int id;
  final String title;
  final List<MemberPresentation> members;
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

class MemberPresentation {
  int id;
  String loginId;
  String nickname;
  String imageUrl;
  bool isSpeaking;
  bool isHost;

  MemberPresentation(
      {required this.id,
      required this.loginId,
      required this.nickname,
      required this.imageUrl,
      required this.isSpeaking,
      required this.isHost});
}

class TextChatPresentation {}

User myInfo = User(loginId: 'seoyun', nickname: "잇츠미");
