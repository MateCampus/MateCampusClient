import 'package:zamongcampus/src/business_logic/models/user.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/services/friend/friend_service.dart';
import 'package:zamongcampus/src/services/user/user_service.dart';

import 'base_model.dart';

class VoiceFriendFormScreenViewModel extends BaseModel {
  final UserService _userService = serviceLocator<UserService>();
  final FriendService _friendService = serviceLocator<FriendService>();

  final List<FriendPresentation> _recentTalkUsers = [];
  final List<FriendPresentation> _friendUsers = [];

  String userType = "recentTalk";

  List<FriendPresentation> get recentTalkUsers => _recentTalkUsers;
  List<FriendPresentation> get friendUsers => _friendUsers;

  void loadUsers() async {
    setBusy(true);
    List<User> recentTalkUserResult = await _userService.fetchRecentTalkUsers();
    List<User> friendUserResult = await _friendService.fetchFriendUsers();
    recentTalkUsers.addAll(recentTalkUserResult.map((recentTalkUser) =>
        FriendPresentation(
            userImageUrl: recentTalkUser.userImageUrls?.first ??
                "assets/images/user/general_user.png",
            userNickname: recentTalkUser.userNickname,
            isOnline: recentTalkUser.isOnline ?? false)));
    friendUsers.addAll(friendUserResult.map((friendUser) => FriendPresentation(
        userImageUrl: friendUser.userImageUrls?.first ??
            "assets/images/user/general_user.png",
        userNickname: friendUser.userNickname,
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
  final String userImageUrl;
  final String userNickname;
  final bool isOnline;

  FriendPresentation(
      {required this.userImageUrl,
      required this.userNickname,
      required this.isOnline});
}
