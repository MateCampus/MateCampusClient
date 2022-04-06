import 'dart:convert';

import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'package:zamongcampus/src/business_logic/models/chatMessage.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';

class StompObject {
  static late StompClient _stompClient;

  StompClient get stompClient => _stompClient;

  static connectStomp() {
    print("stomp init start");
    _stompClient = StompClient(
      config: StompConfig.SockJS(
        url: devServer + '/ws-stomp',
        onConnect: onConnect,
        beforeConnect: () async {
          print('stomp 연결 중 ...');
        },
        onWebSocketError: (dynamic error) => print(error.toString()),
        stompConnectHeaders: {'Authorization': 'Bearer yourToken'},
        webSocketConnectHeaders: {'Authorization': 'Bearer yourToken'},
      ),
    );
    _stompClient.activate(); // 서버 실행
    _stompClient = _stompClient; // stompClient 초기화
  }

  // connect 성공
  static dynamic onConnect(StompFrame frame) async {
    print('stomp 연결 완료');
    // 이미 있는 방들 stomp연결 initStompExistChatRoom();
    // 새로운 메세지로 chatroom setting하기 setChatRoomByNewMessages();
    // chatroom load하기.  loadChatRooms()
  }

  // roomId로 오는 메세지
  // void subscribeChatRoom(String roomId) {
  //   stompClient.subscribe(
  //     destination: '/sub/chat/room/$roomId',
  //     callback: (frame) {
  //       // ** 메시지 도착 시점
  //       print("----- 새로운 메세지 도착 -----");
  //       var res = json.decode(frame.body ?? "");

  //       if (res["type"] == "talk") {
  //         /***** TALK ******/
  //         ChatMessage chatMessage =
  //             ChatMessage.fromJsonRoomId(res["messageDto"], res["roomId"]);
  //         // 1. 메세지 저장
  //         chatRepository.insertMessage(chatMessage);
  //         // 2. chatroom 내용 변경 => 이미 그 방이면 0, 아니면 1 추가
  //         chatRepository.updateChatRoom(
  //             chatMessage.text,
  //             chatMessage.createdAt,
  //             chatMessage.roomId == HomeController.to.chatRoomId.value ? 0 : 1,
  //             chatMessage.roomId);

  //         // 3. pref에 최근 메시지 시간 저장할 것
  //         HomeController.to.prefs.setString(
  //             "totalLastMsgCreatedAt", chatMessage.createdAt.toString());

  //         // UI: 현재 위치가 해당방이면 ui 수정(chatdetail)
  //         if (chatMessage.roomId == HomeController.to.chatRoomId.value)
  //           ChatDetailController.to.addMessage(chatMessage);
  //         // ** UI(chatsScreen) 변경
  //         int index = ChatController.to.getExistRoomIndex(chatMessage.roomId);
  //         ChatRoom chatRoom = ChatController.to.chatRooms[index];
  //         if (index == 0) {
  //           // 최상단 : 업데이트만 => lastmsg, unreadcount, lastMsgCreatedAt
  //           chatRoom.lastMessage = chatMessage.text;
  //           chatRoom.lastMsgCreatedAt = chatMessage.createdAt;
  //           // 해당 방 안에 아닐 때만 unreadcount 변경
  //           if (chatMessage.roomId != HomeController.to.chatRoomId.value)
  //             chatRoom.unreadCount = chatRoom.unreadCount + 1;
  //           ChatController.to.replaceItem(chatRoom, index);
  //         } else {
  //           // 최상단 아니면 => 1. 기존 방: 방 지웠다가 새롭게 방 추가  2. 완전 처음 방: 새롭게 방만 추가

  //           if (index != -1) {
  //             // 기존에 있는 방: unreadCount, lastMsg, lastMsgCreatedAt 변경
  //             // 현재 그 방 안이라면 0으로 값 변경
  //             // 아니면 삭제(removeItem)하면서 unreadcount 반환 (그 값으로 변경)
  //             int unreadCount =
  //                 ChatController.to.removeItem(index, chatRoom.roomId);
  //             if (chatMessage.roomId == HomeController.to.chatRoomId.value) {
  //               chatRoom.unreadCount = 0;
  //             } else {
  //               chatRoom.unreadCount = unreadCount + 1;
  //             }
  //             chatRoom.lastMessage = chatMessage.text;
  //             chatRoom.lastMsgCreatedAt = chatMessage.createdAt;
  //           }
  //           ChatController.to.insertItem(chatRoom);
  //         }
  //       } else if (res["type"] == "enter") {
  //         /***** ENTER ******/
  //         /* 1. 메세지 저장 */
  //         ChatMessage chatMessage = new ChatMessage(
  //             roomId: res["roomId"],
  //             loginId: "",
  //             text: "${res["nickname"]}님이 입장하셨습니다.",
  //             type: "ENTER",
  //             createdAt: DateTime.parse(res["createdAt"]));
  //         chatRepository.insertMessage(chatMessage);

  //         /* 2. 멤버 저장 */
  //         ChatMemberInfo chatMemberInfo = new ChatMemberInfo.fromJson(res);
  //         ChatRoomMemberInfo chatRoomMemberInfo = new ChatRoomMemberInfo(
  //             roomId: res["roomId"], loginId: res["loginId"]);
  //         chatRepository.insertOrUpdateMemberInfoOne(chatMemberInfo);
  //         chatRepository.insertRoomMemberInfoOne(chatRoomMemberInfo);

