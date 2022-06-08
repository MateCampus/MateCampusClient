import 'package:image_picker/image_picker.dart';
import 'package:zamongcampus/src/business_logic/models/user.dart';

abstract class UserService {
  Future<List<User>> fetchRecommendUsers({required int nextPageToken});
  Future<List<User>> fetchRecentTalkUsers();

  Future<User> fetchMyInfo();
  Future<User> fetchUserInfo({required String loginId});

  Future<bool> checkNicknameRedundancy({required String nickname});
  Future<bool> updateMyInfo(
      {String? nickname, String? introduction, XFile? profileImg});
}
