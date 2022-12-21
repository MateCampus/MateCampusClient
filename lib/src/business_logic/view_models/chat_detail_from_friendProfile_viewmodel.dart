import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:zamongcampus/src/business_logic/init/auth_service.dart';
import 'package:zamongcampus/src/business_logic/models/chatMemberInfo.dart';
import 'package:zamongcampus/src/business_logic/models/chatMessage.dart';
import 'package:zamongcampus/src/business_logic/models/chatRoom.dart';
import 'package:zamongcampus/src/business_logic/models/chatRoomMemberInfo.dart';
import 'package:zamongcampus/src/business_logic/utils/methods.dart';
import 'package:zamongcampus/src/business_logic/view_models/chat_viewmodel.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/object/prefs_object.dart';
import 'package:zamongcampus/src/object/stomp_object.dart';
import 'package:zamongcampus/src/services/chat/chat_service.dart';
import 'package:zamongcampus/src/services/user/user_service.dart';

import 'base_model.dart';

class ChatDetailFromFriendProfileViewModel extends BaseModel {
  bool _loadMoreBusy = false;
  bool get loadMoreBusy => _loadMoreBusy;
  final ChatService _chatService = serviceLocator<ChatService>();
  final UserService _userService = serviceLocator<UserService>();
  ChatRoom chatRoom = ChatRoom(
      roomId: "",
      title: "",
      type: "",
      lastMessage: "",
      lastMsgCreatedAt: DateTime(2021, 05, 05),
      imageUrl: "",
      unreadCount: 0);
  final List<ChatMessage> _chatMessages = List.empty(growable: true);
  int nextPageToken = 1;
  Map<String, ChatMemberInfo> chatMemberInfos = <String, ChatMemberInfo>{};
  ScrollController scrollController = ScrollController();

  List<ChatMessage> get chatMessages => _chatMessages;

  // init 시작
  // 1. scroll init 2. chatroom 설정(load) 3. chatmessage,member load
  // 4. unreadCount 0으로 변경 5. chatvm의 roomId 변경
  void chatDetailInit(String otherLoginId, BuildContext context) async {
    print('chatDetailfromfriendprofile Init 시작');
    setBusy(true);
    resetData();
    scrollInit();
    await loadChatRoom(otherLoginId, context);
    await loadFirstChatMessagesAndMember();
    await changeUnreadCount(chatRoom.roomId);
    ChatViewModel chatvm = serviceLocator<ChatViewModel>();
    chatvm.changeInsideRoomId(chatRoom.roomId);
    // 중요!! 이것이 일반 detail과 다른점 (changeFromFriendProfile)
    // => subscribe에서 오는 실시간 메세지를 어떤 vm에 넣어야하는지 구분을 위함(ui)
    chatvm.changeFromFriendProfile(true);
    await chatvm.getTotalUnreadCount();
    changeScrollToLowest();
    setBusy(false);
    print('chatDetailfromfriendprofile Init 끝');
  }

