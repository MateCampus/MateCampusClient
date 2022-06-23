import 'dart:math';

import 'package:flutter/material.dart';
import 'package:stomp_dart_client/stomp_handler.dart';
import 'package:zamongcampus/src/business_logic/init/auth_service.dart';
import 'package:zamongcampus/src/business_logic/models/chatMemberInfo.dart';
import 'package:zamongcampus/src/business_logic/models/chatMessage.dart';
import 'package:zamongcampus/src/business_logic/models/voice_room.dart';
import 'package:zamongcampus/src/business_logic/utils/category_data.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/business_logic/utils/methods.dart';
import 'package:zamongcampus/src/business_logic/utils/voice_category_data.dart';
import 'package:zamongcampus/src/business_logic/view_models/base_model.dart';
import 'package:zamongcampus/src/config/dummy_data.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/object/prefs_object.dart';
import 'package:zamongcampus/src/object/stomp_object.dart';
import 'package:zamongcampus/src/services/voice/voice_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';

import '../models/enums/voiceRoomType.dart';

class VoiceDetailViewModel extends BaseModel {
  final VoiceService _voiceService = serviceLocator<VoiceService>();
  StompUnsubscribe? unsubscribeFn;
  bool isFull = false;
  VoiceRoomPresentation _voiceRoom = VoiceRoomPresentation(
      id: -1,
      roomId: '',
      title: '',
      categories: [],
      type: VoiceRoomType.PUBLIC);

  List<MemberPresentation> _voiceRoomMembers = List.empty(growable: true);
  List<String> _recentTalkUserLoginIds = List.empty(growable: true);
  List<ChatMessage> _textChatMessages = List.empty(growable: true);
  List<TextChatPresentation> _textChatMembers = List.empty(growable: true);
  final ScrollController _scrollController = ScrollController();
  final _focusNode = FocusNode();
  RtcEngine? _engine;

  String _ownerLoginId = ''; //방장 아이디
  MediaQueryData? mediaQueryData;

  VoiceRoomPresentation get voiceRoom => _voiceRoom;
  List<MemberPresentation> get voiceRoomMembers => _voiceRoomMembers;
  List<ChatMessage> get textChatMessages => _textChatMessages;
  List<TextChatPresentation> get textChatMembers => _textChatMembers;
  ScrollController get textChatScrollController => _scrollController;
  FocusNode get focusNode => _focusNode;

  ///init
  voiceDetailInit(
      {int? id,
      VoiceRoom? createdVoiceRoom,
      required BuildContext context}) async {
    setBusy(true);
    print('voiceDetailInit시작');
    VoiceRoom voiceRoom = (createdVoiceRoom == null && id != null)
        ? await _voiceService.fetchVoiceRoom(id: id)
        : createdVoiceRoom!;
    // TODO: 이 부분 checkIsFull 함수로 Future로 만들어서 await 해야할수도.(아래 presentVoiceRoom이 먼저 시작할지도)
    if (voiceRoom.isFull!) {
      isFull = true;
      toastMessage("최대인원을 초과했습니다.");
      Navigator.pop(context);
      return;
    }
    await presentVoiceRoom(voiceRoom);
    await initAgoraRtcEngine(voiceRoom);
    addAgoraEventHandlers(_engine!);
    unsubscribeFn = StompObject.subscribeVoiceRoomChat(voiceRoom.roomId!);

    saveExistingUsers(voiceRoom.memberInfos!);
    setBusy(false);
  }

