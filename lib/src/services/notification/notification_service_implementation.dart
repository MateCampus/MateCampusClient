import 'package:zamongcampus/src/business_logic/init/auth_service.dart';
import 'package:zamongcampus/src/business_logic/models/notificationZC.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/object/secure_storage_object.dart';
import 'package:zamongcampus/src/services/login/login_service.dart';

import 'notification_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NotificationServiceImpl implements NotificationService {
  @override
  Future<List<NotificationZC>> fetchMyNotification() async {
    String? accessToken = await SecureStorageObject.getAccessToken();
    String? refreshToken = await SecureStorageObject.getRefreshToken();
    final response = await http.get(
        Uri.parse(devServer + "/api/notification/my"),
        headers: AuthService.get_auth_header(
            accessToken: accessToken, refreshToken: refreshToken));
    if (response.statusCode == 200) {
      List<NotificationZC> notifications =
          await jsonDecode(utf8.decode(response.bodyBytes))
              .map<NotificationZC>((json) => NotificationZC.fromJson(json))
              .toList();
      return notifications;
    } else {
      throw Exception('내 알림 가져오기 패치 오류');
    }
  }

  @override
  Future<List<NotificationZC>> fetchMyUnreadNotification() async {
    String? accessToken = await SecureStorageObject.getAccessToken();
    String? refreshToken = await SecureStorageObject.getRefreshToken();
    final response = await http.get(
        Uri.parse(devServer + "/api/notification/my/unread"),
        headers: AuthService.get_auth_header(
            accessToken: accessToken, refreshToken: refreshToken));
    if (response.statusCode == 200) {
      List<NotificationZC> notifications =
          await jsonDecode(utf8.decode(response.bodyBytes))
              .map<NotificationZC>((json) => NotificationZC.fromJson(json))
              .toList();
      return notifications;
    } else if (response.statusCode == 401) {
      LoginService loginService = serviceLocator<LoginService>();
      await loginService.reissueToken();
      return fetchMyUnreadNotification();
    } else {
      throw Exception('fetchMyUnreadNotification 패치 오류');
    }
  }

  @override
  Future<bool> updateAllMyNotificationRead() async {
    String? accessToken = await SecureStorageObject.getAccessToken();
    String? refreshToken = await SecureStorageObject.getRefreshToken();
    final response = await http.put(
        Uri.parse(devServer + "/api/notification/my"),
        headers: AuthService.get_auth_header(
            accessToken: accessToken, refreshToken: refreshToken));
    if (response.statusCode == 204) {
      return true;
    } else {
      return false;
    }
  }

  // 반환 값이 남은 알림 수;
  @override
  Future<int> updateMyNotificationRead({required int id}) async {
    String? accessToken = await SecureStorageObject.getAccessToken();
    String? refreshToken = await SecureStorageObject.getRefreshToken();
    final response = await http.put(
        Uri.parse(devServer + "/api/notification/my/" + id.toString()),
        headers: AuthService.get_auth_header(
            accessToken: accessToken, refreshToken: refreshToken));

    if (response.statusCode == 200) {
      return jsonDecode(utf8.decode(response.bodyBytes));
    } else {
      return -1;
    }
  }

  @override
  Future<bool> deleteMyNotification({required int id}) async {
    String? accessToken = await SecureStorageObject.getAccessToken();
    String? refreshToken = await SecureStorageObject.getRefreshToken();
    final response = await http.delete(
        Uri.parse(devServer + "/api/notification/my/" + id.toString()),
        headers: AuthService.get_auth_header(
            accessToken: accessToken, refreshToken: refreshToken));
    if (response.statusCode == 204) {
      return true;
    } else {
      return false;
    }
  }
}
