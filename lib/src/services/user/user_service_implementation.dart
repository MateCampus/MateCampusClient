import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:zamongcampus/src/business_logic/init/auth_service.dart';
import 'package:zamongcampus/src/business_logic/models/user.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/config/dummy_data.dart';

import 'user_service.dart';

class UserServiceImpl implements UserService {
  @override
  Future<List<User>> fetchRecommendUsers({required int nextPageToken}) async {
    final response = await http.get(
        Uri.parse(devServer + "/api/user/recommend"),
        headers: AuthService.get_auth_header());
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
  Future<List<User>> fetchRecentTalkUsers() async {
    List<User> list = [];
    list.addAll(userDummy);
    return list;
  }

  @override
  Future<User> fetchMyInfo() async {
    final response = await http.get(Uri.parse(devServer + "/api/user/mypage"),
        headers: AuthService.get_auth_header());
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
    final response = await http.get(
        Uri.parse(devServer + "/api/user/info/" + loginId),
        headers: AuthService.get_auth_header());
    if (response.statusCode == 200) {
      User user =
          User.fromJson(await jsonDecode(utf8.decode(response.bodyBytes)));
      return user;
    } else {
      throw Exception('fetchMyInfo 서버 오류');
    }
  }
}
