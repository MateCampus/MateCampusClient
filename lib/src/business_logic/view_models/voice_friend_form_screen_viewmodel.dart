import 'package:zamongcampus/src/business_logic/models/user.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/services/user/user_service.dart';

import 'base_model.dart';

class VoiceFriendFormScreenViewModel extends BaseModel {
  final UserService _userService = serviceLocator<UserService>();

  final List<FriendPresentation> _recentTalkUsers = [];
  final List<FriendPresentation> _friendUsers = [];

  String userType = "recentTalk";

  List<FriendPresentation> get recentTalkUsers => _recentTalkUsers;
  List<FriendPresentation> get friendUsers => _friendUsers;

  void loadUsers() async {
    setBusy(true);
    List<User> recentTalkUserResult = await _userService.fetchRecentTalkUsers();
    List<User> friendUserResult = await _userService.fetchFriendUsers();
    recentTalkUsers.addAll(recentTalkUserResult.map((recentTalkUser) =>
        FriendPresentation(
            imageUrl: recentTalkUser.imageUrls?.first ??
                "assets/images/user/general_user.png",
            nickname: recentTalkUser.nickname ?? "error user",
            isOnline: recentTalkUser.isOnline ?? false)));
    friendUsers.addAll(friendUserResult.map((friendUser) => FriendPresentation(
        imageUrl: friendUser.imageUrls?.first ??
            "assets/images/user/general_user.png",
        nickname: friendUser.nickname ?? "error user",
        isOnline: friendUser.isOnline ?? false)));
    setBusy(false);
  }

  void changeUserType(int value) async {
    setBusy(true);
    await Future.delayed(const Duration(milliseconds: 500));
    switch (value) {
      case 0:
        userType = "recentTalk";
        break;
      case 1:
        userType = "friend";
        break;
      default:
        break;
    }
    print("변경: " + userType);

    setBusy(false);
  }
}

class FriendPresentation {
  final String imageUrl;
  final String nickname;
  final bool isOnline;

  FriendPresentation(
      {required this.imageUrl, required this.nickname, required this.isOnline});
}
