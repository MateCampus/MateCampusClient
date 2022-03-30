import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/config/dummy_data.dart';

import 'components/body.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;

class VoiceDetailScreen extends StatefulWidget {
  const VoiceDetailScreen({Key? key}) : super(key: key);

  @override
  State<VoiceDetailScreen> createState() => _VoiceDetailScreenState();
}

class _VoiceDetailScreenState extends State<VoiceDetailScreen> {
  late int? _remoteUid = null;
  bool _localUserJoined = false;
  late RtcEngine _engine;

  @override
  void initState() {
    initForAgora();
    super.initState();
  }

  @override
  void dispose() {
    leaveChannel();
    super.dispose();
  }

  Future<void> initForAgora() async {
    // permissions
    await [Permission.microphone, Permission.camera].request();

    // create the engine
    _engine = await RtcEngine.create(appId);

    // await _engine.enableVideo();
    await _engine.enableAudio();
    _engine.enableAudioVolumeIndication(200, 3, true);
    // 2번: register 후 join하기. 이 방식이 1번보다 빠르다.
    _engine.registerLocalUserAccount(appId, "닉네임인건가?");
    _engine.setEventHandler(
      RtcEngineEventHandler(localUserRegistered: (uid, userAccount) {
        _engine.joinChannelWithUserAccount(token, "room001", userAccount);
      }, joinChannelSuccess: (String channel, int uid, int elapsed) {
        print("내가 join를 성공 => $uid joined");
        // 이때 uid를 넘긴다.
        setState(() {
          _localUserJoined = true;
        });
      }, userJoined: (int uid, int elapsed) {
        // 누가 들어왔을 때의 callback 함수.
        print("remote user $uid joined");
        Future<UserInfo> userInfo = _engine.getUserInfoByUid(uid);
        // 이때 uid와 image, nickname까지 알 수 없을까?
        setState(() {
          userInfo.then((value) => value.userAccount); // => 이게 결국 닉네임
          _remoteUid = uid;
        });
      }, userOffline: (int uid, UserOfflineReason reason) {
        print("remote user $uid left channel");
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Ho")),
        body: Stack(
          children: [
            Center(
              child: _renderRemoteVideo(),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: SizedBox(
                width: 100,
                height: 100,
                child: Center(
                  child: _localUserJoined
                      ? _renderLocalPreview()
                      : CircularProgressIndicator(),
                ),
              ),
            ),
            GridView.builder(
              itemCount: userDummy.length, //item 개수
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, //1 개의 행에 보여줄 item 개수
                childAspectRatio: 1 / 2, //item 의 가로 1, 세로 2 의 비율
                mainAxisSpacing: 10, //수평 Padding
                crossAxisSpacing: 10, //수직 Padding
              ),
              itemBuilder: (BuildContext context, int index) {
                //item 의 반목문 항목 형성
                return Container(
                  child: Column(
                    children: [
                      Image.asset(userDummy[index].imageUrls!.first),
                      Container(
                        height: 50,
                        alignment: Alignment.center,
                        color: Colors.yellow,
                        child: Text(
                          '$index',
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ));
  }

  Widget _renderLocalPreview() {
    return RtcLocalView.SurfaceView();
  }

  Widget _renderRemoteVideo() {
    if (_remoteUid != null) {
      return RtcRemoteView.SurfaceView(channelId: "room001", uid: _remoteUid!);
    } else {
      return const Text("please wait for remote user to join");
    }
  }
}
