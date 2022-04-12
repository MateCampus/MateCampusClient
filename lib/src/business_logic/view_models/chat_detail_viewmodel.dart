import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:zamongcampus/src/business_logic/models/chatMemberInfo.dart';
import 'package:zamongcampus/src/business_logic/models/chatMessage.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/services/chat/chat_service.dart';

import 'base_model.dart';

class ChatDetailViewModel extends BaseModel {
  ChatService chatService = serviceLocator<ChatService>();
  List<ChatMessage> _chatMessages = [];
  String _title = "";
  int nextPageToken = 1;
  Map<String, ChatMemberInfo> chatMemberInfos = <String, ChatMemberInfo>{};
  ScrollController scrollController = ScrollController();

  List<ChatMessage> get chatMessages => _chatMessages;
  String get title => _title;

  Future<void> loadChatMessages() async {
    print("load chatMessage 완료");
  }

  Future<void> addChatMessage(ChatMessage chatMessage) async {
    print("load chatMessage 완료");
  }

  changeMember(ChatMemberInfo chatMemberInfo) {
    chatMemberInfos.update(chatMemberInfo.loginId, (value) => chatMemberInfo);
  }

  Future<void> loadMoreChatMessages() async {
    // TODO: vm에서 vm을? -> 좀 이상한 것 같은데
    // 그러면 그냥 chatroomID를 전역변수로?
    setBusy(true);
    List<ChatMessage> result = await chatService.getMessages(
        HomeController.to.chatRoomId.value, nextPageToken);
    await Future.delayed(Duration(milliseconds: 500));
    chatMessages.insertAll(chatMessages.length, result); // ** 맨마지막에 더하기
    nextPageToken++;
    setBusy(false);
  }

  void _scrollInit() {
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
