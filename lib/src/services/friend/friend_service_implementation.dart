import 'package:http/http.dart';
import 'package:zamongcampus/src/business_logic/init/auth_service.dart';
import 'package:zamongcampus/src/business_logic/models/friend.dart';
import 'package:http/http.dart' as http;
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'dart:convert';
import 'friend_service.dart';

class FriendServiceImpl implements FriendService {
  @override
  Future<List<Friend>> fetchFriends() async {
    final response = await http.get(Uri.parse(devServer + "/api/friend"),
        headers: AuthService.get_auth_header());
    if (response.statusCode == 200) {
      List<Friend> friends = await jsonDecode(utf8.decode(response.bodyBytes))
          .map<Friend>((json) => Friend.fromJson(json))
          .toList();
      return friends;
    } else {
      throw Exception("오류 친구불러오기");
    }
  }

  @override
  Future<List<Friend>> fetchAcceptedTypeFriends() {
    // TODO: implement fetchAcceptedTypeFriends
    throw UnimplementedError();
  }
}
