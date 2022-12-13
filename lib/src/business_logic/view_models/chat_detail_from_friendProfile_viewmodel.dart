import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:stomp_dart_client/stomp_handler.dart';
import 'package:zamongcampus/src/business_logic/models/chatMemberInfo.dart';
import 'package:zamongcampus/src/business_logic/models/chatMessage.dart';
import 'package:zamongcampus/src/business_logic/models/chatRoom.dart';
import 'package:zamongcampus/src/business_logic/models/chatRoomMemberInfo.dart';
import 'package:zamongcampus/src/business_logic/utils/methods.dart';
import 'package:zamongcampus/src/business_logic/view_models/chat_viewmodel.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/object/stomp_object.dart';
import 'package:zamongcampus/src/services/chat/chat_service.dart';

import 'base_model.dart';

class ChatDetailFromFriendProfileViewModel extends BaseModel {
  bool _loadMoreBusy = false;
  bool get loadMoreBusy => _loadMoreBusy;
  ChatService chatService = serviceLocator<ChatService>();
  StompUnsubscribe? unsubscribeFn;
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
    print('chatDetailInit 시작');
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
    changeScrollToLowest();
    setBusy(false);
    print('chatDetailInit 끝');
  }

  /// 기존에 있는 방이면 해당 방으로.
  /// 아니면 새롭게 방을 만들 것.
  loadChatRoom(String otherLoginId, BuildContext context) async {
    /// 여기부분은 서버가 통신이 안되면 무조건 안 돌아가는 공간.
    var res = await chatService.createOrGetChatRoom(otherLoginId: otherLoginId);
    if (res==false){
      toastMessage('채팅방을 만들 수 없습니다');
      Navigator.pop(context);
      

    }else{
       ChatViewModel chatViewModel = serviceLocator<ChatViewModel>();
    bool isExistRoom = false;
    //이 부분은 채팅방 메인에서 리스트가 사라지면 안돌아감. 왜냐, ui 에서 지우려고 chatRooms를 지웠거든!
    //따라서 분기를 하나 더 주고, 이미 구독되어있다면 존재한다고 판단해줘야함.
    for (var chatRoom in chatViewModel.chatRooms) {
      if (chatRoom.roomId == res["createDto"]["roomInfo"]["roomId"]) {
        isExistRoom = true;
        this.chatRoom = chatRoom; // 이미 존재하는 방 -> chat main 리스트에 있는 방
        break;
      }
    }
    if (!isExistRoom) {
      ChatRoom? chatRoom = await chatService
          .getChatRoomByRoomId(res["createDto"]["roomInfo"]["roomId"]);

      if (chatRoom !=null) {
        isExistRoom = true;
        this.chatRoom = chatRoom;
      } else if (chatRoom ==null) {
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

        /// 1. vm에 채팅방 저장
        this.chatRoom = chatRoom;

        /// 2. 새로운 방 구독
       unsubscribeFn = await StompObject.subscribeChatRoom(chatRoom.roomId);

        /// 3. local storage에 채팅방, member 저장
        chatService.insertChatRoom(chatRoom);
        chatService.insertOrUpdateMemberInfo(chatMemberInfos);
        chatService.insertChatRoomMemberInfo(chatRoomMemberInfos);

        /// 4. chatservice(vm)에 추가
        ChatViewModel chatViewModel = serviceLocator<ChatViewModel>();
        chatViewModel.insertItem(chatRoom);
      }
    }
    print("load chatRoom 끝");
    }
   
  }

  loadFirstChatMessagesAndMember() async {
    print("loadFirstChatMessagesAndMember 시작");
    _chatMessages.addAll(await chatService.getMessages(chatRoom.roomId, 0));
    List<ChatMemberInfo> chatMemberInfos =
        await chatService.getMemberInfoes(chatRoom.roomId);
    for (var element in chatMemberInfos) {
      this.chatMemberInfos.addAll({element.loginId: element});
    }
  }

  changeUnreadCount(String roomId) {
    chatService.updateUnreadCount(0, roomId);
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
  }

  changeTitle(String nickname) {
    chatRoom.title = nickname;
    notifyListeners();
  }

  Future<void> loadMoreChatMessages() async {
    /// local storage에 있는 메세지 더 불러오기
    changeLoadMoreBusy(true);

    List<ChatMessage> result =
        await chatService.getMessages(chatRoom.roomId, nextPageToken);
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
      print("위 도착 load morez");
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

  void unsubscribetest(){
    unsubscribeFn!(unsubscribeHeaders: {});
    print('구독끊기');
  }
}
