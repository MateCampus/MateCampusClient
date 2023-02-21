import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'package:stomp_dart_client/stomp_handler.dart';
import 'package:zamongcampus/src/business_logic/arguments/chat_detail_screen_args.dart';
import 'package:zamongcampus/src/business_logic/init/auth_service.dart';
import 'package:zamongcampus/src/business_logic/models/chatMemberInfo.dart';
import 'package:zamongcampus/src/business_logic/models/chatMessage.dart';
import 'package:zamongcampus/src/business_logic/models/chatRoom.dart';
import 'package:zamongcampus/src/business_logic/models/chatRoomMemberInfo.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/chat_detail_from_friendProfile_viewmodel.dart';
import 'package:zamongcampus/src/business_logic/view_models/chat_detail_viewmodel.dart';
import 'package:zamongcampus/src/business_logic/view_models/chat_viewmodel.dart';
import 'package:zamongcampus/src/business_logic/view_models/home_viewmodel.dart';
import 'package:zamongcampus/src/config/navigation_service.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/object/firebase_object.dart';
import 'package:zamongcampus/src/object/prefs_object.dart';
import 'package:zamongcampus/src/object/secure_storage_object.dart';
import 'package:zamongcampus/src/services/chat/chat_service.dart';
import 'package:zamongcampus/src/services/notification/notification_service.dart';

import '../business_logic/arguments/post_detail_screen_args.dart';
import '../business_logic/models/enums/messageType.dart';

//TODO: 지금 헤더쓰는 부분들을 죄다 async로 바꿨는데 이러면 속도적인 부분에서 느려지지 않는지 확인이 필요함. 특히 채팅 메세지 보내는 부분..
class StompObject {
  static late StompClient _stompClient;

  static StompClient get stompClient => _stompClient;

  static Future<void> connectStomp() async {
    String? accessToken = await SecureStorageObject.getAccessToken();
    String? refreshToken = await SecureStorageObject.getRefreshToken();
    print("stomp init start");
    _stompClient = StompClient(
      config: StompConfig.SockJS(
        url: devServer + '/ws-stomp',
        onConnect: onConnect,
        beforeConnect: () async {
          print('stomp 연결 중 ...');
        },
        onWebSocketError: (dynamic error) => print(error.toString()),
        stompConnectHeaders: AuthService.get_auth_header(
            accessToken: accessToken, refreshToken: refreshToken),
        webSocketConnectHeaders: AuthService.get_auth_header(
            accessToken: accessToken, refreshToken: refreshToken),
      ),
    );
    _stompClient.activate(); // 서버 실행
    _stompClient = _stompClient; // stompClient 초기화
  }

