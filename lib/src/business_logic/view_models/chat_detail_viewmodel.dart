import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:zamongcampus/src/business_logic/models/chatMemberInfo.dart';
import 'package:zamongcampus/src/business_logic/models/chatMessage.dart';
import 'package:zamongcampus/src/business_logic/models/chatRoom.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/services/chat/chat_service.dart';

import 'base_model.dart';

class ChatDetailViewModel extends BaseModel {
  ChatService chatService = serviceLocator<ChatService>();
  late ChatRoom chatRoom;
  late int index;
  final List<ChatMessage> _chatMessages = List.empty(growable: true);
  int nextPageToken = 1;
  Map<String, ChatMemberInfo> chatMemberInfos = <String, ChatMemberInfo>{};
  ScrollController scrollController = ScrollController();

  List<ChatMessage> get chatMessages => _chatMessages;

  changeUnreadCount(String roomId) {
    chatService.updateUnreadCount(0, roomId);
  }

  void setChatRoomAndIndex(ChatRoom chatRoom, int index) {
    this.chatRoom = chatRoom;
    this.index = index;
  }

  void getChatMessagesAndMember(String roomId) async {
    setBusy(true);
    _chatMessages.addAll(await chatService.getMessages(roomId, 0));
    List<ChatMemberInfo> chatMemberInfos =
        await chatService.getMemberInfoes(roomId);
    for (var element in chatMemberInfos) {
      this.chatMemberInfos.addAll({element.loginId: element});
    }
    setBusy(false);
  }

  Future<void> addChatMessage(ChatMessage chatMessage) async {
    chatMessages.insert(0, chatMessage);
    changeScrollToLowest();
    print("load chatMessage 완료");
  }

  changeMember(ChatMemberInfo chatMemberInfo) {
    chatMemberInfos.update(chatMemberInfo.loginId, (value) => chatMemberInfo);
  }

  Future<void> loadMoreChatMessages() async {
    setBusy(true);
    List<ChatMessage> result =
        await chatService.getMessages(chatRoom.roomId, nextPageToken);
    await Future.delayed(Duration(milliseconds: 500));
    chatMessages.insertAll(chatMessages.length, result); // ** 맨마지막에 더하기
    nextPageToken++;
    setBusy(false);
  }

  void scrollInit() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        print("위 도착");
        loadMoreChatMessages();
      } else if (scrollController.position.pixels == 0) {
        print("아래 도착 reload");
      } else {
        print(scrollController.position.pixels);
      }
    });
  }

  void changeScrollToLowest() {
    SchedulerBinding.instance?.addPostFrameCallback((_) {
      scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 50),
        curve: Curves.easeOut,
      );
    });
  }
}