  /// 기존에 있는 방이면 해당 방으로.
  /// 아니면 새롭게 방을 만들 것.
  loadChatRoom(String otherLoginId, BuildContext context) async {
    /// 여기부분은 서버가 통신이 안되면 무조건 안 돌아가는 공간.
    var res =
        await _chatService.createOrGetChatRoom(otherLoginId: otherLoginId);

    if (res == false) {
      //차단된 상태여서 403으로 넘어올때
      toastMessage('대화를 걸 수 없는 상대입니다');
      Navigator.pop(context);
    } else {
      ChatViewModel chatViewModel = serviceLocator<ChatViewModel>();
      bool isExistRoom = false;
      //이 부분은 채팅방 메인에서 리스트가 사라지면 안돌아감(채팅방 나가기를 한 경우). 왜냐, ui 에서 지우려고 chatRooms를 지웠거든!
      //따라서 분기를 하나 더 주고, 채팅 리스트엔 없지만 구독이 되어있다면 존재한다고 판단해줘야함.
      for (var chatRoom in chatViewModel.chatRooms) {
        // 이미 존재하는 방 -> chat main 리스트에 있는 방
        if (chatRoom.roomId == res["createDto"]["roomInfo"]["roomId"]) {
          isExistRoom = true;
          this.chatRoom = chatRoom;
          break;
        }
      }
      if (!isExistRoom) {
        //챗 리스트에 존재하지 않는다면 로컬디비를 뒤져본다.
        ChatRoom? chatRoom = await _chatService
            .getChatRoomByRoomId(res["createDto"]["roomInfo"]["roomId"]);

        if (chatRoom != null) {
          //로컬 디비에 남아있는 경우(그러니까 채팅방 나가기를 해버려서 챗 리스트엔 없지만 구독을 끊은것이 아닌 방)
          isExistRoom = true;
          for (ChatRoom exitedChatRoom in chatViewModel.exitedChatRooms) {
            if (exitedChatRoom.roomId ==
                res["createDto"]["roomInfo"]["roomId"]) {
              ChatRoom chatRoom = exitedChatRoom;
              //1.바뀌어야 하는 정보 변경
              chatRoom.lastMessage = "메세지가 도착하였습니다";
              chatRoom.lastMsgCreatedAt = DateTime.now();
              chatRoom.unreadCount = 0;

              //2.vm에 저장
              this.chatRoom = chatRoom;

              //3.chatViewModel의 chatRooms에 넣어줌
              chatViewModel.insertItem(chatRoom);

              //4.다시 들어왔으니 exitedChatRooms에서는 지워준다.
              chatViewModel.exitedChatRooms.remove(exitedChatRoom);
              break;
            }
          }
        } else if (chatRoom == null) {
          //완전히 새로운방! 그러니까 여기서 방 만들어주고 구독도 해주는것이다.
          ChatRoom chatRoom = ChatRoom(
              roomId: res["createDto"]["roomInfo"]["roomId"],
              title: res["createDto"]["roomInfo"]["title"],
              type: res["createDto"]["roomInfo"]["type"],
              imageUrl: res["createDto"]["roomInfo"]["imageUrl"],
              lastMessage: "대화를 시작해보세요!",
              lastMsgCreatedAt: DateTime(2021, 5, 5),
              unreadCount: 0);
          List<ChatMemberInfo> chatMemberInfos = List.empty(growable: true);
          List<ChatRoomMemberInfo> chatRoomMemberInfos =
              List.empty(growable: true);
          for (var memberInfo in res["createDto"]["memberInfos"]) {
            chatMemberInfos.add(ChatMemberInfo.fromJson(memberInfo));
            chatRoomMemberInfos.add(ChatRoomMemberInfo(
                roomId: chatRoom.roomId, loginId: memberInfo["loginId"]));
          }

          /// 1. 새로운 방 구독
          chatRoom.unsubscribeFn =
              StompObject.subscribeChatRoom(chatRoom.roomId);

          /// 2. vm에 채팅방 저장
          this.chatRoom = chatRoom;

          /// 3. local storage에 채팅방, member 저장
          _chatService.insertChatRoom(chatRoom);
          _chatService.insertOrUpdateMemberInfo(chatMemberInfos);
          _chatService.insertChatRoomMemberInfo(chatRoomMemberInfos);

          /// 4. chatservice(vm)에 추가
          // ChatViewModel chatViewModel = serviceLocator<ChatViewModel>();
          chatViewModel.insertItem(chatRoom);
        }
      }
      print("load chatRoom 끝");
    }
  }

  loadFirstChatMessagesAndMember() async {
    print("loadFirstChatMessagesAndMember 시작");
    _chatMessages.addAll(await _chatService.getMessages(chatRoom.roomId, 0));
    List<ChatMemberInfo> chatMemberInfos =
        await _chatService.getMemberInfoes(chatRoom.roomId);
    for (var element in chatMemberInfos) {
      this.chatMemberInfos.addAll({element.loginId: element});
    }
  }

  changeUnreadCount(String roomId) {
    _chatService.updateUnreadCount(0, roomId);
  }
  // init 끝