  Future<void> initAgoraRtcEngine(VoiceRoom voiceRoom) async {
    print('initAgora엔진');
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
    print('add아고라이벤트핸들러');
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
      print('speaker 수' + speakers.length.toString());
      speakers.forEach((speaker) {
        if (speaker.volume > 5) {
          try {
            for (MemberPresentation member in _voiceRoomMembers) {
              if (speaker.uid == 0 && member.loginId == AuthService.loginId) {
                print('멤버 수 나나나' + _voiceRoomMembers.length.toString());
                member.isSpeaking = true;
                notifyListeners();
                print(member.uid.toString() +
                    '  ' +
                    speaker.uid.toString() +
                    '가 volume $volume로 말하고 있음. 그게 나야');
              } else if (member.uid == speaker.uid) {
                print('멤버 수 너너너' + _voiceRoomMembers.length.toString());
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
    saveRecentTalkUsersDB();
    await _engine!.leaveChannel();
    print("leave channel");
    _voiceRoomMembers.clear();
  }

  Future<void> presentVoiceRoom(VoiceRoom voiceRoom) async {
    //뷰에 필요한 룸 정보 매핑
    print('presentVoiceRoom 시작');
    _voiceRoom = VoiceRoomPresentation(
        id: voiceRoom.id,
        roomId: voiceRoom.roomId!,
        title: voiceRoom.title ?? '제목 오류',
        categories: voiceRoom.voiceCategoryCodes
                ?.map<String>((category) =>
                    VoiceCategoryData.iconOf(category.name) +
                    " " +
                    VoiceCategoryData.korNameOf(category.name))
                .toList() ??
            [],
        type: VoiceRoomType.PUBLIC);

    //이미 존재하고 있는 멤버 정보 매핑 -> '나'인 경우와 아닌 경우 닉네임 다르게 표시
    _ownerLoginId = voiceRoom.ownerLoginId!;
    _voiceRoomMembers = voiceRoom.memberInfos!
        .map((memberInfo) => MemberPresentation(
            uid: memberInfo.id ?? -1,
            loginId: memberInfo.loginId,
            nickname: memberInfo.loginId == AuthService.loginId
                ? memberInfo.nickname + '(나)'
                : memberInfo.nickname,
            imageUrl:
                memberInfo.imageUrl ?? 'assets/images/user/general_user.png',
            isSpeaking: false,
            isHost: memberInfo.loginId == _ownerLoginId ? true : false))
        .toList();

    //textChat에 쓰기 위해 따로 저장
    _textChatMembers = voiceRoom.memberInfos!
        .map((memberInfo) => TextChatPresentation(
              loginId: memberInfo.loginId,
              nickname: memberInfo.loginId == AuthService.loginId
                  ? memberInfo.nickname + '(나)'
                  : memberInfo.nickname,
              imageUrl:
                  memberInfo.imageUrl ?? 'assets/images/user/general_user.png',
            ))
        .toList();
  }

  //stomp_object의 subscribeVoiceRoomChat안에서 쓴다. 새로운 멤버가 들어오면 그 멤버의 정보를 맵핑해주고 멤버리스트에 추가
  void addChatMemberInfo(ChatMemberInfo chatMemberInfo) {
    _voiceRoomMembers.add(MemberPresentation(
        uid: chatMemberInfo.id ?? -1,
        loginId: chatMemberInfo.loginId,
        nickname: chatMemberInfo.nickname,
        imageUrl:
            chatMemberInfo.imageUrl ?? 'assets/images/user/general_user.png',
        isSpeaking: false,
        isHost: false));

    _textChatMembers.add(TextChatPresentation(
      loginId: chatMemberInfo.loginId,
      nickname: chatMemberInfo.nickname,
      imageUrl:
          chatMemberInfo.imageUrl ?? 'assets/images/user/general_user.png',
    ));
    saveAddedUser(chatMemberInfo.loginId);
    notifyListeners();
  }

  void saveExistingUsers(List<ChatMemberInfo> chatMemberInfos) {
    for (ChatMemberInfo chatMemberInfo in chatMemberInfos) {
      //본인은 저장하지 않음
      if (chatMemberInfo.loginId != AuthService.loginId) {
        _recentTalkUserLoginIds.add(chatMemberInfo.loginId);
      }
    }
  }

  void saveAddedUser(String loginId) {
    for (String existLoginId in _recentTalkUserLoginIds) {
      if (existLoginId == loginId) {
        _recentTalkUserLoginIds.remove(loginId);
        break;
      }
    }
    _recentTalkUserLoginIds.add(loginId);
  }

  //loacl db에 저장
  Future<void> saveRecentTalkUsersDB() async {
    List<String> _savedLoginIds = await PrefsObject.getRecentTalkUsers() ?? [];
    for (String loginId in _recentTalkUserLoginIds) {
      if (_savedLoginIds.contains(loginId)) {
        _savedLoginIds.remove(loginId);
      }
    }
    _savedLoginIds.addAll(_recentTalkUserLoginIds);
    PrefsObject.setRecentTalkUsers(_savedLoginIds);
  }

  Future<void> addTextChatMessage(ChatMessage chatMessage) async {
    /// 실시간 오는 메세지
    setBusy(true);
    _textChatMessages.insert(0, chatMessage);
    _focusNode.unfocus();
    scrollToEnd();
    print("fromfriendProfile: 실시간 메세지 더하기 완료");
    setBusy(false);
  }

  void removeChatMemberInfo(String exitMemberLoginId) {
    _voiceRoomMembers
        .removeWhere((member) => member.loginId == exitMemberLoginId);
    notifyListeners();
  }

  void scrollToEnd() async {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      //리스트 뷰를 reverse로 그리고 있기 때문에 제일 처음 위치로 스크롤을 떙겨야함.
      _scrollController.animateTo(_scrollController.position.minScrollExtent,
          duration: const Duration(milliseconds: 400),
          curve: Curves.fastOutSlowIn);
    });
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

  void resetData() {
    // 1. agora 해제 2. stomp unsubscribe 3. server participant에서 제거
    //TODO: 4. recentTalkuser 추가해야함!!!
    if (!isFull) {
      leaveChannel();
      unsubscribeFn!(unsubscribeHeaders: AuthService.get_auth_header());
      _voiceService.exitVoiceRoom(id: voiceRoom.id);
    }
  }
}

class VoiceRoomPresentation {
  final int id;
  final String roomId;
  final String title;
  final List<String> categories; //일단은 뷰모델에서 지정해두자. 서버에서는 아직 안넘어옴
  VoiceRoomType type;

  VoiceRoomPresentation(
      {required this.id,
      required this.roomId,
      required this.title,
      required this.categories,
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

class TextChatPresentation {
  String loginId;
  String nickname;
  String imageUrl;
  TextChatPresentation(
      {required this.loginId, required this.nickname, required this.imageUrl});
}
