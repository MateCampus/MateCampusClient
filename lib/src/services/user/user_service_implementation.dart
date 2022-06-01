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
    List<User> list = [];
    list.addAll(userDummy2);
    // 우선 모든 유저 중 이미 친구인 유저 제외하고 불러옴.
    return list;
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
}
