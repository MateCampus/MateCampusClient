import 'package:zamongcampus/src/business_logic/models/notificationZC.dart';
import 'package:zamongcampus/src/services/notification/notification_service.dart';

class FakeNotificationService implements NotificationService {
  @override
  Future<List<NotificationZC>> fetchMyNotification() {
    // TODO: implement fetchMyNotification
    throw UnimplementedError();
  }
}
