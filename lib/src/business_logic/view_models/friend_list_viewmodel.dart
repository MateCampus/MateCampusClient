import 'package:zamongcampus/src/business_logic/models/user.dart';
import 'package:zamongcampus/src/business_logic/view_models/base_model.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/services/friend/friend_service.dart';

class FriendListViewModel extends BaseModel {
  final FriendService _friendService = serviceLocator<FriendService>();

  final List<FriendPresentation> _acceptedUsers = []; // 쌍방친구
  final List<FriendPresentation> _waitingUsers = []; //대기중
  final List<FriendPresentation> _requestUsers = []; //신청자
  final List<FriendPresentation> _friendUsers = []; // 쌍방 + 대기중

  List<FriendPresentation> get friendUsers => _friendUsers;
  List<FriendPresentation> get requestUsers => _requestUsers;

  void loadFriendUsers() async {
    setBusy(true);
    _acceptedUsers.clear();
    _waitingUsers.clear();
    _friendUsers.clear();

    List<User> acceptedUsersResult = await _friendService.fetchFriendUsers();
    List<User> waitingUsersResult = await _friendService.fetchWaitingUsers();
    _acceptedUsers.addAll(acceptedUsersResult.map((acceptedUser) =>
        FriendPresentation(
            loginId: acceptedUser.loginId,
            userImageUrl: acceptedUser.imageUrls?.first ??
                "assets/images/user/general_user.png",
            userNickname: acceptedUser.nickname,
            isOnline: acceptedUser.isOnline ?? false,
            friendRequestStatus: FriendRequestStatus.ACCEPTED)));

    _waitingUsers.addAll(waitingUsersResult.map((waitingUser) =>
        FriendPresentation(
            loginId: waitingUser.loginId,
            userImageUrl: waitingUser.imageUrls?.first ??
                "assets/images/user/general_user.png",
            userNickname: waitingUser.nickname,
            isOnline: waitingUser.isOnline ?? false,
            friendRequestStatus: FriendRequestStatus.UNACCEPTED)));

    _friendUsers
      ..addAll(_acceptedUsers)
      ..addAll(_waitingUsers);

    setBusy(false);
  }

  void loadRequestUsers() async {
    setBusy(true);
    _requestUsers.clear();

    List<User> requestUsersResult = await _friendService.fetchRequestUsers();
    _requestUsers.addAll(requestUsersResult.map((requestUser) =>
        FriendPresentation(
            loginId: requestUser.loginId,
            userImageUrl: requestUser.imageUrls?.first ??
                "assets/images/user/general_user.png",
            userNickname: requestUser.nickname,
            isOnline: requestUser.isOnline ?? false,
            friendRequestStatus: FriendRequestStatus.UNACCEPTED)));

    setBusy(false);
  }

  void acceptRequest(FriendPresentation user) async {
    //친구요청 수락
    _requestUsers.remove(user);
    user.friendRequestStatus = FriendRequestStatus.ACCEPTED;
    int index = _acceptedUsers.length;
    _acceptedUsers.add(user);
    _friendUsers.insert(index, user);
    notifyListeners();
  }

  void rejectRequest(FriendPresentation user) async {
    //친구요청 거절
    user.friendRequestStatus = FriendRequestStatus.NONE;
    _requestUsers.remove(user);
    notifyListeners();
  }

  void gotoChatroom(String loginId) {
    //대화하기
  }
}

class FriendPresentation {
  final String loginId;
  final String userImageUrl;
  final String userNickname;
  final bool isOnline;
  FriendRequestStatus friendRequestStatus;

  FriendPresentation(
      {required this.loginId,
      required this.userImageUrl,
      required this.userNickname,
      required this.isOnline,
      required this.friendRequestStatus});
}

enum FriendRequestStatus {
  NONE,
  UNACCEPTED,
  ACCEPTED,
}