  Future<void> addChatMessage(ChatMessage chatMessage) async {
    /// 실시간 오는 메세지
    setBusy(true);
    _chatMessages.insert(0, chatMessage);
    changeScrollToLowest();
    print("fromfriendProfile: 실시간 메세지 더하기 완료");
    setBusy(false);
  }

  changeMember(ChatMemberInfo chatMemberInfo) {
    chatMemberInfos.update(chatMemberInfo.loginId, (value) => chatMemberInfo);
    notifyListeners();
  }

  changeTitle(String nickname) {
    chatRoom.title = nickname;
    notifyListeners();
  }

  Future<void> loadMoreChatMessages() async {
    /// local storage에 있는 메세지 더 불러오기
    changeLoadMoreBusy(true);

    List<ChatMessage> result =
        await _chatService.getMessages(chatRoom.roomId, nextPageToken);
    chatMessages.insertAll(chatMessages.length, result); // ** 맨마지막에 더하기
    nextPageToken++;
    changeLoadMoreBusy(false);
  }

  void scrollInit() {
    scrollController.addListener(_onScrollEvent);
  }

  void _onScrollEvent() {
    if (scrollController.position.pixels ==
        scrollController.position.minScrollExtent) {
      print("위 도착 load more");
      loadMoreChatMessages();
    } else if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      print("아래 도착");
    } else {}
  }

  void changeScrollToLowest() {
    SchedulerBinding.instance?.addPostFrameCallback((_) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 50),
        curve: Curves.easeOut,
      );
    });
  }

  resetData() {
    _chatMessages.clear();
    chatMemberInfos.clear();
    nextPageToken = 1;
    scrollController.removeListener(_onScrollEvent);
  }

  void changeLoadMoreBusy(bool value) {
    _loadMoreBusy = value;
    notifyListeners();
  }

  Future<void> exitChatRoom() async {
    ChatViewModel chatvm = serviceLocator<ChatViewModel>();
    //chat_detail과 다른점 : chat_detail은 이미 index를 가지고 시작하는데, 여기는 그렇지 않음. 따라서 chatViewModel.chatRooms에서 현재 chatRoom에 대한 index를 따로 구해줘야함.
    int index = chatvm.chatRooms.indexOf(chatRoom);
    resetData();
    _chatService.deleteMessageByRoomId(chatRoom.roomId);
    chatvm.removeItemAndSaveSpare(index, chatRoom.roomId, chatRoom);
  }

  Future<void> blockUserAndExit() async {
    ChatViewModel chatvm = serviceLocator<ChatViewModel>();
    //chat_detail과 다른점 : chat_detail은 이미 index를 가지고 시작하는데, 여기는 그렇지 않음. 따라서 chatViewModel.chatRooms에서 현재 chatRoom에 대한 index를 따로 구해줘야함.
    int index = chatvm.chatRooms.indexOf(chatRoom);
    resetData();
    //구독 끊기
    chatRoom.unsubscribeFn!(unsubscribeHeaders: {});
    //chat main list에서 지우기
    chatvm.removeItem(index, chatRoom.roomId);

    //차단하려는 유저 아이디 찾기
    String targetLoginId = "";
    List<ChatMemberInfo> chatMemberInfos =
        await _chatService.getMemberInfoes(chatRoom.roomId);
    for (var member in chatMemberInfos) {
      if (member.loginId != AuthService.loginId) {
        targetLoginId = member.loginId;
        print('차단하려는 유저의 로그인 아이디는? ' + targetLoginId);
        break;
      }
    }

    //로컬디비에 차단하려는 유저 아이디 저장
    PrefsObject.setBlockedUser(targetLoginId);

    //유저 차단
    await _userService.blockUser(targetLoginId: targetLoginId);

    //채팅관련 로컬 디비 삭제
    _chatService.deleteMessageByRoomId(chatRoom.roomId);
    _chatService.deleteChatRoomMemberInfoByRoomId(chatRoom.roomId);
    _chatService.deleteChatRoomByRoomId(chatRoom.roomId);
    _chatService.deleteAllMemberInfo();
  }
}
