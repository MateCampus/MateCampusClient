import 'package:zamongcampus/src/business_logic/models/notificationZC.dart';
import 'package:zamongcampus/src/services/notification/notification_service.dart';

class FakeNotificationService implements NotificationService {
  @override
  Future<List<NotificationZC>> fetchMyNotification() {
    // TODO: implement fetchMyNotification
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteMyNotification({required int id}) {
    // TODO: implement deleteMyNotification
    throw UnimplementedError();
  }

  @override
  Future<bool> updateAllMyNotificationRead() {
    // TODO: implement updateAllMyNotificationRead
    throw UnimplementedError();
  }

  @override
  Future<int> updateMyNotificationRead({required int id}) {
    // TODO: implement updateMyNotificationRead
    throw UnimplementedError();
  }

  @override
  Future<List<NotificationZC>> fetchMyUnreadNotification() {
    // TODO: implement fetchMyUnreadNotification
    throw UnimplementedError();
  }
}
