import 'chat_service.dart';

class FakeChatService implements ChatService {
  @override
  fetchUnReceivedMessages() {
    // TODO: implement fetchUnReceivedMessages
    throw UnimplementedError();
  }

  @override
  sendMessage(String roomId, String loginId, String text, String type,
      String title, String chatRoomType) {
    // TODO: implement sendMessage
    throw UnimplementedError();
  }
}
