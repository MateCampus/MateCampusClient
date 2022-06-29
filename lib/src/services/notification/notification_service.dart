import 'package:zamongcampus/src/business_logic/models/notificationZC.dart';

abstract class NotificationService {
  Future<List<NotificationZC>> fetchMyNotification();
  Future<List<NotificationZC>> fetchMyUnreadNotification();
  Future<bool> updateAllMyNotificationRead();
  Future<int> updateMyNotificationRead({required int id});
  Future<bool> deleteMyNotification({required int id});
}
