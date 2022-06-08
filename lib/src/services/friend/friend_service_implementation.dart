import 'package:zamongcampus/src/business_logic/init/auth_service.dart';
import 'package:zamongcampus/src/business_logic/models/friend.dart';
import 'package:http/http.dart' as http;
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/services/friend/friend_service_fake.dart';
import 'dart:convert';
import 'friend_service.dart';
import 'friend_service_fake.dart';

class FriendServiceImpl implements FriendService {
  @override
  Future<void> requestFriend({required String targetLoginId}) async {
    var body = jsonEncode({"targetLoginId": targetLoginId});
    final response = await http.post(Uri.parse(devServer + "/api/friend"),
        headers: AuthService.get_auth_header(), body: body);
    if (response.statusCode == 200) {
      print('친구 신청 완료');
    } else {
      throw Exception("오류: 친구 신청");
    }
  }

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
  Future<List<Friend>> fetchApprovedTypeFriends() async {
    final response = await http.get(
        Uri.parse(devServer + "/api/friend/approve"),
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
  Future<Friend> fetchFriend(int friendId) async {
    // TODO: implement fetchFriend
    final response = await http.get(
        Uri.parse(devServer + "/api/friend/" + friendId.toString()),
        headers: AuthService.get_auth_header());
    if (response.statusCode == 200) {
      Friend friend =
          await Friend.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
      return friend;
    } else {
      throw Exception("오류 친구프로필 불러오기");
    }
  }

  @override
  Future<void> approveFriend({required String targetLoginId}) async {
    var body = jsonEncode({"targetLoginId": targetLoginId});
    final response = await http.put(
        Uri.parse(devServer + "/api/friend/approve"),
        headers: AuthService.get_auth_header(),
        body: body);
    if (response.statusCode == 200) {
      print('친구 수락 완료');
    } else {
      throw Exception("오류: 친구 수락");
    }
  }

  @override
  Future<void> refuseFriend({required String targetLoginId}) async {
    var body = jsonEncode({"targetLoginId": targetLoginId});
    final response = await http.put(Uri.parse(devServer + "/api/friend/refuse"),
        headers: AuthService.get_auth_header(), body: body);
    if (response.statusCode == 200) {
      print('친구 거절 완료');
    } else {
      throw Exception("오류: 친구 거절");
    }
  }
}
