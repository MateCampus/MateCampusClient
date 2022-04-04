import 'package:zamongcampus/src/services/chat/chat_service.dart';

class ChatServiceImpl implements ChatService {
  @override
  Future<dynamic> fetchUnReceivedMessages() async {
    String totalLastMsgCreatedAt =
        HomeController.to.prefs.getString("totalLastMsgCreatedAt") == null
            ? DateTime(2021, 5, 5).toString()
            : HomeController.to.prefs.getString("totalLastMsgCreatedAt");
    print(totalLastMsgCreatedAt);
    final response = await http.get(devServer +
        "/api/chat/message?loginId=" +
        HomeController.to.loginId.value +
        "&totalLastMsgCreatedAt=" +
        totalLastMsgCreatedAt);
    if (response.statusCode == 200) {
      dynamic newMessages = jsonDecode(utf8.decode(response.bodyBytes));
      // 여기서 json으로 변경 해야해ㅐㅐㅐㅐㅐ!!
      print("fetchChatRooms!");
      return newMessages;
    } else {
      print("fetchChatrooms 서버 잘못된 경우");
      return {};
      // throw Exception('Failed to load chatRooms');
    }
  }

  @override
  sendMessage(String roomId, String loginId, String text, String type,
      String title, String chatRoomType) {
    // TODO: implement sendMessage
    throw UnimplementedError();
  }
}