  // connect 성공
  static dynamic onConnect(StompFrame frame) async {
    print('stomp 연결 완료');
    if (AuthService.loginId != null && AuthService.token != null) {
      /// (23.02.22) 일단, loadchatRooms 자체를 두번해야하는것같다. 이유는 모르겠음. 새롭게 받아온 메세지들 때문인거 같은데. 리팩필요
      /// 아무튼 authService 에서 한번 불러온 상태이고
      /// 1. fcm 토큰 구독 
      /// 2.밀린 메세지 불러와서 로컬 디비에 세팅
      /// 3. 다시 로컬 디비에서 chatRooms들 불러옴.
      /// 4. 그리고 그 불러온 chatRoom들 모두 구독
      /// 5. 안읽은 메세지 갯수 체크
     
     //1
      subscribeChatRoom(FirebaseObject.deviceFcmToken);

      ChatViewModel chatViewModel = serviceLocator<ChatViewModel>();
      //2
      await chatViewModel.setChatRoomByNewMessages();
      //3
      await chatViewModel.loadChatRooms();
      //4
      for (ChatRoom chatRoom in chatViewModel.chatRooms) {
        chatRoom.unsubscribeFn = subscribeChatRoom(chatRoom.roomId);
        print(chatRoom.roomId+'번 방 구독하는중');
      }
      //5
      await chatViewModel.getTotalUnreadCount();
      /* 백그라운드 상태 (Terminated messages) */
      RemoteMessage? remoteMessage =
          await FirebaseMessaging.instance.getInitialMessage();
      if (remoteMessage != null) {
        print(remoteMessage.data);
        if (remoteMessage.data["navigate"] != null &&
            remoteMessage.data["navigate"] != "/chatDetail") {
          NotificationService notificationService =
              serviceLocator<NotificationService>();
          notificationService.updateMyNotificationRead(
              id: int.parse(remoteMessage.data["notificationId"]));
        }
        switch (remoteMessage.data["navigate"]) {
          case "/chatDetail":
            HomeViewModel homeViewModel = serviceLocator<HomeViewModel>();
            ChatViewModel chatViewModel = serviceLocator<ChatViewModel>();

            ChatRoom chatRoom =
                chatViewModel.getChatRoomForFcm(remoteMessage.data["roomId"]);
            if (chatRoom.roomId == remoteMessage.data["roomId"]) {
              homeViewModel.changeCurrentIndex(1);
              NavigationService().pushNamedAndRemoveUntil(
                  "/chatDetail",
                  "/",
                  ChatDetailScreenArgs(
                      chatRoom,
                      chatViewModel
                          .getExistRoomIndex(remoteMessage.data["roomId"])));
            } else {
              //혹시 chatRoom 삽입(=stomp 구독)이 느렸을경우엔, chatMain 페이지로 넘겨버림
              print('chatmain에서 chatRoom 못찾아서 chatdetail로 못가고 chatmain 으로 왔당');
              NavigationService()
                  .pushNamedAndRemoveUntilWithoutArgs("/", "/");
            }
            break;
          case "/voiceDetail":
            break;
          case "/postDetail":
            NavigationService().pushNamedAndRemoveUntil("/postDetail", "/",
                PostDetailScreenArgs(int.parse(remoteMessage.data["postId"])));
            HomeViewModel homeViewModel = serviceLocator<HomeViewModel>();
            homeViewModel.changeCurrentIndex(0);
            break;
          case "/friend":
            break;
          default:
            break;
        }
      }
      
    }
  }

