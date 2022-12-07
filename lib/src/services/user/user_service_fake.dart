import 'package:image_picker/image_picker.dart';
import 'package:zamongcampus/src/business_logic/models/user.dart';
import 'package:zamongcampus/src/config/dummy/user_dummny.dart';
import 'package:zamongcampus/src/services/user/user_service.dart';

class FakeUserService implements UserService {
  @override
  Future<List<User>> fetchRecommendUsers({required int nextPageToken}) async {
    List<User> list = [];
    list.addAll(userDummy2);
    return list;
  }

  @override
  Future<Map<String, List<User>>> fetchRecentTalkUsersAndFriends() async {
    List<User> list = [];
    list.addAll(userDummy);
    Map<String, List<User>> users = {};
    users.addAll({"recentTalkUsers": userDummy, "approveFriend": userDummy});
    return users;
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
  Future<User> updateMyInfo(
      {String? nickname, String? introduction, XFile? profileImg}) async {
    return User(
      loginId: "zm",
      nickname: nickname!,
    );
  }
}
