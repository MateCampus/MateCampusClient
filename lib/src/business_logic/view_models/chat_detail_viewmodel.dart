import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:zamongcampus/src/business_logic/init/auth_service.dart';
import 'package:zamongcampus/src/business_logic/models/chatMemberInfo.dart';
import 'package:zamongcampus/src/business_logic/models/chatMessage.dart';
import 'package:zamongcampus/src/business_logic/models/chatRoom.dart';
import 'package:zamongcampus/src/business_logic/view_models/chat_viewmodel.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/object/prefs_object.dart';
import 'package:zamongcampus/src/services/chat/chat_service.dart';
import 'package:zamongcampus/src/services/user/user_service.dart';

import 'base_model.dart';

class ChatDetailViewModel extends BaseModel {
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
  // 1. scroll init 2. chatroom 설정 3. chatmessage,member load
  // 4. unreadCount 0으로 변경 5. chatvm의 roomId 변경
  chatDetailInit(ChatRoom chatRoom) async {
    print('chatDetailInit 시작');
    setBusy(true);
    resetData();
    scrollInit();
    await setChatRoom(chatRoom);
    await firstLoadForChatMessagesAndMember(chatRoom.roomId);
    await changeUnreadCount(chatRoom.roomId);
    ChatViewModel chatvm = serviceLocator<ChatViewModel>();
    chatvm.changeInsideRoomId(chatRoom.roomId);
    chatvm.getTotalUnreadCount();
    changeScrollToLowest();
    setBusy(false);
    print('chatDetailInit 끝');
  }

  setChatRoom(ChatRoom chatRoom) {
    this.chatRoom = chatRoom;
  }

  firstLoadForChatMessagesAndMember(String roomId) async {
    _chatMessages.addAll(await _chatService.getMessages(roomId, 0));
    List<ChatMemberInfo> chatMemberInfos =
        await _chatService.getMemberInfoes(roomId);
    for (var element in chatMemberInfos) {
      this.chatMemberInfos.addAll({element.loginId: element});
    }
  }

  changeUnreadCount(String roomId) {
    _chatService.updateUnreadCount(0, roomId);
    ChatViewModel chatViewModel = serviceLocator<ChatViewModel>();
    chatViewModel.changeUnreadCountToZero(roomId);

    /// chatroom 찾아서 unread 0으로 변경할 것.
  }
  // init 끝

  Future<void> addChatMessage(ChatMessage chatMessage) async {
    /// 실시간 오는 메세지
    setBusy(true);
    chatMessages.insert(0, chatMessage);
    changeScrollToLowest();
    print("실시간 메세지 더하기 완료");
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

//listview가 reverse여서 scroll도 반대로 생각해줘야함
  void _onScrollEvent() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      print("위 도착 load more");
      loadMoreChatMessages();
    } else if (scrollController.position.pixels ==
        scrollController.position.minScrollExtent) {
      print("아래 도착");
    } else {}
  }

  void changeScrollToLowest() {
    SchedulerBinding.instance?.addPostFrameCallback((_) {
      scrollController.animateTo(
        scrollController.position.minScrollExtent,
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

  Future<void> exitChatRoom(int chatRoomIndex) async {
    resetData();
    // await chatService.exitChatRoom(roomId: chatRoom.roomId);
    // _chatService
    //     .deleteChatRoomMemberInfoByRoomId(chatRoom.roomId); //얘도 안해도 되려나..안해도될것같다.
    // _chatService.deleteChatRoomByRoomId(chatRoom.roomId);
    _chatService.deleteMessageByRoomId(chatRoom.roomId);
    // chatService.deleteAllMemberInfo(); -> 얘는 해줘야할것같지만 다시 메세지가 올 때를 생각해서 해주면 안됨.
    ChatViewModel chatvm = serviceLocator<ChatViewModel>();
    chatvm.removeItemAndSaveSpare(chatRoomIndex, chatRoom.roomId, chatRoom);
  }

  Future<void> blockUserAndExit(int chatRoomIndex) async {
    ChatViewModel chatvm = serviceLocator<ChatViewModel>();
    resetData();
    //구독 끊기
    chatRoom.unsubscribeFn!(unsubscribeHeaders: {});
    //chat main list에서 지우기
    chatvm.removeItem(chatRoomIndex, chatRoom.roomId);

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
