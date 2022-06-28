import 'package:zamongcampus/src/business_logic/models/notificationZC.dart';

abstract class NotificationService {
  Future<List<NotificationZC>> fetchMyNotification();
}
