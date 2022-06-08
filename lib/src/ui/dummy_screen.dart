import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/init/auth_service.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/business_logic/utils/methods.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/object/prefs_object.dart';
import 'package:zamongcampus/src/object/sqflite_object.dart';
import 'package:zamongcampus/src/services/chat/chat_service.dart';
import 'package:http/http.dart' as http;
import '../object/firebase_object.dart';

/// 삭제 예정 (채팅 테스트 용도)
class DummyScreen extends StatelessWidget {
  DummyScreen({Key? key}) : super(key: key);

  ChatService chatService = serviceLocator<ChatService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () async {
                  var count = 0;
                  await chatService.getAllChatRoom().then((chatrooms) => {
                        if (chatrooms.length == 0) print("참여한 방 없음"),
                        chatrooms.forEach((element) {
                          count++;
                          print("채팅방 출력 ${count} ==== " +
                              "roomId: ${element.roomId}, " +
                              "title: ${element.title}, " +
                              "type: ${element.type}, " +
                              "image: ${element.imageUrl}, " +
                              "lastmsg: ${element.lastMessage}, " +
                              "lastmsgcreatedat: ${element.lastMsgCreatedAt.toIso8601String()}, " +
                              "unreadCount: ${element.unreadCount.toString()}, ");
                        })
                      });
                },
                child: Text("chatroom 리스트 출력"),
              ),
              TextButton(
                onPressed: () async {
                  chatService.deleteAllChatRoom();
                },
                child: Text("chatroom 리스트 삭제"),
              ),
              TextButton(
                onPressed: () async {
                  var count = 0;
                  await chatService.getAllChatMessage().then((msgs) => {
                        if (msgs.length == 0) print("메시지 없음"),
                        msgs.forEach((element) {
                          count++;
                          print("메시지 출력 ${count}==== " +
                              "roomId: ${element.roomId}, " +
                              "loginId: ${element.loginId}, " +
                              "text: ${element.text}, " +
                              "type: ${element.type}" +
                              "createdAt : ${element.createdAt.toIso8601String()}");
                        })
                      });
                },
                child: Text("chatmsg 리스트 출력"),
              ),
              TextButton(
                onPressed: () {
                  chatService.deleteAllMessage();
                },
                child: Text("chatmsg 리스트 삭제"),
              ),
              TextButton(
                onPressed: () async {
                  var count = 0;
                  await chatService.getAllMemberInfoes().then((memberInfos) => {
                        if (memberInfos.length == 0) print("멤버 없음"),
                        memberInfos.forEach((element) {
                          count++;
                          print("멤버 출력 ${count}==== " +
                              // "roomId: ${element.roomId}, " +
                              "loginId: ${element.loginId}, " +
                              "nickname: ${element.nickname}, " +
                              "imageUrl: ${element.imageUrl}");
                        })
                      });
                },
                child: Text("memberinfo 리스트 출력"),
              ),
              TextButton(
                onPressed: () {
                  chatService.deleteAllMemberInfo();
                },
                child: Text("memberinfo 리스트 삭제"),
              ),
              TextButton(
                onPressed: () async {
                  var count = 0;
                  await chatService
                      .getAllChatRoomMemberInfos()
                      .then((memberInfos) => {
                            if (memberInfos.length == 0) print("멤버 없음"),
                            memberInfos.forEach((element) {
                              count++;
                              print("멤버 출력 ${count}==== " +
                                  // "roomId: ${element.roomId}, " +
                                  "loginId: ${element.loginId}, " +
                                  "nickname: ${element.roomId}, ");
                            })
                          });
                },
                child: Text("roomMemberinfo 리스트 출력"),
              ),
              TextButton(
                onPressed: () {
                  chatService.deleteAllChatRoomMemberInfo();
                },
                child: Text("roomMemberinfo 리스트 삭제"),
              ),
              TextButton(
                onPressed: () async {
                  print(await PrefsObject.getTotalLastMsgCreatedAt());
                },
                child: Text("totalLastMsgCreatedAt 출력"),
              ),
              TextButton(
                onPressed: () {
                  PrefsObject.setTotalLastMsgCreatedAt(
                      DateTime(2021, 05, 05).toIso8601String());
                },
                child: Text("totalLastMsgCreatedAt 삭제"),
              ),
              TextButton(
                onPressed: () {
                  SqfliteObject.dropTableIfExistsThenReCreate();
                },
                child: Text("db 삭제하고 다시 만들기"),
              ),
              TextButton(
                onPressed: () async {
                  print(await PrefsObject.getToken());
                },
                child: Text("print token"),
              ),
              TextButton(
                onPressed: () {
                  print(FirebaseObject.deviceFcmToken);
                },
                child: Text("print deviceFcmToken"),
              ),
              TextButton(
                onPressed: () async {
                  print(await PrefsObject.getRecentTalkUsers());
                },
                child: Text("recentTalkUser 리스트 출력"),
              ),
              buildActivateButton()
            ],
          ),
        ),
      ),
    );
  }

  final _textController = TextEditingController();
  Widget buildActivateButton() {
    if (AuthService.loginId == "admin") {
      return Column(
        children: [
          TextField(
            controller: _textController,
            decoration: const InputDecoration(
              hintText: '활성화시킬 유저 loginId',
              hintStyle: TextStyle(color: Color(0xFFADADAD), fontSize: 14),
              border: OutlineInputBorder(),
              isDense: true,
            ),
          ),
          TextButton(
            onPressed: () {
              _activateUser(_textController.text);
            },
            child: Text("유저 활성화"),
          ),
        ],
      );
    }
    return Container();
  }

  void _activateUser(String text) async {
    print(text + " 유저 활성화 시작!");
    final response = await http.post(
        Uri.parse(devServer + "/api/user/activate?loginId=" + text),
        headers: AuthService.get_auth_header());
    if (response.statusCode == 200) {
      print("활성화 완료");
      toastMessage("활성화 완료: " + _textController.text.toString());
    } else {
      toastMessage("활성화 오류");
    }
  }
}