  //         /* 3. 현재 위치가 해당방이면 ui 수정(chatdetail) */
  //         if (chatMessage.roomId == HomeController.to.chatRoomId.value)
  //           ChatDetailController.to.addMessage(chatMessage);

  //         /* 4. pref에 최근 메시지 시간 저장할 것 */
  //         HomeController.to.prefs.setString(
  //             "totalLastMsgCreatedAt", chatMessage.createdAt.toString());
  //       } else if (res["type"] == "exit") {
  //         /***** EXIT ******/
  //         /* 1. 메세지 저장 */
  //         ChatMessage chatMessage = new ChatMessage(
  //             roomId: res["roomId"],
  //             loginId: "",
  //             text: "${res["nickname"]}님이 퇴장하셨습니다.",
  //             type: "EXIT",
  //             createdAt: DateTime.parse(res["createdAt"]));
  //         chatRepository.insertMessage(chatMessage);

  //         /* 2. 멤버 삭제 */
  //         chatRepository.deleteChatRoomMemberInfo(
  //             res["roomId"], res["loginId"]);
  //         chatRepository.checkIsExistRoomMemberInfo(res["loginId"]).then(
  //             (value) => value
  //                 ? chatRepository.deleteMemberInfo(res["loginId"])
  //                 : print("삭제 x"));

  //         /* 3. 현재 위치가 해당방이면 ui 수정(chatdetail) */
  //         if (chatMessage.roomId == HomeController.to.chatRoomId.value)
  //           ChatDetailController.to.addMessage(chatMessage);

  //         /* 4. pref에 최근 메시지 시간 저장할 것 */
  //         HomeController.to.prefs.setString(
  //             "totalLastMsgCreatedAt", chatMessage.createdAt.toString());
  //       } else if (res["type"] == "update") {
  //         /***** UPDATE ******/
  //         /* 1. 멤버 수정 */
  //         ChatMemberInfo chatMemberInfo = new ChatMemberInfo.fromJson(res);
  //         chatRepository.insertOrUpdateMemberInfoOne(chatMemberInfo);

  //         /* 2. UI 수정 */
  //         changeMemberInfo(chatMemberInfo);
  //       } else {
  //         /* 1. 채팅방정보 저장 및 구독 */
  //         ChatRoom chatRoom = new ChatRoom(
  //             roomId: res["roomInfo"]["roomId"],
  //             title: res["roomInfo"]["title"],
  //             type: res["roomInfo"]["type"],
  //             lastMessage: "새로운 매칭입니다!",
  //             lastMsgCreatedAt: DateTime(2021, 5, 5),
  //             imageUrl: res["roomInfo"]["imageUrl"],
  //             unreadCount: 0);
  //         chatRepository.insertChatRoom(chatRoom);
  //         this.subscribeChatRoom(chatRoom.roomId);

  //         /* 2. 멤버 저장 */
  //         res["memberInfos"].forEach((memberInfo) {
  //           ChatMemberInfo chatMemberInfo =
  //               new ChatMemberInfo.fromJson(memberInfo);
  //           ChatRoomMemberInfo chatRoomMemberInfo = new ChatRoomMemberInfo(
  //               roomId: memberInfo["roomId"], loginId: memberInfo["loginId"]);
  //           chatRepository.insertOrUpdateMemberInfoOne(chatMemberInfo);
  //           chatRepository.insertRoomMemberInfoOne(chatRoomMemberInfo);
  //         });

  //         /* 3. chatsScreen 수정 */
  //         ChatController.to.insertItem(chatRoom);
  //       }
  //     },
  //   );
  //   print('구독성공: $roomId번 방 ');
  // }

  // void sendMessage(
  //     String roomId, String text, String type, String chatRoomType) {
  //   print("-----메세지 전송 => 내용: $text, 방번호: ${roomId}");
  //   stompClient.send(
  //     destination: '/pub/chat/message',
  //     body: json.encode({
  //       'roomId': roomId,
  //       'loginId': HomeController.to.loginId.value,
  //       'text': text,
  //       "type": type,
  //       "chatRoomType": chatRoomType,
  //     }),
  //   );
  // }

  // void changeMemberInfo(ChatMemberInfo chatMemberInfo) async {
  //   /* 2. 채팅방 내외부 이미지 및 nickname 변경해줘야함.*/
  //   // 2-1. chatdetail의 멤버 정보 변경
  //   // - loginId로 해당 loginId를 가진 모든 채팅방 찾고,
  //   // - 그 채팅방과 homecontroller의 roomid와 같으면 그 방 안에 있기에 멤버 변경
  //   // 2-2. chatsScreen의 imageurl 및 닉네임 변경
  //   // - 채팅방들 중 1:1인 방이 있다면(type =="single"), chatsScreen의 imageUrl, title 변경

  //   List<ChatRoom> chatRooms = await chatRepository
  //       .getChatRoomsByMemberLoginId(chatMemberInfo.loginId);

  //   chatRooms.forEach((chatRoom) {
  //     if (chatRoom.roomId == HomeController.to.chatRoomId.value)
  //       ChatDetailController.to.changeMember(chatMemberInfo);
  //     if (chatRoom.type == "single") {
  //       chatRoom.title = chatMemberInfo.nickname;
  //       chatRoom.imageUrl = chatMemberInfo.imageUrl;
  //       int index = ChatController.to.getExistRoomIndex(chatRoom.roomId);
  //       ChatController.to.replaceItem(chatRoom, index);
  //     }
  //   });
  // }
}
