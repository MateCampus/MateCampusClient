import 'package:zamongcampus/src/business_logic/init/auth_service.dart';
import 'package:zamongcampus/src/business_logic/models/notificationZC.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';

import 'notification_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NotificationServiceImpl implements NotificationService {
  @override
  Future<List<NotificationZC>> fetchMyNotification() async {
    final response = await http.get(
        Uri.parse(devServer + "/api/notification/my"),
        headers: AuthService.get_auth_header());
    if (response.statusCode == 200) {
      List<NotificationZC> notifications =
          await jsonDecode(utf8.decode(response.bodyBytes))
              .map<NotificationZC>((json) => NotificationZC.fromJson(json))
              .toList();
      return notifications;
    } else {
      throw Exception('게시물 패치 오류');
    }
  }

  @override
  Future<List<NotificationZC>> fetchMyUnreadNotification() async {
    final response = await http.get(
        Uri.parse(devServer + "/api/notification/my/unread"),
        headers: AuthService.get_auth_header());
    if (response.statusCode == 200) {
      List<NotificationZC> notifications =
          await jsonDecode(utf8.decode(response.bodyBytes))
              .map<NotificationZC>((json) => NotificationZC.fromJson(json))
              .toList();
      return notifications;
    } else {
      throw Exception('게시물 패치 오류');
    }
  }

  @override
  Future<bool> updateAllMyNotificationRead() async {
    final response = await http.put(
        Uri.parse(devServer + "/api/notification/my"),
        headers: AuthService.get_auth_header());
    if (response.statusCode == 204) {
      return true;
    } else {
      return false;
    }
  }

  // 반환 값이 남은 알림 수;
  @override
  Future<int> updateMyNotificationRead({required int id}) async {
    final response = await http.put(
        Uri.parse(devServer + "/api/notification/my/" + id.toString()),
        headers: AuthService.get_auth_header());

    if (response.statusCode == 200) {
      return jsonDecode(utf8.decode(response.bodyBytes));
    } else {
      return -1;
    }
  }

  @override
  Future<bool> deleteMyNotification({required int id}) async {
    final response = await http.delete(
        Uri.parse(devServer + "/api/notification/my/" + id.toString()),
        headers: AuthService.get_auth_header());
    if (response.statusCode == 204) {
      return true;
    } else {
      return false;
    }
  }
}
