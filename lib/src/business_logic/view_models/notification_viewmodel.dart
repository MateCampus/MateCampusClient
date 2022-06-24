import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/models/notificationZC.dart';
import 'package:zamongcampus/src/business_logic/utils/date_convert.dart';
import 'package:zamongcampus/src/business_logic/view_models/base_model.dart';
import 'package:zamongcampus/src/ui/views/notification/notification_main/components/notification_list_tile.dart';

class NotificationViewModel extends BaseModel {
  List<NotificationPresentation> _notifications = List.empty(growable: true);
  final _listKey = GlobalKey<AnimatedListState>();

  List<NotificationPresentation> get notifications => _notifications;
  GlobalKey<AnimatedListState> get listKey => _listKey;

  void loadNotifications() {
    setBusy(true);
    List<NotificationZC> notiResult = fakeNotificationList; //일단은 페이크데이터
    _notifications = notiResult
        .map(
          (notification) => NotificationPresentation(
              body: changeTypeToWord(notification.type),
              loginId: notification.loginId,
              nickname: notification.userNickname,
              imageUrl: notification.imageUrl ??
                  "assets/images/user/general_user.png",
              createdAt: dateToElapsedTimeOnChatMain(notification.createdAt)),
        )
        .toList();
    setBusy(false);
  }

  String changeTypeToWord(int type) {
    switch (type) {
      case 1:
        return "님이 피드에 댓글을 달았습니다.";
      case 2:
        return "님이 새로운 메세지를 보냈습니다";
      case 3:
        return "님이 음성대화방에 초대했습니다.";
      case 4:
        return "님에게 친구 신청이 도착했습니다.";
      case 5:
        return "님이 당신의 친구 요청을 수락했습니다.";
      default:
        break;
    }
    return "";
  }

  void insertItem() {
    final newNotification = NotificationPresentation(
        body: changeTypeToWord(fakeNewNoti.type),
        loginId: fakeNewNoti.loginId,
        nickname: fakeNewNoti.userNickname,
        imageUrl: fakeNewNoti.imageUrl ?? "assets/images/user/general_user.png",
        createdAt: dateToElapsedTimeOnChatMain(fakeNewNoti.createdAt));
    _notifications.insert(0, newNotification);
    listKey.currentState!.insertItem(0);

    notifyListeners();
  }

  void removeItem(int index) {
    final removeItem = _notifications[index];
    _notifications.removeAt(index);
    listKey.currentState!.removeItem(
        index,
        (context, animation) => NotificationListTile(
            notification: removeItem, animation: animation, onClicked: () {}));
    notifyListeners();
  }
}

class NotificationPresentation {
  final String body;
  final String loginId;
  final String nickname;
  final String imageUrl;
  final String createdAt;

  NotificationPresentation(
      {required this.body,
      required this.loginId,
      required this.nickname,
      required this.imageUrl,
      required this.createdAt});
}

List<NotificationZC> fakeNotificationList = [
  NotificationZC(
      type: 1,
      loginId: "aaa",
      userNickname: "가나초코릿",
      imageUrl: 'assets/images/user/user1.jpg',
      createdAt: DateTime(22, 06, 21)),
  NotificationZC(
      type: 1,
      loginId: "bbb",
      userNickname: "나비야",
      imageUrl: 'assets/images/user/user2.jpg',
      createdAt: DateTime(22, 06, 22)),
  NotificationZC(
      type: 1,
      loginId: "ccc",
      userNickname: "다람쥐",
      imageUrl: 'assets/images/user/user3.jpg',
      createdAt: DateTime(22, 06, 23)),
  NotificationZC(
      type: 1,
      loginId: "ddd",
      userNickname: "라디오헤드",
      imageUrl: 'assets/images/user/user4.jpg',
      createdAt: DateTime(22, 06, 21)),
  NotificationZC(
      type: 1,
      loginId: "eee",
      userNickname: "마동석짱",
      createdAt: DateTime(22, 06, 21)),
  NotificationZC(
      type: 1,
      loginId: "fff",
      userNickname: "바름이",
      createdAt: DateTime(22, 06, 21)),
];

NotificationZC fakeNewNoti = NotificationZC(
    type: 1,
    loginId: "abbaba",
    userNickname: '사과주스',
    imageUrl: 'assets/images/user/user5.jpg',
    createdAt: DateTime.now());
