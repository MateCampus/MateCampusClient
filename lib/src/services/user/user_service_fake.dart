import 'package:image_picker/image_picker.dart';
import 'package:zamongcampus/src/business_logic/models/user.dart';
import 'package:zamongcampus/src/config/dummy_data.dart';
import 'package:zamongcampus/src/services/user/user_service.dart';

class FakeUserService implements UserService {
  @override
  Future<List<User>> fetchRecommendUsers({required int nextPageToken}) async {
    List<User> list = [];
    list.addAll(userDummy2);
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
    User userProfile;
    userProfile = userDummy.first;

    return userProfile;
  }

  @override
  Future<User> fetchUserInfo({required String loginId}) async {
    User userProfile;
    userProfile = userDummy.first;

    return userProfile;
  }

  @override
  Future<bool> checkNicknameRedundancy({required String nickname}) async {
    bool value = true;
    return value;
  }

  @override
  Future<bool> updateMyInfo(
      {String? nickname, String? introduction, XFile? profileImg}) async {
    return true;
  }
}
