import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/arguments/post_detail_screen_args.dart';
import 'package:zamongcampus/src/business_logic/models/enums/notificationType.dart';
import 'package:zamongcampus/src/business_logic/models/notificationZC.dart';
import 'package:zamongcampus/src/business_logic/utils/date_convert.dart';
import 'package:zamongcampus/src/business_logic/view_models/base_model.dart';
import 'package:zamongcampus/src/business_logic/view_models/home_viewmodel.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/services/notification/notification_service.dart';
import 'package:zamongcampus/src/ui/views/notification/notification_main/components/notification_list_tile.dart';
import 'package:zamongcampus/src/ui/views/post/post_detail/post_detail_screen.dart';

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
            nickname: notification.nickname,
            imageUrl:
                notification.imageUrl.isEmpty
                  ?'assets/images/user/general_user.png'
                  : notification.imageUrl,
            title: trimBody(notification.body),
            typeText: setTypeText(notification.type),
            createdAt: dateToElapsedTime(notification.createdAt),
            isUnRead: notification.isUnRead,
            voiceRoomId: notification.voiceRoomId,
            postId: notification.postId??-1))
        .toList();
    setBusy(false);
  }

  String trimBody(String rawBody){
    String title = rawBody.replaceAll(bodyRegexp, " ");
    if (title.length > 22) {
          title = "\'" + title.substring(0, 22) + "...\'";
        } else {
          title = "\'" + title + "\'";
        }
    return title;

  }

  String setTypeText(NotificationType type){
    String typeText ="";
    switch(type){
      case NotificationType.post:
        typeText = "님이 내 피드에 댓글을 남겼어요!";
        return typeText;
      case NotificationType.postlike:
      typeText = "님이 내 피드에 좋아요를 눌렀어요!";
        return typeText;

      case NotificationType.postsubcomment:
      typeText = "님이 내 댓글에 답글을 남겼어요!";
        return typeText;

      case NotificationType.friend:
      typeText = "님이 친구신청을 했습니다";
        return typeText;

      case NotificationType.voiceroom:
      typeText = "님이 음성대화방에 초대했습니다";
        return typeText;

      default:break;

    }
    return "";

  }

  String changeToBody(NotificationZC notificationZC) {
    switch (notificationZC.type) {
      case NotificationType.post:
        String body = notificationZC.body.replaceAll(bodyRegexp, " ");
        if (body.length > 22) {
          body = "\'" + body.substring(0, 22) + "...\'";
        } else {
          body = "\'" + body + "\'";
        }
        return body + "\n" +notificationZC.nickname+"님이 내 피드에 댓글을 남겼어요!";
      case NotificationType.postlike:
        String body = notificationZC.body.replaceAll(bodyRegexp, " ");
        if (body.length > 22) {
          body = "\'" + body.substring(0, 22) + "...\'";
        } else {
          body = "\'" + body + "\'";
        }
        return body + "\n" +notificationZC.nickname+"님이 내 피드에 좋아요를 눌렀어요!";
        case NotificationType.postsubcomment:
          String body = notificationZC.body.replaceAll(bodyRegexp, " ");
        if (body.length > 22) {
          body = "\'" + body.substring(0, 22) + "...\'";
        } else {
          body = "\'" + body + "\'";
        }
        return body + "\n" +notificationZC.nickname+"님이 내 댓글에 답글을 남겼어요!";

      //version1에서는 안쓴다. 
      case NotificationType.friend:
        return (notificationZC.nickname ) + "님의 친구 신청이 도착했습니다!";
      
      case NotificationType.voiceroom:
        return (notificationZC.nickname ) +
            "님이" +
            "\'" +
            (notificationZC.body == null
                ? ""
                : notificationZC.body.replaceAll(bodyRegexp, " ")) +
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
        if (notificationPresentation.postId != -1) {
          Navigator.pushNamed(context, PostDetailScreen.routeName,
              arguments:
                  PostDetailScreenArgs(notificationPresentation.postId));
        }
        break;
       case NotificationType.postlike:
        if (notificationPresentation.postId != -1) {
          Navigator.pushNamed(context, PostDetailScreen.routeName,
              arguments:
                  PostDetailScreenArgs(notificationPresentation.postId));
        }
        break;
         case NotificationType.postsubcomment:
        if (notificationPresentation.postId != -1) {
          Navigator.pushNamed(context, PostDetailScreen.routeName,
              arguments:
                  PostDetailScreenArgs(notificationPresentation.postId));
        }
        break;
      
      case NotificationType.friend:
        Navigator.pushNamed(context, "/friend");
        break;
      case NotificationType.voiceroom:
        
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

  void removeItem(NotificationViewModel vm, int index) {
    final removeItem = _notifications[index];
    _notifications.removeAt(index);
    listKey.currentState!.removeItem(
        index,
        (context, animation) => NotificationListTile(vm: vm ,
            notification: removeItem, index:index, animation: animation, onClicked: () {}));
    notifyListeners();
  }
}

class NotificationPresentation {
  final NotificationType type;
  final int id;
  final String imageUrl;
  final String nickname;
  final String title;
  final String typeText;
  bool isUnRead;int? voiceRoomId;
  final int postId;
  final String createdAt;
  
  

  NotificationPresentation(
      {required this.type,
      required this.id,
      required this.imageUrl,
      required this.nickname,
      required this.title,
      required this.typeText,
      required this.isUnRead,
      this.voiceRoomId,
      required this.postId,
      required this.createdAt,
      });

  NotificationPresentation changeUnReadToFalse() {
    isUnRead = false;
    return this;
  }
}
