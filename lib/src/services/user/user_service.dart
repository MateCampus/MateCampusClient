import 'package:zamongcampus/src/business_logic/models/user.dart';

abstract class UserService {
  Future<List<User>> fetchRecommendUsers({required int nextPageToken});
  Future<List<User>> fetchRecentTalkUsers();

  Future<User> fetchMyInfo();
  Future<User> fetchUserInfo({required String loginId});
}
