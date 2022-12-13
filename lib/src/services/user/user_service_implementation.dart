import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:zamongcampus/src/business_logic/init/auth_service.dart';
import 'package:zamongcampus/src/business_logic/models/user.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/config/dummy_data.dart';
import 'package:zamongcampus/src/object/prefs_object.dart';
import 'package:zamongcampus/src/object/secure_storage_object.dart';

import 'user_service.dart';

class UserServiceImpl implements UserService {
  @override
  Future<List<User>> fetchRecommendUsers({required int nextPageToken}) async {
    String? accessToken = await SecureStorageObject.getAccessToken();
    String? refreshToken = await SecureStorageObject.getRefreshToken();
    final response = await http.get(
        Uri.parse(devServer + "/api/user/recommend"),
        headers: AuthService.get_auth_header(
            accessToken: accessToken, refreshToken: refreshToken));
    if (response.statusCode == 200) {
      List<User> users = await jsonDecode(utf8.decode(response.bodyBytes))
          .map<User>((user) => User.fromJson(user))
          .toList();
      return users;
    } else {
      throw Exception('fetchMyInfo 서버 오류');
    }
  }

  @override
  Future<Map<String, List<User>>> fetchRecentTalkUsersAndFriends() async {
    String? accessToken = await SecureStorageObject.getAccessToken();
    String? refreshToken = await SecureStorageObject.getRefreshToken();
    String recentTalkUserLoginIds =
        (await PrefsObject.getRecentTalkUsers() ?? []).join(', ');

    final response = await http.get(
        Uri.parse(devServer +
            "/api/user/recentTalkAndFriend?recentTalkUserLoginIds=" +
            recentTalkUserLoginIds),
        headers: AuthService.get_auth_header(
            accessToken: accessToken, refreshToken: refreshToken));
    if (response.statusCode == 200) {
      var json = await jsonDecode(utf8.decode(response.bodyBytes));
      Map<String, List<User>> users = {};
      users.addAll({
        "recentTalkUsers": json["recentTalkUsers"]
            .map<User>((user) => User.fromJson(user))
            .toList(),
        "approveFriends": json["approveFriends"]
            .map<User>((user) => User.fromJson(user))
            .toList()
      });
      return users;
    } else {
      throw Exception('최근 대화한 사람, approve 친구 가져오기 오류');
    }
  }

  @override
  Future<User> fetchMyInfo() async {
    String? accessToken = await SecureStorageObject.getAccessToken();
    String? refreshToken = await SecureStorageObject.getRefreshToken();
    final response = await http.get(Uri.parse(devServer + "/api/user/mypage"),
        headers: AuthService.get_auth_header(
            accessToken: accessToken, refreshToken: refreshToken));
    if (response.statusCode == 200) {
      User user =
          User.fromJson(await jsonDecode(utf8.decode(response.bodyBytes)));
      return user;
    } else {
      throw Exception('fetchMyInfo 서버 오류');
    }
  }

  @override
  Future<User> fetchUserInfo({required String loginId}) async {
    String? accessToken = await SecureStorageObject.getAccessToken();
    String? refreshToken = await SecureStorageObject.getRefreshToken();
    final response = await http.get(
        Uri.parse(devServer + "/api/user/info/" + loginId),
        headers: AuthService.get_auth_header(
            accessToken: accessToken, refreshToken: refreshToken));
    if (response.statusCode == 200) {
      User user =
          User.fromJson(await jsonDecode(utf8.decode(response.bodyBytes)));
      return user;
    } else {
      throw Exception('fetchMyInfo 서버 오류');
    }
  }

  @override
  Future<User> updateMyInfo(
      {String? nickname, String? introduction, XFile? profileImg}) async {
    String? accessToken = await SecureStorageObject.getAccessToken();
    String? refreshToken = await SecureStorageObject.getRefreshToken();
    var request =
        http.MultipartRequest("PUT", Uri.parse(devServer + "/api/user"))
          ..headers.addAll(AuthService.get_auth_header(
              accessToken: accessToken, refreshToken: refreshToken));
    if (nickname != null) {
      request.fields['nickname'] = nickname;
    }
    if (introduction != null) {
      request.fields['introduction'] = introduction;
    }
    if (profileImg != null) {
      request.files.add(
          await http.MultipartFile.fromPath('profileImage', profileImg.path));
    }

    var streamedResponse = await request.send();
    if (streamedResponse.statusCode == 200) {
      print('내정보 업데이트 성공');
      var response = await http.Response.fromStream(streamedResponse);
      User user =
          User.fromJson(await jsonDecode(utf8.decode(response.bodyBytes)));
      return user;
    } else {
      throw Exception('업데이트 오류');
    }
  }

  @override
  Future<void> blockUser({required String targetLoginId}) async {
    String? accessToken = await SecureStorageObject.getAccessToken();
    String? refreshToken = await SecureStorageObject.getRefreshToken();
    final jsonBody = jsonEncode({"blockedUserLoginId": targetLoginId});
    final response = await http.post(Uri.parse(devServer + "/api/blockedUser"),
        body: jsonBody,
        headers: AuthService.get_auth_header(
            accessToken: accessToken, refreshToken: refreshToken));
    if (response.statusCode == 201) {
      print('유저차단성공');
    } else {
      throw Exception('blockUser 서버 오류');
    }
  }
}
