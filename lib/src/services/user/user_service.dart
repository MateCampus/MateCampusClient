import 'package:image_picker/image_picker.dart';
import 'package:zamongcampus/src/business_logic/models/user.dart';

abstract class UserService {
  Future<List<User>> fetchRecommendUsers({required int nextPageToken});
  Future<Map<String, List<User>>> fetchRecentTalkUsersAndFriends();

  Future<User> fetchMyInfo();
  Future<User> fetchUserInfo({required String loginId});

  Future<User> updateMyInfo(
      {String? nickname, String? introduction, XFile? profileImg});

  Future<void> blockUser({required String targetLoginId});
}
