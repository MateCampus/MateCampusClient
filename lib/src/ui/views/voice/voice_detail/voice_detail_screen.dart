import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zamongcampus/src/business_logic/view_models/voice_detail_viewmodel.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/isLoading.dart';
import 'package:zamongcampus/src/ui/views/voice/voice_detail/components/body.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/config/dummy_data.dart';

import 'components/body.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;

class VoiceDetailScreen extends StatefulWidget {
  static const routeName = '/voiceDetail';
  final int voiceRoomId;
  const VoiceDetailScreen({Key? key, required this.voiceRoomId})
      : super(key: key);

  @override
  _VoiceDetailScreenState createState() => _VoiceDetailScreenState();
}

class _VoiceDetailScreenState extends State<VoiceDetailScreen> {
  VoiceDetailViewModel vm = serviceLocator<VoiceDetailViewModel>();
  late int? _remoteUid = null;
  bool _localUserJoined = false;
  late RtcEngine _engine;
  @override
  void initState() {
    vm.loadVoiceRoom(widget.voiceRoomId);
    initForAgora();
  }

  void dispose() {
    leaveChannel();
    super.dispose();
  }

  Future<void> initForAgora() async {
    // permissions
    await [Permission.microphone].request();

    // create the engine
    _engine = await RtcEngine.create(appId);

    // await _engine.enableVideo();
    await _engine.enableAudio();
    _engine.enableAudioVolumeIndication(200, 3, true);
    // 2번: register 후 join하기. 이 방식이 1번보다 빠르다.
    _engine.registerLocalUserAccount(appId, "닉네임인건가?");
    _engine.setEventHandler(
      RtcEngineEventHandler(
          joinChannelSuccess: (String channel, int uid, int elapsed) {
        print("내가 join를 성공 => $uid joined");
        // 이때 uid를 넘긴다.
        setState(() {
          _localUserJoined = true;
        });
      }, userJoined: (int uid, int elapsed) {
        // 안 쓸 예정.
        print("remote user $uid joined");
      }, userOffline: (int uid, UserOfflineReason reason) {
        print("remote user $uid left channel");
        // 누가 나감.
        setState(() {
          _remoteUid = null;
        });
      }, audioVolumeIndication: (List<AudioVolumeInfo> speakers, int volume) {
        print("hi~");
        speakers.forEach((speaker) {
          print("Uid ${speaker.uid} Level ${speaker.volume}");
          if (speaker.uid == 1) {
            // 나 자신인 경우
          }
        });
      }),
    );

    await _engine.joinChannel(token, "room001", null, 0);
    // + server로 참여자 uid 와 loginId 추가. // chatmemberInfo를 줘야할까?
    // 1번: 이 아래걸로만 연결하기.
    await _engine.joinChannelWithUserAccount(token, "room0001", "닉네임으로?");
  }

  Future<void> leaveChannel() async {
    print("leave channel");
    _engine.leaveChannel();
  }

  // 내 화면
  Widget _renderLocalPreview() {
    return RtcLocalView.SurfaceView();
  }

  // 상대방 화면
  Widget _renderRemoteVideo() {
    if (_remoteUid != null) {
      return RtcRemoteView.SurfaceView(channelId: "room001", uid: _remoteUid!);
    } else {
      return const Text("please wait for remote user to join");
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context: context);
    return ChangeNotifierProvider<VoiceDetailViewModel>(
      create: (context) => vm,
      child: Consumer<VoiceDetailViewModel>(builder: ((context, vm, child) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: PreferredSize(
            preferredSize: Size.fromHeight(getProportionateScreenHeight(30)),
            child: Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: const Icon(Icons.expand_more_outlined),
                  color: Colors.black,
                  onPressed: () {
                    Navigator.of(context).pop(); //일단은 뒤로가기로
                  },
                ),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.person_add_outlined),
                    color: Colors.black,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.logout_outlined),
                    color: Colors.black,
                  ),
                ],
                elevation: 0.0,
                backgroundColor: const Color(0xfff8f8f8),
              ),
              backgroundColor: const Color(0xfff8f8f8),
              //extendBodyBehindAppBar: true,
              body: vm.busy ? const IsLoading() : Body(vm: vm),
            ),
          ),
        );
      })),
    );
  }
}