  // roomId로 오는 메세지
  static StompUnsubscribe subscribeChatRoom(String? roomId) {
    // String? accessToken = await SecureStorageObject.getAccessToken();
    // String? refreshToken = await SecureStorageObject.getRefreshToken();

    ChatService _chatService = serviceLocator<ChatService>();
    ChatViewModel chatViewModel = serviceLocator<ChatViewModel>();

    ChatDetailViewModel chatDetailViewModel =
        serviceLocator<ChatDetailViewModel>();
    ChatDetailFromFriendProfileViewModel chatDetailFromFriendProfileViewModel =
        serviceLocator<ChatDetailFromFriendProfileViewModel>();

    StompUnsubscribe unsubscribeFn = stompClient.subscribe(
      headers: {},
      destination: '/sub/chat/room/$roomId',
      callback: (frame) async {
        // ** 메시지 도착 시점
        print("----- 새로운 메세지 도착 -----");
        var res = json.decode(frame.body ?? "");

        if (res["type"] == "talk") {
          /***** TALK ******/
          ChatMessage chatMessage =
              ChatMessage.fromJsonRoomId(res["messageDto"], res["roomId"]);
          // 1. 메세지 저장
          _chatService.insertMessage(chatMessage);
          // 2. local db의 chatroom 내용 변경 => 이미 그 방 안이면 0, 아니면 1 추가
          _chatService.updateChatRoom(
              lastMsg: chatMessage.text,
              lastMsgCreatedAt: chatMessage.createdAt,
              unreadCount:
                  chatMessage.roomId == chatViewModel.insideRoomId ? 0 : 1,
              roomId: chatMessage.roomId);

          // 3. pref에 최근 메시지 시간 저장할 것
          PrefsObject.setTotalLastMsgCreatedAt(
              chatMessage.createdAt.toIso8601String());

          // UI: 현재 위치가 해당방이면 ui 수정(chatdetail)
          if (chatMessage.roomId == chatViewModel.insideRoomId) {
            if (chatViewModel.fromFriendProfile) {
              chatDetailFromFriendProfileViewModel.addChatMessage(chatMessage);
            } else {
              chatDetailViewModel.addChatMessage(chatMessage);
            }
          }
          // ** UI(chatsScreen) 변경
          int index = chatViewModel.getExistRoomIndex(chatMessage.roomId!);
          // ChatRoom chatRoom = chatViewModel.chatRooms[index];
          if (index == 0) {
            // 최상단 : 업데이트만 => lastmsg, unreadcount, lastMsgCreatedAt
            ChatRoom chatRoom = chatViewModel.chatRooms[index];
            chatRoom.lastMessage = chatMessage.text;
            chatRoom.lastMsgCreatedAt = chatMessage.createdAt;
            // 해당 방 안에 아닐 때만 unreadcount 변경
            if (chatMessage.roomId != chatViewModel.insideRoomId) {
              chatRoom.unreadCount = chatRoom.unreadCount + 1;
            }
            chatViewModel.replaceItem(chatRoom, index);
          } else {
            // 최상단 아니면 => 1. 기존 방: 방 지웠다가 새롭게 방 추가  2. 완전 처음 방: 새롭게 방만 추가

            if (index >= 0) {
              // 기존에 있는 방: unreadCount, lastMsg, lastMsgCreatedAt 변경
              // 현재 그 방 안이라면 0으로 값 변경
              // 아니면 삭제(removeItem)하면서 unreadcount 반환 (그 값으로 변경)
              ChatRoom chatRoom = chatViewModel.chatRooms[index];
              int unreadCount =
                  chatViewModel.removeItem(index, chatRoom.roomId);
              if (chatMessage.roomId == chatViewModel.insideRoomId) {
                chatRoom.unreadCount = 0;
              } else {
                chatRoom.unreadCount = unreadCount + 1;
              }
              chatRoom.lastMessage = chatMessage.text;
              chatRoom.lastMsgCreatedAt = chatMessage.createdAt;
              chatViewModel.insertItem(chatRoom);
            } else if (index == -1) {
              ///한번 나간 방에서 다시 메세지가 올 때.
              ///이 때는 chatViewModel.chatRooms에는 없지만 chatViewModel.exitedChatRooms 에는 있다.
              ///여기서 꺼내와야함. 그래야 구독끊는 함수가 그대로 저장되어있음

              for (ChatRoom exitedChatRoom in chatViewModel.exitedChatRooms) {
                if (exitedChatRoom.roomId == res["roomId"]) {
                  ChatRoom chatRoom = exitedChatRoom;
                  //1.바뀌어야 하는 정보 변경
                  chatRoom.lastMessage = chatMessage.text;
                  chatRoom.lastMsgCreatedAt = chatMessage.createdAt;
                  chatRoom.unreadCount = 1;
                  //2. chatsScreen 수정
                  chatViewModel.insertItem(chatRoom);
                  //나갔다가 다시 들어가는거니까 더이상 나간방에 스페어로 저장해둘 필요없음. 오히려 계속 놔두면 같은방을 또 나갔을때 여기 계속 쌓이게 됨. 그래서 지워준다.
                  //아직 테스트는 안해봄(12.15)
                  chatViewModel.exitedChatRooms.remove(exitedChatRoom);
                  break;
                }
              }
            }
          }
          chatViewModel.getTotalUnreadCount();
        } else if (res["type"] == "enter") {
          /***** ENTER ******/
          /* 1. 메세지 저장 */
          ChatMessage chatMessage = ChatMessage(
              roomId: res["roomId"],
              loginId: "",
              text: res["body"],
              type: MessageType.ENTER,
              createdAt: DateTime.parse(res["createdAt"]));
          _chatService.insertMessage(chatMessage);

          /* 2. 멤버 저장 */
          ChatMemberInfo chatMemberInfo = ChatMemberInfo.fromJson(res);
          ChatRoomMemberInfo chatRoomMemberInfo = ChatRoomMemberInfo(
              roomId: res["roomId"], loginId: res["loginId"]);
          _chatService.insertOrUpdateMemberInfoOne(chatMemberInfo);
          _chatService.insertChatRoomMemberInfoOne(chatRoomMemberInfo);

          /* 3. 현재 위치가 해당방이면 ui 수정(chatdetail) */
          if (chatMessage.roomId == chatViewModel.insideRoomId) {
            if (chatViewModel.fromFriendProfile) {
              chatDetailFromFriendProfileViewModel.addChatMessage(chatMessage);
            } else {
              chatDetailViewModel.addChatMessage(chatMessage);
            }
          }

          /* 4. pref에 최근 메시지 시간 저장할 것 */
          PrefsObject.setTotalLastMsgCreatedAt(
              chatMessage.createdAt.toIso8601String());
        } else if (res["type"] == "exit") {
          /***** EXIT ******/
          /* 1. 메세지 저장 */
          ChatMessage chatMessage = ChatMessage(
              roomId: res["roomId"],
              loginId: "",
              text: res["body"],
              type: MessageType.EXIT,
              createdAt: DateTime.parse(res["createdAt"]));
          _chatService.insertMessage(chatMessage);

          /* 2. 멤버 삭제 */
          _chatService.deleteChatRoomMemberInfo(res["roomId"], res["loginId"]);
          if (_chatService.isExistChatRoomMemberInfo(res["loginId"])) {
            _chatService.deleteMemberInfo(res["loginId"]);
          }

          /* 3. 현재 위치가 해당방이면 ui 수정(chatdetail) */
          if (chatMessage.roomId == chatViewModel.insideRoomId) {
            if (chatViewModel.fromFriendProfile) {
              chatDetailFromFriendProfileViewModel.addChatMessage(chatMessage);
            } else {
              chatDetailViewModel.addChatMessage(chatMessage);
            }
          }

          /* 4. pref에 최근 메시지 시간 저장할 것 */
          PrefsObject.setTotalLastMsgCreatedAt(
              chatMessage.createdAt.toIso8601String());
        } else if (res["type"] == "update") {
          /***** UPDATE ******/
          /* 1. 멤버 수정 */
          ChatMemberInfo chatMemberInfo = ChatMemberInfo.fromJson(res);
          _chatService.insertOrUpdateMemberInfoOne(chatMemberInfo);

          /* 2. UI 수정 */
          _changeMemberInfo(chatMemberInfo);
        } else {
          /***** CREATE ******/
          /* 1. 채팅방정보 저장 및 구독 */
          ChatRoom chatRoom = ChatRoom(
              roomId: res["roomInfo"]["roomId"],
              title: res["roomInfo"]["title"],
              type: res["roomInfo"]["type"],
              lastMessage: "대화를 시작해보세요!",
              lastMsgCreatedAt:
                  DateTime(2021, 5, 5), //TODO: DateTime.now()로 바꾸기
              imageUrl: res["roomInfo"]["imageUrl"],
              unreadCount: 0);
          _chatService.insertChatRoom(chatRoom);
          chatRoom.unsubscribeFn = subscribeChatRoom(chatRoom.roomId);

          /* 2. 멤버 저장 */
          res["memberInfos"].forEach((memberInfo) {
            ChatMemberInfo chatMemberInfo = ChatMemberInfo.fromJson(memberInfo);
            ChatRoomMemberInfo chatRoomMemberInfo = ChatRoomMemberInfo(
                roomId: chatRoom.roomId, loginId: memberInfo["loginId"]);
            _chatService.insertOrUpdateMemberInfoOne(chatMemberInfo);
            _chatService.insertChatRoomMemberInfoOne(chatRoomMemberInfo);
          });

          // /* 3. chatsScreen 수정 */
          chatViewModel.insertItem(chatRoom);
          chatViewModel.getTotalUnreadCount();
        }
      },
    );
    print('stomp에 존재하는 방: $roomId번 방 ');
    return unsubscribeFn;
  }

