import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/arguments/post_detail_screen_args.dart';
import 'package:zamongcampus/src/business_logic/arguments/voice_detail_screen_args.dart';
import 'package:zamongcampus/src/business_logic/models/enums/notificationType.dart';
import 'package:zamongcampus/src/business_logic/models/notificationZC.dart';
import 'package:zamongcampus/src/business_logic/utils/date_convert.dart';
import 'package:zamongcampus/src/business_logic/view_models/base_model.dart';
import 'package:zamongcampus/src/business_logic/view_models/home_viewmodel.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/services/notification/notification_service.dart';
import 'package:zamongcampus/src/ui/views/notification/notification_main/components/notification_list_tile.dart';
import 'package:zamongcampus/src/ui/views/post/post_detail/post_detail_screen.dart';
import 'package:zamongcampus/src/ui/views/voice/voice_detail/voice_detail_screen.dart';

class NotificationViewModel extends BaseModel {
  final NotificationService _notificationService =
      serviceLocator<NotificationService>();
  List<NotificationPresentation> _notifications = List.empty(growable: true);
  final _listKey = GlobalKey<AnimatedListState>();

  List<NotificationPresentation> get notifications => _notifications;
  GlobalKey<AnimatedListState> get listKey => _listKey;
  final RegExp bodyRegexp = RegExp(r"\n+");

  void loadNotifications() async {
    setBusy(true);
    List<NotificationZC> notiResult =
        await _notificationService.fetchMyNotification();
    _notifications = notiResult
        .map((notification) => NotificationPresentation(
            type: notification.type,
            id: notification.id,
            body: changeToBody(notification),
            imageUrl:
                notification.imageUrl ?? 'assets/images/user/general_user.png',
            createdAt: dateToElapsedTime(notification.createdAt),
            isUnRead: notification.isUnRead,
            voiceRoomId: notification.voiceRoomId,
            postId: notification.postId))
        .toList();
    setBusy(false);
  }

  String changeToBody(NotificationZC notificationZC) {
    switch (notificationZC.type) {
      case NotificationType.post:
        String body = (notificationZC.title == null
            ? ""
            : notificationZC.title!.replaceAll(bodyRegexp, " "));
        if (body.length > 22) {
          body = "\'" + body.substring(0, 22) + "...\'";
        } else {
          body = "\'" + body + "\'";
        }
        return body + "\n피드에 새로운 댓글이 달렸습니다!";
      case NotificationType.friend:
        return (notificationZC.nickname ?? "error") + "님의 친구 신청이 도착했습니다!";
      case NotificationType.voiceroom:
        return (notificationZC.nickname ?? "error") +
            "님이" +
            "\'" +
            (notificationZC.title == null
                ? ""
                : notificationZC.title!.replaceAll(bodyRegexp, " ")) +
            "\'" +
            "\n음성대화방에 초대했습니다!";
      default:
        break;
    }
    return "";
  }

  void navigateAndSetRead(NotificationPresentation notificationPresentation,
      BuildContext context, int index) async {
    // 반환 값이 남은 알림 수.
    int remainUnreadNoti = await _notificationService.updateMyNotificationRead(
        id: notificationPresentation.id);
    if (remainUnreadNoti != -1) {
      _notifications[index] = _notifications[index].changeUnReadToFalse();
      if (remainUnreadNoti < 1) {
        HomeViewModel homeViewModel = serviceLocator<HomeViewModel>();
        homeViewModel.changeNotificationExist(false);
      }
      notifyListeners();
    }
    switch (notificationPresentation.type) {
      case NotificationType.post:
        if (notificationPresentation.postId != null) {
          Navigator.pushNamed(context, PostDetailScreen.routeName,
              arguments:
                  PostDetailScreenArgs(notificationPresentation.postId!));
        }
        break;
      case NotificationType.friend:
        Navigator.pushNamed(context, "/friend");
        break;
      case NotificationType.voiceroom:
        if (notificationPresentation.voiceRoomId != null) {
          Navigator.pushNamed(context, VoiceDetailScreen.routeName,
              arguments: VoiceDetailScreenArgs(
                  id: notificationPresentation.voiceRoomId));
        }
        break;
      default:
        break;
    }
  }

  void setAllNotiRead() async {
    bool isSuccess = await _notificationService.updateAllMyNotificationRead();
    if (isSuccess) {
      _notifications.forEach((element) {
        element.changeUnReadToFalse();
      });
      notifyListeners();
    }
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
  final NotificationType type;
  final int id;
  final String body;
  final String imageUrl;
  final String createdAt;
  bool isUnRead;
  int? voiceRoomId;
  int? postId;

  NotificationPresentation(
      {required this.type,
      required this.id,
      required this.body,
      required this.imageUrl,
      required this.createdAt,
      required this.isUnRead,
      this.voiceRoomId,
      this.postId});

  NotificationPresentation changeUnReadToFalse() {
    isUnRead = false;
    return this;
  }
}