  static void deactivateStomp() {
    /// stomp 연결 제거하기 -> 로그아웃 시 활용
    stompClient.deactivate();
  }

  static Future<void> sendMessage(
      String roomId, String text, String type, String chatRoomType) async {
    String? accessToken = await SecureStorageObject.getAccessToken();
    String? refreshToken = await SecureStorageObject.getRefreshToken();
    print("-----메세지 전송 => 내용: $text, 방번호: ${roomId}");
    stompClient.send(
        destination: '/pub/chat/message',
        body: json.encode({
          'roomId': roomId,
          'loginId': AuthService.loginId,
          'text': text,
          "type": type,
          "chatRoomType": chatRoomType,
        }),
        headers: AuthService.get_auth_header(
            accessToken: accessToken, refreshToken: refreshToken));
    print('일단 서버로 보냄');
  }

  static void _changeMemberInfo(ChatMemberInfo chatMemberInfo) async {
    /* 2. 채팅방 내외부 이미지 및 nickname 변경해줘야함.*/
    // 2-1. chatdetail의 멤버 정보 변경
    // - loginId로 해당 loginId를 가진 모든 채팅방 찾고,
    // - 그 채팅방과 homecontroller의 roomid와 같으면 그 방 안에 있기에 멤버 변경
    // 2-2. chatsScreen의 imageurl 및 닉네임 변경
    // - 채팅방들 중 1:1인 방이 있다면(type =="single"), chatsScreen의 imageUrl, title 변경
    ChatService _chatService = serviceLocator<ChatService>();
    ChatViewModel chatViewModel = serviceLocator<ChatViewModel>();
    ChatDetailViewModel chatDetailViewModel =
        serviceLocator<ChatDetailViewModel>();
    ChatDetailFromFriendProfileViewModel chatDetailFromFriendProfileViewModel =
        serviceLocator<ChatDetailFromFriendProfileViewModel>();
    List<ChatRoom> chatRooms =
        await _chatService.getChatRoomsByMemberLoginId(chatMemberInfo.loginId);

    chatRooms.forEach((chatRoom) {
      if (chatRoom.roomId == chatViewModel.insideRoomId) {
        if (chatViewModel.fromFriendProfile) {
          chatDetailFromFriendProfileViewModel.changeMember(chatMemberInfo);
          if (chatRoom.type == "single") {
            chatDetailFromFriendProfileViewModel
                .changeTitle(chatMemberInfo.nickname);
          }
        } else {
          chatDetailViewModel.changeMember(chatMemberInfo);
          if (chatRoom.type == "single") {
            chatDetailViewModel.changeTitle(chatMemberInfo.nickname);
          }
        }
      }
      if (chatRoom.type == "single") {
        // 1:1이면 채팅방의 타이틀, 이미지를 nickname, imageUrl로 변경
        _chatService.updateTitleImageUrlChatRoom(
            title: chatMemberInfo.nickname,
            imageUrl: chatMemberInfo.imageUrl,
            roomId: chatRoom.roomId);
        chatRoom.title = chatMemberInfo.nickname;
        chatRoom.imageUrl = chatMemberInfo.imageUrl;
        int index = chatViewModel.getExistRoomIndex(chatRoom.roomId);
        chatViewModel.replaceItem(chatRoom, index);
      }
    });
  }
}
